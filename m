Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D484BC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23492184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeLRVw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:52:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44215 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeLRVw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:52:27 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E418C207BE; Tue, 18 Dec 2018 22:52:24 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id BBCE3206FF;
        Tue, 18 Dec 2018 22:52:14 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: pcf8523: Add rv8523 compatible
Date:   Tue, 18 Dec 2018 22:52:12 +0100
Message-Id: <20181218215212.17039-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microcrystal RV-8523 is compatible with the PCF8523.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/rtc/rtc.txt | 1 +
 drivers/rtc/rtc-pcf8523.c                     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 7c8da6926095..21d885fa56a8 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -49,6 +49,7 @@ isil,isl1208		Intersil ISL1208 Low Power RTC with Battery Backed SRAM
 isil,isl1218		Intersil ISL1218 Low Power RTC with Battery Backed SRAM
 isil,isl12022		Intersil ISL12022 Real-time Clock
 microcrystal,rv3029	Real Time Clock Module with I2C-Bus
+microcrystal,rv8523	Real Time Clock
 nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
 nxp,pcf8523		Real-time Clock
diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index 3fcd2cbafc84..fb13933f4006 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -374,6 +374,7 @@ MODULE_DEVICE_TABLE(i2c, pcf8523_id);
 #ifdef CONFIG_OF
 static const struct of_device_id pcf8523_of_match[] = {
 	{ .compatible = "nxp,pcf8523" },
+	{ .compatible = "microcrystal,rv8523" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcf8523_of_match);
-- 
2.20.0

