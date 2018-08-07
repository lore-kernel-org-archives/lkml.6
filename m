Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B14C46473
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D135219DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMeMZRnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D135219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbeHGGRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:17:45 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33972 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeHGGRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:17:45 -0400
Received: by mail-qk0-f196.google.com with SMTP id b66-v6so10544423qkj.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rqi0bPls3G5dxRfgBOWSnyRbXK/YoSXRHj1iTTCJ3fE=;
        b=WMeMZRnkr8Ry1B1c8ThvMDLHb2yGNxEtKzYhh0yvXXBuWU9GYvth8iJ2KEPOITkN8R
         c6G26UTwCbL5fCkciZqx6OdNnc8EBDhKEUvPl5QhFBp/VB07aN+SmDIQjs21RX/Ybi9w
         g2AcvNtFH0g/CMlakdD+s4+NA2yJ9vpFPFOL9KCpUNHl42qjucHCx8oR5LbJlGeaM0O2
         uHayoXcBF0r9Vt/VrPTQYCVf+0ZMIIthSHo7qYh1RrdW/ye4+XVjPGn+C1+ZFVgW2+1E
         0eMATKtjWjImjayk0P2DWn0rp1tlCv4eloVd1j1A/NC6tZ8WRm3WqGtJXIcXllWoHEvP
         nCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rqi0bPls3G5dxRfgBOWSnyRbXK/YoSXRHj1iTTCJ3fE=;
        b=H/q0v/e0aOKdH2iLgAkGaoM05nQ2KiNqPxR6OTTfx4Dd33ghq7iKy6WE9/6qZHwIAH
         pxPpYWant94ctTZLXgYsEjZG67LJXVpZQd5+6KZxIbNBV3WqXEjkeW6/J4vGH2BOOjIN
         zjZW4Asb/GikFwjLPRV3KB1ALsxuGmYCPMkBxZ40IOGPfdugbn237fclrrjOJUBJ/Mgi
         D5/VdkfgSSy1XAUAmGANv7MwCMHHlWGF4zxceeo1p9R8ENUnE0+A8I3kkp5WJXETCS8E
         TNpzTjWR5PGx8LOF4Me2X+yN5jGNS/swRbETFv8t/mg5aALpYWeXWMkODa1URD2L4C5H
         4LIA==
X-Gm-Message-State: AOUpUlF+owwscNhnT95v2m8y7NNkdBNOSZFQJas50SfYFU6rKuecUUTk
        ObZbdliBditryE/txZAv1ZI=
X-Google-Smtp-Source: AAOMgpcYEKgNNGaCg2RqDj6iJ+LTLkmQVpfPdULIPg8ZjJjBJ3ixsdwBhbAzlsc7usuXGKmt11gZGQ==
X-Received: by 2002:a37:1241:: with SMTP id c62-v6mr16316944qkh.118.1533614723975;
        Mon, 06 Aug 2018 21:05:23 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id a144-v6sm154414qkc.84.2018.08.06.21.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:05:23 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:05:19 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] staging: fbtft: Puts macro arguments in parenthesis to
 avoid precedence issues - Style
Message-ID: <e56cf41cff4261fe30ca005d7b5caaceaaf96a3d.1533614243.git.leobras.c@gmail.com>
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
 drivers/staging/fbtft/fb_hx8347d.c   |  2 +-
 drivers/staging/fbtft/fb_ili9163.c   |  2 +-
 drivers/staging/fbtft/fb_ili9320.c   |  2 +-
 drivers/staging/fbtft/fb_ili9325.c   |  2 +-
 drivers/staging/fbtft/fb_ili9341.c   |  2 +-
 drivers/staging/fbtft/fb_s6d1121.c   |  2 +-
 drivers/staging/fbtft/fb_ssd1289.c   |  2 +-
 drivers/staging/fbtft/fb_st7735r.c   |  2 +-
 drivers/staging/fbtft/fb_watterott.c | 12 +++++++++---
 drivers/staging/fbtft/fbtft.h        |  9 +++++----
 10 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/fbtft/fb_hx8347d.c b/drivers/staging/fbtft/fb_hx8347d.c
