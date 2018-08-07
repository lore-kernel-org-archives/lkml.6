Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D240C4646D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA41121A6D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA41121A6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeHGETR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:19:17 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:35522 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbeHGETR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:19:17 -0400
Received: from ofmlt.linux-actions.org (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 7 Aug 2018
 10:07:27 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] pinctrl: meson-g12a: add pinctrl driver support
Date:   Tue, 7 Aug 2018 10:06:32 +0800
Message-ID: <20180807020634.18182-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This patch series try to add pinctrl driver support for
the Meson-G12A SoC.

  The pinctrl driver for Meson-G12A SoC share the similar IP as
the previous Meson-AXG SoC, both use same pinmux ops (register layout).
But, a new driver is needed here due to the differences in the pins.

Changes since v2 at [2]
 - use ${FUNCTION}_${DOMAIN}_${PORT}_${PINFUNC}_${BANK}${PINNUM}
   to rename some pins
 - fix tdm groups
 - explain the similarity of pinmux between AXG and G12A - thanks Martin 
 - collect Rob's Reviewed-by

Changes since v1 at [1]
 - add Martin's Ack, Xingyu's Signed-off
 - squash patch 1,2 (documentation & header file)
 - explain pinctrl IP
 - notice GPIOE located in AO bank

[1] https://lkml.kernel.org/r/20180704224511.29350-1-yixun.lan@amlogic.com
[2] https://lkml.kernel.org/r/20180714232754.5402-1-yixun.lan@amlogic.com

Yixun Lan (2):
  documentation: pinctrl: Add compatibles for Amlogic Meson G12A pin
    controllers
  pinctrl: meson-g12a: add pinctrl driver support

 .../bindings/pinctrl/meson,pinctrl.txt        |    2 +
 drivers/pinctrl/meson/Kconfig                 |    6 +
 drivers/pinctrl/meson/Makefile                |    1 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 1404 +++++++++++++++++
 include/dt-bindings/gpio/meson-g12a-gpio.h    |  114 ++
 5 files changed, 1527 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
 create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h

-- 
2.18.0

