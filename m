Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A78C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E86C20843
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="mu865zPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E86C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeKAJMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:12:40 -0400
Received: from onstation.org ([52.200.56.107]:44714 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbeKAJMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:12:40 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 2DB1D3A9;
        Thu,  1 Nov 2018 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1541031129;
        bh=Wz3piMyHLznJPk9wXcEKthjp+KRacZDARJjXuFwM5EE=;
        h=From:To:Cc:Subject:Date:From;
        b=mu865zPmz+pzgCQ2DfSy4G0HcHXMwi3C0Q8rEXkiU/ISmYWoiHbSsVBmYct0NdjIO
         XPfL2XFfvOm+K2IVcWHmgmGqy58rTGE+pJCvfD0GprtAKeY+U3IIiOMXUyHPvk1/Z1
         sjik6fO3qgqmE7trMGgeUqiE4gDKhrp2Wd/89054=
From:   Brian Masney <masneyb@onstation.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        jonathan@marek.ca, masneyb@onstation.org
Subject: [PATCH v2 0/7] ARM: qcom: msm8974-hammerhead: add USB OTG support
Date:   Wed, 31 Oct 2018 20:11:42 -0400
Message-Id: <20181101001149.13453-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds USB OTG support for the LG Nexus 5 (hammerhead)
phone.

Changes in v2:
- Reworked patches to use gpio hogging as suggested in the bq24190
  device tree documentation.
- bq24190_charger: changed to use a switch instead of an if as requested
  by Sebastian Reichel.
- bq24190_charger dt-bindings: added usb-otg-vbus to example.


Brian Masney (5):
  dt-bindings: power: supply: bq24190_charger: add bq24192 and
    usb-otg-vbus
  power: supply: bq24190_charger: add extcon support for USB OTG
  pinctrl: qcom: spmi-gpio: fix gpio-hog related boot issues
  ARM: dts: qcom: msm8974: add gpio-ranges
  ARM: dts: qcom: msm8974-hammerhead: add USB OTG support

Jonathan Marek (2):
  power: supply: bq24190_charger: add support for bq24192 variant
  power: supply: bq24190_charger: add of_match for usb-otg-vbus
    regulator

 .../bindings/power/supply/bq24190.txt         |  9 +++
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 60 +++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi           | 11 ++++
 arch/arm/boot/dts/qcom-pm8941.dtsi            |  1 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      | 21 +++++--
 drivers/power/supply/bq24190_charger.c        | 48 ++++++++++++++-
 6 files changed, 143 insertions(+), 7 deletions(-)

-- 
2.17.2

