Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C9C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BF820850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BF820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeGVWTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:19:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:38660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730144AbeGVWSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 578F7ADC0;
        Sun, 22 Jul 2018 21:20:18 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 00/15] MIPS: pistachio: Creator Ci40 aka Marduk SPI-UART
Date:   Sun, 22 Jul 2018 23:19:55 +0200
Message-Id: <20180722212010.3979-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset enables SPI and UARTs for the Ci40's mikroBUS and Raspberry Pi B+
connectors, as well as the remaining seven LEDs and as dependency the 802.15.4.

I also dug out some related driver fixes from their pistachio-4.9-lede branch:
https://github.com/CreatorDev/linux/commits/pistachio-4.9-lede

Tested with a LoRa click expansion board. [*]
Note that a number of drivers are missing in the pistachio defconfig. This
should probably be remedied as follow-up.

While all creatordev.io websites appear to be gone, I still had a local copy
of the Ci40 schematics document.

This patchset: https://github.com/afaerber/linux/commits/ci40-spi-uart.v1

Some more potential patches for missing features appear to be here:
https://github.com/CreatorDev/linux/commits/pistachio-4.9-wip

Have a lot of fun!

Cheers,
Andreas

P.S. As follow-up to this series I've reported on linux-serial that sc16is7xx
and serdev drivers don't appear to play nicely together:
https://marc.info/?l=linux-serial&m=153228314300681&w=2

[*] Cf. netdev https://patchwork.ozlabs.org/cover/937545/

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org

Andreas Färber (7):
  MIPS: dts: img: pistachio_marduk: Reorder nodes
  MIPS: dts: img: pistachio_marduk: Cleanups
  MIPS: dts: img: pistachio: Rename spim0-clk pin node label
  MIPS: dts: img: pistachio_marduk: Enable SPIM0
  MIPS: dts: img: pistachio_marduk: Add 6Lowpan node
  MIPS: dts: img: pistachio_marduk: Add SPI UART node
  MIPS: dts: img: pistachio_marduk: Add user LEDs

Damien Horsley (1):
  dmaengine: img-mdc: Handle early status read

Govindraj Raja (1):
  clk: pistachio: Fix wrong SDHost card speed

Ian Pozella (1):
  MIPS: dts: img: pistachio_marduk: Switch mmc to 1 bit mode

Ionela Voinescu (5):
  spi: img-spfi: Implement dual and quad mode
  spi: img-spfi: Set device select bits for SPFI port state
  spi: img-spfi: Use device 0 configuration for all devices
  spi: img-spfi: RX maximum burst size for DMA is 8
  spi: img-spfi: Finish every transfer cleanly

 arch/mips/boot/dts/img/pistachio.dtsi       |   2 +-
 arch/mips/boot/dts/img/pistachio_marduk.dts | 174 ++++++++++++++++++++++------
 drivers/clk/pistachio/clk-pistachio.c       |   3 +-
 drivers/dma/img-mdc-dma.c                   |  40 ++++---
 drivers/spi/spi-img-spfi.c                  | 165 +++++++++++++++++++++-----
 include/dt-bindings/clock/pistachio-clk.h   |   1 +
 6 files changed, 299 insertions(+), 86 deletions(-)

-- 
2.16.4

