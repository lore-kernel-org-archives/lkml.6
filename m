Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755BB208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aKvmZbyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755BB208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeH1Ega (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:36:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36740 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbeH1Ega (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:36:30 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7S0kx6m017914;
        Mon, 27 Aug 2018 19:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535417219;
        bh=NtOWRFWTsomFEL5SgMUqxoZHadbUztBm41L1mMrybkU=;
        h=From:To:CC:Subject:Date;
        b=aKvmZbyOG0TFTcF54HtB7rTSdoJrvXqBPlKMAKm/vBrpeXzQJi7DmSw3Yi9BhJOZ+
         bBGQl2JAhPF5RQA2x/VBu+rBi+r7cFcXbUod5SB56JAw6MatI+YSSANALD7ySjrlBG
         iXC+VPa5iQX78K4Fx1FymALSHZvGYLu2GBUnxC7M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S0kx12022229;
        Mon, 27 Aug 2018 19:46:59 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 27
 Aug 2018 19:46:58 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 27 Aug 2018 19:46:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7S0kw0I012230;
        Mon, 27 Aug 2018 19:46:58 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, <arm@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: defconfig: Enable TI's AM6 SoC platform
Date:   Mon, 27 Aug 2018 19:46:50 -0500
Message-ID: <20180828004650.2184-1-nm@ti.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable K3 SoC platform for TI's AM6 SoC.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Ref: https://www.spinics.net/lists/arm-kernel/msg667805.html

Unfortunately, Kconfig changes did'nt hit v4.19-rc1 window.
So, as promised, patch based off v4.19-rc1 tag.

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5e93ad..db8d364f8476 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -38,6 +38,7 @@ CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_K3=y
 CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_LG1K=y
 CONFIG_ARCH_HISI=y
@@ -605,6 +606,8 @@ CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
+CONFIG_ARCH_K3_AM6_SOC=y
+CONFIG_SOC_TI=y
 CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
-- 
2.15.1

