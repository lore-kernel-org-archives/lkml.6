Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDRTyD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 15:54:03 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:49595 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751256AbeDRTyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 15:54:02 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:,RULES_HIT:41:46:150:153:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2692:2828:2904:3138:3139:3140:3141:3142:3653:3865:3866:3867:3868:3870:3872:3873:4250:4321:4605:4823:5007:6117:6119:7903:7904:8957:9010:9040:9121:10004:10848:11026:11232:11233:11473:11658:11914:11984:12043:12294:12296:12346:12438:12555:12740:12760:12895:13095:13255:13439:14180:14181:14659:14721:21060:21080:21221:21326:21433:21451:21627:30012:30022:30034:30054:30062:30070:30091,0,RBL:72.2.237.46:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: dock11_2273351098207
X-Filterd-Recvd-Size: 5254
Message-ID: <e3d072d47e9dd8255c19f074bcf99e76dc2a82f9.camel@perches.com>
Subject: Re: =?UTF-8?Q?=E3=80=90scripts=2Fcheckpatch=2Epl=E3=80=91why?= we
 expand table key to 8 characters =?UTF-8?Q?=EF=BC=9F?=
From: Joe Perches <joe@perches.com>
To: LKML <linux-kernel@vger.kernel.org>
Date: Wed, 18 Apr 2018 12:53:49 -0700
In-Reply-To: <OF1E263C3C.2B407D65-ON48258273.00325117-48258273.0035DEE8@alitech.com>
References: <OF1E263C3C.2B407D65-ON48258273.00325117-48258273.0035DEE8@alitech.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarding on to LKML as I didn't realize it wasn't
on the original email chain.

On Wed, 2018-04-18 at 17:48 +0800, Dennis.Dai@alitech.com wrote:
> 
> Hi Joe & Andy,
> 
> Sorry to interrupt you for scripts/checkpatch.pl.
> 
> I always use scripts/checkpatch.pl in kernel to check my code style. It's
> very helpful to improve our code more readable.
> 
> We always set 4 characters for table key and most of others do this well in
> China, but I cann't understand why we expand the number to 8 characters and
> check the indent with 8 characters by following code ?

I don't personally mind allowing various tab widths,
but it should be with some command line option like
--tab-width=<n>

Perhaps:
---
 scripts/checkpatch.pl | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 24618dffc5cb..95dae55bc94d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -49,6 +49,7 @@ my @ignore = ();
 my $help = 0;
 my $configuration_file = ".checkpatch.conf";
 my $max_line_length = 80;
+my $tab_width = 8;
 my $ignore_perl_version = 0;
 my $minimum_perl_version = 5.10.0;
 my $min_conf_desc_length = 4;
@@ -92,6 +93,7 @@ Options:
   --ignore TYPE(,TYPE2...)   ignore various comma separated message types
   --show-types               show the specific message type in the output
   --max-line-length=n        set the maximum line length, if exceeded, warn
+  --tab-width=n              set the expected tab indentation width (default:8)
   --min-conf-desc-length=n   set the min description length, if shorter, warn
   --root=PATH                PATH to the kernel tree root
   --no-summary               suppress the per-file summary
@@ -209,6 +211,7 @@ GetOptions(
 	'show-types!'	=> \$show_types,
 	'list-types!'	=> \$list_types,
 	'max-line-length=i' => \$max_line_length,
+	'tab-width=i'	=> \$tab_width,
 	'min-conf-desc-length=i' => \$min_conf_desc_length,
 	'root=s'	=> \$root,
 	'summary!'	=> \$summary,
@@ -1162,7 +1165,7 @@ sub expand_tabs {
 		if ($c eq "\t") {
 			$res .= ' ';
 			$n++;
-			for (; ($n % 8) != 0; $n++) {
+			for (; ($n % $tab_width) != 0; $n++) {
 				$res .= ' ';
 			}
 			next;
@@ -2175,7 +2178,7 @@ sub string_find_replace {
 sub tabify {
 	my ($leading) = @_;
 
-	my $source_indent = 8;
+	my $source_indent = $tab_width;
 	my $max_spaces_before_tab = $source_indent - 1;
 	my $spaces_to_tab = " " x $source_indent;
 
@@ -3056,7 +3059,7 @@ sub process {
 				"please, no space before tabs\n" . $herevet) &&
 			    $fix) {
 				while ($fixed[$fixlinenr] =~
-					   s/(^\+.*) {8,8}\t/$1\t\t/) {}
+					   s/(^\+.*) {$tab_width,$tab_width}\t/$1\t\t/) {}
 				while ($fixed[$fixlinenr] =~
 					   s/(^\+.*) +\t/$1\t/) {}
 			}
@@ -3078,11 +3081,11 @@ sub process {
 		if ($^V && $^V ge 5.10.0 &&
 		    $sline =~ /^\+\t+( +)(?:$c90_Keywords\b|\{\s*$|\}\s*(?:else\b|while\b|\s*$)|$Declare\s*$Ident\s*[;=])/) {
 			my $indent = length($1);
-			if ($indent % 8) {
+			if ($indent % $tab_width) {
 				if (WARN("TABSTOP",
 					 "Statements should start on a tabstop\n" . $herecurr) &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/8)@e;
+					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/$tab_width)@e;
 				}
 			}
 		}
@@ -3100,8 +3103,8 @@ sub process {
 				my $newindent = $2;
 
 				my $goodtabindent = $oldindent .
-					"\t" x ($pos / 8) .
-					" "  x ($pos % 8);
+					"\t" x ($pos / $tab_width) .
+					" "  x ($pos % $tab_width);
 				my $goodspaceindent = $oldindent . " "  x $pos;
 
 				if ($newindent ne $goodtabindent &&
@@ -3572,11 +3575,11 @@ sub process {
 			#print "line<$line> prevline<$prevline> indent<$indent> sindent<$sindent> check<$check> continuation<$continuation> s<$s> cond_lines<$cond_lines> stat_real<$stat_real> stat<$stat>\n";
 
 			if ($check && $s ne '' &&
-			    (($sindent % 8) != 0 ||
+			    (($sindent % $tab_width) != 0 ||
 			     ($sindent < $indent) ||
 			     ($sindent == $indent &&
 			      ($s !~ /^\s*(?:\}|\{|else\b)/)) ||
-			     ($sindent > $indent + 8))) {
+			     ($sindent > $indent + $tab_width))) {
 				WARN("SUSPECT_CODE_INDENT",
 				     "suspect code indent for conditional statements ($indent, $sindent)\n" . $herecurr . "$stat_real\n");
 			}
