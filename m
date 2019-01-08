Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01140C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1EC2171F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfAHNvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:51:06 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:63162 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfAHNvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:51:05 -0500
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 8 Jan 2019
 21:51:31 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH RESEND v9 0/4] clk: meson: add a sub EMMC clock controller support
Date:   Tue, 8 Jan 2019 21:50:40 +0800
Message-ID: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver will add a MMC clock controller driver support.
The original idea about adding a clock controller is during the
discussion in the NAND driver mainline effort[1].

This driver is tested in the S400 board (AXG platform) with NAND driver.


Changes since v8 [9]
 - fix auto build test ERROR with ARCH=i386

Changes since v7 [8]
 - move meson_clk_get_phase_delay_data() from header to driver
 - CONFIG sclk-div with COMMON_CLK_AMLOGIC instead of COMMON_CLK_AMLOGIC_AUDIO
 - remove onecell date and ID for internal MUX clk
 - use helper for functions for ONE_BASED in sclk-div
 - add ONE_BASED support for duty cycle

Changes since v6 [7]:
 - add one based support for sclk divier
 - alloc sclk in probe for multiple instance
 - fix coding styles

Changes since v5 [6]:
 - remove divider ops with .init and use sclk_div instead
 - drop CLK_DIVIDER_ROUND_CLOSEST in mux and div
 - drop the useless type cast 

Changes since v4 [5]:
 - use struct parm in phase delay driver
 - remove 0 delay releted part in phase delay driver
 - don't rebuild the parent name once again
 - add divider ops with .init

Changes since v3 [4]:
 - separate clk-phase-delay driver
 - replace clk_get_rate() with clk_hw_get_rate()
 - collect Rob's R-Y
 - drop 'meson-' prefix from compatible string

 Changes since v2 [3]:
 - squash dt-binding clock-id patch
 - update license
 - fix alignment
 - construct a clk register helper() function

Changes since v1 [2]:
 - implement phase clock
 - update compatible name
 - adjust file name
 - divider probe() into small functions, and re-use them

[1] https://lkml.kernel.org/r/20180628090034.0637a062@xps13
[2] https://lkml.kernel.org/r/20180703145716.31860-1-yixun.lan@amlogic.com
[3] https://lkml.kernel.org/r/20180710163658.6175-1-yixun.lan@amlogic.com
[4] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan@amlogic.com
[5] https://lkml.kernel.org/r/20180809070724.11935-4-yixun.lan@amlogic.com
[6] https://lkml.kernel.org/r/1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com
[7] https://lkml.kernel.org/r/1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com
[8] https://lkml.kernel.org/r/1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com
[9] https://lkml.kernel.org/r/1545063850-21504-1-git-send-email-jianxin.pan@amlogic.com
Jianxin Pan (1):
  clk: meson: add one based divider support for sclk divider

Yixun Lan (3):
  clk: meson: add emmc sub clock phase delay driver
  clk: meson: add DT documentation for emmc clock controller
  clk: meson: add sub MMC clock controller driver

 .../devicetree/bindings/clock/amlogic,mmc-clkc.txt |  39 +++
 drivers/clk/meson/Kconfig                          |  10 +
 drivers/clk/meson/Makefile                         |   5 +-
 drivers/clk/meson/clk-phase-delay.c                |  73 +++++
 drivers/clk/meson/clkc-audio.h                     |   8 -
 drivers/clk/meson/clkc.h                           |  17 +-
 drivers/clk/meson/mmc-clkc.c                       | 304 +++++++++++++++++++++
 drivers/clk/meson/sclk-div.c                       |  59 ++--
 include/dt-bindings/clock/amlogic,mmc-clkc.h       |  17 ++
 9 files changed, 502 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
 create mode 100644 drivers/clk/meson/clk-phase-delay.c
 create mode 100644 drivers/clk/meson/mmc-clkc.c
 create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h

-- 
1.9.1

