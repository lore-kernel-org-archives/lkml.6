Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7FC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E520620881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbfAaIZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:25:32 -0500
Received: from olimex.com ([184.105.72.32]:43365 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfAaIZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:25:30 -0500
Received: from localhost.localdomain ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:25:26 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC
        DEVICE DRIVERS)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 2/5] mfd: axp20x: Add axp20x-led cell
Date:   Thu, 31 Jan 2019 10:23:04 +0200
Message-Id: <20190131082308.22522-2-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131082308.22522-1-stefan@olimex.com>
References: <20190131082308.22522-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add axp20x-led cell for AXP20x, AXP221, AXP223, AXP228, AXP803, AXP809
and AXP813.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/mfd/axp20x.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 3c97f2c0fdfe..e6ab078f0462 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -610,6 +610,9 @@ static const struct mfd_cell axp20x_cells[] = {
 		.of_compatible	= "x-powers,axp202-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_usb_power_supply_resources),
 		.resources	= axp20x_usb_power_supply_resources,
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -636,6 +639,9 @@ static const struct mfd_cell axp221_cells[] = {
 		.of_compatible	= "x-powers,axp221-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
 		.resources	= axp22x_usb_power_supply_resources,
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -662,6 +668,9 @@ static const struct mfd_cell axp223_cells[] = {
 		.of_compatible	= "x-powers,axp223-usb-power-supply",
 		.num_resources	= ARRAY_SIZE(axp22x_usb_power_supply_resources),
 		.resources	= axp22x_usb_power_supply_resources,
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -719,6 +728,9 @@ static const struct mfd_cell axp288_cells[] = {
 		.resources	= axp288_power_button_resources,
 	}, {
 		.name		= "axp288_pmic_acpi",
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -741,8 +753,12 @@ static const struct mfd_cell axp803_cells[] = {
 		.of_compatible	= "x-powers,axp813-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
 		.resources	= axp20x_ac_power_supply_resources,
+	}, {
+		.name		= "axp20x-regulator"
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
-	{	.name		= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
@@ -769,6 +785,9 @@ static const struct mfd_cell axp809_cells[] = {
 	}, {
 		.id		= 1,
 		.name		= "axp20x-regulator",
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
@@ -793,6 +812,9 @@ static const struct mfd_cell axp813_cells[] = {
 		.of_compatible	= "x-powers,axp813-ac-power-supply",
 		.num_resources	= ARRAY_SIZE(axp20x_ac_power_supply_resources),
 		.resources	= axp20x_ac_power_supply_resources,
+	}, {
+		.name		= "axp20x-led",
+		.of_compatible	= "x-powers,axp20x-led",
 	},
 };
 
-- 
2.17.1

