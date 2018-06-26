Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD13DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AFF242CD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EJXeslHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AFF242CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934930AbeFZKYg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:24:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42658 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964772AbeFZKXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so1069042wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jx0FFc73oZ6Zy8ptPCMM0HpA1qgmrfI2HIre8erTRrc=;
        b=EJXeslHmnuNOi2mxctiJDvT8YFbu+rwVBZxblABRHGsOf4AlZImBbXhQiHtOGO5DxJ
         06z2CVCoUo1VHrImbSiXUSa6j1Y/KyigtZ8YY0hmvHUwU7Appqu9uHvFQM3e5FXNg2ph
         1job/FQgL5QBFefHP+weegtx/iR5QllQqQb8vf0TtzRoDCtonv4/tu8WCwC8a4Fh1yPO
         pga5ZNUzSlUwWlUv42O9Lf0/sfj1F18KwoSn3h/sfhdT8O6xhfec2smy3bqMNfKqD+wk
         xEJn1iAuktaFwdacOPKuK7MDFR8Zf5KQzK5H77nHumN/19r9zT3k/s/e/jP4pv/K5Tnh
         pZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jx0FFc73oZ6Zy8ptPCMM0HpA1qgmrfI2HIre8erTRrc=;
        b=AyAdD8IwA/Sjd1FSKSpmCy+AvcyVuptBPtAZ9LOLn5unQeuF5YWrgCKW42S9CvR7mi
         pW2SDhFkY+njC4iP+me7IB/q+dNIaVshdbfWj336+nEzmpoT+Sumd5oBCaQDSqYQbIX9
         b7Rt67NKMT4Sus3NTfyCYM1lv/ejfUqKqZkufiJPPLPaV4yDgDEdytq8iFoTqvaO/TPD
         jWBWSZiNzD+qBV2ZYAWqtQg+S9WV805lWaiaO8logUQwqqXmdyytZUgajBz2XEIRHbZW
         BA3TjKaXh0lko82hR6UyeGyhf/nzq97RNo3cYBmJKIApj566PDK6nOZ1wKWRjAdeW8Z8
         jzVA==
X-Gm-Message-State: APt69E3UtzvRIJ/GGbR2tLplkqCZkd5GChz/3K37feEvlqmDHiNnw3TW
        jhl/0bv0AD6ObEWS6RPQhl/3NQ==
X-Google-Smtp-Source: AAOMgpezj9FWKIBTJ8u0ROeOS6U3pWHN0IDZpD0aJAMcYxNefLS8bLoHVOGonkz33Ktd1SJA6XanMA==
X-Received: by 2002:a5d:470b:: with SMTP id y11-v6mr929844wrq.107.1530008614647;
        Tue, 26 Jun 2018 03:23:34 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:34 -0700 (PDT)
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
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 13/15] ARM: davinci: sffsdr: fix the at24 eeprom device name
Date:   Tue, 26 Jun 2018 12:22:43 +0200
Message-Id: <20180626102245.30711-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626102245.30711-1-brgl@bgdev.pl>
References: <20180626102245.30711-1-brgl@bgdev.pl>
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

