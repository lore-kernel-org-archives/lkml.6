Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9653CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50166208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50166208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeGaHR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:17:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24639 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725912AbeGaHRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:17:55 -0400
X-UUID: 8a9652292d1f4ee59f295ae60a51a4e4-20180731
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 119231163; Tue, 31 Jul 2018 13:39:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 31 Jul 2018 13:39:19 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 31 Jul 2018 13:39:19 +0800
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
Subject: [PATCH v4 00/10] Add basic and clock support for Mediatek MT8183 SoC
Date:   Tue, 31 Jul 2018 13:37:57 +0800
Message-ID: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA53 and 4 CA73 cores.
MT8183 share many HW IP with MT65xx series.
This patchset was tested on MT8183 evaluation board and use correct clock to shell.

This series contains document bindings, device tree including interrupt, uart, clock.

Based on v4.18-rc1 and https://patchwork.kernel.org/patch/10528515/
Composed of clock control (PATCH 5-8) and device tree (PATCH 9-10)

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

Weiyi Lu (6):
  dt-bindings: ARM: Mediatek: Document bindings for MT8183
  clk: mediatek: Add dt-bindings for MT8183 clocks
  clk: mediatek: Add flags support for mtk_gate data
  clk: mediatek: Add MT8183 clock support
  arm64: dts: mt8183: Add clock controller device nodes
  dts: arm64: mt8183: add uart node

 Documentation/devicetree/bindings/arm/mediatek.txt |    4 +
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,ipu.txt         |   43 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,vencsys.txt     |    1 +
 .../interrupt-controller/mediatek,sysirq.txt       |    1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |   31 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  268 +++++
 drivers/clk/mediatek/Kconfig                       |   74 ++
 drivers/clk/mediatek/Makefile                      |   12 +
 drivers/clk/mediatek/clk-gate.c                    |    5 +-
 drivers/clk/mediatek/clk-gate.h                    |    3 +-
 drivers/clk/mediatek/clk-mt8183-audio.c            |  112 ++
 drivers/clk/mediatek/clk-mt8183-cam.c              |   75 ++
 drivers/clk/mediatek/clk-mt8183-img.c              |   75 ++
 drivers/clk/mediatek/clk-mt8183-ipu0.c             |   68 ++
 drivers/clk/mediatek/clk-mt8183-ipu1.c             |   68 ++
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c          |   66 ++
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c         |  155 +++
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c           |   66 ++
 drivers/clk/mediatek/clk-mt8183-mm.c               |  128 ++
 drivers/clk/mediatek/clk-mt8183-vdec.c             |   84 ++
 drivers/clk/mediatek/clk-mt8183-venc.c             |   71 ++
 drivers/clk/mediatek/clk-mt8183.c                  | 1230 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                     |    3 +-
 drivers/clk/mediatek/clk-mtk.h                     |    1 +
 include/dt-bindings/clock/mt8183-clk.h             |  413 +++++++
 36 files changed, 3064 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
 create mode 100644 drivers/clk/mediatek/clk-mt8183-audio.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu0.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu1.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu_adl.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-ipu_conn.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8183.c
 create mode 100644 include/dt-bindings/clock/mt8183-clk.h

--
1.9.1

