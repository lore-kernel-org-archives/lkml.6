Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C147C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DBC21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vFVzvyd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DBC21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJDSFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:05:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45898 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeJDSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:05:40 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94BCnH2002952;
        Thu, 4 Oct 2018 06:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538651569;
        bh=W2Q6B80L9aLKGGPaKLSGV86gXzkaYHJG8Wpy/wHR0DI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vFVzvyd3oxaPPenBtoKx7BoBb/ZSRSldG5o8uinJv2fh0rjcPZAvBQza6wvg899rt
         5sYT1HaSpAOUu9ijNuRN0mWqB9y0H5iB58FHs+XR/OH2lYAk22SVFVndKqOWH23F+S
         /3QKrasRrwHXtv7rZY+NGmgQI6BJmXFCNndaue5Q=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCnXG020236;
        Thu, 4 Oct 2018 06:12:49 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 06:12:49 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 06:12:48 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCSLg027478;
        Thu, 4 Oct 2018 06:12:46 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <faiz_abbas@ti.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <catalin.marinas@arm.com>,
        <adrian.hunter@intel.com>
Subject: [PATCH 6/6] arm64: defconfig: Enable MMC PHY for AM65xx
Date:   Thu, 4 Oct 2018 16:44:51 +0530
Message-ID: <20181004111451.9539-7-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004111451.9539-1-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the MMC phy implemented in the AM65xx SOC.
This phy is required for the sdhci host controller
driving the MMC ports.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a51967154caa..d897ec2ba390 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -659,6 +659,7 @@ CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_UNIPHIER_USB2=y
+CONFIG_PHY_AM654_MMC=y
 CONFIG_HISI_PMU=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
-- 
2.18.0

