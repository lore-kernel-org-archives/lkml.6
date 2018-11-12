Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54F2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F02E223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F02E223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeKLXY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:24:29 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47626 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbeKLXY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:24:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 13CEB207AD; Mon, 12 Nov 2018 14:31:10 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id DD4AA20717;
        Mon, 12 Nov 2018 14:31:09 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/7] clk: at91: Rework DT bindings
Date:   Mon, 12 Nov 2018 14:31:01 +0100
Message-Id: <20181112133108.31021-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the remaining part of the clock rework series.

I'll convert the remaining SoCs later this cycle.

Changes in v3:
 - Dropped clk patches that have been applied
 - Rebased on top of v4.20-rc1

Alexandre Belloni (7):
  ARM: dts: at91: sama5d4: switch to new clock bindings
  ARM: dts: at91: sama5d2: switch to new binding
  ARM: dts: at91: at91sam9260: switch to new clock bindings
  ARM: dts: at91: at91sam9261: switch to new clock bindings
  ARM: dts: at91: at91sam9263: switch to new clock bindings
  ARM: dts: at91: at91sam9x5: switch to new clock bindings
  ARM: dts: at91: at91sam9rl: switch to new clock bindings

 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi          | 308 +--------
 arch/arm/boot/dts/at91sam9261.dtsi          | 287 +--------
 arch/arm/boot/dts/at91sam9263.dtsi          | 315 +--------
 arch/arm/boot/dts/at91sam9g15.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9g20.dtsi          |  23 +-
 arch/arm/boot/dts/at91sam9g25.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9g25ek.dts         |   4 +-
 arch/arm/boot/dts/at91sam9g35.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9rl.dtsi           | 239 +------
 arch/arm/boot/dts/at91sam9x25.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9x35.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9x5.dtsi           | 326 +---------
 arch/arm/boot/dts/at91sam9x5_can.dtsi       |  18 +-
 arch/arm/boot/dts/at91sam9x5_isi.dtsi       |  11 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi       |  19 +-
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi     |  11 +-
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi     |  11 +-
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi    |  11 +-
 arch/arm/boot/dts/sama5d2.dtsi              | 670 ++------------------
 arch/arm/boot/dts/sama5d4.dtsi              | 535 ++--------------
 24 files changed, 287 insertions(+), 2541 deletions(-)

-- 
2.19.1

