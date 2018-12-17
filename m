Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C460C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020E420645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V6vy225R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbeLQMUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:20:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59170 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732384AbeLQMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:20:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBHCKDhR078140;
        Mon, 17 Dec 2018 06:20:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545049213;
        bh=S+Kh2jM3SArB/Z0GAWyT0DgmdQJ/9Ni6nS3Z48n1Ss4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V6vy225Rc3up5hP47Ntbvod9GledugWmOnYytQfiRSr0kJFaitpurhp1xlaZr9lGJ
         8TLuftx6jSEV9rhPmuGH85+vwVAgtk7UYqE+fVIbSCqF2GHd5i09VtZ2QPRVRhjn65
         gslJRnlD6BRJCCfaTEmUJCm5v4YUapQXSnxT2ZiQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBHCKDfn100634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 06:20:13 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 06:20:13 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 06:20:13 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBHCJuXR023433;
        Mon, 17 Dec 2018 06:20:10 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <jarkko.nikula@bitmer.com>, <tony@atomide.com>, <nsekhar@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jsarha@ti.com>
Subject: [PATCH 5/9] ARM: davinci: dm365-evm: Update for the new ASoC Kcofnig options
Date:   Mon, 17 Dec 2018 14:21:38 +0200
Message-ID: <20181217122142.6652-6-peter.ujfalusi@ti.com>
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

The codec selection config options for DMA365 has been changed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 8143756ff38b..09e439d4abf5 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -794,9 +794,9 @@ static __init void dm365_evm_init(void)
 	/* maybe setup mmc1/etc ... _after_ mmc0 */
 	evm_init_cpld();
 
-#ifdef CONFIG_SND_DM365_AIC3X_CODEC
+#ifdef CONFIG_SND_SOC_DM365_AIC3X_CODEC
 	dm365_init_asp();
-#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
+#elif defined(CONFIG_SND_SOC_DM365_VOICE_CODEC)
 	dm365_init_vc();
 #endif
 	dm365_init_rtc();
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

