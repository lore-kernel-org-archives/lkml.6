Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965BB20868
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfAPSiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:38:14 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:60285 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728404AbfAPSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:38:14 -0500
X-IronPort-AV: E=Sophos;i="5.56,487,1539615600"; 
   d="scan'208";a="5151662"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Jan 2019 03:38:10 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.13])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 448FC40F10DB;
        Thu, 17 Jan 2019 03:38:04 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-clk@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        linux-kernel@vger.kernel.org, ebiharaml@si-linux.co.jp
Subject: [PATCH 00/11] Add basic EK874 support
Date:   Wed, 16 Jan 2019 18:37:43 +0000
Message-Id: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

The EK874 is an evaluation kit for the RZ/G2E SoC (a.k.a. r8a774c0)
from Silicon Linux Corporation. It is made of two boards: cat874
(the main board) and cat875 (the sub board).

This series adds the device trees to describe the HW configuration
of the EK874, with some basic support.

This applies onto next-20190116

Thanks,
Fab

Biju Das (6):
  dt-bindings: Add vendor prefix for Silicon Linux.
  arm64: dts: renesas: Add Si-Linux CAT874 board support
  arm64: dts: renesas: Add Si-Linux EK874 board support
  arm64: dts: renesas: r8a774c0-cat874: Add pincontrol support to scif2
  arm64: dts: renesas: r8a774c0-cat874: Add uSD support
  arm64: dts: renesas: cat875: Add ethernet support

Fabrizio Castro (5):
  dt-bindings: arm: renesas: Add si-linux cat87[45] boards
  clk: renesas: r8a774c0: Add missing CANFD clock
  dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
  arm64: dts: renesas: r8a774c0: Add clkp2 clock to CAN nodes
  dt-bindings: can: rcar_canfd: document r8a774c0 support

 Documentation/devicetree/bindings/arm/renesas.yaml |  8 ++
 .../devicetree/bindings/net/can/rcar_can.txt       | 12 +--
 .../devicetree/bindings/net/can/rcar_canfd.txt     | 16 ++--
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 arch/arm64/boot/dts/renesas/cat875.dtsi            | 40 +++++++++
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts    | 97 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts     | 14 ++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 12 ++-
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |  4 +
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h      | 17 ++--
 11 files changed, 194 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/cat875.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts

-- 
2.7.4

