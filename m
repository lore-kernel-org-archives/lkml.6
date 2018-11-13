Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6280C2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DUVq818X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6280C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbeKNABt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:01:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36250 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388094AbeKNAAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:00:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id z13-v6so13447124wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+tDzntZFfY3GLS/4lI4221oPwYjWwUsoPxzbNeGoww=;
        b=DUVq818XztF17potVvI9i1PK86EqQtT0jlWPLbOegWOH4yTLmtdDDz4q21BC3B/eYI
         YoKQo6AYE35b03fTLwXQ2o2KyF4nWWkmoUerwPL5EL3tMRj9T8IiIj45nI3sItiosz7P
         wdmmlLh+RjotdnEw62fOngzb/NCZRISqqHsO7bhR68cznZ96cSW3HhGrdYbPu+q+Tb9m
         q9uDdpiGrUClJhH1qf4ZLVCRaXFOJ0laD0ECnlukekcdTqstB5oebQuN3KeWEF9VYnpW
         gKupXEvepZHzekUG7o1wCIN99mJq5t1gjjgltVvG5lb9VVKSPt6uyEmnsaxmGyxrFT+0
         pZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+tDzntZFfY3GLS/4lI4221oPwYjWwUsoPxzbNeGoww=;
        b=OAqvEEP+qrH9BuwlquziDkYWoFsJE7PCUEppYIfTD9/zg2b6xi+je+cJ4y06OX0a9x
         +d8Ruamb9hgdkX2LkORJZK+L01w4OvKyYq/1/oJ/KZvQ07hlqCByXniMj8I3jwq59lSY
         gxFZ/38quvkCJAd6PRLz6cblqKiKdyCQ3tr51j6wJTz4/ywQgTE8OKpqYywAmAgPO4FI
         oS3e0mQuhcdKoD0aCjetG3U1OB3VAOK+LGxSbdtrLWdMbjg7hM1sDPqXwqKXzVGIWUw1
         4gK/xmKOqjBjDyne7iEgnJqA5NzCUNh/hjm1IzTRnqhv2oRmuFkuWZaYfbnQdZWwf5o1
         zRdw==
X-Gm-Message-State: AGRZ1gKy33XFcp9bP2SCODqvLSmauyKVXCbYeraJopWtxhJDObg6P4X5
        0/1JO75EMUcCwm8ljzvZNdQ3uA==
X-Google-Smtp-Source: AJdET5fUa7P4pqTkNLMJPx+aR+6iEMAGcJAORVawMii9aSn1PUmSuSdfVOcHiOSJabclU1KqVRDk4w==
X-Received: by 2002:adf:ded1:: with SMTP id i17-v6mr5283755wrn.307.1542117750456;
        Tue, 13 Nov 2018 06:02:30 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m69-v6sm16604122wmb.8.2018.11.13.06.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 06:02:29 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 20/25] ARM: davinci: sffsdr: fix the at24 eeprom device name
Date:   Tue, 13 Nov 2018 15:01:28 +0100
Message-Id: <20181113140133.17385-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113140133.17385-1-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 792bb84d5011..acd9778ffa07 100644
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
2.19.1

