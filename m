Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEB4C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E1B2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E1B2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeGYIJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:09:30 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:8752 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbeGYIJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:09:29 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pB1ZSLA74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6P6x4d5N
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 25 Jul 2018 08:59:04 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 00/32] Device Tree Updates for GTA04 (A3/A4/A5 variants)
Date:   Wed, 25 Jul 2018 08:58:32 +0200
Message-Id: <cover.1532501910.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have not upstreamed significant improvements collected
in the GTA04 vendor kernel tree for some years. The result
is that distribution kernels derived from upstream (e.g.
Debian) lag behind and miss significant features and fixes.


H. Nikolaus Schaller (32):
  ARM: dts: omap3-gta04: fix typo in backlight pins node name
  ARM: dts: omap3-gta04: fix some whitespace and tab style errors
  ARM: dts: omap3-gta04: give spi_lcd node a label so that we can
    overwrite in other DTS files
  ARM: dts: omap3-gta04: fixes for tvout / venc
  ARM: dts: omap3-gta04: add devconf1 setup for correct tvout pins
  ARM: dts: omap3-gta04: tvout: enable as display1 alias
  ARM: dts: omap3-gta04: fix touchscreen tsc2007
  ARM: dts: omap3-gta04: add pinmux for bmp085 EOC interrupt
  ARM: dts: omap3-gta04: make NAND partitions compatible with recent
    U-Boot
  ARM: dts: omap3-gta04: update gpmc NAND setup
  ARM: dts: omap3-gta04: keep vpll2 always on
  ARM: dts: omap3-gta04: add a comment how to reference the tca6507 gpio
  ARM: dts: omap3-gta04: add warning comment to vaux2 regulator
  ARM: dts: omap3-gta04: replace ti,non-removable with generic
    non-removable
  ARM: dts: omap3-gta04: make use of input event include file and
    constants
  ARM: dts: omap3-gta04: map antenna detect GPIO to SW_LINEIN_INSERT key
    event
  ARM: dts: omap3-gta04: add camera interface parallel port
  ARM: dts: omap3-gta04: add camera pinmux
  ARM: dts: omap3-gta04: add mcbsp (audio subsystem) pinmux
  ARM: dts: omap3-gta04: add devconf0 setup for mcbsp1 clock pins
  ARM: dts: omap3-gta04: add mcbsp (audio subsystem) nodes
  ARM: dts: omap3-gta04a3: fix model name for A3 variant
  ARM: dts: omap3-gta04a4: fix model name for A4 variant
  ARM: dts: omap3-gta04a5: fix copyright of A5 variant
  ARM: dts: omap3-gta04a5: fix model name
  ARM: dts: omap3-gta04a5: fix whitepsace and tab style
  ARM: dts: omap3-gta04a5: add support for PPS
  ARM: dts: omap3-gta04a5: disable IrDA receiver to save power
  ARM: dts: omap3-gta04a5: add support for ti,wl1837 module
  ARM: dts: omap3-gta04a5: uses different sensors than gta04a4
  ARM: dts: omap3-gta04a5: define pinmux for bluetooth enable of
    ti,wl1837 module
  ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND

 arch/arm/boot/dts/omap3-gta04.dtsi     | 253 +++++++++++++++++++++++++++++----
 arch/arm/boot/dts/omap3-gta04a3.dts    |   2 +-
 arch/arm/boot/dts/omap3-gta04a4.dts    |   2 +-
 arch/arm/boot/dts/omap3-gta04a5.dts    | 129 ++++++++++++++++-
 arch/arm/boot/dts/omap3-gta04a5one.dts | 114 +++++++++++++++
 5 files changed, 464 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-gta04a5one.dts

-- 
2.12.2

