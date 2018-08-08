Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFB9C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA3421A27
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cggQzO/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA3421A27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeHHRyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:54:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53272 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbeHHRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:54:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so3185327wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sGOzUdYoefHsqeEVpETOZKTrsiIrdDWkhYzQ4MVNoLM=;
        b=cggQzO/93LG4Ij5L8Kjw5OtZD4R+Xn3/ud7uGfm7stR4t8PLMuetQby1uNWl5BKucN
         QMOLDiJ4WpC+U2Oc3FdrskC6mzJf1HtRqbVHEj5/5PVTWEXYXj3Yvk7NNnePH2DEtMuE
         +2wpkQL3LNoeXXs4tJD7yhDN2tow7d8UMWQpexy4kW4It+dSr7gKyHDkdNOcRhGoLw4W
         IDdkLta2tMmDtN3uV+mB8/W7LTT8kaQxqvPlD7p3WIQQFOTAs3pbF+mbSOmF/wXmexrL
         ZdTgaH9cgz182EEdjbpP+Pg95mtV1DZ6B0SXyt1fTm9cTCgR6o4Ezihybw0cR9NSkEf/
         143w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sGOzUdYoefHsqeEVpETOZKTrsiIrdDWkhYzQ4MVNoLM=;
        b=IALYEphaZ48MX2mqtvgXzEi1vttTJ1LC1gFyEkdMFLEIQMYk28CYFFKTm8Qi3V7sYd
         pTLrGnAiKBzowyCWlEU0ZKhpc6RgK0mY8tSa7WtAssvJTfnfQM1IFzVA4r96/MxX/usX
         Mu3RMEP1hT4eMePUd/qVN+lKGXnhBdNjPGGccJ/y+uSAVXB1zasCOh6Ir+TVaKifoWxV
         zaw4+pYX13qHisnDlZ2ar6I2v1xUQJcMxIuzPkEeX8KkdG2psrq8U/qV+nqesNOUVLsy
         XRAFK7dWZx4iVfjTVPkYqHNTIL4L18k+NfvmjJtkZYUOYk1Qjfc2O95CFL66i+BTmhba
         H76Q==
X-Gm-Message-State: AOUpUlEHpBqiHddKFoYr2XHTww/tXTngW9kU+MyoYSsRiStp1JaMwArN
        YT4rUKlVhTD/eCbOeD1GXIJn6w==
X-Google-Smtp-Source: AA+uWPyc0yqSUqvSbIZ9GQ0fQtkypRMmK/5NeEG1AMKT0dqCxEcMcDEiygbjIbPm14RgK076rWQoNg==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26-v6mr2298030wmh.61.1533742430519;
        Wed, 08 Aug 2018 08:33:50 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id s2-v6sm5240915wrw.52.2018.08.08.08.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:33:49 -0700 (PDT)
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
Subject: [PATCH 12/28] ARM: davinci: da850-evm: use nvmem lookup for mac address
Date:   Wed,  8 Aug 2018 17:31:34 +0200
Message-Id: <20180808153150.23444-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808153150.23444-1-brgl@bgdev.pl>
References: <20180808153150.23444-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now support nvmem lookups for machine code. Add a lookup for
mac-address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 6d5beb11bd96..5a634a04ec69 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -29,6 +29,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/mtd-davinci.h>
@@ -99,6 +100,19 @@ static struct mtd_partition da850evm_spiflash_part[] = {
 	},
 };
 
+static struct nvmem_cell_lookup da850evm_mac_address_cell = {
+	.info = {
+		.name = "mac-address",
+		.offset = 0x0,
+		.bytes = ETH_ALEN,
+	},
+	/*
+	 * The nvmem name differs from the partition name because of the
+	 * internal works of the nvmem framework.
+	 */
+	.nvmem_name = "MAC-Address0",
+};
+
 static struct flash_platform_data da850evm_spiflash_data = {
 	.name		= "m25p80",
 	.parts		= da850evm_spiflash_part,
@@ -1447,6 +1461,8 @@ static __init void da850_evm_init(void)
 		pr_warn("%s: spi info registration failed: %d\n", __func__,
 			ret);
 
+	nvmem_add_lookup_table(&da850evm_mac_address_cell, 1);
+
 	ret = da8xx_register_spi_bus(1, ARRAY_SIZE(da850evm_spi_info));
 	if (ret)
 		pr_warn("%s: SPI 1 registration failed: %d\n", __func__, ret);
-- 
2.18.0

