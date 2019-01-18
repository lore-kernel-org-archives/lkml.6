Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEE420657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfARBTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:19:42 -0500
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:41116 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbfARBTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:19:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 830A252BB;
        Fri, 18 Jan 2019 01:19:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: use11_37204fdb61e4a
X-Filterd-Recvd-Size: 6309
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 18 Jan 2019 01:19:38 +0000 (UTC)
Message-ID: <40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com>
Subject: Re: linux-next: Fixes tag needs some work in the tip tree
From:   Joe Perches <joe@perches.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, avarab@gmail.com
Cc:     Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 17 Jan 2019 17:19:37 -0800
In-Reply-To: <20190118113230.3d11be0c@canb.auug.org.au>
References: <20190118093135.39cf071e@canb.auug.org.au>
         <alpine.DEB.2.21.1901180044260.1647@nanos.tec.linutronix.de>
         <20190118113230.3d11be0c@canb.auug.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 11:32 +1100, Stephen Rothwell wrote:
> Hi Thomas,
> 
> On Fri, 18 Jan 2019 00:45:44 +0100 (CET) Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 18 Jan 2019, Stephen Rothwell wrote:
> > > Commit
> > > 
> > >   a31e184e4f69 ("x86/pkeys: Properly copy pkey state at fork()")
> > > 
> > > Fixes tag
> > > 
> > >   Fixes: e8c24d3a23a ("x86/pkeys: Allocation/free syscalls")
> > > 
> > > has these problems:
> > > 
> > >   - SHA1 should be at least 12 digits long  
> > 
> > Sigh. I'll add that to my sanity checks, but this one has to be as is as
> > it's in the middle of a series of fixes pending for linus tree.
> 
> That's OK, more of a reminder ... the abbreviated SHA1 is unique now,
> but may not be in the future - of course 12 digits does not guarantee
> that either.  I am told we already have some clashes using 11 digits :-(

Ævar Arnfjörð Bjarmason sent a [atch to
	Documentation/process/submitting-patches.rst
for that .gitconfig default length problem last month.

https://lore.kernel.org/patchwork/patch/1026639/

Perhaps something will come of that one day.

It does seem that of the 30K or so commits with "Fixes:" that
the style has standardized on the typical form below where
12 ("") is a 12 char SHA1 and ("") is the commit description

  21911 Fixes: 12 ("")
   1151 Fixes: 13 ("")
   1053 Fixes: 12 (')
    541 Fixes: 16 ("")
    325 Fixes: 10 ("")
    323 Fixes: 40
    274 Fixes:
    272 Fixes: 12 ""
    256 Fixes: 11 ("")
    217 Fixes: 14 ("")
    188 Fixes: commit 12 ("")
    181 Fixes: 8 ("")
    178 Fixes: 7 ("")
    163 Fixes: 9 ("")
     94 Fixes: 15 ("")
     51 Fixes: 12("")
     48 Fixes: 13 (')
     38 Fixes: 12
     35 Fixes: 12(')
     34 Fixes: 40 ("")
     30 Fixes: 12 (""
     28 Fixes: 17 ("")
     24 Fixes: Commit 12 ("")

So for checkpatch, maybe something like the below
would help standardize the Fixes line:
---
 scripts/checkpatch.pl | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 155fa9305166..a1aa3787d0b0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2730,10 +2730,11 @@ sub process {
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
-		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
-		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
+		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i))) {
 			my $init_char = "c";
 			my $orig_commit = "";
+			my $prefix = "commit";
+			my $prefix_case = "[Cc]ommit";
 			my $short = 1;
 			my $long = 0;
 			my $case = 1;
@@ -2744,18 +2745,24 @@ sub process {
 			my $orig_desc = "commit description";
 			my $description = "";
 
-			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
+			if ($line =~ /\b(f)ixes:\s+([0-9a-f]{5,})\b/i) {
+				$init_char = $1;
+				$orig_commit = lc($2);
+				$prefix = "Fixes:";
+				$prefix_case = "Fixes:";
+				$init_char = "F";
+			} elsif ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
 				$init_char = $1;
 				$orig_commit = lc($2);
 			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
+			$short = 0 if ($line =~ /\b$prefix\s+[0-9a-f]{12,40}/i);
+			$long = 1 if ($line =~ /\b$prefix\s+[0-9a-f]{41,}/i);
+			$space = 0 if ($line =~ /\b$prefix [0-9a-f]/i);
+			$case = 0 if ($line =~ /\b$prefix_case\s+[0-9a-f]{5,40}[^A-F]/);
+			if ($line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
 				$orig_desc = $1;
 				$hasparens = 1;
 			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
@@ -2763,10 +2770,10 @@ sub process {
 				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
 				$orig_desc = $1;
 				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
+			} elsif ($line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
 				 defined $rawlines[$linenr] &&
 				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+				$line =~ /\b$prefix\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
 				$orig_desc = $1;
 				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
 				$orig_desc .= " " . $1;
@@ -2779,7 +2786,7 @@ sub process {
 			if (defined($id) &&
 			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style '$prefix <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}" . substr($prefix, 1) . " $id (\"$description\")'\n" . $herecurr);
 			}
 		}
 

