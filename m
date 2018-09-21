Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0E3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C852147C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C852147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389460AbeIUOWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:22:40 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:34904 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIUOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:22:40 -0400
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Fri, 21 Sep 2018
 16:35:17 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/2] arm64: dts: meson-g12a: Introduce new DT files for Meson-G12A SoC
Date:   Fri, 21 Sep 2018 16:34:39 +0800
Message-ID: <1537518881-53137-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This attempt will try to add new DT files to support Meson-G12A SoC.

1) first, Please notice that, in this patch series, the DT node about 16M reserved
memory for hwrom is removed, since it's not needed by G12A SoC.
2) second, the pclk for uart_AO need to be fixed once G12A clock_ao driver is
merged. In this version, it rely on bootloader to enable the pclk gate which 
belong to AO clock domain. Please add clk_ignore_unused to bootargs.

Changes since v4 [3]:
 - add chosen and memory node

Changes since v3 [2]:
 - collect Rob's Reviewed-by
 - test on latest v4.20/integ

Changes since v2 [1]:
 - reorder subnodes
 - collect Rob's Reviewed-by

Changes since v1 [0]:
 - fix signoff typo
 - order subnodes by addresses when there is one and alphabetically when there is none


[0] https://lore.kernel.org/lkml/1533802951-49919-2-git-send-email-jianxin.pan@amlogic.com
[1] https://lore.kernel.org/lkml/1534160901-22889-1-git-send-email-jianxin.pan@amlogic.com
[2] https://lore.kernel.org/lkml/1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com
[3] https://lore.kernel.org/lkml/1537427368-11104-1-git-send-email-jianxin.pan@amlogic.com

Jianxin Pan (2):
  dt-bindings: arm: amlogic: Add Meson G12A binding
  arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support

 Documentation/devicetree/bindings/arm/amlogic.txt |   6 +
 arch/arm64/boot/dts/amlogic/Makefile              |   1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts   |  29 ++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 172 ++++++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi

-- 
1.9.1

