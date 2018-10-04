Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BC8C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C69121473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C69121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJDTWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:22:20 -0400
Received: from hermes.aosc.io ([199.195.250.187]:43902 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeJDTWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:22:20 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id BD06E6687F;
        Thu,  4 Oct 2018 12:29:11 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 00/10] Allwinner H6 USB support
Date:   Thu,  4 Oct 2018 20:28:45 +0800
Message-Id: <20181004122855.22981-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support for the USB ports (both USB2 and USB3)
on the Allwinner H6 SoC.

The first 6 PATCHes are the USB2 part, and the latter 4 PATCHes are the
USB3 part.

PATCH 1, 2, 3, 7, 8 should go through the PHY tree, and the remaining
patches should go through the armsoc tree via sunxi tree.

Icenowy Zheng (10):
  dt-bindings: phy: add binding for Allwinner H6 USB2 PHY
  phy: sun4i-usb: add support for missing USB PHY index
  phy: sun4i-usb: add support for H6 USB2 PHY
  arm64: allwinner: dts: h6: add USB2-related device nodes
  arm64: allwinner: dts: h6: add USB Vbus regulator
  arm64: allwinner: dts: h6: enable USB2 on Pine H64
  dt-bindings: phy: add binding for Allwinner USB3 PHY
  phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
  arm64: allwinner: dts: h6: add USB3 device nodes
  arm64: allwinner: dts: h6: enable USB3 port on Pine H64

 .../devicetree/bindings/phy/sun4i-usb-phy.txt |   8 +-
 .../bindings/phy/sun50i-usb3-phy.txt          |  23 ++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  46 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 113 +++++++++
 drivers/phy/allwinner/Kconfig                 |  12 +
 drivers/phy/allwinner/Makefile                |   1 +
 drivers/phy/allwinner/phy-sun4i-usb.c         |  26 +-
 drivers/phy/allwinner/phy-sun50i-usb3.c       | 239 ++++++++++++++++++
 8 files changed, 463 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

-- 
2.18.0

