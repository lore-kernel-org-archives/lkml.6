Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF0C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F8D219E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN9I+VXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F8D219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbeHGGS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:18:57 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38179 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeHGGS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:18:56 -0400
Received: by mail-qk0-f193.google.com with SMTP id 126-v6so10545833qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RfZ5UNqJ+BhKwYfoJI+HSW9NDxr/tp8jlpcQP0xOn+c=;
        b=lN9I+VXNJHu+KuhKVe9HfHjUYJhxXN78fbUbtG5v5MWiE0+bvaOCMt37fFJGrN5mj5
         JySb7D6IUa8S1bcrdn5sftv1KXT11T7ejlukGaHilcEpdDorg5GnyGtBFDKRcNfvAXtK
         tZG+qyehR/PqxKyPXarCPl0WVuTw1U3E8fBzYzGbw7QBsZwIqbqPPAG3ftjAKii3T15I
         ffSyd4SoG7YJQ4nOHh2uGqLSSaT0KaUtEnqv4UmeJnUpHTSxDnOdZDAVFgUy/7kmh+Dy
         Rc2T+sAeUa0HAusiy7CbhpLIGZi/Hn+jwg+b2nr3i2JxZy2gtiS6lvF60agMHWtkCw5Z
         hmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RfZ5UNqJ+BhKwYfoJI+HSW9NDxr/tp8jlpcQP0xOn+c=;
        b=H4FrlEsWNlhTdTOaW3K5cjPIogRt75ExFvo8tgTDVWFxgN3ClV8V8ihz5zSSqiXnRl
         6bzZdu9mRJxpkBgoD2E7+Z9X2FwUb1q2H35tePY3ufFWMIBV9Wsi7vHiDE62lgybELgx
         oMdVs/h4rfGtz59ggq1XzyxKWy2v1EPZdfqKj7IB5FRIjhSG8w5bVczVmn1Koj/vP7VT
         L8+z50+C8cXuqB8u82kjFXpRZDlWIjEXBSQ1n+pxmj/dUeYzt9+cx4stAFwDRwukpFM1
         eyA4iUKtjpQU1iy29YK3JhsT0+mFqNs5bUNNp9qY7zyGsMMba9Uvhf6lwv83KV+Kenul
         WgKQ==
X-Gm-Message-State: AOUpUlHtVPB3MWm75iN3+cIvVy0TgAiKC9H8Sl3sWRS3jJNkSLvLtRKL
        hk4XXGSsWyTNmoL0BR/ImJM=
X-Google-Smtp-Source: AAOMgpejS4qaB/GncyxJ7IraeKILVV3/zV+03Ogk4h/MAyN2U3jI0KKFfJpaznxOn7HQXYpA6aaang==
X-Received: by 2002:a37:1a4c:: with SMTP id a73-v6mr15327682qka.77.1533614795700;
        Mon, 06 Aug 2018 21:06:35 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id w39-v6sm162339qtk.74.2018.08.06.21.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:06:35 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:06:30 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] staging: fbtft: Fixes some defines styles - Style
Message-ID: <2769547f2ad78ea51812ae0bfc59c23946a5a0ec.1533614243.git.leobras.c@gmail.com>
References: <cover.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533614243.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c  | 10 ++++++----
 drivers/staging/fbtft/fbtft-core.c |  6 ++++--
 drivers/staging/fbtft/fbtft.h      |  4 ++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 5c768c658258..5a68802abac7 100644
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
index 4660a9f9eace..a9ee586ee6ba 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -278,6 +278,7 @@ void fbtft_unregister_backlight(struct fbtft_par *par)
 		par->info->bl_dev = NULL;
 	}
 }
+EXPORT_SYMBOL(fbtft_unregister_backlight);
 
 static const struct backlight_ops fbtft_bl_ops = {
 	.get_brightness	= fbtft_backlight_get_brightness,
@@ -315,12 +316,13 @@ void fbtft_register_backlight(struct fbtft_par *par)
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
index a1411590732d..d8e7204a8d74 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -236,7 +236,7 @@ struct fbtft_par {
 	bool polarity;
 };
 
-#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__})/sizeof(int))
+#define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__}) / sizeof(int))
 
 #define write_reg(par, ...)                                            \
 	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
@@ -346,7 +346,7 @@ static void __exit fbtft_driver_module_exit(void)                          \
 }                                                                          \
 									   \
 module_init(fbtft_driver_module_init);                                     \
-module_exit(fbtft_driver_module_exit);
+module_exit(fbtft_driver_module_exit)
 
 /* Debug macros */
 
-- 
2.18.0

