Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82ADECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB3A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB3A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbeGQO4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:56:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42126 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731607AbeGQO4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:56:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB031208FF; Tue, 17 Jul 2018 16:23:28 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 93A89203EC;
        Tue, 17 Jul 2018 16:23:18 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/5] Add support for MSCC Ocelot SPI
Date:   Tue, 17 Jul 2018 16:23:09 +0200
Message-Id: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The MSCC MIPS SoC line uses a designware IP for the SPI controller but
still requires some special handling to give control of the SPI
interface to the IP and also has a specific handling for the chip
select.

Patches 1 to 3 should go through the SPI tree while 4 and 5 should
probably got throught the MIPS tree once patch 3 has been reviewed by
the DT maintainers.

Alexandre Belloni (5):
  spi: dw: fix possible race condition
  spi: dw: allow providing own set_cs callback
  spi: dw-mmio: add MSCC Ocelot support
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 11 +++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     | 10 +++
 drivers/spi/spi-dw-mmio.c                     | 86 +++++++++++++++++++
 drivers/spi/spi-dw.c                          |  6 +-
 drivers/spi/spi-dw.h                          |  1 +
 6 files changed, 116 insertions(+), 3 deletions(-)

-- 
2.18.0

