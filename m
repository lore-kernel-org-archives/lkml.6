Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC42C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B75825C57
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B75825C57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965487AbeGBKWS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:22:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53780 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965132AbeGBKWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:22:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 651132895A8
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@collabora.com, Guenter Roeck <groeck@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Lukas Wunner <lukas@wunner.de>,
        Tony Lindgren <tony@atomide.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 0/3] platform/chrome: mfd: Move cros-ec transport drivers to drivers/platform
Date:   Mon,  2 Jul 2018 12:21:58 +0200
Message-Id: <20180702102201.13461-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The cros-ec transport drivers are placed in two subsystems, in MFD and
in platform/chrome. As far as I know there is no reason for this, so,
move the I2C and the SPI cros-ec transport driver from the MFD subsystem
to the platform/chrome. The series also removes the MFD_ prefix for the
Kconfig symbols, modifies the defconfigs that used these symbols and
fixes the KEYBOARD_CROS_EC Kconfig help.

Best regards,
 Enric

Enric Balletbo i Serra (3):
  platform/chrome: Move cros-ec transport drivers to drivers/platform.
  arm/arm64: configs: Remove the MFD_ prefix for MFD_CROS_EC_I2C/SPI
    symbols.
  Input: keyboard: Fix ChromeOS EC keyboard help message.

 arch/arm/configs/exynos_defconfig             |  4 ++--
 arch/arm/configs/multi_v7_defconfig           |  4 ++--
 arch/arm/configs/pxa_defconfig                |  4 ++--
 arch/arm64/configs/defconfig                  |  4 ++--
 drivers/input/keyboard/Kconfig                |  2 +-
 drivers/mfd/Kconfig                           | 20 -------------------
 drivers/mfd/Makefile                          |  2 --
 drivers/platform/chrome/Kconfig               | 20 +++++++++++++++++++
 drivers/platform/chrome/Makefile              |  2 ++
 .../{mfd => platform/chrome}/cros_ec_i2c.c    |  0
 .../{mfd => platform/chrome}/cros_ec_spi.c    |  0
 11 files changed, 31 insertions(+), 31 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec_i2c.c (100%)
 rename drivers/{mfd => platform/chrome}/cros_ec_spi.c (100%)

-- 
2.18.0

