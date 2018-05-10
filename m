Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966514AbeEJPsg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:48:36 -0400
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:38804 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966087AbeEJPq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:46:27 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1345:1359:1437:1534:1540:1711:1714:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3350:3867:4321:4419:5007:6261:6642:10004:10848:11026:11658:11914:12043:12296:12555:12895:12986:13069:13311:13357:14181:14384:14394:14721:21080:21433:21451:21627:30054,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: stone28_1b0b4a5daf327
X-Filterd-Recvd-Size: 1617
From: Joe Perches <joe@perches.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] ptp: Remove pr_fmt duplicate logging prefixes
Date: Thu, 10 May 2018 08:45:35 -0700
Message-Id: <5b315a623c63fd82df0540e27a130aaabd8c3b49.1525964385.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1525964381.git.joe@perches.com>
References: <cover.1525964381.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting pr_fmt from a simple define to use KBUILD_MODNAME added
some duplicate logging prefixes to existing uses.

Remove them.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/ptp/ptp_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 7eacc1c4b3b1..35d9e1aa6564 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -396,13 +396,13 @@ static int __init ptp_init(void)
 
 	ptp_class = class_create(THIS_MODULE, "ptp");
 	if (IS_ERR(ptp_class)) {
-		pr_err("ptp: failed to allocate class\n");
+		pr_err("failed to allocate class\n");
 		return PTR_ERR(ptp_class);
 	}
 
 	err = alloc_chrdev_region(&ptp_devt, 0, MINORMASK + 1, "ptp");
 	if (err < 0) {
-		pr_err("ptp: failed to allocate device region\n");
+		pr_err("failed to allocate device region\n");
 		goto no_region;
 	}
 
-- 
2.15.0
