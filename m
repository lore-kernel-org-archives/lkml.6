Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C538C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F3427CA6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UlR62K6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F3427CA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935906AbeF2JmH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:42:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41548 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935791AbeF2JlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:41:07 -0400
Received: by mail-wr0-f196.google.com with SMTP id h10-v6so8193170wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jx0FFc73oZ6Zy8ptPCMM0HpA1qgmrfI2HIre8erTRrc=;
        b=UlR62K6cnqNIA1TStTCMgPtKItyFvhlGGrY1ju6O1njLKHwEyDWfeFtzEKlKcDlqQ2
         Set8KmJa/525kg0PMpMRqNluhjrWcGyofxsPbC393UTO07VgCGV2bs0OEmAr2/J0ujbF
         bqs3xLiR/0i2AXfnZXaTsav7bfMMI3yqY92zwFiZq1GCOua6OuCkJr3/yx0nLdeS+0ic
         jGJaD6fja3yF0j2yflhNYuFmf7j1nWdiPTlHwAC2FiFZEA8Xx7osXVaa1RSKRwdKwASe
         OmwRs16Py36rBJMQXwwm6Lsw8k671x4DbZ9/GA55t3oAoYDSow0cRKfieyzrcaY70twf
         hPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jx0FFc73oZ6Zy8ptPCMM0HpA1qgmrfI2HIre8erTRrc=;
        b=mPt4cEm5KjFLW0iLJQf3rYRZT8pyyC90zII3Ejdn7vpVh7Tvxu1hN1fA2yNzpPoEDF
         0pDkdhWv1s0ju1C/R0rRM5Z5H5LWG9a16Oa4nzJWcbq+G/NM9trQxO+T5cUssl/C1L7v
         8YKZuKKYMYCxCS/f2Zi49MRtztRbytabJ4e/YEJv24xvci7jGOt7nB6ZSLV2HFRpTmyR
         ADOctIYsWESajDaJybDnz5yZRM0496y9OpcgtrGZjXHWxNcxONILrXiYtstRkgj0P2l1
         ZxED1zwCu/J7I2N4vPsfY+XFVvFZKnOdVRi6BGed6DdqgnnI/ltlkKDPYhT+ClCpTSAj
         FybQ==
X-Gm-Message-State: APt69E35ZDua0cdoEKFzBzK7ctRct8Y+zHfDKFGexuhTy68hge3Vtw2h
        7eKjgyroizu38nDozb4ug8Mhng==
X-Google-Smtp-Source: AAOMgpfMtV/f1dGPPS/FEDeLyozvdg5qkcsGKaDhbGUSXLr1aPZ6yX34H68+It0wFTWxUqA/LVWsbw==
X-Received: by 2002:adf:8441:: with SMTP id 59-v6mr8142264wrf.138.1530265265889;
        Fri, 29 Jun 2018 02:41:05 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id d102-v6sm1386394wma.10.2018.06.29.02.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 02:41:05 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 16/18] ARM: davinci: sffsdr: fix the at24 eeprom device name
Date:   Fri, 29 Jun 2018 11:40:37 +0200
Message-Id: <20180629094039.7543-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629094039.7543-1-brgl@bgdev.pl>
References: <20180629094039.7543-1-brgl@bgdev.pl>
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

