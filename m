Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3B0C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FEE8218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbeL1IKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:10:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:7077 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728006AbeL1IKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:10:00 -0500
X-UUID: c2721f1436b0405aa4f384da51032f57-20181228
X-UUID: c2721f1436b0405aa4f384da51032f57-20181228
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1889686763; Fri, 28 Dec 2018 16:09:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Dec 2018 16:09:50 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Dec 2018 16:09:50 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v5 0/6] Add basic and clock support for Mediatek MT8183 SoC
Date:   Fri, 28 Dec 2018 16:09:35 +0800
Message-ID: <1545984581-25843-1-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 03A174E426CB1C589FDC2791DACB0D395FA53E3951E9A9D31D983E2BDC60B6512000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA53 and 4 CA73 cores.
MT8183 share many HW IP with MT65xx series.
This patchset was tested on MT8183 evaluation board and use correct clock to shell.

This series contains document bindings, device tree including
interrupt, uart, clock, pinctrl, power, iommu, spi, and pwrap.

Based on v4.20-rc1 and
http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016243.html
http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016205.html
http://lists.infradead.org/pipermail/linux-mediatek/2018-October/015676.html

Change in v5:
1. Collect all device tree nodes to the last patch
2. Add PMU
3. Add Signed-off-by
4. Remove clock driver code and binding doc
5. Add pinctrl, iommu, spi, and pwrap nodes

Change in v4:
1. Correct syntax error in dtsi
2. Add MT8183 clock support

Change in v3:
1. Fill out GICC, GICH, GICV regions
2. Update Copyright to 2018

Change in v2:
1. Split dt-bindings into different patches
2. Correct bindings for supported SoCs (mtk-uart.txt)

Ben Ho (1):
  arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
    Makefile

Erin Lo (3):
  dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
  dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
  dt-bindings: serial: Add compatible for Mediatek MT8183

Seiya Wang (1):
  irqchip/mtk-sysirq: support 4 interrupt parameters for sysirq

Zhiyong Tao (1):
  dt-bindings: pinctrl: mt8183: add binding document

 Documentation/devicetree/bindings/arm/mediatek.txt |    4 +
 .../interrupt-controller/mediatek,sysirq.txt       |    1 +
 .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt |  110 ++
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  136 +++
 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h      | 1120 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  547 ++++++++++
 drivers/irqchip/irq-mtk-sysirq.c                   |    4 +-
 9 files changed, 1922 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

--
1.9.1

