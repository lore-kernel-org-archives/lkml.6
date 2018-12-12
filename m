Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DF6C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B783220849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B783220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeLLKlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:41:13 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:25696 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLLKlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:41:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,344,1539673200"; 
   d="scan'208";a="21413891"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 03:41:12 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Wed, 12 Dec 2018 03:41:11 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <sandeepsheriker.mallikarjun@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: at91: add support in soc driver for new SAM9X60
Date:   Wed, 12 Dec 2018 11:41:10 +0100
Message-ID: <20181212104110.5584-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>

Add detection of new SAM9X60 by this soc.c driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[nicolas.ferre@microchip.com: split patch]
Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
---
 drivers/soc/atmel/soc.c | 2 ++
 drivers/soc/atmel/soc.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 2cc272ddf906..096a83cf0caf 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -66,6 +66,8 @@ static const struct at91_soc __initconst socs[] = {
 	AT91_SOC(AT91SAM9XE128_CIDR_MATCH, 0, "at91sam9xe128", "at91sam9xe128"),
 	AT91_SOC(AT91SAM9XE256_CIDR_MATCH, 0, "at91sam9xe256", "at91sam9xe256"),
 	AT91_SOC(AT91SAM9XE512_CIDR_MATCH, 0, "at91sam9xe512", "at91sam9xe512"),
+	AT91_SOC(SAM9X60_CIDR_MATCH, SAM9X60_EXID_MATCH,
+		 "sam9x60", "sam9x60"),
 #endif
 #ifdef CONFIG_SOC_SAMA5
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D21CU_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index ed89b24ecee1..ee652e4841a5 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -42,6 +42,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9G45_CIDR_MATCH		0x019b05a0
 #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
+#define SAM9X60_CIDR_MATCH		0x019b35a0
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
 #define AT91SAM9M10_EXID_MATCH		0x00000002
@@ -58,6 +59,8 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9N12_EXID_MATCH		0x00000006
 #define AT91SAM9CN11_EXID_MATCH		0x00000009
 
+#define SAM9X60_EXID_MATCH		0x00000000
+
 #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
 #define AT91SAM9XE512_CIDR_MATCH	0x329aa3a0
-- 
2.17.1

