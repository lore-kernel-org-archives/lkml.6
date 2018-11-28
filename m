Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA75C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FE920660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 11:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FE920660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeK1WBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:01:54 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:64270 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeK1WBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 17:01:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="24601424"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Nov 2018 04:00:38 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Wed, 28 Nov 2018 04:00:37 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: at91: add support in soc driver for LPDDR2 SiP
Date:   Wed, 28 Nov 2018 12:00:35 +0100
Message-ID: <20181128110035.10407-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some more SiP components to be detected by this soc.c driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/soc/atmel/soc.c | 8 ++++++++
 drivers/soc/atmel/soc.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 4dd03b099c89..2cc272ddf906 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -90,12 +90,20 @@ static const struct at91_soc __initconst socs[] = {
 		 "sama5d27c 128MiB SiP", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27C_D5M_EXID_MATCH,
 		 "sama5d27c 64MiB SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27C_LD1G_EXID_MATCH,
+		 "sama5d27c 128MiB LPDDR2 SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D27C_LD2G_EXID_MATCH,
+		 "sama5d27c 256MiB LPDDR2 SiP", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CU_EXID_MATCH,
 		 "sama5d28", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28CN_EXID_MATCH,
 		 "sama5d28", "sama5d2"),
 	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28C_D1G_EXID_MATCH,
 		 "sama5d28c 128MiB SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28C_LD1G_EXID_MATCH,
+		 "sama5d28c 128MiB LPDDR2 SiP", "sama5d2"),
+	AT91_SOC(SAMA5D2_CIDR_MATCH, SAMA5D28C_LD2G_EXID_MATCH,
+		 "sama5d28c 256MiB LPDDR2 SiP", "sama5d2"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D31_EXID_MATCH,
 		 "sama5d31", "sama5d3"),
 	AT91_SOC(SAMA5D3_CIDR_MATCH, SAMA5D33_EXID_MATCH,
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 94cd5d1ab502..ed89b24ecee1 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -73,9 +73,13 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA5D26CU_EXID_MATCH		0x00000012
 #define SAMA5D27C_D1G_EXID_MATCH	0x00000033
 #define SAMA5D27C_D5M_EXID_MATCH	0x00000032
+#define SAMA5D27C_LD1G_EXID_MATCH	0x00000061
+#define SAMA5D27C_LD2G_EXID_MATCH	0x00000062
 #define SAMA5D27CU_EXID_MATCH		0x00000011
 #define SAMA5D27CN_EXID_MATCH		0x00000021
 #define SAMA5D28C_D1G_EXID_MATCH	0x00000013
+#define SAMA5D28C_LD1G_EXID_MATCH	0x00000071
+#define SAMA5D28C_LD2G_EXID_MATCH	0x00000072
 #define SAMA5D28CU_EXID_MATCH		0x00000010
 #define SAMA5D28CN_EXID_MATCH		0x00000020
 
-- 
2.15.1

