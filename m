Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012D6C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31E2218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeLRVmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:42:38 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44010 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeLRVmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:42:38 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 11B01207D9; Tue, 18 Dec 2018 22:42:36 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id DC2B6206FF;
        Tue, 18 Dec 2018 22:42:25 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: pcf2123: Add Microcrystal rv2123
Date:   Tue, 18 Dec 2018 22:42:23 +0100
Message-Id: <20181218214223.15981-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for Microcrystal rv2123 as the reset procedure seem
to be differing. However, the current driver works just fine.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt | 1 +
 drivers/rtc/rtc-pcf2123.c                              | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt b/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
index 811124a36d16..1994f601800a 100644
--- a/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
+++ b/Documentation/devicetree/bindings/rtc/nxp,rtc-2123.txt
@@ -2,6 +2,7 @@ NXP PCF2123 SPI Real Time Clock
 
 Required properties:
 - compatible: should be: "nxp,rtc-pcf2123"
+                      or "microcrystal,rv2123"
 - reg: should be the SPI slave chipselect address
 
 Optional properties:
diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index e5222c5d8223..39da8b214275 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -453,6 +453,7 @@ static int pcf2123_remove(struct spi_device *spi)
 #ifdef CONFIG_OF
 static const struct of_device_id pcf2123_dt_ids[] = {
 	{ .compatible = "nxp,rtc-pcf2123", },
+	{ .compatible = "microcrystal,rv2123", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, pcf2123_dt_ids);
-- 
2.20.0

