Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37DBC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505B52403B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MokTP0+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505B52403B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754376AbeFVKQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:16:38 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:45010 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbeFVKQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:16:35 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5MAGUwZ008831;
        Fri, 22 Jun 2018 05:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529662590;
        bh=OvuX3VmbEesyvQTLeypXNgqkbKAXxCOrae59JoQIP0E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MokTP0+GaSmpmGRgLnk6W50TV4ZnIC35bpFMdULWo20qlUERR6F0ytnfy9cts/vWN
         Dh+huMlL9os8cnEvUj2L5dLv8DLrg6Be6L88fTq/WDS8oXoITqlIuccaS3T2yfeJXl
         vFDuOfGj185ArOhv6HWqXbS9nIG9ORVoFCENo+bc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MAGUU7010133;
        Fri, 22 Jun 2018 05:16:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 22
 Jun 2018 05:16:30 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 22 Jun 2018 05:16:30 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5MAGI3V032544;
        Fri, 22 Jun 2018 05:16:27 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>, <kishon@ti.com>
CC:     <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH RESEND 3/3] ARM: configs: keystone: Enable CONFIG_MMC_SDHCI_OMAP
Date:   Fri, 22 Jun 2018 15:46:17 +0530
Message-ID: <20180622101617.11157-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622101617.11157-1-kishon@ti.com>
References: <20180622101617.11157-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_MMC_SDHCI_OMAP so that TI's K2G SoC
can use sdhci-omap driver for MMC/SD controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/keystone_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 2536c231eea1..21a6ce4ef9bc 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -170,7 +170,10 @@ CONFIG_USB_DWC3=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_OMAP_HS=y
+CONFIG_MMC_SDHCI_OMAP=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
-- 
2.17.1

