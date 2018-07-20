Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D48ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C348020647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C348020647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388339AbeGTTGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:06:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34859 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbeGTTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:06:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fgZxL-00083u-Gm; Fri, 20 Jul 2018 18:16:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Samuel Ortiz <sameo@linux.intel.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfc: fdp: remove redundant pointer 'client'
Date:   Fri, 20 Jul 2018 19:16:43 +0100
Message-Id: <20180720181643.21340-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'client' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'client' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/nfc/fdp/i2c.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index 70a970c7375c..5d3ea63e405f 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -210,7 +210,6 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 static irqreturn_t fdp_nci_i2c_irq_thread_fn(int irq, void *phy_id)
 {
 	struct fdp_i2c_phy *phy = phy_id;
-	struct i2c_client *client;
 	struct sk_buff *skb;
 	int r;
 
@@ -219,8 +218,6 @@ static irqreturn_t fdp_nci_i2c_irq_thread_fn(int irq, void *phy_id)
 		return IRQ_NONE;
 	}
 
-	client = phy->i2c_dev;
-
 	r = fdp_nci_i2c_read(phy, &skb);
 
 	if (r == -EREMOTEIO)
-- 
2.17.1

