Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 219E821929
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfBOLui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:50:38 -0500
Received: from olimex.com ([184.105.72.32]:57445 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfBOLuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:50:37 -0500
Received: from localhost.localdomain ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 03:50:36 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC
        DEVICE DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH v2 0/8] leds: Add AXP20X CHGLED
Date:   Fri, 15 Feb 2019 13:50:05 +0200
Message-Id: <20190215115013.11098-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for CHGLED pin found on most of
X-Powers PMICs.

Changes for v2:
- use mutex when accessing hardware registers
- fixed LED naming style
- fixed some typos
- fix variable types when showing attributes
- remove useless private data
- fix binding documentation
- add device consumers

Stefan Mavrodiev (8):
  leds: Add support for AXP20X CHGLED
  mfd: axp20x: Add axp20x-led cell
  dt-bindings: leds: Add binding for axp20x-led device driver
  arm64: dts: allwinner: axp803: add charge led node
  arm64: dts: allwinner: Enable AXP803 CHGLED for Olimex boards
  arm: dts: axpxx: add charge led node
  ARM: dts: sun7i: Enable AXP209 CHGLED for Olimex boards
  ARM: dts: sun8i: a33: Enable AXP223 CHGLED for A33-OLinuXino

 .../devicetree/bindings/leds/leds-axp20x.txt  |  74 +++++
 arch/arm/boot/dts/axp209.dtsi                 |   5 +
 arch/arm/boot/dts/axp22x.dtsi                 |   5 +
 arch/arm/boot/dts/axp81x.dtsi                 |   5 +
 .../arm/boot/dts/sun7i-a20-olimex-som-evb.dts |   6 +
 .../boot/dts/sun7i-a20-olimex-som204-evb.dts  |   6 +
 .../boot/dts/sun7i-a20-olinuxino-lime2.dts    |   6 +
 .../boot/dts/sun7i-a20-olinuxino-micro.dts    |   6 +
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts     |   6 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     |   5 +
 .../dts/allwinner/sun50i-a64-olinuxino.dts    |   6 +
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |   6 +
 drivers/leds/Kconfig                          |  10 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-axp20x.c                    | 291 ++++++++++++++++++
 drivers/mfd/axp20x.c                          |  24 +-
 16 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt
 create mode 100644 drivers/leds/leds-axp20x.c

-- 
2.17.1

