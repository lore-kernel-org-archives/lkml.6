Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeEMWFv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 18:05:51 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:46196 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751053AbeEMWFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 18:05:50 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1515:1516:1518:1534:1539:1567:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2901:3138:3139:3140:3141:3142:3876:3877:4321:5007:6114:6642:7904:10004:10400:10848:11026:11473:11658:11914:12043:12296:12555:12679:12760:13069:13161:13229:13311:13357:13439:14181:14394:14659:14721:21080:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: chair25_15adb5117df0a
X-Filterd-Recvd-Size: 1307
Message-ID: <6cb70923c547bb95496833593f994f4e2de6b0ab.camel@perches.com>
Subject: [PATCH] cramfs: Fix IS_ENABLED typo
From: Joe Perches <joe@perches.com>
To: Nicolas Pitre <nico@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Date: Sun, 13 May 2018 15:05:47 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an extra C here...

Fixes: 99c18ce580c6 ("cramfs: direct memory access support")
Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/cramfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 017b0ab19bc4..124b093d14e5 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -492,7 +492,7 @@ static void cramfs_kill_sb(struct super_block *sb)
 {
 	struct cramfs_sb_info *sbi = CRAMFS_SB(sb);
 
-	if (IS_ENABLED(CCONFIG_CRAMFS_MTD) && sb->s_mtd) {
+	if (IS_ENABLED(CONFIG_CRAMFS_MTD) && sb->s_mtd) {
 		if (sbi && sbi->mtd_point_size)
 			mtd_unpoint(sb->s_mtd, 0, sbi->mtd_point_size);
 		kill_mtd_super(sb);
