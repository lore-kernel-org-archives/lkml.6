Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nUOGAuzvGFtYCgAAmS7hNA
	; Thu, 07 Jun 2018 08:42:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5396608CD; Thu,  7 Jun 2018 08:42:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 852A6608FF;
	Thu,  7 Jun 2018 08:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 852A6608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbeFGIla (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:41:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36202 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753240AbeFGIl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:41:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5A494207CB; Thu,  7 Jun 2018 10:41:25 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 77720203B4;
        Thu,  7 Jun 2018 10:41:11 +0200 (CEST)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/4] Fix suspend resume on at91sam9261 and at91sam9263
Date: Thu,  7 Jun 2018 10:41:03 +0200
Message-Id: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB clock detection may not work properly on at91sam9261 and at91sam9263
because they currently use the same bit mask as at91rm9200 instead of
the one for at91sam9260.

Take the opportunity to also change the PMC compatible strings for all
the other SoCs in preparation for the new clock bindings.

Alexandre Belloni (4):
  dt-bindings: arm: remove PMC bindings
  dt-bindings: clk: at91: Document all the PMC compatibles
  ARM: at91: fix USB clock detection handling
  ARM: dts: fix PMC compatible

 .../devicetree/bindings/arm/atmel-pmc.txt          | 14 --------------
 .../devicetree/bindings/clock/at91-clock.txt       |  9 ++++-----
 arch/arm/boot/dts/at91sam9261.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |  2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |  2 +-
 arch/arm/mach-at91/pm.c                            |  5 +++++
 7 files changed, 13 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt

-- 
2.17.1
