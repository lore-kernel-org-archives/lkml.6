Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14BAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8642081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8642081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeLKRL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:11:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33172 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbeLKRL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:11:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6C2A420510; Tue, 11 Dec 2018 18:11:23 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 422D6207AD;
        Tue, 11 Dec 2018 18:11:13 +0100 (CET)
Date:   Tue, 11 Dec 2018 18:11:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 4.21
Message-ID: <20181211171112.GA30925@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here is the DT pull request for 4.21. The clock DT binding switch has
been in -next for a while and doesn't seem to have any issue.

This is based on the 4.20 fixes branch that you alredy pulled.

The following changes since commit 4ab7ca092c3c7ac8b16aa28eba723a8868f82f14:

  ARM: dts: at91: sama5d2: use the divided clock for SMC (2018-11-21 11:50:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.21-dt

for you to fetch changes up to d8007306f6ad18f2ba0dcad68ffe9b2fd1d56bfb:

  ARM: dts: at91: nattis: initialize the BLON pin as output-low early (2018-11-21 12:24:50 +0100)

----------------------------------------------------------------
AT91 DT for 4.21

 - Switch most platforms to the new clock binding
 - Small improvement for Axentia nattis

----------------------------------------------------------------
Alexandre Belloni (7):
      ARM: dts: at91: sama5d4: switch to new clock bindings
      ARM: dts: at91: sama5d2: switch to new clock binding
      ARM: dts: at91: at91sam9260: switch to new clock bindings
      ARM: dts: at91: at91sam9261: switch to new clock bindings
      ARM: dts: at91: at91sam9263: switch to new clock bindings
      ARM: dts: at91: at91sam9x5: switch to new clock bindings
      ARM: dts: at91: at91sam9rl: switch to new clock bindings

Peter Rosin (1):
      ARM: dts: at91: nattis: initialize the BLON pin as output-low early

 arch/arm/boot/dts/at91-nattis-2-natte-2.dts |   8 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts |  12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts |   4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi          | 308 ++-----------
 arch/arm/boot/dts/at91sam9261.dtsi          | 287 +-----------
 arch/arm/boot/dts/at91sam9263.dtsi          | 315 ++-----------
 arch/arm/boot/dts/at91sam9g15.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9g20.dtsi          |  23 +-
 arch/arm/boot/dts/at91sam9g25.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9g25ek.dts         |   4 +-
 arch/arm/boot/dts/at91sam9g35.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9rl.dtsi           | 239 +---------
 arch/arm/boot/dts/at91sam9x25.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9x35.dtsi          |   4 +
 arch/arm/boot/dts/at91sam9x5.dtsi           | 326 ++------------
 arch/arm/boot/dts/at91sam9x5_can.dtsi       |  18 +-
 arch/arm/boot/dts/at91sam9x5_isi.dtsi       |  11 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi       |  19 +-
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi     |  11 +-
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi     |  11 +-
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi    |  11 +-
 arch/arm/boot/dts/sama5d2.dtsi              | 670 +++-------------------------
 arch/arm/boot/dts/sama5d4.dtsi              | 535 ++--------------------
 25 files changed, 295 insertions(+), 2541 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
