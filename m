Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4A3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52C9208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52C9208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbeHAKcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:32:48 -0400
Received: from regular1.263xmail.com ([211.150.99.141]:39996 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388529AbeHAKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:32:47 -0400
Received: from cl?rock-chips.com (unknown [192.168.167.233])
        by regular1.263xmail.com (Postfix) with ESMTP id 8D06F2B9;
        Wed,  1 Aug 2018 16:47:53 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 3D4C43B2;
        Wed,  1 Aug 2018 16:47:12 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: cl@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: cl@rock-chips.com
X-UNIQUE-TAG: <6ea1cd9c646e38f727e894fb9fdf080a>
X-ATTACHMENT-NUM: 0
X-SENDER: cl@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith ESMTP id 28987SD6HSQ;
        Wed, 01 Aug 2018 16:47:41 +0800 (CST)
From:   <cl@rock-chips.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        klaus.goger@theobroma-systems.com, hjc@rock-chips.com,
        jagan@amarulasolutions.com, djw@t-chip.com.cn,
        jacob-chen@iotwrt.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com, arnd@arndb.de,
        zhangqing@rock-chips.com, shawn.lin@rock-chips.com,
        kever.yang@rock-chips.com, david.wu@rock-chips.com,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com,
        william.wu@rock-chips.com, sandy.huang@rock-chips.com,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH v3 0/4] arm64: dts: rockchip: add basic dts file for PX30 SoCs
Date:   Wed,  1 Aug 2018 16:45:12 +0800
Message-Id: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Changes in v3:
1. backlight: remove properties <brightness-levels>,<num-interpolated-steps>,
<default-brightness-level>, as the driver will compute a default table.

Changes in V2:
1. change the subject to format "dt-bindings: module: ..." for the documents. 
2. use new property <num-interpolated-steps> for backlight.
3. remove pinctrl of rk809, because the driver is not ready.

Liang Chen (4):
  dt-bindings: usb: dwc2: add description for px30
  dt-bindings: rockchip: grf: add grf and pmugrf description for px30
  arm64: dts: rockchip: add core dtsi file for PX30 SoCs
  arm64: dts: rockchip: add PX30 eavluation board devicetree

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  470 +++++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2043 ++++++++++++++++++++
 6 files changed, 2521 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi

-- 
1.9.1


