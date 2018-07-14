Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A1CECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BE4208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 15:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BE4208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeGNPum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 11:50:42 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:51893 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeGNPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 11:50:42 -0400
Received: from localhost.localdomain (10.18.20.250) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Sat, 14 Jul 2018
 23:30:31 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] pinctrl: meson-g12a: add pinctrl driver support
Date:   Sat, 14 Jul 2018 23:27:52 +0000
Message-ID: <20180714232754.5402-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series try to add pinctrl driver support for
the Meson-G12A SoC.

Changes since v1 at [1]
 - add Martin's Ack, Xingyu's Signed-off
 - squash patch 1,2 (documentation & header file)
 - explain pinctrl IP
 - notice GPIOE located in AO bank

[1] https://lkml.kernel.org/r/20180704224511.29350-1-yixun.lan@amlogic.com

Yixun Lan (2):
  documentation: pinctrl: Add compatibles for Amlogic Meson G12A pin
    controllers
  pinctrl: meson-g12a: add pinctrl driver support

 .../bindings/pinctrl/meson,pinctrl.txt        |    2 +
 drivers/pinctrl/meson/Kconfig                 |    6 +
 drivers/pinctrl/meson/Makefile                |    1 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    | 1433 +++++++++++++++++
 include/dt-bindings/gpio/meson-g12a-gpio.h    |  114 ++
 5 files changed, 1556 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
 create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h

-- 
2.18.0

