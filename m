Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4296EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067AF20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067AF20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeGQI6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:58:49 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:8937 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbeGQI6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:58:49 -0400
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="16320159"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jul 2018 01:27:22 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 17 Jul 2018 01:27:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/4] ARM: at91: pm: add PMC fast startup registers defines
Date:   Tue, 17 Jul 2018 11:26:56 +0300
Message-ID: <1531816017-31986-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
References: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMC fast startup registers defines.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/clk/at91_pmc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 4ea2cbf9b50d..931ab05f771d 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -157,6 +157,19 @@
 #define		AT91_PMC_GCKRDY		(1 << 24)		/* Generated Clocks */
 #define	AT91_PMC_IMR		0x6c			/* Interrupt Mask Register */
 
+#define AT91_PMC_FSMR		0x70		/* Fast Startup Mode Register */
+#define AT91_PMC_FSTT(n)	BIT(n)
+#define AT91_PMC_RTCAL		BIT(17)		/* RTC Alarm Enable */
+#define AT91_PMC_USBAL		BIT(18)		/* USB Resume Enable */
+#define AT91_PMC_SDMMC_CD	BIT(19)		/* SDMMC Card Detect Enable */
+#define AT91_PMC_LPM		BIT(20)		/* Low-power Mode */
+#define AT91_PMC_RXLP_MCE	BIT(24)		/* Backup UART Receive Enable */
+#define AT91_PMC_ACC_CE		BIT(25)		/* ACC Enable */
+
+#define AT91_PMC_FSPR		0x74		/* Fast Startup Polarity Reg */
+
+#define AT91_PMC_FS_INPUT_MASK  0x7ff
+
 #define AT91_PMC_PLLICPR	0x80			/* PLL Charge Pump Current Register */
 
 #define AT91_PMC_PROT		0xe4			/* Write Protect Mode Register [some SAM9] */
-- 
2.7.4

