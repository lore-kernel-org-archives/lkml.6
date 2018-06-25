Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C695925D59
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="E872KcsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C695925D59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755157AbeFYPws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:52:48 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43926 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754694AbeFYPvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id c5-v6so3038372wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jx0FFc73oZ6Zy8ptPCMM0HpA1qgmrfI2HIre8erTRrc=;
        b=E872KcsYndIuvH9FzxXK19r8cdypuq0livJT3n8TSxSHxe2hBMw6tWohv3He58FEqK
         HQYRsB54qA2umdz8mByNhEDNweLXJn/jS+KB0o+7k4ezaDUE4bYYJGMg5vO5e3V/TEI0
         B2M5RVHdAWol/Q1MNqfWDn5pHWIqAGuhFzj9CRijDcroZi9yLMhgAUzzMifW6g5bOxOg
         qB4LWa71oSav77asjYDUCTQtsY4qlSPSYi2gFl9Urd1KlYX8E86hChMZVGY+jAKkcEcK
         haGkQUiu/TpAkU/Ptb5PFt0++edaKyazrGfJ+UPRCqsz6g++AZI7q3q4FlTXnK8amDSF
         nymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jx0FFc73oZ6Zy8ptPCMM0HpA1qgmrfI2HIre8erTRrc=;
        b=DMCbtUdPNeRazZaLMPz1B3V9Zm7WVCVv3oa18Tl9e4B1zTxDoRMx4IIQiOZsRiN6jd
         NISMI3y/X62R/3AG5mY/Y2orb8vG1CccIx7b1IQpjgKrglbnP4uOSFi8hAff+6RyZvIt
         eTiacgSipSCaYrbgQCb4YGyM1IhQa0nBRAmpgxhmPMb0/KvaQNrnvWAnrp7EGdewdWaN
         kgnTAO3BSHhH7LhMKHTh85VbzV34tLEFKzWjHNTwZL7DJVyEMbB7kRsTvf3l2nfxk6J8
         JEDCkR1LsSRJCXZAvleHOXZCNL+4KPYB+02yFmT4MCbe0Q2qpt2wZMAN5Ig0Hbj4aveP
         ynog==
X-Gm-Message-State: APt69E0YLhnpY3xFCDdRfkYuXv935dhZ+2LD1FpqE6hv91pM0XWJMpeU
        t3CCicxzmrh36Ti7c/d0m2SgOw==
X-Google-Smtp-Source: AAOMgpflpminnVCkaV25R43dpx7HI+m5cCa8b4NuW5jjbrilptu5az5hmasrpYRsGIyAlslD/WDaDg==
X-Received: by 2002:adf:ee81:: with SMTP id b1-v6mr211846wro.21.1529941896264;
        Mon, 25 Jun 2018 08:51:36 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:35 -0700 (PDT)
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
Subject: [PATCH 13/14] ARM: davinci: sffsdr: fix the at24 eeprom device name
Date:   Mon, 25 Jun 2018 17:50:24 +0200
Message-Id: <20180625155025.12567-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
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
2.17.1

