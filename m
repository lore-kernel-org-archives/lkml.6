Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D128FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DAD223F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U3PL+3n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DAD223F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeHJKfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:35:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54402 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbeHJKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:35:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so921245wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3zmWRBLVjC00ebZcBXbf19VncOAWdFwL8jWPHWZ5uxI=;
        b=U3PL+3n3uXolcLkxhCewaU9ykJwXzrjjMK1woc6BFMPgeiMDMP9FswEHoYiPpIN8C3
         fJdZKIwV/NJDvcFEboCLIkBNowV9LPTavvVxl/x/E4yc0393bIdZQqdT7swf+CWeaB+m
         yY6ZemJKyrKm6H01JyEABY3FgzxOf7DjReOFi4FurkDOPJovVciM60fH+2T00EKokoeE
         NV2PkaKP0Rw9KkhqdjvSyZEWpiZIBayjgbPpXtlMsvBv01o3DK8CRuNbxww56c5cZaIH
         2iJPNR2r/o25vqnG4qK3UaQBD2e7xcs62G6Qb+QIrGUXqNsV2DmXtNNneufxF5bUbhbA
         zXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3zmWRBLVjC00ebZcBXbf19VncOAWdFwL8jWPHWZ5uxI=;
        b=IsG5/Nzs16YaQ7NBj9ZOvgKAConzcMAXyIaYiHAknU+DFsp7NQrmx0/bt/WQVvTcip
         HOIisZB+DuTTiAM88sWfL6HRS1xVv/crxNZi+aiS/9KFnE7QQP+DKiWhHbH19lRB57Jq
         /XX3F6vmuRxE9f3lHNoXqANyhkiFWoGDzTkzWuvenplYngykcr5TW9JYeAqekQ1IT8Z/
         qfc3+iRbmZFoi8bzMqdue4rbIzlTZlIhCmV8sdGXmFGuVBWFEhTOilX6p/IymW9K+YUQ
         2/gESllgPA6mvvWnE2NxtYPTJT6YtFp63D90A41sKTw+ukLqv43m5kClLM6aOqkKtQxl
         P9AA==
X-Gm-Message-State: AOUpUlHtsEX9KFXBTcoMcJvbQW5Bj+d0X3Jvfc1wATDKsXRE9AXdQcSz
        KKdVLDffwfbT8sTywfSOeqjLMw==
X-Google-Smtp-Source: AA+uWPxi9geU7Rdg+6i3cWwgv6KbIFPXpfcpG1RrXVcM2DpCUAXrnYX/ZIeWs+BU9/iygdBJqYQJTA==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr768950wmr.138.1533888378597;
        Fri, 10 Aug 2018 01:06:18 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id h7-v6sm9546405wrs.8.2018.08.10.01.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:06:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Alban Bedel <albeu@free.fr>,
        Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 24/29] ARM: davinci: sffsdr: fix the at24 eeprom device name
Date:   Fri, 10 Aug 2018 10:05:21 +0200
Message-Id: <20180810080526.27207-25-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810080526.27207-1-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The currently used 24lc64 i2c device name doesn't match against any
of the devices supported by the at24 driver. Change it to the closest
compatible chip.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-sffsdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index e7c1728b0833..f6a4d094cbc3 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -100,7 +100,7 @@ static struct at24_platform_data eeprom_info = {
 
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
-		I2C_BOARD_INFO("24lc64", 0x50),
+		I2C_BOARD_INFO("24c64", 0x50),
 		.platform_data	= &eeprom_info,
 	},
 	/* Other I2C devices:
-- 
2.18.0

