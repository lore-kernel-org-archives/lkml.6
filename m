Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7331E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nq1B0cY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbeLQMVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:21:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47234 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732642AbeLQMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:20:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBHCKAmo049694;
        Mon, 17 Dec 2018 06:20:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545049210;
        bh=QtPh+TfEuBq+L53Bg5LvYbgsbkSBr+LqYJCuH0WYoxE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nq1B0cY/9M+6deUlV7V4x5zkPYDWTQGbc3zWNbC0HEAY8Fwxpi9I7FbdBgg7F32DU
         rFpUPlqiANK6Z2Ipsv41qpvuxNCHyNwxfTQ8AVWrnNbkoO19zu39dslEJGFG9wJzuC
         RADkmjAPKVLlikgtIFMSamAVLOZiObLWg1legBLs=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBHCKA5N100612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 06:20:10 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 06:20:10 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 06:20:10 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBHCJuXQ023433;
        Mon, 17 Dec 2018 06:20:08 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <jarkko.nikula@bitmer.com>, <tony@atomide.com>, <nsekhar@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jsarha@ti.com>
Subject: [PATCH 4/9] ARM: OMAP2: Update for new MCBSP Kconfig option
Date:   Mon, 17 Dec 2018 14:21:37 +0200
Message-ID: <20181217122142.6652-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217122142.6652-1-peter.ujfalusi@ti.com>
References: <20181217122142.6652-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCBSP config option has been changed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/Makefile       | 2 +-
 arch/arm/mach-omap2/pdata-quirks.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 01377c292db4..899c60fac159 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -24,7 +24,7 @@ obj-$(CONFIG_SOC_OMAP5)	 += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM43XX) += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_DRA7XX) += $(hwmod-common) $(secure-common)
 
-ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
+ifneq ($(CONFIG_SND_SOC_OMAP_MCBSP),)
 obj-y += mcbsp.o
 endif
 
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 9fec5f84bf77..8a5b6ed4ec36 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -524,7 +524,7 @@ void omap_auxdata_legacy_init(struct device *dev)
 	dev->platform_data = &twl_gpio_auxdata;
 }
 
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
+#if IS_ENABLED(CONFIG_SND_SOC_OMAP_MCBSP)
 static struct omap_mcbsp_platform_data mcbsp_pdata;
 static void __init omap3_mcbsp_init(void)
 {
@@ -572,7 +572,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 	OF_DEV_AUXDATA("ti,am3517-emac", 0x5c000000, "davinci_emac.0",
 		       &am35xx_emac_pdata),
 	/* McBSP modules with sidetone core */
-#if IS_ENABLED(CONFIG_SND_OMAP_SOC_MCBSP)
+#if IS_ENABLED(CONFIG_SND_SOC_OMAP_MCBSP)
 	OF_DEV_AUXDATA("ti,omap3-mcbsp", 0x49022000, "49022000.mcbsp", &mcbsp_pdata),
 	OF_DEV_AUXDATA("ti,omap3-mcbsp", 0x49024000, "49024000.mcbsp", &mcbsp_pdata),
 #endif
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

