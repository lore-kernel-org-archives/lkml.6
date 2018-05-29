Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965741AbeE2R4l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:56:41 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:37349 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965453AbeE2R4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:56:39 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:541:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3865:3867:3870:3872:3874:4321:5007:10004:10400:10848:11026:11232:11657:11658:11914:12555:12760:12986:13069:13311:13357:13439:14181:14659:14721:21080:21627:30054:30070,0,RBL:172.56.40.139:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: pump72_56ece9852f51f
X-Filterd-Recvd-Size: 1489
Message-ID: <af44c893f6973393f2a5b11f1a8e5cd4c8bbbba5.camel@perches.com>
Subject: [-next fix PATCH] checkpatch: Fix missing close parenthesis
From: Joe Perches <joe@perches.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 29 May 2018 10:56:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest -next has a missing close parenthesis in the
patch that adds better recognition for rename only patches.

Add it.

Signed-off-by: Joe Perches <joe@perches.com>
---

Dunno how that happened.

Maybe this could be rolled into the appropriate patch
that added this change.

 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f1fecd8aa4d7..3f936b046213 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2379,7 +2379,7 @@ sub process {
 		if (!$in_commit_log &&
 		    ($line =~ /^ mode change [0-7]+ => [0-7]+ \S+\s*$/ ||
 		    ($line =~ /^rename (?:from|to) \S+\s*$/ ||
-		     $line =~ /^diff --git a\/[\w\/\.\_\-]+ b\/\S+\s*$/)) {
+		     $line =~ /^diff --git a\/[\w\/\.\_\-]+ b\/\S+\s*$/))) {
 			$is_patch = 1;
 		}
 
