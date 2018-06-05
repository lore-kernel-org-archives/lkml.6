Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeFEQMl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:12:41 -0400
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:46334 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751727AbeFEQMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:12:40 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:541:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2829:2898:3138:3139:3140:3141:3142:3352:3740:3865:3866:3867:3868:3870:3871:3872:3874:4250:4605:5007:6117:7903:9121:9707:10004:10400:10848:11026:11658:11914:12043:12555:12679:12760:13069:13311:13357:13439:14181:14394:14659:14721:21080:21324:21627:30054:30070:30090,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:33,LUA_SUMMARY:none
X-HE-Tag: anger40_16f6186749844
X-Filterd-Recvd-Size: 1871
Message-ID: <7eeefc862194930c773e662cb2152e178441d3b8.camel@perches.com>
Subject: [PATCH] spdxcheck: Work with current HEAD LICENSES/ directory
From: Joe Perches <joe@perches.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Tue, 05 Jun 2018 09:12:35 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on how old your -next tree is, it may
not have a master that has the LICENSES directory.

Change the lookup to HEAD and find whatever
LICENSE directory files are used in that branch.

Miscellanea:

o Remove the checkpatch test as it will have its own
  SPDX license identifier.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/spdxcheck.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 7deaef297f52..a6041f29b18e 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -32,7 +32,7 @@ def read_spdxdata(repo):
 
     # The subdirectories of LICENSES in the kernel source
     license_dirs = [ "preferred", "other", "exceptions" ]
-    lictree = repo.heads.master.commit.tree['LICENSES']
+    lictree = repo.head.commit.tree['LICENSES']
 
     spdx = SPDXdata()
 
@@ -199,8 +199,6 @@ def scan_git_tree(tree):
             continue
         if el.path.find("license-rules.rst") >= 0:
             continue
-        if el.path == 'scripts/checkpatch.pl':
-            continue
         if not os.path.isfile(el.path):
             continue
         parser.parse_lines(open(el.path), args.maxlines, el.path)
