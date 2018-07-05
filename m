Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04444219CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M9+J1fF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04444219CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeGEOXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:23:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39668 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753891AbeGEOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:21:49 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w65ELTK1089876;
        Thu, 5 Jul 2018 09:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530800489;
        bh=NpWgezIFP2E+Zt/i1ppwWdo15r31Uun2B+j65AbARgE=;
        h=From:To:CC:Subject:Date;
        b=M9+J1fF10K1Y8Acp3BnYpTraoMmXCzngV3u/3MSdRC5G8jhtu947S9Ainucai2v09
         8QmNiiFkfFlYgCZt2AYmuAHdYFm8/w5HHkZm4F4FoxnINIft1hdizbk6Om6K1fcgOU
         yhiYqeMv2suvnT9ycGfzrGrMSV4IjHO+7tbz9I/o=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w65ELTjN004139;
        Thu, 5 Jul 2018 09:21:29 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 5 Jul
 2018 09:21:28 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 5 Jul 2018 09:21:29 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w65ELPxf020259;
        Thu, 5 Jul 2018 09:21:25 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>, <tony@atomide.com>,
        <paul@pwsan.com>, <t-kristo@ti.com>, <mark.rutland@arm.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v4 0/6] Add MCAN Support for dra76x
Date:   Thu, 5 Jul 2018 19:53:13 +0530
Message-ID: <20180705142319.19583-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add dts and sysconfig support
for MCAN on TI's dra76 SOCs

Changes in v4:
 1. Rebased to latest kernel
 2. Using ddata->cfg.syss_mask instead of ddata->cfg.quirks
    for checking if poll on reset status is required.

Changes in v3:
 1. Added reset functionality to the ti-sysc
    driver. This enables me to drop the hwmod
    data patch as everything is being done in dt.

 2. Dropped ti,hwmods from the dts nodes

 3. Fixed the unit address of target-module
    and mcan

 4. Removed the status="disabled" in dtsi
    followed by status="okay" in dts.

Changes in v2:
 1. Added Support for mcan in the ti-sysc driver
    Also added the target-module node for the same

 2. Added clkctrl data for mcan clocks

Faiz Abbas (4):
  clk: ti: dra7: Add clkctrl clock data for the mcan clocks
  bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
  bus: ti-sysc: Add support for software reset
  ARM: dts: Add generic interconnect target module node for MCAN

Franklin S Cooper Jr (1):
  ARM: dts: dra76x: Add MCAN node

Lokesh Vutla (1):
  ARM: dts: dra762: Add MCAN clock support

 .../devicetree/bindings/bus/ti-sysc.txt       |  1 +
 arch/arm/boot/dts/dra76-evm.dts               |  6 ++
 arch/arm/boot/dts/dra76x.dtsi                 | 64 +++++++++++++++++++
 drivers/bus/ti-sysc.c                         | 57 +++++++++++++++++
 drivers/clk/ti/clk-7xx.c                      |  1 +
 include/dt-bindings/bus/ti-sysc.h             |  2 +
 include/dt-bindings/clock/dra7.h              |  1 +
 include/linux/platform_data/ti-sysc.h         |  1 +
 8 files changed, 133 insertions(+)

-- 
2.17.0

