Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0315C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78DD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403903AbfAPJ5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:57:49 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49626 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbfAPJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:57:49 -0500
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="25551576"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jan 2019 02:57:47 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 16 Jan 2019 02:57:47 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
        <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 0/8] ARM: at91/dt: update to existing drivers for the sam9x60 SoC
Date:   Wed, 16 Jan 2019 10:57:36 +0100
Message-ID: <cover.1547629763.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This serries collects some little modifications to DT bindings and associated
drivers changes for supporting the upcoming SAM9X60 SoC.

I took the advantage of this series for fixing some of the leftovers in DT
bindings for reset controller and Ethernet macb.

These changes touch several sub-systems but I would like that these (mostly
trivial) patches stay together for facilitating reviews, prevent breaking
dependencies and facilitating the tracking of acceptance status. However, tell
me if you think otherwise.
My intentions are that the series would enter Mainline through arm-soc tree:
sounds okay to everyone? If okay, I'm ready to collect Ack tags...

For the first batch, I send the whole series to everyone. I'll try my best to
reduce subsequent message deliveries if one part of the serries needs rework.

Best regards,
  Nicolas


Nicolas Ferre (8):
  dt-bindings: arm: atmel: add missing samx7 to reset controller
  dt-bindings: arm: atmel: add new sam9x60 reset controller binding
  dt-bindings: arm: atmel: add new sam9x60 SFR binding
  net/macb: bindings doc/trivial: fix documentation for sama5d3 10/100
    interface
  net/macb: bindings doc: add sam9x60 binding
  power: reset: at91-reset: add support for sam9x60 SoC
  USB: host: ohci-at91: add sam9x60-sfr definition for ohci
  net: macb: add sam9x60-macb compatibility string

 .../devicetree/bindings/arm/atmel-sysregs.txt       |  4 +++-
 Documentation/devicetree/bindings/net/macb.txt      |  4 ++--
 drivers/net/ethernet/cadence/macb_main.c            |  1 +
 drivers/power/reset/at91-reset.c                    | 13 +++++++++++++
 drivers/usb/host/ohci-at91.c                        |  7 +++++--
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.17.1

