Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0516C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678CE25D4A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="f2ajk6jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678CE25D4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeFYPvy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:51:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38698 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754804AbeFYPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:40 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so14204524wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMXs7v3ptxT9vNOclT7VSTCrCsz0f0HMpiip+jVy0Kw=;
        b=f2ajk6jvZDnPWdtHseCHAIO37sIz9sXY9OsiswLCGXUdqTDHS29bksRFKJvGSykycN
         ONzHg2XT1HRY8WHAmfHhTMTSNxFXFaTZS9vlRUwHfaR7U9bwmBGUVH4zGB2nS3sTOrHo
         EMe/voyLCrV4XM3bAj+3Na4sRPZteNofYSv1ZH7HaJ6Ai1WxDF4jNqxbx5mR0kBF2fAa
         03aFg3L30ZCT4AtfYOaDIJpZ4vPCQGKj9eFswMO97mi8rCHrC4wLyhHSJ2ifXR0vi9gh
         1B8pbo6iB8QZtAemY9vSkuxVQ6A+OoTtFO+EzK4k7AGNBiw190G1+I0OKftrbmTIBOpc
         Vr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EMXs7v3ptxT9vNOclT7VSTCrCsz0f0HMpiip+jVy0Kw=;
        b=Q5cj0Z1L3m25yJMwdY5nIaXj2g4YfDsJfmaPZZo3fxrRxSkbe9MDtKZS07Kfc7hT9R
         jsO8+pwSkiTvtGTKShsAwIBXFFEJZSEFvFhVyIH0d5cKAEmwPOs/XziNUc3o2IGpV2wp
         haiKREf5lvNVRAQMG2Hx0zeUrBy8MW6PEHi0j2mFdTOKFzdUQdjBsNPQ4YXy4QcJgZPv
         XlF0CT14klE0jaMv/HPs+wU6qqcvFttlDKtYbh4oZnwfdSd/NgolKHMl4XlswMgt0/aB
         j/fYBE5EXVctATSosXMO8vqb1u9uQmbVUiEe3mHu41jiupmoZKT4GFZQPR1aRaDtUbsQ
         aT7A==
X-Gm-Message-State: APt69E2LMX8GXyyy13/gtuH+jYbo8iPXXODkbfBQonnD3SP/2phwc16V
        Ey1kDCRDFnN+tyatbjkCMORdkg==
X-Google-Smtp-Source: AAOMgpfLUkvAb+zm9evQXlCr+0Z2r/ylFWNK2so7yEM+Ftkbbx2dyEvSbc9F0a/nmcyRixf4cazxpw==
X-Received: by 2002:a5d:4806:: with SMTP id l6-v6mr986098wrq.24.1529941899039;
        Mon, 25 Jun 2018 08:51:39 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 14/14] ARM: davinci: sffsdr: use device properties for at24 eeprom
Date:   Mon, 25 Jun 2018 17:50:25 +0200
Message-Id: <20180625155025.12567-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-sffsdr.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index f6a4d094cbc3..680e5d7628a8 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -26,7 +26,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/at24.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -92,16 +92,15 @@ static struct platform_device davinci_sffsdr_nandflash_device = {
 	.resource	= davinci_sffsdr_nandflash_resource,
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (64*1024) / 8,
-	.page_size	= 32,
-	.flags		= AT24_FLAG_ADDR16,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 32),
+	{ },
 };
 
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c64", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	/* Other I2C devices:
 	 * MSP430,  addr 0x23 (not used)
-- 
2.17.1

