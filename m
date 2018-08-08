Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0095CC46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CCD21533
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blbAcaoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CCD21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeHHCq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:46:27 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38658 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeHHCq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:46:27 -0400
Received: by mail-qk0-f196.google.com with SMTP id 126-v6so355486qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Dan5GbZ9b6G+XsnByVOu8L+Xvw99bp8n/KoMkYEKYG8=;
        b=blbAcaoaku3ttMXTmOK+0BXzCgcdLmBMPxrdiTCytmfA03owshDGEle/3Tr59b1ecl
         i1GIvfCqNhOYPE/zUV4JmQ4oWIQzbRJrWVROu9Y5YkZeuIpO7PoYcsULVvT8t/VxAYVV
         olVe+hTvm4lp4vBUmO2YvMrwQCd+ZfqJ7+3zczLRUl/zZVyl9PWb9Dj1NSA0QN/k1a9C
         kfPIfCEooH58VHpabm05so5s4xR9xkUjGTszEnxKjrthe8yBV7Cfh3VQR36WpCYjH1RO
         jDQW4quZiT+Qr+qVinuUhqCmfQag/PNQT4XXBtG6sJ72uCSnLkwvYrCXQoi9WAGLfnjz
         HVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Dan5GbZ9b6G+XsnByVOu8L+Xvw99bp8n/KoMkYEKYG8=;
        b=XDGxhwZR/41xp5iXLvBJYgguxaUs2AkDVEtS5Zrx9Dn6jXD/f5jIX+n+DcQEUlYJUR
         QT0ou92EU7dnd+Yymai96R+ajRb6Vo2nVV13xWNrfp53oX9VIlEBvQbvGy251/XzLJqT
         nKMwkmWzp8URmSXnZUSUF91nZxNswswqqRlEPP5eleZnbOABEIC/WNII6M8di5mdc24+
         8mPbz3Rj5vlPPEmrJmARO5bh+ps9r/ruWoN5xhJVVbCbw0+2EDLPWI5NV6nAYS0UAgIa
         Lkj4QRGuu/VLGP+MHD/4o5f1piTUsrgwuucopapeNbZaRJTBfgf00zg9szRLzaAqcVlR
         sZrg==
X-Gm-Message-State: AOUpUlFmzytgO+RQhQ/IKJvgJAAATHZVKWb4h3obamuAST52UlHZKwVN
        qR01wRbM7NoHRYXuxNSvs2Q=
X-Google-Smtp-Source: AA+uWPxaTR1pNCwZYXFrcWY9hisOadM1gg9KeGEhcWBwW14bue3YggNmDzoU7fWW2UxpJwop58dFKw==
X-Received: by 2002:a37:9242:: with SMTP id u63-v6mr544629qkd.189.1533688169329;
        Tue, 07 Aug 2018 17:29:29 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id a66-v6sm1633636qkf.96.2018.08.07.17.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:29:28 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:29:25 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/15] staging: fbtft: Fixes some defines styles - Style
Message-ID: <cb5b3900e97e3b295dda63b5d8b29d6fed669893.1533686201.git.leobras.c@gmail.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing some styles as recommended by checkpatch.pl.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c  | 10 ++++++----
 drivers/staging/fbtft/fbtft-core.c |  6 ++++--
 drivers/staging/fbtft/fbtft.h      |  4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 8ce1ff9b6c2a..20d94712cc84 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -60,11 +60,13 @@ void func(struct fbtft_par *par, int len, ...)                                \
 out:									      \
 	va_end(args);                                                         \
 }                                                                             \
-EXPORT_SYMBOL(func);
+EXPORT_SYMBOL(func)
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
-define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+#define no_modf /*No modifier*/
+
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, no_modf);
+define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16);
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, no_modf);
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 64f69d1a3029..8b79353c722a 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -275,6 +275,7 @@ void fbtft_unregister_backlight(struct fbtft_par *par)
 		par->info->bl_dev = NULL;
 	}
 }
+EXPORT_SYMBOL(fbtft_unregister_backlight);
 
 static const struct backlight_ops fbtft_bl_ops = {
 	.get_brightness	= fbtft_backlight_get_brightness,
@@ -312,12 +313,13 @@ void fbtft_register_backlight(struct fbtft_par *par)
 	if (!par->fbtftops.unregister_backlight)
 		par->fbtftops.unregister_backlight = fbtft_unregister_backlight;
 }
+EXPORT_SYMBOL(fbtft_register_backlight);
 #else
 void fbtft_register_backlight(struct fbtft_par *par) { };
-void fbtft_unregister_backlight(struct fbtft_par *par) { };
-#endif
 EXPORT_SYMBOL(fbtft_register_backlight);
+void fbtft_unregister_backlight(struct fbtft_par *par) { };
 EXPORT_SYMBOL(fbtft_unregister_backlight);
+#endif
 
 static void fbtft_set_addr_win(struct fbtft_par *par, int xs, int ys, int xe,
 			       int ye)
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 87114502e836..6ee9ff320567 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -232,7 +232,7 @@ struct fbtft_par {
 	bool polarity;
 };
 
-#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__})/sizeof(int))
+#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
 
 #define write_reg(par, ...)                                            \
 	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
@@ -342,7 +342,7 @@ static void __exit fbtft_driver_module_exit(void)                          \
 }                                                                          \
 									   \
 module_init(fbtft_driver_module_init);                                     \
-module_exit(fbtft_driver_module_exit);
+module_exit(fbtft_driver_module_exit)
 
 /* Debug macros */
 
-- 
2.18.0

