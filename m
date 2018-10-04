Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E600CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF2421479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KCqihe6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF2421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJDSFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:05:25 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60230 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeJDSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:05:25 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94BCWNk103604;
        Thu, 4 Oct 2018 06:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538651552;
        bh=oan4RXhaeIfz/hST/iWIE+4M9ToQ5PoOrj2b4y0Gexw=;
        h=From:To:CC:Subject:Date;
        b=KCqihe6PuxvSkmj1HQF2JNRI00XOZi1Cf0QusrCDQgvB8WE92DZ4QDs9taAS8REUI
         5spi89L5qqtaHBb4EKVoLwe0Uf5ZtgHymIg3MTZSnH06NqjGv2OxpIa4cAUu2/Bwwx
         3CcLFqdvEJJFVvFHtcl/VYUPz9hlCt5ssuo0AaL8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCWbJ020023;
        Thu, 4 Oct 2018 06:12:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 06:12:32 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 06:12:32 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCSLa027478;
        Thu, 4 Oct 2018 06:12:29 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <faiz_abbas@ti.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <catalin.marinas@arm.com>,
        <adrian.hunter@intel.com>
Subject: [PATCH 0/6] Add Support for MMC/SD in TI's AM65x SOCs
Date:   Thu, 4 Oct 2018 16:44:45 +0530
Message-ID: <20181004111451.9539-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add driver support for MMC/SD in TI's
AM65x SOCs. There are two controller instances. Both are compatible
with eMMC5.1 Host Controller Standard Specification and SD Host
Controller Standard Specification 4.10.

DT Support patches will be posted separately.

Faiz Abbas (6):
  dt-bindings: phy: am654-mmc-phy: Document new phy bindings
  phy: am654-mmc-phy: Add Support for MMC PHY on AM654 Devices
  dt-bindings: mmc: sdhci-of-arasan: Add new compatible for AM654 MMC
    PHY
  mmc: sdhci-of-arasan: Add a single data structure to incorporate pdata
    and soc_ctl_map
  mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY
  arm64: defconfig: Enable MMC PHY for AM65xx

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |   1 +
 .../devicetree/bindings/phy/am654-mmc-phy.txt |  42 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/mmc/host/sdhci-of-arasan.c            |  93 +++++-
 drivers/phy/ti/Kconfig                        |   7 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-am654-mmc.c                | 291 ++++++++++++++++++
 7 files changed, 421 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
 create mode 100644 drivers/phy/ti/phy-am654-mmc.c

-- 
2.18.0

