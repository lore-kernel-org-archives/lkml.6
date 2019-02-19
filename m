Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EF9C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC29E2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfBSRCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:02:07 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46689 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbfBSRCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:02:07 -0500
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr [90.53.137.203])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E9E1A20013;
        Tue, 19 Feb 2019 17:02:03 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/7] clk: at91: rework sckc bindings
Date:   Tue, 19 Feb 2019 18:01:53 +0100
Message-Id: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a rework of the sckc DT bindings to avoid warnings with dtc.
DT backward compatibility is kept.

This series also fix a possible issue with the sama5d3 slow RC
oscillator.

The sckc driver changes and documetation can go through the clk tree and
we will handle th DT changes.

Alexandre Belloni (7):
  dt-bindings: clock: at91: new sckc bindings
  clk: at91: modernize sckc binding
  clk: at91: sckc: handle different RC startup time
  ARM: dts: at91: at91sam9x5: switch to new sckc bindings
  ARM: dts: at91: at91sam9g45: switch to new sckc bindings
  ARM: dts: at91: at91sam9rl: switch to new sckc bindings
  ARM: dts: at91: sama5d3: switch to new sckc bindings

 .../devicetree/bindings/clock/at91-clock.txt  |  30 ++--
 arch/arm/boot/dts/at91-wb50n.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi            |  25 +---
 arch/arm/boot/dts/at91sam9rl.dtsi             |  25 +---
 arch/arm/boot/dts/at91sam9x5.dtsi             |  23 +--
 arch/arm/boot/dts/sama5d3.dtsi                |  27 +---
 drivers/clk/at91/sckc.c                       | 134 ++++++------------
 7 files changed, 73 insertions(+), 193 deletions(-)

-- 
2.20.1

