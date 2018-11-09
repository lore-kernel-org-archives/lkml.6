Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1F8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55BD20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55BD20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeKIWeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:34:20 -0500
Received: from gloria.sntech.de ([185.11.138.130]:58822 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeKIWeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:34:20 -0500
Received: from wd0474.dip.tu-dresden.de ([141.76.109.218] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gL6IH-0008Ln-G1; Fri, 09 Nov 2018 13:53:49 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH] power: supply: bq24190_charger: add support for bq24196 variant
Date:   Fri,  9 Nov 2018 13:53:35 +0100
Message-Id: <20181109125335.1219-1-heiko@sntech.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

The bq24196 is another variant of the bq24190 charger ic.
Its register set is identical to the bq24192 and it even reuses
the same part number (0x5).

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
This should go on top of the bq24192 support patches from Brian Masney /
Jonathan Marek [0]

[0] https://patchwork.kernel.org/patch/10663409/

 drivers/power/supply/bq24190_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 4e64e6ac95c5..effa7c3c21e6 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -143,7 +143,7 @@
 #define BQ24190_REG_VPRS_PN_MASK		(BIT(5) | BIT(4) | BIT(3))
 #define BQ24190_REG_VPRS_PN_SHIFT		3
 #define BQ24190_REG_VPRS_PN_24190			0x4
-#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193 */
+#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193, 24196 */
 #define BQ24190_REG_VPRS_PN_24192I			0x3
 #define BQ24190_REG_VPRS_TS_PROFILE_MASK	BIT(2)
 #define BQ24190_REG_VPRS_TS_PROFILE_SHIFT	2
@@ -1973,6 +1973,7 @@ static const struct i2c_device_id bq24190_i2c_ids[] = {
 	{ "bq24190" },
 	{ "bq24192" },
 	{ "bq24192i" },
+	{ "bq24196" },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
@@ -1982,6 +1983,7 @@ static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
 	{ .compatible = "ti,bq24192", },
 	{ .compatible = "ti,bq24192i", },
+	{ .compatible = "ti,bq24196", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
-- 
2.18.0

