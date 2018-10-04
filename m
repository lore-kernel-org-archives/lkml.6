Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D67C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB10A2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=lemmela.net header.i=@lemmela.net header.b="RqWlLjhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB10A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJECf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:35:29 -0400
Received: from mail1.kuutio.org ([92.222.216.83]:47754 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbeJECf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:35:28 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Oct 2018 22:35:26 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 2941F1F939;
        Thu,  4 Oct 2018 21:34:42 +0200 (CEST)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        x-mailer:message-id:date:date:subject:subject:from:from:received
        :received; s=dkim; t=1538681681; x=1541273682; bh=2lmrm9ERgOon4b
        q8ddlI1H2P70tRgbnivAMHkXBG8E8=; b=RqWlLjhcOWmzQijZPVNzaYxZOHQO0q
        herQqev1TQE9wtOmJFuzA8SKbOapU8Pt0hDYJ/FP6iaa6KnTxv6Gt5VpgAK7dlS3
        kwMbA3RUu1/WLMeoK9JuQmZZw+tydqztc5Tg/DqEv3DZlHwth2Vmd3wgfKebpZsW
        uc34nN1hVZ0j3S3i0lBxWVwhJRq33JbaQtHCFDAthopB2/XezZImIKmJWliczf4r
        6HCBaz28tcD7mQp3kYG/qVXkSnWQb5jeNNDXA8EUZmSHfbgarJR6MKr+gZcr0bnk
        GRdkNlrWUtoJmf70dW8CwCkKYB6+hyij9dPsaOQbuark6RM/RqNLmshwP+89ianz
        mj0rgQNG8vjWwq9EqpTGWIrrokPv/Z4QqHJhH8hMrroP/OZVvSMmd2icKvPr6IVu
        pHyaw/zuIGJEa7PeyJgy/gDYoFTZHnCdi9ENWhcyPuqKszTbC0Xp6rI9llYDNI92
        +RC8wMRvktgvbJJM8umxwptuvT1SLHfTYViyUVs3GN6OWhiNfX70T0EWF9NcdqAm
        sr7g1JFcX9wvUywb7eFZMCaCFdCn4THATIoIX9JeSXjVlUiGUq0liY3CaYQCkt3m
        dLry6ceIJEMtGTldXONDVluvo2t8UrDphzlq+uCCWoH/oe17jnd6/oxE8S7GnWD1
        r/Ry36Odm8iJM=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id r8n3SQyDBlpn; Thu,  4 Oct 2018 21:34:41 +0200 (CEST)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id CEFE71F99C;
        Thu,  4 Oct 2018 21:34:40 +0200 (CEST)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] AXP8x3 AC and battery power supply support
Date:   Thu,  4 Oct 2018 22:34:06 +0300
Message-Id: <20181004193410.7265-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803 AC and battery power supply support.
AXP803/AXP813 AC power supply support with input current and
voltage limiting support.

Oskari Lemmela (4):
  dt-bindings: add compatibles for AXP803 AC and battery power supplies
  ARM: dtsi: axp81x: add AC power supply subnode
  arm64: allwinner: a64: add battery and AC power supply support
  power: supply: add AXP803/AXP813 AC and battery power supply support

 .../devicetree/bindings/gpio/gpio-axp209.txt  |   3 +-
 .../bindings/iio/adc/axp20x_adc.txt           |   3 +-
 .../bindings/power/supply/axp20x_ac_power.txt |   4 +
 .../bindings/power/supply/axp20x_battery.txt  |   1 +
 arch/arm/boot/dts/axp81x.dtsi                 |   5 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi     |  31 +++
 .../allwinner/sun50i-a64-sopine-baseboard.dts |   8 +
 drivers/iio/adc/axp20x_adc.c                  |   1 +
 drivers/mfd/axp20x.c                          |  22 +-
 drivers/pinctrl/pinctrl-axp209.c              |   1 +
 drivers/power/supply/axp20x_ac_power.c        | 194 ++++++++++++++++++
 drivers/power/supply/axp20x_battery.c         |   3 +
 include/linux/mfd/axp20x.h                    |   1 +
 13 files changed, 274 insertions(+), 3 deletions(-)

-- 
2.17.1

