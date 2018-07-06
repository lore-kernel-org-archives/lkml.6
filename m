Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CE7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B102224E8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B102224E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeGFVgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:36:33 -0400
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:59148 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753631AbeGFVgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:36:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2EE5B180A8873;
        Fri,  6 Jul 2018 21:36:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: men15_901adb0c7aa14
X-Filterd-Recvd-Size: 6220
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Jul 2018 21:36:30 +0000 (UTC)
Message-ID: <948af2d06623e8fcca6f0c0fd300a65bbfd1c6fa.camel@perches.com>
Subject: Re: [PATCH] get_maintainer.pl: Add optional
 .get_maintainer.MAINTAINERS override
From:   Joe Perches <joe@perches.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        Don Zickus <dzickus@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jtoppins@redhat.com
Date:   Fri, 06 Jul 2018 14:36:28 -0700
In-Reply-To: <716eb88d-31ac-c488-f799-dec9c9afb5af@redhat.com>
References: <20180626182505.4176-1-prarit@redhat.com>
         <601f0e6bf3baa88b9f6145e635d728a435542292.camel@perches.com>
         <20180706175419.6irtvs64e6dbz7hk@redhat.com>
         <c187fe5040cb616292dab6c106352273df95bc41.camel@perches.com>
         <20180706184411.ilzbt7fxuje2nhx6@redhat.com>
         <716eb88d-31ac-c488-f799-dec9c9afb5af@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 15:39 -0400, Prarit Bhargava wrote:
> 
> On 07/06/2018 02:44 PM, Don Zickus wrote:
> > On Fri, Jul 06, 2018 at 11:31:13AM -0700, Joe Perches wrote:
> > > On Fri, 2018-07-06 at 13:54 -0400, Don Zickus wrote:
> > > > On Tue, Jun 26, 2018 at 01:16:11PM -0700, Joe Perches wrote:
> > > > > On Tue, 2018-06-26 at 14:25 -0400, Prarit Bhargava wrote:
> > > > > > OSes have additional maintainers that should be cc'd on patches or may
> > > > > > want to circulate internal patches.
> > > > > > 
> > > > > > Parse the .get_maintainer.MAINTAINERS file.  Entries in the file
> > > > > > can begin with a '+' to indicate the email and list entries should be
> > > > > > added to the exiting MAINTAINERS output, or a '-' to indicate that the
> > > > > > entries should override the existing MAINTAINERS file.
> > > > > > 
> > > > > > Also add a help entry for the .get_maintainers.ignore file.
> > > > > 
> > > > > I see no reason for this patch to be applied.
> > > > > Why should it?
> > > > > Why shouldn't this be in your private repository?
> > > > 
> > > > Hi Joe,
> > > > 
> > > > Would you be open to a '--mfile=<path>/MAINTAINERS' option that would
> > > > override the default ./MAINTAINERS file?  Then we could just add that to our
> > > > .get_maintainers.conf file.
> > > 
> > > Hi Don.
> > > 
> > > Sure.
> > > 
> > > And that kinda already exists in mainline with
> > > --find-maintainer-files where any subdirectory
> > > that contains a MAINTAINER file is also read.
> > 
> > Hi Joe,
> > 
> > Yes, I saw and played with it.  My only quirk with it was that option still
> > found and added ./MAINTAINERS to the list which I/we were trying to avoid
> > (we have our own private MAINTAINERS copy).
> > 
> > But yes, it easily found our private MAINTAINERS file.
> > 
> > > 
> > > > Just trying to find ways to minimize our collection of private patches.
> > > 
> > > Perhaps that could be extended for your purpose
> > > with some additional argument like a specific
> > > optional directory/path where every subdirectory
> > > would be found.
> > 
> > So something like --find-maintainer-files=<dir> ?  I think that could work.
> 
> So --find-maintainers-files=./kernel/pci
> 
> would only look for MAINTAINERS files under kernel/pci?

Well, perhaps yes.   Perhaps it would also read
a top level MAINTAINERS file.  Dunno.  What seems
right to you?

I don't have an objection to
--find-maintainer-files=<path_or_file> where
the existing behavior of --find-maintainer-files
without <path_or_file> is all subdirs.

Perhaps something like the below
(some of this is whitespace change only)
---
 scripts/get_maintainer.pl | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c87fa734e3e1..2eb11b5c8f34 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -60,7 +60,7 @@ my $pattern_depth = 0;
 my $self_test = undef;
 my $version = 0;
 my $help = 0;
-my $find_maintainer_files = 0;
+my $find_maintainer_files;
 
 my $vcs_used = 0;
 
@@ -262,7 +262,7 @@ if (!GetOptions(
 		'sections!' => \$sections,
 		'fe|file-emails!' => \$file_emails,
 		'f|file' => \$from_filename,
-		'find-maintainer-files' => \$find_maintainer_files,
+		'find-maintainer-files:s' => \$find_maintainer_files,
 		'self-test:s' => \$self_test,
 		'v|version' => \$version,
 		'h|help|usage' => \$help,
@@ -384,26 +384,30 @@ sub find_ignore_git {
 read_all_maintainer_files();
 
 sub read_all_maintainer_files {
-    if (-d "${lk_path}MAINTAINERS") {
-        opendir(DIR, "${lk_path}MAINTAINERS") or die $!;
-        my @files = readdir(DIR);
-        closedir(DIR);
-        foreach my $file (@files) {
-            push(@mfiles, "${lk_path}MAINTAINERS/$file") if ($file !~ /^\./);
-        }
-    }
-
-    if ($find_maintainer_files) {
-        find( { wanted => \&find_is_maintainer_file,
-                preprocess => \&find_ignore_git,
-                no_chdir => 1,
-        }, "${lk_path}");
+    my $path = defined $find_maintainer_files && $find_maintainer_files ne ""
+	? $find_maintainer_files : $lk_path;
+    if (-d "${path}MAINTAINERS") {
+	opendir(DIR, "${path}MAINTAINERS") or die $!;
+	my @files = readdir(DIR);
+	closedir(DIR);
+	foreach my $file (@files) {
+	    push(@mfiles, "${path}MAINTAINERS/$file") if ($file !~ /^\./);
+	}
+    }
+
+    if (defined $find_maintainer_files) {
+	die "$P: invalid find-maintainer-files <$path>" if (!-d $path);
+	find( { wanted => \&find_is_maintainer_file,
+		preprocess => \&find_ignore_git,
+		no_chdir => 1,
+	      }, "${path}");
     } else {
-        push(@mfiles, "${lk_path}MAINTAINERS") if -f "${lk_path}MAINTAINERS";
+	push(@mfiles, "${path}MAINTAINERS") if -f "${path}MAINTAINERS";
     }
 
+    die "$P: No MAINTAINER files found in $path\n" if (scalar(@mfiles) == 0);
     foreach my $file (@mfiles) {
-        read_maintainer_file("$file");
+	read_maintainer_file("$file");
     }
 }
 
