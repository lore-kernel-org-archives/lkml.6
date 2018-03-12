Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeCLHDw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:03:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37968 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751878AbeCLHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:03:49 -0400
X-UUID: e5b82e0c334245f6b54c610050d2bc23-20180312
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
CC: James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 0/5] update Mediatek MT2712 clock and scpsys support 
Date: Mon, 12 Mar 2018 15:03:36 +0800
Message-ID: <20180312070342.4335-1-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on v4.16-rc1 and composed of scpsys control (PATCH 1-2) and clock control (PATCH 3-5).
Basically, all changes are for the ECO design change of MT2712.

changes since v1:
- Avoid renumbering clocks. Append new clocks at the bottom of each own subsystem.

Weiyi Lu (5):
  dt-bindings: soc: update MT2712 power dt-bindings
  soc: mediatek: update power domain data of MT2712
  dt-bindings: clock: add clocks for MT2712
  arm64: dts: add clock device nodes of MT2712
  clk: mediatek: update clock driver of MT2712

 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 28 +++++++++++++
 drivers/clk/mediatek/clk-mt2712.c         | 69 ++++++++++++++++++++++++-------
 drivers/soc/mediatek/mtk-scpsys.c         | 42 ++++++++++++++++++-
 include/dt-bindings/clock/mt2712-clk.h    | 12 +++++-
 include/dt-bindings/power/mt2712-power.h  |  3 ++
 5 files changed, 136 insertions(+), 18 deletions(-)
