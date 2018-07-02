Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE092C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B0825C67
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B0825C67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965460AbeGBKXV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:23:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53864 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965470AbeGBKWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:22:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 06604289A7C
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
        Arnd Bergmann <arnd@arndb.de>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 3/3] Input: keyboard: Fix ChromeOS EC keyboard help message.
Date:   Mon,  2 Jul 2018 12:22:01 +0200
Message-Id: <20180702102201.13461-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702102201.13461-1-enric.balletbo@collabora.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros-ec I2C and SPI transport drivers have been moved from MFD
subsystem to platform/chrome, at the same time, the config symbol
has been renamed and lost the MFD_ prefix So, update the help message
accordingly.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 6bd97ffee761..4713957b0cbb 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -721,7 +721,7 @@ config KEYBOARD_CROS_EC
 	help
 	  Say Y here to enable the matrix keyboard used by ChromeOS devices
 	  and implemented on the ChromeOS EC. You must enable one bus option
-	  (MFD_CROS_EC_I2C or MFD_CROS_EC_SPI) to use this.
+	  (CROS_EC_I2C or CROS_EC_SPI) to use this.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_keyb.
-- 
2.18.0

