Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D036EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A59B2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xCX6gG0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfBTP05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:26:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50024 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfBTP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:26:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KFPwHd065757;
        Wed, 20 Feb 2019 09:25:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550676358;
        bh=yfgR1fzd7iWRZRBwGvYRuSanRPnPFahgoqcfsyD7zQ4=;
        h=From:To:CC:Subject:Date;
        b=xCX6gG0SeeIAIFMVK5w4TrAT84q5N/tFNEL4dkzpWTYPCuYkcDVaVRltSqN0VRP0J
         MPzYi/MXixielMstfSjSXhIMhQoHOWi/ujZfnpD3/RXRRv0Nx+hNY58IgsBWiJMJHG
         HExcYUP8iL138ss4sIemcEtaq+O5dllGZv4bUytE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KFPwjD085140
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Feb 2019 09:25:58 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 09:25:58 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 09:25:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KFPv99022614;
        Wed, 20 Feb 2019 09:25:57 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/6] ARM: dts: ti: cpsw: switch to phy-gmii-sel phy driver
Date:   Wed, 20 Feb 2019 17:25:13 +0200
Message-ID: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Hence prerequisite patches [1] have been merged already I'm sending final set
of DT patches to complete conversation of TI CPSW driver to use phy-gmii-sel
phy driver instead of cpsw-phy-sel. 

[1] https://lkml.org/lkml/2018/11/26/154

Grygorii Strashko (6):
  ARM: dts: dra7: switch to use phy-gmii-sel
  ARM: dts: dm814x: switch to use phy-gmii-sel
  ARM: dts: am4372: switch to use phy-gmii-sel
  ARM: dts: am335x: switch to use phy-gmii-sel
  dt-bindings: net: ti: deprecate cpsw-phy-sel bindings
  net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver

 .../devicetree/bindings/net/cpsw-phy-sel.txt    |  2 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts      |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts      |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      |  4 ----
 arch/arm/boot/dts/am335x-chiliboard.dts         |  4 ----
 arch/arm/boot/dts/am335x-icev2.dts              |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi          |  4 ----
 arch/arm/boot/dts/am335x-lxm.dts                |  4 ----
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi    |  5 -----
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts  |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |  4 ----
 arch/arm/boot/dts/am33xx-l4.dtsi                | 15 ++++++++-------
 arch/arm/boot/dts/am437x-l4.dtsi                | 17 +++++++++--------
 arch/arm/boot/dts/am43x-epos-evm.dts            |  5 +----
 arch/arm/boot/dts/dm814x.dtsi                   | 15 +++++++++------
 arch/arm/boot/dts/dra7-l4.dtsi                  | 15 ++++++++-------
 drivers/net/ethernet/ti/Kconfig                 |  6 +++---
 drivers/net/ethernet/ti/cpsw.h                  |  6 ++++++
 18 files changed, 45 insertions(+), 78 deletions(-)

-- 
2.17.1

