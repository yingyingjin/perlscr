#! /usr/bin/perl -w


(@ARGV > 2) ||
    die "Usage:  $0  <animal>  <chr> <from> <to> [revcom]\n";

($animal, $chr, $from, $to ) = @ARGV;

$genome_dir    = "/home/ivanam/projects/colabs/Vivek/mirna/genomes/genome_hs";
if ( $animal eq "mouse" ) {
    $genome_dir    = "/home/ivanam/projects/colabs/Vivek/mirna/genomes/genome_mm";
}

if ( defined $ARGV[3] && $ARGV[3] eq "revcom" ) {
    $rvc = 1;
} else {
    $rvc = 0;
}

$chrseq = `grep -v \'>\' $genome_dir/$chr/$chr.fa`;
chomp $chrseq;
$chrseq =~ s/\n//g;
  
$offset = $from -1;
$length = $to-$from+1;

$str = uc  substr $chrseq, $offset, $length;
if (  $rvc ) {
    $str =  revcom ($str);
} 

print "$str \n";



sub rev{

    my($sequence)=@_;

    my $rev=reverse $sequence;   

    return $rev;
}

sub com{

    my($sequence)=@_;

    $sequence=~tr/acgtuACGTU/TGCAATGCAA/;   
 
    return $sequence;
}

sub revcom{

    my($sequence)=@_;

    my $revcom=rev(com($sequence));

    return $revcom;
}
