Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8FCC46473
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7340214C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXyqY4fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7340214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeHHCpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:45:18 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35878 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHHCpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:45:18 -0400
Received: by mail-qt0-f194.google.com with SMTP id t5-v6so591499qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+vyJjv9SqvJnGmFNzbx9kZaYgya/zn1RQ9HWMXUBSIg=;
        b=bXyqY4fTLYKvXQerkes6kSa5PRfCCqGincRzTMlvpqMFvhmcqh3RUNw+uzl538Wb3s
         VzY9oLjjWEQSUmGtHSvx+oG/5OTbqcFWCzf8a/1OK7GFaq0VySkHjYBWNXc3uGQJD6yP
         6BnbFB/jHSx57r54yO73Vd4stHhuYbm9X+Y3TeA07PnguBpe49tcwk5oEO+IZXXSVrY2
         NWvYa0jgp5PpZkchWeux4N6IZ+eRTBjoDa2dfR2O7Gnm6Z1aAZn5PfT13Y8p7SlT7brI
         VelTeGaVlnlvP2IvXNxyAVa18nf8jEbM+KhxJ7U6p48wqN2bJ2cbr6sG92LD6D1YzLP9
         wGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+vyJjv9SqvJnGmFNzbx9kZaYgya/zn1RQ9HWMXUBSIg=;
        b=BuW3Fnm0mSLWJbldlCwQ76qdPSUJRfH1sbQcHtXYXBtnp00CPqkuEt2/lJ7Q89MuNV
         oZuQ7rYHTWYKloK75IRtfmX925K+sMsKJFT6F9rSy0AAAd7YfOLysI71OZraHPhQ/B40
         g+HCQewTJqnRoHK9ZS9PRoPW5jn4G1H1n+ePe4c3SMk7jZmNVO2YgP6wdgSM0i/vUv6z
         AUfjffPyZi6EuGi9J6WWlRopAVpzh1i1BGt5XFl2gaPE0wZ91CvyreEiseQWL1Ie5yrx
         X5qqDLNBg6pmWnkeyOnABn5jEW+6lxdCCObqYWPWAvGzOrcjUvX+PTh84wa+oywcHhui
         fvRQ==
X-Gm-Message-State: AOUpUlFqPs8l5CyMqvdDMQly6GuKs/oVLI6E8FAN4VeZ2ASfsCqYKSsx
        AWYJocv4jQ2ehlkKsFMjHQd6y8Do
X-Google-Smtp-Source: AA+uWPxVntaOC49t9ut1fOM9T57KmDu8lq680X6kfsUx0kQ8JhQlCuKwP8hm2T2/ktmll5hQHK9mDA==
X-Received: by 2002:ac8:117:: with SMTP id e23-v6mr646682qtg.262.1533688100844;
        Tue, 07 Aug 2018 17:28:20 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id z18-v6sm2007918qtz.89.2018.08.07.17.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:28:20 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:28:16 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/15] staging: fbtft: Puts macro arguments in parenthesis
 to avoid precedence issues - Style
Message-ID: <69107724cfd916b39ae1b1fe5105d33dc9a688ad.1533686201.git.leobras.c@gmail.com>
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

Puts macro arguments in parenthesis to avoid precedence issues.
Some large lines were broken to fit the 80-char limit.

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

