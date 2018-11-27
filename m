Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCF0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8E72086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8E72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeK0Ojx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:39:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:62157 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728097AbeK0Ojw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:39:52 -0500
X-UUID: cf38d4e0fe7647a6b408846c7668c169-20181127
X-UUID: cf38d4e0fe7647a6b408846c7668c169-20181127
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 771860661; Tue, 27 Nov 2018 11:43:03 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 27 Nov 2018 11:43:01 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 27 Nov 2018 11:43:01 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 00/11] Mediatek MT8183 clock and scpsys support
Date:   Tue, 27 Nov 2018 11:42:43 +0800
Message-ID: <20181127034254.24721-2-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181127034254.24721-1-weiyi.lu@mediatek.com>
References: <20181127034254.24721-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A94476A83D50906CF4CBCFE6CB7BEF25ECC514A3385E2ED454D4DCFBF6D46E762000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on v4.20-rc1 and most of changes are
extracted from series below
(clock/scpsys common changes for both MT8183 & MT6765)
https://patchwork.kernel.org/patch/10528495/
(clock support of MT8183)
https://patchwork.kernel.org/patch/10549891/

The whole series is composed of
clock common changes for both MT8183 & MT6765 (PATCH 1-3),
scpsys common changes for both MT8183 & MT6765 (PATCH 4),
clock support of MT8183 (PATCH 5-8), and
scpsys support of MT8183 (PATCH 9-11).

changes since v1:
- refine for better code quality.
- some minor bug fix of clock part, like incorrect control address
  and missing clocks.

Owen Chen (4):
  clk: mediatek: add new clkmux register API
  clk: mediatek: add new member to mtk_pll_data
  clk: mediatek: Disable tuner_en before change PLL rate
  soc: mediatek: add new flow for mtcmos power.

Weiyi Lu (7):
  dt-bindings: ARM: Mediatek: Document bindings for MT8183
  clk: mediatek: Add dt-bindings for MT8183 clocks
  clk: mediatek: Add flags support for mtk_gate data
  clk: mediatek: Add MT8183 clock support
  dt-bindings: soc: fix typo of MT8173 power dt-bindings
  dt-bindings: soc: Add MT8183 power dt-bindings
  soc: mediatek: Add MT8183 scpsys support

 .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |    1 +
 .../bindings/arm/mediatek/mediatek,camsys.txt |   22 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt |    1 +
 .../arm/mediatek/mediatek,infracfg.txt        |    1 +
 .../bindings/arm/mediatek/mediatek,ipu.txt    |   43 +
 .../bindings/arm/mediatek/mediatek,mcucfg.txt |    1 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt  |    1 +
 .../arm/mediatek/mediatek,topckgen.txt        |    1 +
 .../arm/mediatek/mediatek,vdecsys.txt         |    1 +
 .../arm/mediatek/mediatek,vencsys.txt         |    1 +
 .../bindings/soc/mediatek/scpsys.txt          |   14 +
 drivers/clk/mediatek/Kconfig                  |   75 +
 drivers/clk/mediatek/Makefile                 |   14 +-
 drivers/clk/mediatek/clk-gate.c               |    5 +-
 drivers/clk/mediatek/clk-gate.h               |   17 +-
 drivers/clk/mediatek/clk-mt8183-audio.c       |  102 ++
 drivers/clk/mediatek/clk-mt8183-cam.c         |   70 +
 drivers/clk/mediatek/clk-mt8183-img.c         |   70 +
 drivers/clk/mediatek/clk-mt8183-ipu0.c        |   63 +
 drivers/clk/mediatek/clk-mt8183-ipu1.c        |   63 +
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c     |   61 +
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c    |  130 ++
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c      |   61 +
 drivers/clk/mediatek/clk-mt8183-mm.c          |  118 ++
 drivers/clk/mediatek/clk-mt8183-vdec.c        |   74 +
 drivers/clk/mediatek/clk-mt8183-venc.c        |   66 +
 drivers/clk/mediatek/clk-mt8183.c             | 1305 +++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c                |    3 +-
 drivers/clk/mediatek/clk-mtk.h                |    3 +
 drivers/clk/mediatek/clk-mux.c                |  240 +++
 drivers/clk/mediatek/clk-mux.h                |  101 ++
 drivers/clk/mediatek/clk-pll.c                |   45 +-
 drivers/soc/mediatek/Makefile                 |    2 +-
 drivers/soc/mediatek/mtk-scpsys-ext.c         |   99 ++
 drivers/soc/mediatek/mtk-scpsys.c             |  604 +++++++-
 include/dt-bindings/clock/mt8183-clk.h        |  422 ++++++
 include/dt-bindings/power/mt8173-power.h      |    6 +-
 include/dt-bindings/power/mt8183-power.h      |   26 +
 include/linux/soc/mediatek/scpsys-ext.h       |   39 +
 41 files changed, 3889 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ipu.txt
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
 create mode 100644 drivers/clk/mediatek/clk-mux.c
 create mode 100644 drivers/clk/mediatek/clk-mux.h
 create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
 create mode 100644 include/dt-bindings/clock/mt8183-clk.h
 create mode 100644 include/dt-bindings/power/mt8183-power.h
 create mode 100644 include/linux/soc/mediatek/scpsys-ext.h

-- 
2.18.0

