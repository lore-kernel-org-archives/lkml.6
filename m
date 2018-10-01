Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788C6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2292F2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2292F2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeJATsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:48:19 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:58752 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728979AbeJATsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:48:19 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 01 Oct 2018 22:10:32 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 1BCAB7FA93;
        Mon,  1 Oct 2018 22:10:32 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,327,1534777200"; 
   d="scan'208";a="292407159"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii1.idc.renesas.com with ESMTP; 01 Oct 2018 22:10:29 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>, linux-gpio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v7 0/3] Renesas R9A06G032 PINCTRL Driver
Date:   Mon,  1 Oct 2018 14:10:23 +0100
Message-Id: <20181001131026.14635-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the pinctrl driver for the RZ/N1 family of devices, including
the R9A06G032 (RZ/N1D) device.

This series was originally written by Michel Pollet whilst at Renesas, and I
have taken over this work.

Main changes:
v7:
 - Revert changes in v6, and just remove the token pasting

v6:
 - Instead of combining the pin nr and func into a single element, use
   a pair of 8-bit elements.
 - Simplified how the MDIO function is calculated

v5:
 - Address Jacopo's further comments
 - Address Geert's comments

v4:
 - Address Jacopo's comments
 - Add alternative way to use the pinmux prop.
 - Remove mention of gpios.
 - Implement pin_config_group_get()
 - Fix function to get pin configs, i.e. return -EINVAL when disabled.

v3:
 - Use standard DT props instead of proprietary ones.
 - Replace virtual pins used for MDIO muxing with extra funcs.
 - Use pinctrl_utils funcs to handle the maps.
 - Remove the dbg functions to keep things simple.
 - Change the way the functions are defined so it is easy to check
   against the hardware numbering.

v2:
 - Change to generic rzn1 family driver, instead of device specific.
 - Review comments fixed.
 - Fix error handling during probe

Phil Edworthy (3):
  dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
  pinctrl: renesas: Renesas RZ/N1 pinctrl driver
  ARM: dts: r9a06g032: Add pinctrl node

 .../bindings/pinctrl/renesas,rzn1-pinctrl.txt | 153 +++
 arch/arm/boot/dts/r9a06g032.dtsi              |   8 +
 drivers/pinctrl/Kconfig                       |  10 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-rzn1.c                | 948 ++++++++++++++++++
 include/dt-bindings/pinctrl/rzn1-pinctrl.h    | 141 +++
 6 files changed, 1261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-rzn1.c
 create mode 100644 include/dt-bindings/pinctrl/rzn1-pinctrl.h

-- 
2.17.1

