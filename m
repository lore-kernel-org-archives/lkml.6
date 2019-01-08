Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCABC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566FA2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Sfs9Aaiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfAHJQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:52 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43059 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfAHJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:15:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so3431473eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+tDzntZFfY3GLS/4lI4221oPwYjWwUsoPxzbNeGoww=;
        b=Sfs9AaizMYDAGnIdGzo9aI6cMDMrNgpofOsNLiN+Ztc/ZFSGdh7C055MfB1L5SJZtL
         16vdeY/f0DshKMDzGI0ovkRkYsF7Uqj4G1nIPSMy7/PLNgOkM9vMtjpV9+XADW07Nic0
         LU2Ziz+GlDKATPpEOeBEecexaiVHOV0kq3d4/pYDDIRFU6UXGjEMt7YRuUrtfWw4kl7x
         QvUypi1Q9b586+Ktore16WgZwA4nhQfn6zoEGozs4R4FthVWLewOXb45pSQApy6Aye8P
         QXbsLLZTaoNohKSvieoxd8L6P1n4/2xXaZoajj9yn83xgCxDGJSbSCP6uG0wbOtITIBn
         SuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+tDzntZFfY3GLS/4lI4221oPwYjWwUsoPxzbNeGoww=;
        b=pCwvaTpO2Rywju9/ApZ3pGaz3u40IwVKrG4GiWe/andU8wGuSEanc3fOhrPJJ7L32Q
         2S4VWcHvguQ/Am/J7LnLpPNQv21muiQv+zoMTND05MxWJIQvejRCzQFsEsF0ITyJZ2Sz
         lgahve52vJva4ZhZIwPWkPeAwLGkKH25L8ek9JW7mYJD5vKt1qoxrAsKjuBd5gyfpyF6
         Loxqbog3XEEMWGE/ERckxjTZa6JXs3aC3UOG3v3vxKUHdqvaF9CQG3kCKvibgH4gOjKD
         slKshFU+zwp5+kgAOPjcYw2H2JmV1+JPYum2QkEwPKfzsokVZlbICUMYe2Q0cGVrz2YE
         id8w==
X-Gm-Message-State: AJcUukcxD2H2uBQvxe3v8xVhWyBrYvgCSmDDy+AcuzZpwuGPtdliU7PY
        UrM4YHa/1VXDi3u/0FVZaE5Wkw==
X-Google-Smtp-Source: ALg8bN4j+I8YL2AMMYbG560bpM8Oo1VADblSDU5OZamCQEc11xdzdSpUnnAfXOmYidqv8SieFvo//g==
X-Received: by 2002:a50:f10b:: with SMTP id w11mr1349052edl.0.1546938958171;
        Tue, 08 Jan 2019 01:15:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 07/12] ARM: davinci: sffsdr: fix the at24 eeprom device name
Date:   Tue,  8 Jan 2019 10:15:34 +0100
Message-Id: <20190108091539.16674-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
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

