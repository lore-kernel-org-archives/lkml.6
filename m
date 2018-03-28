Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeC1CvR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:51:17 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:49677 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC1CvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:51:15 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/6] clk: meson-axg: Add AO Cloclk and Reset driver
Date: Wed, 28 Mar 2018 10:50:44 +0800
Message-ID: <20180328025050.221585-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch try to add AO clock and Reset driver for Amlogic's
Meson-AXG SoC.
  Please note that patch 6 need to wait for the DTS changes[3] merged
into mainline first, otherwise it will break the serial console.

 patch 1: factor the common code into a dedicated file
 patch 2-4: add the aoclk driver for AXG SoC
 patch 5-6: drop unnecessary clock flags

changes since v2 at [2]: 
 - rework meson_aoclkc_probe() which leverage the of_match_data
 - merge patch 5-6 into this series
 - seperate DTS patch, will send to Kevin Hilman independently
 
changes since v1 at [0]: 
 - rebase to clk-meson's branch 'next/drivers' [1]
 - fix license, update to BSD-3-Clause
 - drop un-used include header file

[0] https://lkml.kernel.org/r/20180209070026.193879-1-yixun.lan@amlogic.com
[1] git://github.com/BayLibre/clk-meson.git branch: next-drivers
[2] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan@amlogic.com
[3] https://lkml.kernel.org/r/20180326081809.49493-4-yixun.lan@amlogic.com

Qiufang Dai (1):
  clk: meson-axg: Add AO Clock and Reset controller driver

Yixun Lan (5):
  clk: meson: aoclk: refactor common code into dedicated file
  dt-bindings: clock: axg-aoclkc: New binding for Meson-AXG SoC
  dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
  clk: meson: drop CLK_SET_RATE_PARENT flag
  clk: meson: drop CLK_IGNORE_UNUSED flag

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |   1 +
 drivers/clk/meson/Makefile                         |   4 +-
 drivers/clk/meson/axg-aoclk.c                      | 163 +++++++++++++++++++++
 drivers/clk/meson/axg-aoclk.h                      |  31 ++++
 drivers/clk/meson/gxbb-aoclk.c                     |  88 ++++-------
 drivers/clk/meson/gxbb-aoclk.h                     |   7 +
 drivers/clk/meson/meson-aoclk.c                    |  79 ++++++++++
 drivers/clk/meson/meson-aoclk.h                    |  35 +++++
 include/dt-bindings/clock/axg-aoclkc.h             |  26 ++++
 include/dt-bindings/reset/axg-aoclkc.h             |  20 +++
 10 files changed, 393 insertions(+), 61 deletions(-)
 create mode 100644 drivers/clk/meson/axg-aoclk.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h
 create mode 100644 drivers/clk/meson/meson-aoclk.c
 create mode 100644 drivers/clk/meson/meson-aoclk.h
 create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
 create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

-- 
2.15.1
