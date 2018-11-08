Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F367ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5F82081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5F82081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeKHWut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:50:49 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:27678 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHWut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:50:49 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 8 Nov 2018
 21:15:22 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/2] clk: meson-g12a: Add EE clock controller driver
Date:   Thu, 8 Nov 2018 21:15:09 +0800
Message-ID: <1541682912-120480-1-git-send-email-jian.hu@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3 at[4]
-add fixed clocks clk_regmap definition

Changes since v2 at[2]
-fix fixed clocks's descriptions
-fix aligment
-add enable bit for plls base on [3] patches
-add fixed clock gate bit

Changes since v1 at[1]
-fix typo of 'Everything'.
-change the word 'AmLogic' to 'Amlogic'
-squash patch 1 and 2.
-delete usless message of "Trying obsolete regs".
-delete the empty line in include/dt-bindings/clock/g12a-clkc.h.
-rebase on top of the "next/drivers" branch, and add g12a clock patch.
-add CLK_MUX_ROUND_CLOSEST for g12a_sd_emmc_b_clk0_sel and
 g12a_sd_emmc_c_clk0_sel.

[1]https://lkml.kernel.org/r/1531133549-25806-2-git-send-email-jian.hu@amlogic.com
[2]https://lkml.kernel.org/r/1531728707-192230-2-git-send-email-jian.hu@amlogic.com
[3]https://lkml.kernel.org/r/20180717095617.12240-1-jbrunet@baylibre.com
[4]https://lkml.kernel.org/r/1533890858-113020-1-git-send-email-jian.hu@amlogic.com

Jian Hu (2):
  dt-bindings: clk: meson-g12a: Add G12A EE Clock Bindings
  clk: meson-g12a: Add EE Clock controller driver

 .../bindings/clock/amlogic,gxbb-clkc.txt           |    1 +
 drivers/clk/meson/Kconfig                          |   10 +
 drivers/clk/meson/Makefile                         |    1 +
 drivers/clk/meson/g12a.c                           | 1134 ++++++++++++++++++++
 drivers/clk/meson/g12a.h                           |  128 +++
 include/dt-bindings/clock/g12a-clkc.h              |   93 ++
 6 files changed, 1367 insertions(+)
 create mode 100644 drivers/clk/meson/g12a.c
 create mode 100644 drivers/clk/meson/g12a.h
 create mode 100644 include/dt-bindings/clock/g12a-clkc.h

-- 
1.9.1

