Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C22C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111DA2403B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jlToWTef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111DA2403B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeFVKQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:16:29 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:23968 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbeFVKQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:16:27 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5MAGMrV011985;
        Fri, 22 Jun 2018 05:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529662582;
        bh=yM52k5AIqCRLxJoMkrem8ub4bodmHk91WUKkcbtfvQs=;
        h=From:To:CC:Subject:Date;
        b=jlToWTef2wrE9gCbpCAcDIwepKuJuM+yQUykzsE7eQTFNLLVuoGQEKdd6JwWPi8ly
         kcX/yiBzBFGgZ2KYjPA2ZqMAWPeYwRShABTek6gjasNMSB03m5nbXLx7dqcw5U1CwB
         pnfyIPsQXkEHhRvMNfjGY55lAZgWh/Ga1jzL1VUg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MAGMOn010010;
        Fri, 22 Jun 2018 05:16:22 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 22
 Jun 2018 05:16:22 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 22 Jun 2018 05:16:21 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MAGI3S032544;
        Fri, 22 Jun 2018 05:16:19 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>, <kishon@ti.com>
CC:     <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH RESEND 0/3] K2G: mmc: Update mmc dt node to use
Date:   Fri, 22 Jun 2018 15:46:14 +0530
Message-ID: <20180622101617.11157-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
binding.

I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
Everyone who use a custom .config should also enable
CONFIG_MMC_SDHCI_OMAP for MMC to work.

Kishon Vijay Abraham I (3):
  ARM: dts: keystone-k2g-evm: Add "vqmmc-supply" property for mmc0/mmc1
  ARM: dts: keystone-k2g-evm: Use sdhci-omap programming model
  ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP

 arch/arm/boot/dts/keystone-k2g-evm.dts | 10 ++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi    | 12 ++++--------
 arch/arm/configs/keystone_defconfig    |  3 +++
 3 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.17.1

