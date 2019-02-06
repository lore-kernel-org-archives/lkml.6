Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E068DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1EA2184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfBFDdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:33:38 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33756 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBFDcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:32:48 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 8FC765FCDF; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 0/9] ARM: sun9i: a80: Enable GMAC
Date:   Wed,  6 Feb 2019 11:32:30 +0800
Message-Id: <20190206033239.3619-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On the Allwinner A80, the PIO pin controller includes configuration
registers to set the I/O voltage. These must match the actual voltage
provided externally. A mismatch results in signals not being passed
through.

With the new PIO pin-bank regulator supply support in place, we can
tack on support for setting up these registers.

This in turn allows us to enable the GMAC, which runs at a reduced
2.5V for RGMII, instead of the standard 3.0V or 3.3V.

Please have a look.


Regards
ChenYu


Chen-Yu Tsai (9):
  pinctrl: sunxi: Support I/O bias voltage setting on A80
  ARM: dts: sun9i: a80-optimus: Add node for AXP809's unused dc1sw
    regulator
  ARM: dts: sun9i: a80-optimus: Add GPIO pin-bank regulator supplies
  ARM: dts: sun9i: cubieboard4: Add GPIO pin-bank regulator supplies
  ARM: dts: sun9i: Add GMAC clock node
  ARM: dts: sun9i: Add A80 GMAC gigabit ethernet controller node
  ARM: dts: sun9i: Add A80 GMAC RGMII pinmux setting
  ARM: dts: sun9i: a80-optimus: Enable GMAC
  ARM: dts: sun9i: cubieboard4: Enable GMAC

 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 44 +++++++++++++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts     | 44 +++++++++++++-
 arch/arm/boot/dts/sun9i-a80.dtsi            | 65 +++++++++++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80-r.c |  1 +
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c   |  1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       | 41 +++++++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h       | 12 ++++
 7 files changed, 202 insertions(+), 6 deletions(-)

-- 
2.20.1

