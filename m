Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA1FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D8620874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D8620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbeGVRrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:12 -0400
Received: from mout.perfora.net ([74.208.4.194]:51027 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbeGVRrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:11 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Mgdfd-1fL3br0az1-00O2Xo; Sun, 22 Jul 2018 18:49:44 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 00/28] ARM: dts: tegra: apalis_t30: major revamp incl. v1.1 hardware support
Date:   Sun, 22 Jul 2018 18:49:08 +0200
Message-Id: <20180722164936.20581-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:ig2vguf4Zw3YRa6u0GsjCUtkxzw+pCojGbLLiy+9cPayI847MQH
 wWt8AZbRtvEG1sK7sdnzZ4H6vvkUEsWo1c+wUsPnYIsXvxkjUpRyciZG1uDNJowai1PIwk+
 GcjuiQHgb4K+wd0qARJ7MD1ouYnXb2Iunyh9/AVRw+tFgRjVMNIL1VjnRdx/ey9+l26ZXCb
 p0XiZ1Cz7LCg6CRewW9gA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Fo7fAvsyi8w=:ME+nOPdv4Bstf5yDciXQhq
 vG2Xyo7WaxVQZ9I2a4wMb3QnZqvxrTHNaC70YM/nGS9QiaShqyjiJg+uhxmwITPYyOOzSp4Pj
 qUn+LT0LS0cpJnGEa/PcfRx2cPLKrnkjPVuyHpjv0Zf1W8gQOzvIwPBRIkA9H6/MNto4hj/It
 y2EL8mb1aJa+KiyRRR1HnKtZj0Ndhz8KnqyJfFkDyyeeK4ifdm93HDPx9tHmCp1aRxtcig0Zv
 4hGZE1Oq3CQEWbWCF4PmlVs52QnlCWrXpQPTJbQ+osNNYoVcxHZgN8Ibyvl7EWSTqLJr27NRz
 FbLWMjif83JyirlAtsJUnwLMBPRvkRZjdjM1Tef9hHVgq+sZ0dhwUcoHpuXrgT6rRcNFPN6wy
 zjQGBS+omt0eiZ17ELRqo24tb0mQjn9ycnFbG+ZNB/dNzn1fKSPpGWW1s2iLtlKHiwHc+3Cly
 Wetapky3hlQJtIthceOAlAZrp52kk383jtAzlRCHjJRSJ198QOcst1tOuDlUgL0sXaHseMK+T
 R8nAKZLxUadJNdwjgUylNU9CYWFCn2CKQEQwgitwqvwSNILBk/4q+84th2Y5feJejQrEClBqa
 i5X2wB0M5ZiWNrOIE2s5F5juycFqp922f0QSiYync/ZG5LB3Fk1cqU3zxXledbOoLPQzwkgct
 +QAdovTYeIqhXc4g3sJN3CU6w34SVOuq/rUZF3h9zFIDoyMCMX+aDnLwvsx7umNupOE4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a major overhaul and adds support for the V1.1 hardware
revision of the Toradex Apalis T30 system on module.

Marcel Ziswiler (28):
  ARM: tegra: apalis_t30: enable broken-hpi on emmc
  ARM: tegra: apalis_t30: fix mmc1 cmd pull-up
  ARM: tegra: apalis_t30: pull-up sd card detect pins
  ARM: tegra: apalis_t30: add local-mac-address property
  ARM: tegra: apalis_t30: reorder pcie properties
  ARM: tegra: apalis_t30: annotate pcie port nodes
  ARM: tegra: apalis_t30: reorder host1x/hdmi properties
  ARM: tegra: apalis_t30: regulator clean-up
  ARM: tegra: apalis_t30: add missing regulators
  ARM: tegra: apalis_t30: annotate uarts
  ARM: tegra: apalis_t30: drop unused cami2c label
  ARM: tegra: apalis_t30: white-space clean-up
  ARM: tegra: apalis_t30: drop unused mmc1/sd1 labels
  ARM: tegra: apalis_t30: annotate mmc1/sd1
  ARM: tegra: apalis_t30: move dr_mode property from phy to controller
  ARM: tegra: apalis_t30: reorder backlight properties
  ARM: tegra: apalis_t30: drop pwmleds
  ARM: tegra: apalis_t30: pinmux clean-up
  ARM: tegra: apalis_t30: add missing pinmux
  ARM: tegra: apalis_t30: use proper irq-gpio for stmpe811
  ARM: tegra: apalis_t30: further lm95245 temperature sensor annotation
  ARM: tegra: apalis_t30: add i2c-thermtrip
  ARM: tegra: apalis_t30: add proper emmc vmmc and vqmmc supplies
  ARM: tegra: apalis_t30: enable emmc ddr52 mode
  ARM: tegra: apalis_t30: rename clk to clock
  ARM: tegra: apalis_t30: line break long compatible property line
  ARM: tegra: apalis_t30: fix pcie switch vendor compatible
  ARM: tegra: apalis_t30: support v1.1 hardware revision

 Documentation/devicetree/bindings/arm/tegra.txt |    2 +
 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/tegra30-apalis-eval.dts       |  116 +--
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts  |  280 ++++++
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi      | 1189 +++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi           |  595 ++++++++++--
 6 files changed, 2013 insertions(+), 170 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi

-- 
2.14.4

