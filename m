Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A23C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397BA2081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="sFHfaNIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397BA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeLHRio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:38:44 -0500
Received: from mail1.kuutio.org ([92.222.216.83]:49642 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeLHRiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:38:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 98E6520791;
        Sat,  8 Dec 2018 18:38:07 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=dkim; t=1544290686; x=1546882687; bh=0Pau1t2uLHm0gx
        3d62knvUIoAPmSdr+RCvfuDsyGkaY=; b=sFHfaNIi4kss1Hb5upa1tXz5K52GyT
        XB6FNKDbxHJh7/XLCSlwSFsHM3YmWQO6UDFs0KxGCdYuEOBKnn49LErT4T+Wq9Td
        mlD11cGpwl7kyfRF9D7cziFquNqJOQtCiVWlQpZrttVC/Dc4s5TaAIQ63j2tYzFN
        FMZjUoBkG0XbzfmI91+I9VG/dug9Mu4A7Xxdix1nx96mWCVOh01PoXHkXpArNFSq
        VekoULuORwHbWCD350OB44oLelmB/I4BI/ko9kknRvIX8/7zeu5V3GHcANbRH0un
        9bAXjq5E+15oxiN2C+HArIrMoZJ9M5msv/FR2U0a8S/Y25K0y7RZizcFcVUH6bvi
        DIGBIrqPYFvp2R/+TrN6K6pv0IbPV0KiBlUIDOKNzC5KsAXVApA/4Cv7tVbHlnS4
        4mWrNA0VbABc5hUyb9A6UkAmj7NA++XGgLXsPCW3S9NW6GeuMtNmcF8v5HJWVMlL
        X1WfjdKOuhnBwxOAlbjuqHw/gzBILjkmyVfzApbYmEAWfOpBefcmrgjsyW5TRSE9
        nXGm0IvkR6yTSf/89vf7eZ2J0XscXD0+u6vWD1Fl6OCASCyfRRB2LJyEP16aB9+j
        mLQa9Mz3AIFC9J1K8jAP9NbkV/8NWJ0tlkcwcJ7GcoVsj5wm03yPFWwXl0/bVnfu
        GDpD/NOmrwGgU=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id pImGOoLzEQbr; Sat,  8 Dec 2018 18:38:06 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 27B211F965;
        Sat,  8 Dec 2018 18:38:06 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH v7 0/9] AXP8x3 AC and battery power supply support
Date:   Sat,  8 Dec 2018 19:36:09 +0200
Message-Id: <20181208173618.31395-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP813 AC power supply support with input current and
voltage limiting support.

AXP803 AC and battery power supply support.

Changes in v7:
* Added re-align patch for mfd cells

Changes in v6:
* Collected tags
* Rebase to master
* Dropped AXP803 compatible patches

Changes in v5:
* Return correct input current limit for values 0x6 and 0x7
* Add specific compatibles for AXP803
* Change commit messages
* Add Vasily Khoruzhick Pinebook DTS patch

Changes in v4:
* Change order of axp20x-gpio in axp20x.c
* Fix indentation and spaces to tabs in axp20x.c

Changes in v3:
* Reorder ac_power_supply DT node
* Rename axp20x_ac_power_set_property function
* Split mfd commit 

Changes in v2:
* Reuse axp813 compatibles for axp803
* Refactor axp20x_ac_power.c

Chen-Yu Tsai (1):
  mfd: axp20x: Re-align mfd cell entries

Oskari Lemmela (7):
  dt-bindings: power: supply: axp20x: add AXP813 AC power DT binding
  ARM: dts: axp81x: add AC power supply subnode
  arm64: dts: allwinner: axp803: add AC and battery power supplies
  arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
  power: supply: add AC power supply driver for AXP813
  mfd: axp20x: Add AC power supply cell for AXP813
  mfd: axp20x: Add supported cells for AXP803

Vasily Khoruzhick (1):
  arm64: dts: allwinner: a64: pinebook: enable power supplies

 .../bindings/power/supply/axp20x_ac_power.txt |   3 +
 arch/arm/boot/dts/axp81x.dtsi                 |   5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     |  33 +++++
 .../dts/allwinner/sun50i-a64-pinebook.dts     |   8 ++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |   8 ++
 drivers/mfd/axp20x.c                          | 126 ++++++++++--------
 drivers/power/supply/axp20x_ac_power.c        |  94 +++++++++++++
 include/linux/mfd/axp20x.h                    |   1 +
 8 files changed, 222 insertions(+), 56 deletions(-)

-- 
2.17.1

