Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428A0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DE9216E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BT79WY5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DE9216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeHHRy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:54:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38297 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbeHHRy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so3201724wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3zmWRBLVjC00ebZcBXbf19VncOAWdFwL8jWPHWZ5uxI=;
        b=BT79WY5i/ylbNRfzAznyk8wdkT3VXpt6pWEmpgwydCoTZ0czuErKeNBMeL7yBf8iKF
         c7+2VCW8xW4qoWDD15hZrGSCDegyWDShx1e3p+T/tj/1MMkNeqPUXqoIoIJGytdYybDY
         xg4rK9gAio/gBv8vd/Oq8gjcTh6/1YoJ9PVD8qTaBB8Wle4V95R9ThkOjfcIP71stvW7
         JNn+W9FLqYgqhgb4FFI4OjVuGPP1uWn1wPqPTcqpopWtiTz78LRNMnwWAB3fwvGvwSzk
         JGUTei9E55tPcf3v++D4wY5ExTheiksDCoUaz/Ji+B1LXHRrAodeJeApWmwABn+3TpUb
         LzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3zmWRBLVjC00ebZcBXbf19VncOAWdFwL8jWPHWZ5uxI=;
        b=PIkk/K/XoTg6H/xGNeysnwIA1BVtLoxNT904x+DLzsbnhaTBK2/Rfk2IGO67N+egD1
         ojs+eo/3dRUAyBKM1c9piBESequkuitTBw6Z7a7r2haRVpW7FpA0Mb13EVT/Xnq9HN8K
         A9dygydBko72xQ/Nj2tUIS8IULSh5eq4XtliEHxcgMiYPhg/AqVSsQF8iPPgtfgAO7M1
         hqNTfuqUTc2mys5lUo29AOsGek2B9QH3rFo3VM1INJ1Ci6pBv/faHmYLpP+5EAlREmb1
         gqODo9hVCRT0g1YlS6XxAtmeGdZPYoHWDsd7JYNskCVijKfRog3fQ1eExAcn29CyF3sK
         N3ag==
X-Gm-Message-State: AOUpUlEnWBsAeZ3aQ9mm3DWTtEKyRuWAMG1uwwrTZJ0QTaFU1TD5Z+yg
        7ageXQzxkE6NSz2D4fLky+P0fA==
X-Google-Smtp-Source: AA+uWPzEi1m4ARfaadbvyqjj9z92+GFN6UYJ+IHVI7vlDPNnoQcxmZXmNTEZaNiSof0oVsPgocOOGA==
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr2052562wmd.105.1533742454486;
        Wed, 08 Aug 2018 08:34:14 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:34:13 -0700 (PDT)
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
Subject: [PATCH 23/28] ARM: davinci: sffsdr: fix the at24 eeprom device name
Date:   Wed,  8 Aug 2018 17:31:45 +0200
Message-Id: <20180808153150.23444-24-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
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