index 0b605303813e..3427a858d17c 100644
--- a/drivers/staging/fbtft/fb_hx8347d.c
+++ b/drivers/staging/fbtft/fb_hx8347d.c
@@ -92,7 +92,7 @@ static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
  *   VRP0 VRP1 VRP2 VRP3 VRP4 VRP5 PRP0 PRP1 PKP0 PKP1 PKP2 PKP3 PKP4 CGM
  *   VRN0 VRN1 VRN2 VRN3 VRN4 VRN5 PRN0 PRN1 PKN0 PKN1 PKN2 PKN3 PKN4 CGM
  */
-#define CURVE(num, idx)  curves[num * par->gamma.num_values + idx]
+#define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
 	unsigned long mask[] = {
diff --git a/drivers/staging/fbtft/fb_ili9163.c b/drivers/staging/fbtft/fb_ili9163.c
index fd3dd671509f..86e140244aab 100644
--- a/drivers/staging/fbtft/fb_ili9163.c
+++ b/drivers/staging/fbtft/fb_ili9163.c
@@ -192,7 +192,7 @@ static int set_var(struct fbtft_par *par)
 }
 
 #ifdef GAMMA_ADJ
-#define CURVE(num, idx)  curves[num * par->gamma.num_values + idx]
+#define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int gamma_adj(struct fbtft_par *par, u32 *curves)
 {
 	unsigned long mask[] = {
diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
index 501eee7dce4c..740c0acbecd8 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -211,7 +211,7 @@ static int set_var(struct fbtft_par *par)
  *  VRP0 VRP1 RP0 RP1 KP0 KP1 KP2 KP3 KP4 KP5
  *  VRN0 VRN1 RN0 RN1 KN0 KN1 KN2 KN3 KN4 KN5
  */
-#define CURVE(num, idx)  curves[num * par->gamma.num_values + idx]
+#define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
 	unsigned long mask[] = {
diff --git a/drivers/staging/fbtft/fb_ili9325.c b/drivers/staging/fbtft/fb_ili9325.c
index d6b1d4be9ff4..2cf75f2e03e2 100644
--- a/drivers/staging/fbtft/fb_ili9325.c
+++ b/drivers/staging/fbtft/fb_ili9325.c
@@ -205,7 +205,7 @@ static int set_var(struct fbtft_par *par)
  *  VRP0 VRP1 RP0 RP1 KP0 KP1 KP2 KP3 KP4 KP5
  *  VRN0 VRN1 RN0 RN1 KN0 KN1 KN2 KN3 KN4 KN5
  */
-#define CURVE(num, idx)  curves[num * par->gamma.num_values + idx]
+#define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
 	unsigned long mask[] = {
diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_ili9341.c
index a10e8c9de438..9ccd0823c3ab 100644
--- a/drivers/staging/fbtft/fb_ili9341.c
+++ b/drivers/staging/fbtft/fb_ili9341.c
@@ -111,7 +111,7 @@ static int set_var(struct fbtft_par *par)
  *  Positive: Par1 Par2 [...] Par15
  *  Negative: Par1 Par2 [...] Par15
  */
-#define CURVE(num, idx)  curves[num * par->gamma.num_values + idx]
+#define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
 	int i;
diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/fb_s6d1121.c
index b90244259d43..c3e434d647b8 100644
--- a/drivers/staging/fbtft/fb_s6d1121.c
+++ b/drivers/staging/fbtft/fb_s6d1121.c
@@ -120,7 +120,7 @@ static int set_var(struct fbtft_par *par)
  * PKP0 PKP1 PKP2 PKP3 PKP4 PKP5 PKP6 PKP7 PKP8 PKP9 PKP10 PKP11 VRP0 VRP1
  * PKN0 PKN1 PKN2 PKN3 PKN4 PKN5 PKN6 PKN7 PRN8 PRN9 PRN10 PRN11 VRN0 VRN1
  */
-#define CURVE(num, idx)  curves[num * par->gamma.num_values + idx]
+#define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
 	unsigned long mask[] = {
diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index cbf22e1f4b61..46116d06522c 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -126,7 +126,7 @@ static int set_var(struct fbtft_par *par)
  * VRP0 VRP1 PRP0 PRP1 PKP0 PKP1 PKP2 PKP3 PKP4 PKP5
  * VRN0 VRN1 PRN0 PRN1 PKN0 PKN1 PKN2 PKN3 PKN4 PKN5
  */
-#define CURVE(num, idx)  curves[num * par->gamma.num_values + idx]
+#define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
 	unsigned long mask[] = {
diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/fb_st7735r.c
index 631208bd3a17..e24af0a7f2de 100644
--- a/drivers/staging/fbtft/fb_st7735r.c
+++ b/drivers/staging/fbtft/fb_st7735r.c
@@ -133,7 +133,7 @@ static int set_var(struct fbtft_par *par)
  * VRF0P VOS0P PK0P PK1P PK2P PK3P PK4P PK5P PK6P PK7P PK8P PK9P SELV0P SELV1P SELV62P SELV63P
  * VRF0N VOS0N PK0N PK1N PK2N PK3N PK4N PK5N PK6N PK7N PK8N PK9N SELV0N SELV1N SELV62N SELV63N
  */
-#define CURVE(num, idx)  curves[num * par->gamma.num_values + idx]
+#define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
 {
 	int i, j;
diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index 9ad4307a50c8..9d5979b3cfb8 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -89,9 +89,15 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 	return 0;
 }
 
-#define RGB565toRGB323(c) (((c&0xE000)>>8) | ((c&0600)>>6) | ((c&0x001C)>>2))
-#define RGB565toRGB332(c) (((c&0xE000)>>8) | ((c&0700)>>6) | ((c&0x0018)>>3))
-#define RGB565toRGB233(c) (((c&0xC000)>>8) | ((c&0700)>>5) | ((c&0x001C)>>2))
+#define RGB565toRGB323(c) ((((c) & 0xE000) >> 8) |\
+			   (((c) & 000600) >> 6) |\
+			   (((c) & 0x001C) >> 2))
+#define RGB565toRGB332(c) ((((c) & 0xE000) >> 8) |\
+			   (((c) & 000700) >> 6) |\
+			   (((c) & 0x0018) >> 3))
+#define RGB565toRGB233(c) ((((c) & 0xC000) >> 8) |\
+			   (((c) & 000700) >> 5) |\
+			   (((c) & 0x001C) >> 2))
 
 static int write_vmem_8bit(struct fbtft_par *par, size_t offset, size_t len)
 {
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index c7cb4a7896f4..0c710d374fab 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -234,8 +234,8 @@ struct fbtft_par {
 
 #define NUMARGS(...)  (sizeof((int[]){__VA_ARGS__})/sizeof(int))
 
-#define write_reg(par, ...)                                              \
-	par->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__)
+#define write_reg(par, ...)                                            \
+	((par)->fbtftops.write_register(par, NUMARGS(__VA_ARGS__), __VA_ARGS__))
 
 /* fbtft-core.c */
 int fbtft_write_buf_dc(struct fbtft_par *par, void *buf, size_t len, int dc);
@@ -404,8 +404,9 @@ do {                                                         \
 
 #define fbtft_par_dbg_hex(level, par, dev, type, buf, num, format, arg...) \
 do {                                                                       \
-	if (unlikely(par->debug & level))                                  \
-		fbtft_dbg_hex(dev, sizeof(type), buf, num * sizeof(type), format, ##arg); \
+	if (unlikely((par)->debug & (level)))                                  \
+		fbtft_dbg_hex(dev, sizeof(type), buf,\
+			      (num) * sizeof(type), format, ##arg); \
 } while (0)
 
 #endif /* __LINUX_FBTFT_H */
-- 
2.18.0

