Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00DC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8914D2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfA0Osn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:48:43 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:60090 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfA0Osm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:48:42 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 55E285FD14; Sun, 27 Jan 2019 22:48:39 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] ARM: dts: sun5i: q8-tablet: Complete LCD panel description
Date:   Sun, 27 Jan 2019 22:48:33 +0800
Message-Id: <20190127144838.3578-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds the missing bits for the LCD panel of the A13 Q8
tablets. The panel and backlight were missing their enable GPIOs.
The panel can have its power supply added as well, though it is not
a complete description. See the commit log of that patch for more
details. The backlight's power supply is the unregulator output of
the PMIC, which does not have a device tree representation.

For the Q8 tablets, the backlight GPIO is driven by a GPIO pin from
the PMIC. This needs a fix in the pwm backlight driver to avoid a
runtime warning. This will be sent separately.


Please have a look.

Regards
ChenYu

Chen-Yu Tsai (5):
  ARM: dts: sun5i: Add backlight GPIO for reference design tablet
  ARM: dts: sun5i: q8-tablet: Move panel properties to correct node
    level
  ARM: dts: sun5i: q8-tablet: Add LCD Panel enable GPIO
  ARM: dts: sun5i: q8-tablet: Add LCD Panel power supply
  ARM: dts: sun5i: q8-tablet: Use bananapi,s070wv20-ct16 panel
    compatible

 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts            | 7 ++++---
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.20.1

