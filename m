Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5E720875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5E720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mixed-mode.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbeGXLAq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:00:46 -0400
Received: from mailgate.pixel-group.de ([145.253.133.146]:49240 "EHLO
        mailgate.pixel-group.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbeGXLAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:00:46 -0400
Received: from mail.pixel.de (unknown [10.63.25.81])
        by mailgate.pixel-group.de (Postfix) with ESMTP id 705975E2E5;
        Tue, 24 Jul 2018 11:46:08 +0200 (CEST)
Received: from tragicomix (localhost [127.0.0.1])
        by mail.pixel.de (Postfix) with ESMTP id 40A741A192;
        Tue, 24 Jul 2018 11:46:08 +0200 (CEST)
Received: from neckar.pixel-group.local (10.63.25.31)
 by tragicomix (F-Secure/fsigk_smtp/550/tragicomix);
 Tue, 24 Jul 2018 11:46:08 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/tragicomix)
Received: from lippe.pixel-group.local (10.63.25.67) by
 Neckar.pixel-group.local (10.63.25.31) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 11:46:07 +0200
Received: from lippe.pixel-group.local ([fe80::50c5:3a27:2d73:37cb]) by
 lippe.pixel-group.local ([fe80::50c5:3a27:2d73:37cb%16]) with mapi id
 15.00.1367.000; Tue, 24 Jul 2018 11:46:07 +0200
From:   Sven Schmitt <Sven.Schmitt@mixed-mode.de>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>
Subject: [PATCH v3 3/3] soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes
Thread-Topic: [PATCH v3 3/3] soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes
Thread-Index: AQHUIzJL/ao7CKx3U0KEIQh/qcTgzw==
Date:   Tue, 24 Jul 2018 09:46:07 +0000
Message-ID: <1532425563388.30268@mixed-mode.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.63.25.69]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GPC_PGC_DOMAIN_* indexes consistent.

Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>
---
 drivers/soc/imx/gpc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 35cc1d2dc4d5..6618ff1eaebd 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -247,6 +247,7 @@ builtin_platform_driver(imx_pgc_power_domain_driver)
 #define GPC_PGC_DOMAIN_ARM	0
 #define GPC_PGC_DOMAIN_PU	1
 #define GPC_PGC_DOMAIN_DISPLAY	2
+#define GPC_PGC_DOMAIN_PCI	3
 
 static struct genpd_power_state imx6_pm_domain_pu_state = {
 	.power_off_latency_ns = 25000,
@@ -254,12 +255,13 @@ static struct genpd_power_state imx6_pm_domain_pu_state = {
 };
 
 static struct imx_pm_domain imx_gpc_domains[] = {
-	{
+	[GPC_PGC_DOMAIN_ARM] {
 		.base = {
 			.name = "ARM",
 			.flags = GENPD_FLAG_ALWAYS_ON,
 		},
-	}, {
+	},
+	[GPC_PGC_DOMAIN_PU] {
 		.base = {
 			.name = "PU",
 			.power_off = imx6_pm_domain_power_off,
@@ -269,7 +271,8 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		},
 		.reg_offs = 0x260,
 		.cntr_pdn_bit = 0,
-	}, {
+	},
+	[GPC_PGC_DOMAIN_DISPLAY] {
 		.base = {
 			.name = "DISPLAY",
 			.power_off = imx6_pm_domain_power_off,
@@ -277,7 +280,8 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 		},
 		.reg_offs = 0x240,
 		.cntr_pdn_bit = 4,
-	}, {
+	},
+	[GPC_PGC_DOMAIN_PCI] {
 		.base = {
 			.name = "PCI",
 			.power_off = imx6_pm_domain_power_off,
@@ -343,8 +347,8 @@ static const struct regmap_config imx_gpc_regmap_config = {
 };
 
 static struct generic_pm_domain *imx_gpc_onecell_domains[] = {
-	&imx_gpc_domains[0].base,
-	&imx_gpc_domains[1].base,
+	&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base,
+	&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base,
 };
 
 static struct genpd_onecell_data imx_gpc_onecell_data = {
-- 
2.17.1

