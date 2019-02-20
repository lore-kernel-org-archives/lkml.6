Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34641C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044E4206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfBTL0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:26:16 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55789 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfBTL0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:26:15 -0500
X-Originating-IP: 109.212.12.126
Received: from localhost (alyon-652-1-153-126.w109-212.abo.wanadoo.fr [109.212.12.126])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5D5374000A;
        Wed, 20 Feb 2019 11:26:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/7] clk: at91: add sam9x60 pmc clock support
Date:   Wed, 20 Feb 2019 12:25:58 +0100
Message-Id: <20190220112605.23095-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for the sam9x60 clocks handled by the PMC.

The first four patches are preparatory patches to handle register layout
and offset differences. Then, a driver for the new interface for PLLs is
added and the final patch is the driver for the sam9x60 PMC.

Alexandre Belloni (7):
  clk: at91: allow configuring peripheral PCR layout
  clk: at91: allow configuring generated PCR layout
  clk: at91: usb: Add sam9x60 support
  clk: at91: master: Add sam9x60 support
  clk: at91: add sam9x60 PLL driver
  dt-bindings: clk: at91: add bindings for SAM9X60 pmc
  clk: at91: add sam9x60 pmc driver

 .../devicetree/bindings/clock/at91-clock.txt  |   3 +-
 drivers/clk/at91/Makefile                     |   2 +
 drivers/clk/at91/at91sam9x5.c                 |   9 +
 drivers/clk/at91/clk-generated.c              |  48 +--
 drivers/clk/at91/clk-master.c                 |   8 +-
 drivers/clk/at91/clk-peripheral.c             |  46 +--
 drivers/clk/at91/clk-sam9x60-pll.c            | 329 ++++++++++++++++++
 drivers/clk/at91/clk-usb.c                    |  33 +-
 drivers/clk/at91/dt-compat.c                  |  12 +-
 drivers/clk/at91/pmc.h                        |  23 ++
 drivers/clk/at91/sam9x60.c                    | 307 ++++++++++++++++
 drivers/clk/at91/sama5d2.c                    |  10 +
 drivers/clk/at91/sama5d4.c                    |   8 +
 include/linux/clk/at91_pmc.h                  |  12 +-
 14 files changed, 785 insertions(+), 65 deletions(-)
 create mode 100644 drivers/clk/at91/clk-sam9x60-pll.c
 create mode 100644 drivers/clk/at91/sam9x60.c

-- 
2.20.1

