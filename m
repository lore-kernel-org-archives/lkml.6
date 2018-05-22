Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeEVAjG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:39:06 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:39370 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752102AbeEVAip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:38:45 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1345:1359:1437:1534:1540:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6261:10004:10848:11026:11658:11914:12555:12895:12986:13069:13161:13221:13229:13311:13357:14181:14384:14394:14721:21080:21451:21627:30054:30070,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: home72_4c276aaecec3a
X-Filterd-Recvd-Size: 1722
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] checkpatch: Improve patch recognition
Date: Mon, 21 May 2018 17:38:38 -0700
Message-Id: <974a407e6fa18abd5a965da39cc68986a4c4f091.1526949367.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1526949367.git.joe@perches.com>
References: <cover.1526949367.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are mode change and rename only patches that are unrecognized
by checkpatch.

Recognize them.

Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index baddac9379f0..61849a4d7132 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2375,6 +2375,14 @@ sub process {
 
 		my $rawline = $rawlines[$linenr - 1];
 
+# check if it's a mode change, rename or start of a patch
+		if (!$in_commit_log &&
+		    ($line =~ /^ mode change [0-7]+ => [0-7]+ \S+\s*$/ ||
+		    ($line =~ /^rename (?:from|to) \S+\s*$/ ||
+		     $line =~ /^diff --git a\/[\w\/\.\_\-]+ b\/\S+\s*$/)) {
+			$is_patch = 1;
+		}
+
 #extract the line range in the file after the patch is applied
 		if (!$in_commit_log &&
 		    $line =~ /^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@(.*)/) {
-- 
2.15.0
