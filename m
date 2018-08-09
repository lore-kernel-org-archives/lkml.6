Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7932C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA9F21C2E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA9F21C2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbeHIKqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:46:03 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:33094 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHIKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:46:03 -0400
Received: from droid02.amlogic.com (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 9 Aug 2018
 16:22:22 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@caione.org>,
        Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>
Subject: [PATCH 0/2] arm64: dts: meson-g12a: Introduce new DT files for Meson-G12A SoC
Date:   Thu, 9 Aug 2018 16:22:29 +0800
Message-ID: <1533802951-49919-1-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianxin <jianxin.pan@amlogic.com>

This attempt will try to add new DT files to support Meson-G12A SoC.

1) first, Please notice that, in this patch series, the DT node about 16M reserved
memory for hwrom is removed, since it's not needed by G12A SoC.
2) second, the pclk for uart_AO need to be fixed once G12A clock_ao driver is
merged. In this version, it rely on bootloader to enable the pclk gate which 
belong to AO clock domain. Please add clk_ignore_unused to bootargs.


Jianxin Pan (2):
  dt-bindings: arm: amlogic: Add Meson G12A binding
  arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support

 Documentation/devicetree/bindings/arm/amlogic.txt |   6 +
 arch/arm64/boot/dts/amlogic/Makefile              |   1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts   |  22 +++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 174 ++++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi

-- 
1.9.1

