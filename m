Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0CF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394514AbfAPRIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:08:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47883 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbfAPRIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:08:20 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gjofp-0005L4-Di; Wed, 16 Jan 2019 17:08:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Francois Romieu <romieu@fr.zoreil.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wan: dscc4: fix various indentation issues
Date:   Wed, 16 Jan 2019 17:08:17 +0000
Message-Id: <20190116170817.22383-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are some lines that have indentation issues, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wan/dscc4.c | 50 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wan/dscc4.c b/drivers/net/wan/dscc4.c
index c0b0f525c87c..d5dc823f781e 100644
--- a/drivers/net/wan/dscc4.c
+++ b/drivers/net/wan/dscc4.c
@@ -456,16 +456,16 @@ static int state_check(u32 state, struct dscc4_dev_priv *dpriv,
 	int ret = 0;
 
 	if (debug > 1) {
-	if (SOURCE_ID(state) != dpriv->dev_id) {
-		printk(KERN_DEBUG "%s (%s): Source Id=%d, state=%08x\n",
-		       dev->name, msg, SOURCE_ID(state), state );
+		if (SOURCE_ID(state) != dpriv->dev_id) {
+			printk(KERN_DEBUG "%s (%s): Source Id=%d, state=%08x\n",
+			       dev->name, msg, SOURCE_ID(state), state);
 			ret = -1;
-	}
-	if (state & 0x0df80c00) {
-		printk(KERN_DEBUG "%s (%s): state=%08x (UFO alert)\n",
-		       dev->name, msg, state);
+		}
+		if (state & 0x0df80c00) {
+			printk(KERN_DEBUG "%s (%s): state=%08x (UFO alert)\n",
+			       dev->name, msg, state);
 			ret = -1;
-	}
+		}
 	}
 	return ret;
 }
@@ -1760,25 +1760,25 @@ static void dscc4_rx_irq(struct dscc4_pci_priv *priv,
 	} else { /* SccEvt */
 		if (debug > 1) {
 			//FIXME: verifier la presence de tous les evenements
-		static struct {
-			u32 mask;
-			const char *irq_name;
-		} evts[] = {
-			{ 0x00008000, "TIN"},
-			{ 0x00000020, "RSC"},
-			{ 0x00000010, "PCE"},
-			{ 0x00000008, "PLLA"},
-			{ 0, NULL}
-		}, *evt;
-
-		for (evt = evts; evt->irq_name; evt++) {
-			if (state & evt->mask) {
+			static struct {
+				u32 mask;
+				const char *irq_name;
+			} evts[] = {
+				{ 0x00008000, "TIN"},
+				{ 0x00000020, "RSC"},
+				{ 0x00000010, "PCE"},
+				{ 0x00000008, "PLLA"},
+				{ 0, NULL}
+			}, *evt;
+
+			for (evt = evts; evt->irq_name; evt++) {
+				if (state & evt->mask) {
 					printk(KERN_DEBUG "%s: %s\n",
-						dev->name, evt->irq_name);
-				if (!(state &= ~evt->mask))
-					goto try;
+					       dev->name, evt->irq_name);
+					if (!(state &= ~evt->mask))
+						goto try;
+				}
 			}
-		}
 		} else {
 			if (!(state &= ~0x0000c03c))
 				goto try;
-- 
2.19.1

