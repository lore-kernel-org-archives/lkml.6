Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C965C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2932219DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/eHCBJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2932219DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbeHGGSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:18:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33476 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeHGGSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:18:02 -0400
Received: by mail-qk0-f194.google.com with SMTP id 27-v6so10557860qkv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M/JJdhQ2UNG5pfUdBoJ5Jhb/JTYTL1X/mgSKdLcCDkI=;
        b=I/eHCBJaP8uqVhZ1ubon3nZjipnRjd7D4Nl0Bc86m4B9dMVoOPdqShpkakhKvSfs5C
         E+H3IGDBC6ZUIesM2BH7palrqOehTEIg5+2M4U0PJQUJbRUBPCKKoQUJjrVuiWTFahlf
         3tNpwAdrsRAk8yhUhwgvDo3Vf39MyROdSNkEumh5/9FexsADw6IPurCoPVxNUdq4GiYh
         QwFfIRPV9p3Y0QYZS4ZgMYlcS/HTyBIKI+gwnHhRJErWPWev2iHuitLlaphdAL8m6IBR
         a0fRgX8/GFcpNmQsmo67P55XxhuADGxNqW9EcIH8KM0Kfv2Xz/tnqp2qMil5/9qMqHU1
         H0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M/JJdhQ2UNG5pfUdBoJ5Jhb/JTYTL1X/mgSKdLcCDkI=;
        b=tpF57s6PfRD3SD+xlbigwI5/nuIygPvASaRpijF+dcF/v3sAa9A+MuWlnF3AqWS0qp
         Dwp3+BGziVBTcH5OF+TjdN1LAcE946v6C1aUTLVcFCBCT5hUKB3FdsDAS8i1/ikW4Naw
         Z7sJl87a0+EKdcuRx26M1veJimfKD5A4yHhtb+cBYY1XBb1rZcY3Z51MbkVNih2YYOgO
         g6ecT+eunf/uJ8uq6Wm6t35rUNv97aSaL39Hb1j57qqdivQzVFATixv2oGj1l8d18Gsi
         YGxSeYbsbYIMSrBak+keE+mzaJmJqLyV7W6hzOsGvycizIPc5zEIjt7wPk0sktJyFpd7
         xt6g==
X-Gm-Message-State: AOUpUlEFo9nNu9KWKCw+xRkIeGUo1lE6BrsL2esoHbC70X6W0C6c84Mq
        CE4LniFTBqKTqgUk0MEx41Q=
X-Google-Smtp-Source: AAOMgpcwp19+ms/nN55UuSseaicKaPgrtHfIUyItpRNRcugK7XIScMT3QtS8rELHJ5gR8KvDCH0Now==
X-Received: by 2002:a37:284a:: with SMTP id o71-v6mr15317240qkh.176.1533614739938;
        Mon, 06 Aug 2018 21:05:39 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id b30-v6sm142158qtc.78.2018.08.06.21.05.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:05:39 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:05:33 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: fbtft: Fixes some alignment and line > 80
 char issues - Style
Message-ID: <c3d5c1c1087897c1079ff996a216c1fe75b0c494.1533614243.git.leobras.c@gmail.com>
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
 drivers/staging/fbtft/fb_ssd1289.c   |  6 +--
 drivers/staging/fbtft/fb_ssd1306.c   |  3 +-
 drivers/staging/fbtft/fb_ssd1331.c   |  9 ++++-
 drivers/staging/fbtft/fb_ssd1351.c   | 43 +++++++++++++--------
 drivers/staging/fbtft/fb_st7735r.c   | 19 +++++++---
 drivers/staging/fbtft/fb_st7789v.c   | 13 +++----
 drivers/staging/fbtft/fb_watterott.c | 17 +++++----
 drivers/staging/fbtft/fbtft-bus.c    | 21 ++++++----
 drivers/staging/fbtft/fbtft-core.c   | 57 ++++++++++++++++++----------
 drivers/staging/fbtft/fbtft-io.c     | 17 +++++----
 drivers/staging/fbtft/fbtft-sysfs.c  |  4 +-
 drivers/staging/fbtft/fbtft.h        | 38 +++++++++++++++----
 drivers/staging/fbtft/fbtft_device.c | 44 +++++++++++----------
 drivers/staging/fbtft/flexfb.c       | 46 +++++++++++++---------
 14 files changed, 214 insertions(+), 123 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
index 46116d06522c..67b3f8548241 100644
--- a/drivers/staging/fbtft/fb_ssd1289.c
+++ b/drivers/staging/fbtft/fb_ssd1289.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0x0E, 0x2B00);
 	write_reg(par, 0x1E, 0x00B7);
 	write_reg(par, 0x01,
-		BIT(13) | (par->bgr << 11) | BIT(9) | (HEIGHT - 1));
+		  BIT(13) | (par->bgr << 11) | BIT(9) | (HEIGHT - 1));
 	write_reg(par, 0x02, 0x0600);
 	write_reg(par, 0x10, 0x0000);
 	write_reg(par, 0x05, 0x0000);
@@ -98,8 +98,8 @@ static int set_var(struct fbtft_par *par)
 	if (par->fbtftops.init_display != init_display) {
 		/* don't risk messing up register 11h */
 		fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-			"%s: skipping since custom init_display() is used\n",
-			__func__);
+			      "%s: skipping since custom init_display() is used\n",
+			      __func__);
 		return 0;
 	}
 
diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
index 9276be499303..f5e0ec1c01dc 100644
--- a/drivers/staging/fbtft/fb_ssd1306.c
+++ b/drivers/staging/fbtft/fb_ssd1306.c
@@ -184,7 +184,8 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
 		for (y = 0; y < yres / 8; y++) {
 			*buf = 0x00;
 			for (i = 0; i < 8; i++)
-				*buf |= (vmem16[(y * 8 + i) * xres + x] ? 1 : 0) << i;
+				*buf |= (vmem16[(y * 8 + i) * xres + x] ?
+					 1 : 0) << i;
 			buf++;
 		}
 	}
diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
index 383e197cf56a..4c7500991a5b 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -74,7 +74,14 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 		for (i = 0; i < len; i++)
 			buf[i] = (u8)va_arg(args, unsigned int);
 		va_end(args);
-		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device, u8, buf, len, "%s: ", __func__);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER,
+				  par,
+				  par->info->device,
+				  u8,
+				  buf,
+				  len,
+				  "%s: ",
+				  __func__);
 	}
 
 	va_start(args, len);
diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index 1b92691ac7cc..8abee5450ca1 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -126,35 +126,45 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 	for (i = 0; i < 63; i++) {
 		if (i > 0 && curves[i] < 2) {
 			dev_err(par->info->device,
-				"Illegal value in Grayscale Lookup Table at index %d. Must be greater than 1\n", i);
+				"Illegal value in Grayscale Lookup Table at index %d. Must be greater than 1\n",
+				i);
 			return -EINVAL;
 		}
 		acc += curves[i];
 		tmp[i] = acc;
 		if (acc > 180) {
 			dev_err(par->info->device,
-				"Illegal value(s) in Grayscale Lookup Table. At index=%d, the accumulated value has exceeded 180\n", i);
+				"Illegal value(s) in Grayscale Lookup Table. At index=%d, the accumulated value has exceeded 180\n",
+				i);
 			return -EINVAL;
 		}
 	}
 
 	write_reg(par, 0xB8,
-	tmp[0], tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7],
-	tmp[8], tmp[9], tmp[10], tmp[11], tmp[12], tmp[13], tmp[14], tmp[15],
-	tmp[16], tmp[17], tmp[18], tmp[19], tmp[20], tmp[21], tmp[22], tmp[23],
-	tmp[24], tmp[25], tmp[26], tmp[27], tmp[28], tmp[29], tmp[30], tmp[31],
-	tmp[32], tmp[33], tmp[34], tmp[35], tmp[36], tmp[37], tmp[38], tmp[39],
-	tmp[40], tmp[41], tmp[42], tmp[43], tmp[44], tmp[45], tmp[46], tmp[47],
-	tmp[48], tmp[49], tmp[50], tmp[51], tmp[52], tmp[53], tmp[54], tmp[55],
-	tmp[56], tmp[57], tmp[58], tmp[59], tmp[60], tmp[61], tmp[62]);
+		  tmp[0],  tmp[1],  tmp[2],  tmp[3],
+		  tmp[4],  tmp[5],  tmp[6],  tmp[7],
+		  tmp[8],  tmp[9],  tmp[10], tmp[11],
+		  tmp[12], tmp[13], tmp[14], tmp[15],
+		  tmp[16], tmp[17], tmp[18], tmp[19],
+		  tmp[20], tmp[21], tmp[22], tmp[23],
+		  tmp[24], tmp[25], tmp[26], tmp[27],
+		  tmp[28], tmp[29], tmp[30], tmp[31],
+		  tmp[32], tmp[33], tmp[34], tmp[35],
+		  tmp[36], tmp[37], tmp[38], tmp[39],
+		  tmp[40], tmp[41], tmp[42], tmp[43],
+		  tmp[44], tmp[45], tmp[46], tmp[47],
+		  tmp[48], tmp[49], tmp[50], tmp[51],
+		  tmp[52], tmp[53], tmp[54], tmp[55],
+		  tmp[56], tmp[57], tmp[58], tmp[59],
+		  tmp[60], tmp[61], tmp[62]);
 
 	return 0;
 }
 
 static int blank(struct fbtft_par *par, bool on)
 {
-	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
-		__func__, on ? "true" : "false");
+	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
+		      __func__, on ? "true" : "false");
 	if (on)
 		write_reg(par, 0xAE);
 	else
@@ -185,8 +195,8 @@ static int update_onboard_backlight(struct backlight_device *bd)
 	bool on;
 
 	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
-		"%s: power=%d, fb_blank=%d\n",
-		__func__, bd->props.power, bd->props.fb_blank);
+		      "%s: power=%d, fb_blank=%d\n",
+		      __func__, bd->props.power, bd->props.fb_blank);
 
 	on = (bd->props.power == FB_BLANK_UNBLANK) &&
 	     (bd->props.fb_blank == FB_BLANK_UNBLANK);
@@ -209,7 +219,10 @@ static void register_onboard_backlight(struct fbtft_par *par)
 	bl_props.power = FB_BLANK_POWERDOWN;
 
 	bd = backlight_device_register(dev_driver_string(par->info->device),
-				par->info->device, par, &bl_ops, &bl_props);
+				       par->info->device,
+				       par,
+				       &bl_ops,
+				       &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
 			"cannot register backlight device (%ld)\n",
diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/fb_st7735r.c
index e24af0a7f2de..c8e94f388ce5 100644
--- a/drivers/staging/fbtft/fb_st7735r.c
+++ b/drivers/staging/fbtft/fb_st7735r.c
@@ -130,8 +130,10 @@ static int set_var(struct fbtft_par *par)
 
 /*
  * Gamma string format:
- * VRF0P VOS0P PK0P PK1P PK2P PK3P PK4P PK5P PK6P PK7P PK8P PK9P SELV0P SELV1P SELV62P SELV63P
- * VRF0N VOS0N PK0N PK1N PK2N PK3N PK4N PK5N PK6N PK7N PK8N PK9N SELV0N SELV1N SELV62N SELV63N
+ * VRF0P VOS0P PK0P PK1P PK2P PK3P PK4P
+ *	       PK5P PK6P PK7P PK8P PK9P SELV0P SELV1P SELV62P SELV63P
+ * VRF0N VOS0N PK0N PK1N PK2N PK3N PK4N
+ *	       PK5N PK6N PK7N PK8N PK9N SELV0N SELV1N SELV62N SELV63N
  */
 #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
 static int set_gamma(struct fbtft_par *par, u32 *curves)
@@ -145,13 +147,18 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 
 	for (i = 0; i < par->gamma.num_curves; i++)
 		write_reg(par, 0xE0 + i,
-			CURVE(i, 0), CURVE(i, 1), CURVE(i, 2), CURVE(i, 3),
-			CURVE(i, 4), CURVE(i, 5), CURVE(i, 6), CURVE(i, 7),
-			CURVE(i, 8), CURVE(i, 9), CURVE(i, 10), CURVE(i, 11),
-			CURVE(i, 12), CURVE(i, 13), CURVE(i, 14), CURVE(i, 15));
+			  CURVE(i, 0),  CURVE(i, 1),
+			  CURVE(i, 2),  CURVE(i, 3),
+			  CURVE(i, 4),  CURVE(i, 5),
+			  CURVE(i, 6),  CURVE(i, 7),
+			  CURVE(i, 8),  CURVE(i, 9),
+			  CURVE(i, 10), CURVE(i, 11),
+			  CURVE(i, 12), CURVE(i, 13),
+			  CURVE(i, 14), CURVE(i, 15));
 
 	return 0;
 }
+
 #undef CURVE
 
 static struct fbtft_display display = {
diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 7d7573a7b615..3c3f387936e8 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -201,13 +201,12 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 		c = i * par->gamma.num_values;
 		for (j = 0; j < par->gamma.num_values; j++)
 			curves[c + j] &= gamma_par_mask[j];
-		write_reg(
-			par, PVGAMCTRL + i,
-			curves[c + 0], curves[c + 1], curves[c + 2],
-			curves[c + 3], curves[c + 4], curves[c + 5],
-			curves[c + 6], curves[c + 7], curves[c + 8],
-			curves[c + 9], curves[c + 10], curves[c + 11],
-			curves[c + 12], curves[c + 13]);
+		write_reg(par, PVGAMCTRL + i,
+			  curves[c + 0],  curves[c + 1],  curves[c + 2],
+			  curves[c + 3],  curves[c + 4],  curves[c + 5],
+			  curves[c + 6],  curves[c + 7],  curves[c + 8],
+			  curves[c + 9],  curves[c + 10], curves[c + 11],
+			  curves[c + 12], curves[c + 13]);
 	}
 	return 0;
 }
diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index 9d5979b3cfb8..47ed8b9c5020 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -46,7 +46,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	va_end(args);
 
 	fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
-		par->info->device, u8, par->buf, len, "%s: ", __func__);
+			  par->info->device, u8, par->buf,
+			  len, "%s: ", __func__);
 
 	ret = par->fbtftops.write(par, par->buf, len);
 	if (ret < 0) {
@@ -174,8 +175,9 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0x00);
 
 	version = firmware_version(par);
-	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Firmware version: %x.%02x\n",
-						version >> 8, version & 0xFF);
+	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
+		      "Firmware version: %x.%02x\n",
+		      version >> 8, version & 0xFF);
 
 	if (mode == 332)
 		par->fbtftops.write_vmem = write_vmem_8bit;
@@ -226,9 +228,9 @@ static int backlight_chip_update_status(struct backlight_device *bd)
 	int brightness = bd->props.brightness;
 
 	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
-		"%s: brightness=%d, power=%d, fb_blank=%d\n",
-		__func__, bd->props.brightness, bd->props.power,
-		bd->props.fb_blank);
+		      "%s: brightness=%d, power=%d, fb_blank=%d\n",
+		      __func__, bd->props.brightness, bd->props.power,
+		      bd->props.fb_blank);
 
 	if (bd->props.power != FB_BLANK_UNBLANK)
 		brightness = 0;
@@ -256,7 +258,8 @@ static void register_chip_backlight(struct fbtft_par *par)
 	bl_props.brightness = DEFAULT_BRIGHTNESS;
 
 	bd = backlight_device_register(dev_driver_string(par->info->device),
-				par->info->device, par, &bl_ops, &bl_props);
+				       par->info->device, par,
+				       &bl_ops, &bl_props);
 	if (IS_ERR(bd)) {
 		dev_err(par->info->device,
 			"cannot register backlight device (%ld)\n",
diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 871b307d83cb..5c768c658258 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -79,7 +79,8 @@ void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 			*(((u8 *)buf) + i) = (u8)va_arg(args, unsigned int);
 		va_end(args);
 		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
-			par->info->device, u8, buf, len, "%s: ", __func__);
+				  par->info->device, u8, buf, len, "%s: ",
+				  __func__);
 	}
 	if (len <= 0)
 		return;
@@ -129,7 +130,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 	size_t startbyte_size = 0;
 
 	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
-		__func__, offset, len);
+		      __func__, offset, len);
 
 	remain = len / 2;
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
@@ -153,8 +154,10 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 
 	while (remain) {
 		to_copy = min(tx_array_size, remain);
-		dev_dbg(par->info->device, "    to_copy=%zu, remain=%zu\n",
-						to_copy, remain - to_copy);
+		dev_dbg(par->info->device,
+			"to_copy=%zu, remain=%zu\n",
+			to_copy,
+			remain - to_copy);
 
 		for (i = 0; i < to_copy; i++)
 			txbuf16[i] = cpu_to_be16(vmem16[i]);
@@ -183,7 +186,7 @@ int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
 	int ret = 0;
 
 	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
-		__func__, offset, len);
+		      __func__, offset, len);
 
 	if (!par->txbuf.buf) {
 		dev_err(par->info->device, "%s: txbuf.buf is NULL\n", __func__);
@@ -197,8 +200,10 @@ int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
 
 	while (remain) {
 		to_copy = min(tx_array_size, remain);
-		dev_dbg(par->info->device, "    to_copy=%zu, remain=%zu\n",
-						to_copy, remain - to_copy);
+		dev_dbg(par->info->device,
+			"to_copy=%zu, remain=%zu\n",
+			to_copy,
+			remain - to_copy);
 
 #ifdef __LITTLE_ENDIAN
 		for (i = 0; i < to_copy; i += 2) {
@@ -233,7 +238,7 @@ int fbtft_write_vmem16_bus16(struct fbtft_par *par, size_t offset, size_t len)
 	u16 *vmem16;
 
 	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
-		__func__, offset, len);
+		      __func__, offset, len);
 
 	vmem16 = (u16 *)(par->info->screen_buffer + offset);
 
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 731e47149af8..4660a9f9eace 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -137,8 +137,8 @@ static int fbtft_request_gpios(struct fbtft_par *par)
 			flags = fbtft_request_gpios_match(par, gpio);
 		if (flags != FBTFT_GPIO_NO_MATCH) {
 			ret = devm_gpio_request_one(par->info->device,
-					gpio->gpio, flags,
-					par->info->device->driver->name);
+					      gpio->gpio, flags,
+					      par->info->device->driver->name);
 			if (ret < 0) {
 				dev_err(par->info->device,
 					"%s: gpio_request_one('%s'=%d) failed with %d\n",
@@ -249,8 +249,11 @@ static int fbtft_backlight_update_status(struct backlight_device *bd)
 	bool polarity = par->polarity;
 
 	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
-		"%s: polarity=%d, power=%d, fb_blank=%d\n",
-		__func__, polarity, bd->props.power, bd->props.fb_blank);
+		      "%s: polarity=%d, power=%d, fb_blank=%d\n",
+		      __func__,
+		      polarity,
+		      bd->props.power,
+		      bd->props.fb_blank);
 
 	if ((bd->props.power == FB_BLANK_UNBLANK) &&
 	    (bd->props.fb_blank == FB_BLANK_UNBLANK))
@@ -372,7 +375,7 @@ static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
 	if (start_line > par->info->var.yres - 1 ||
 	    end_line > par->info->var.yres - 1) {
 		dev_warn(par->info->device,
-			"%s: start_line=%u or end_line=%u is larger than max=%d. Shouldn't happen, will do full display update\n",
+			 "%s: start_line=%u or end_line=%u is larger than max=%d. Shouldn't happen, will do full display update\n",
 			 __func__, start_line,
 			 end_line, par->info->var.yres - 1);
 		start_line = 0;
@@ -538,8 +541,11 @@ static unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
 	return chan << bf->offset;
 }
 
-static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
-			      unsigned int blue, unsigned int transp,
+static int fbtft_fb_setcolreg(unsigned int regno,
+			      unsigned int red,
+			      unsigned int green,
+			      unsigned int blue,
+			      unsigned int transp,
 			      struct fb_info *info)
 {
 	unsigned int val;
@@ -818,7 +824,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par,
-			par->gamma.curves, gamma, strlen(gamma)))
+					  par->gamma.curves,
+					  gamma,
+					  strlen(gamma)))
 			goto alloc_fail;
 	}
 
@@ -1045,8 +1053,8 @@ static int fbtft_init_display_dt(struct fbtft_par *par)
 			while (p && !(val & 0xFFFF0000)) {
 				if (i > 63) {
 					dev_err(par->info->device,
-					"%s: Maximum register values exceeded\n",
-					__func__);
+						"%s: Maximum register values exceeded\n",
+						__func__);
 					return -EINVAL;
 				}
 				buf[i++] = val;
@@ -1166,8 +1174,8 @@ int fbtft_init_display(struct fbtft_par *par)
 			while (par->init_sequence[i] >= 0) {
 				if (j > 63) {
 					dev_err(par->info->device,
-					"%s: Maximum register values exceeded\n",
-					__func__);
+						"%s: Maximum register values exceeded\n",
+						__func__);
 					return -EINVAL;
 				}
 				buf[j++] = par->init_sequence[i++];
@@ -1193,19 +1201,22 @@ int fbtft_init_display(struct fbtft_par *par)
 		case -2:
 			i++;
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
-				"init: mdelay(%d)\n", par->init_sequence[i]);
+				      "init: mdelay(%d)\n",
+				      par->init_sequence[i]);
 			mdelay(par->init_sequence[i++]);
 			break;
 		default:
 			dev_err(par->info->device,
 				"unknown delimiter %d at position %d\n",
-				par->init_sequence[i], i);
+				par->init_sequence[i],
+				i);
 			return -EINVAL;
 		}
 	}
 
 	dev_err(par->info->device,
-		"%s: something is wrong. Shouldn't get here.\n", __func__);
+		"%s: something is wrong. Shouldn't get here.\n",
+		__func__);
 	return -EINVAL;
 }
 EXPORT_SYMBOL(fbtft_init_display);
@@ -1225,8 +1236,9 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
 
 	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
 
-	if (pdata->display.buswidth != 9 && par->startbyte == 0 &&
-							par->gpio.dc < 0) {
+	if (pdata->display.buswidth != 9 &&
+	    par->startbyte == 0 &&
+	    par->gpio.dc < 0) {
 		dev_err(par->info->device,
 			"Missing info about 'dc' gpio. Aborting.\n");
 		return -EINVAL;
@@ -1321,7 +1333,8 @@ static struct fbtft_platform_data *fbtft_probe_dt(struct device *dev)
  * Return: 0 if successful, negative if error
  */
 int fbtft_probe_common(struct fbtft_display *display,
-			struct spi_device *sdev, struct platform_device *pdev)
+			struct spi_device *sdev,
+			struct platform_device *pdev)
 {
 	struct device *dev;
 	struct fb_info *info;
@@ -1393,11 +1406,13 @@ int fbtft_probe_common(struct fbtft_display *display,
 			par->spi->bits_per_word = 9;
 		} else {
 			dev_warn(&par->spi->dev,
-				"9-bit SPI not available, emulating using 8-bit.\n");
+				 "9-bit SPI not available, emulating using 8-bit.\n");
 			/* allocate buffer with room for dc bits */
 			par->extra = devm_kzalloc(par->info->device,
-				par->txbuf.len + (par->txbuf.len / 8) + 8,
-				GFP_KERNEL);
+						  par->txbuf.len
+						  + (par->txbuf.len / 8)
+						  + 8,
+						  GFP_KERNEL);
 			if (!par->extra) {
 				ret = -ENOMEM;
 				goto out_release;
diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbtft-io.c
index f4a591919f62..b5051d3d46a6 100644
--- a/drivers/staging/fbtft/fbtft-io.c
+++ b/drivers/staging/fbtft/fbtft-io.c
@@ -14,7 +14,7 @@ int fbtft_write_spi(struct fbtft_par *par, void *buf, size_t len)
 	struct spi_message m;
 
 	fbtft_par_dbg_hex(DEBUG_WRITE, par, par->info->device, u8, buf, len,
-		"%s(len=%d): ", __func__, len);
+			  "%s(len=%d): ", __func__, len);
 
 	if (!par->spi) {
 		dev_err(par->info->device,
@@ -47,7 +47,7 @@ int fbtft_write_spi_emulate_9(struct fbtft_par *par, void *buf, size_t len)
 	u64 val, dc, tmp;
 
 	fbtft_par_dbg_hex(DEBUG_WRITE, par, par->info->device, u8, buf, len,
-		"%s(len=%d): ", __func__, len);
+			  "%s(len=%d): ", __func__, len);
 
 	if (!par->extra) {
 		dev_err(par->info->device, "%s: error: par->extra is NULL\n",
@@ -109,14 +109,15 @@ int fbtft_read_spi(struct fbtft_par *par, void *buf, size_t len)
 		txbuf[0] = par->startbyte | 0x3;
 		t.tx_buf = txbuf;
 		fbtft_par_dbg_hex(DEBUG_READ, par, par->info->device, u8,
-			txbuf, len, "%s(len=%d) txbuf => ", __func__, len);
+				  txbuf, len, "%s(len=%d) txbuf => ",
+				  __func__, len);
 	}
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
 	ret = spi_sync(par->spi, &m);
 	fbtft_par_dbg_hex(DEBUG_READ, par, par->info->device, u8, buf, len,
-		"%s(len=%d) buf <= ", __func__, len);
+			  "%s(len=%d) buf <= ", __func__, len);
 
 	return ret;
 }
@@ -135,7 +136,7 @@ int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len)
 #endif
 
 	fbtft_par_dbg_hex(DEBUG_WRITE, par, par->info->device, u8, buf, len,
-		"%s(len=%d): ", __func__, len);
+			  "%s(len=%d): ", __func__, len);
 
 	while (len--) {
 		data = *(u8 *)buf;
@@ -151,7 +152,7 @@ int fbtft_write_gpio8_wr(struct fbtft_par *par, void *buf, size_t len)
 			for (i = 0; i < 8; i++) {
 				if ((data & 1) != (prev_data & 1))
 					gpio_set_value(par->gpio.db[i],
-								data & 1);
+						       data & 1);
 				data >>= 1;
 				prev_data >>= 1;
 			}
@@ -185,7 +186,7 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
 #endif
 
 	fbtft_par_dbg_hex(DEBUG_WRITE, par, par->info->device, u8, buf, len,
-		"%s(len=%d): ", __func__, len);
+			  "%s(len=%d): ", __func__, len);
 
 	while (len) {
 		data = *(u16 *)buf;
@@ -201,7 +202,7 @@ int fbtft_write_gpio16_wr(struct fbtft_par *par, void *buf, size_t len)
 			for (i = 0; i < 16; i++) {
 				if ((data & 1) != (prev_data & 1))
 					gpio_set_value(par->gpio.db[i],
-								data & 1);
+						       data & 1);
 				data >>= 1;
 				prev_data >>= 1;
 			}
diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 712096659aa0..8327f8f26ab1 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -126,7 +126,9 @@ static ssize_t store_gamma_curve(struct device *device,
 
 	mutex_lock(&par->gamma.lock);
 	memcpy(par->gamma.curves, tmp_curves,
-	       par->gamma.num_curves * par->gamma.num_values * sizeof(tmp_curves[0]));
+	       par->gamma.num_curves
+	       * par->gamma.num_values
+	       * sizeof(tmp_curves[0]));
 	mutex_unlock(&par->gamma.lock);
 
 	return count;
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 0c710d374fab..a1411590732d 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -64,16 +64,20 @@ struct fbtft_ops {
 	void (*write_register)(struct fbtft_par *par, int len, ...);
 
 	void (*set_addr_win)(struct fbtft_par *par,
-		int xs, int ys, int xe, int ye);
+			     int xs,
+			     int ys,
+			     int xe,
+			     int ye);
 	void (*reset)(struct fbtft_par *par);
 	void (*mkdirty)(struct fb_info *info, int from, int to);
 	void (*update_display)(struct fbtft_par *par,
-				unsigned int start_line, unsigned int end_line);
+			       unsigned int start_line,
+			       unsigned int end_line);
 	int (*init_display)(struct fbtft_par *par);
 	int (*blank)(struct fbtft_par *par, bool on);
 
 	unsigned long (*request_gpios_match)(struct fbtft_par *par,
-		const struct fbtft_gpio *gpio);
+					     const struct fbtft_gpio *gpio);
 	int (*request_gpios)(struct fbtft_par *par);
 	int (*verify_gpios)(struct fbtft_par *par);
 
@@ -348,11 +352,29 @@ module_exit(fbtft_driver_module_exit);
 
 /* shorthand debug levels */
 #define DEBUG_LEVEL_1	DEBUG_REQUEST_GPIOS
-#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 | DEBUG_DRIVER_INIT_FUNCTIONS | DEBUG_TIME_FIRST_UPDATE)
-#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 | DEBUG_RESET | DEBUG_INIT_DISPLAY | DEBUG_BLANK | DEBUG_REQUEST_GPIOS | DEBUG_FREE_GPIOS | DEBUG_VERIFY_GPIOS | DEBUG_BACKLIGHT | DEBUG_SYSFS)
-#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 | DEBUG_FB_READ | DEBUG_FB_WRITE | DEBUG_FB_FILLRECT | DEBUG_FB_COPYAREA | DEBUG_FB_IMAGEBLIT | DEBUG_FB_BLANK)
-#define DEBUG_LEVEL_5	(DEBUG_LEVEL_3 | DEBUG_UPDATE_DISPLAY)
-#define DEBUG_LEVEL_6	(DEBUG_LEVEL_4 | DEBUG_LEVEL_5)
+#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 |\
+			 DEBUG_DRIVER_INIT_FUNCTIONS |\
+			 DEBUG_TIME_FIRST_UPDATE)
+#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 |\
+			 DEBUG_RESET |\
+			 DEBUG_INIT_DISPLAY |\
+			 DEBUG_BLANK |\
+			 DEBUG_REQUEST_GPIOS |\
+			 DEBUG_FREE_GPIOS |\
+			 DEBUG_VERIFY_GPIOS |\
+			 DEBUG_BACKLIGHT |\
+			 DEBUG_SYSFS)
+#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 |\
+			 DEBUG_FB_READ |\
+			 DEBUG_FB_WRITE |\
+			 DEBUG_FB_FILLRECT |\
+			 DEBUG_FB_COPYAREA |\
+			 DEBUG_FB_IMAGEBLIT |\
+			 DEBUG_FB_BLANK)
+#define DEBUG_LEVEL_5	(DEBUG_LEVEL_3 |\
+			 DEBUG_UPDATE_DISPLAY)
+#define DEBUG_LEVEL_6	(DEBUG_LEVEL_4 |\
+			 DEBUG_LEVEL_5)
 #define DEBUG_LEVEL_7	0xFFFFFFFF
 
 #define DEBUG_DRIVER_INIT_FUNCTIONS (1<<3)
diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index 22ba81dbf093..dc424f3a0ec5 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -21,12 +21,13 @@ static struct platform_device *p_device;
 
 static char *name;
 module_param(name, charp, 0000);
-MODULE_PARM_DESC(name, "Devicename (required). name=list => list all supported devices.");
+MODULE_PARM_DESC(name,
+		 "Devicename (required). name=list => list all supported devices.");
 
 static unsigned int rotate;
 module_param(rotate, uint, 0000);
 MODULE_PARM_DESC(rotate,
-"Angle to rotate display counter clockwise: 0, 90, 180, 270");
+		 "Angle to rotate display counter clockwise: 0, 90, 180, 270");
 
 static unsigned int busnum;
 module_param(busnum, uint, 0000);
@@ -47,7 +48,7 @@ MODULE_PARM_DESC(mode, "SPI mode (override device default)");
 static char *gpios;
 module_param(gpios, charp, 0000);
 MODULE_PARM_DESC(gpios,
-"List of gpios. Comma separated with the form: reset:23,dc:24 (when overriding the default, all gpios must be specified)");
+		 "List of gpios. Comma separated with the form: reset:23,dc:24 (when overriding the default, all gpios must be specified)");
 
 static unsigned int fps;
 module_param(fps, uint, 0000);
@@ -56,7 +57,7 @@ MODULE_PARM_DESC(fps, "Frames per second (override driver default)");
 static char *gamma;
 module_param(gamma, charp, 0000);
 MODULE_PARM_DESC(gamma,
-"String representation of Gamma Curve(s). Driver specific.");
+		 "String representation of Gamma Curve(s). Driver specific.");
 
 static int txbuflen;
 module_param(txbuflen, int, 0000);
@@ -65,7 +66,7 @@ MODULE_PARM_DESC(txbuflen, "txbuflen (override driver default)");
 static int bgr = -1;
 module_param(bgr, int, 0000);
 MODULE_PARM_DESC(bgr,
-"BGR bit (supported by some drivers).");
+		 "BGR bit (supported by some drivers).");
 
 static unsigned int startbyte;
 module_param(startbyte, uint, 0000);
@@ -95,12 +96,12 @@ MODULE_PARM_DESC(init, "Init sequence, used with the custom argument");
 static unsigned long debug;
 module_param(debug, ulong, 0000);
 MODULE_PARM_DESC(debug,
-"level: 0-7 (the remaining 29 bits is for advanced usage)");
+		 "level: 0-7 (the remaining 29 bits is for advanced usage)");
 
 static unsigned int verbose = 3;
 module_param(verbose, uint, 0000);
 MODULE_PARM_DESC(verbose,
-"0 silent, >0 show gpios, >1 show devices, >2 show devices before (default=3)");
+		 "0 silent, >0 show gpios, >1 show devices, >2 show devices before (default=3)");
 
 struct fbtft_device_display {
 	char *name;
@@ -112,7 +113,10 @@ static void fbtft_device_pdev_release(struct device *dev);
 
 static int write_gpio16_wr_slow(struct fbtft_par *par, void *buf, size_t len);
 static void adafruit18_green_tab_set_addr_win(struct fbtft_par *par,
-	int xs, int ys, int xe, int ye);
+					      int xs,
+					      int ys,
+					      int xe,
+					      int ye);
 
 #define ADAFRUIT18_GAMMA \
 		"02 1c 07 12 37 32 29 2d 29 25 2B 39 00 01 03 10\n" \
@@ -261,6 +265,10 @@ static const s16 waveshare32b_init_sequence[] = {
 	-3
 };
 
+#define PIOLED_GAMMA	"0 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 " \
+			"2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 " \
+			"3 3 3 4 4 4 4 4 4 4 4 4 4 4 4"
+
 /* Supported displays in alphabetical order */
 static struct fbtft_device_display displays[] = {
 	{
@@ -889,14 +897,7 @@ static struct fbtft_device_display displays[] = {
 					{ "dc", 25 },
 					{},
 				},
-				.gamma =	"0 2 2 2 2 2 2 2 "
-						"2 2 2 2 2 2 2 2 "
-						"2 2 2 2 2 2 2 2 "
-						"2 2 2 2 2 2 2 3 "
-						"3 3 3 3 3 3 3 3 "
-						"3 3 3 3 3 3 3 3 "
-						"3 3 3 4 4 4 4 4 "
-						"4 4 4 4 4 4 4"
+				.gamma = PIOLED_GAMMA
 			}
 		}
 	}, {
@@ -1243,7 +1244,7 @@ static int write_gpio16_wr_slow(struct fbtft_par *par, void *buf, size_t len)
 #endif
 
 	fbtft_par_dbg_hex(DEBUG_WRITE, par, par->info->device, u8, buf, len,
-		"%s(len=%d): ", __func__, len);
+			  "%s(len=%d): ", __func__, len);
 
 	while (len) {
 		data = *(u16 *)buf;
@@ -1259,7 +1260,7 @@ static int write_gpio16_wr_slow(struct fbtft_par *par, void *buf, size_t len)
 			for (i = 0; i < 16; i++) {
 				if ((data & 1) != (prev_data & 1))
 					gpio_set_value(par->gpio.db[i],
-								data & 1);
+						       data & 1);
 				data >>= 1;
 				prev_data >>= 1;
 			}
@@ -1285,7 +1286,10 @@ static int write_gpio16_wr_slow(struct fbtft_par *par, void *buf, size_t len)
 }
 
 static void adafruit18_green_tab_set_addr_win(struct fbtft_par *par,
-						int xs, int ys, int xe, int ye)
+					      int xs,
+					      int ys,
+					      int xe,
+					      int ye)
 {
 	write_reg(par, 0x2A, 0, xs + 2, 0, xe + 2);
 	write_reg(par, 0x2B, 0, ys + 1, 0, ye + 1);
@@ -1476,7 +1480,7 @@ static int __init fbtft_device_init(void)
 			size_t len;
 
 			len = strlcpy(displays[i].spi->modalias, name,
-				SPI_NAME_SIZE);
+				      SPI_NAME_SIZE);
 			if (len >= SPI_NAME_SIZE)
 				pr_warn("modalias (name) truncated to: %s\n",
 					displays[i].spi->modalias);
diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
index f676c9b853f1..674452866f91 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -667,11 +667,15 @@ static int flexfb_probe_common(struct spi_device *sdev,
 		case 8:
 			par->fbtftops.write_vmem = fbtft_write_vmem16_bus8;
 			if (!par->startbyte)
-				par->fbtftops.verify_gpios = flexfb_verify_gpios_dc;
+				par->fbtftops.verify_gpios =
+						flexfb_verify_gpios_dc;
 			break;
 		case 9:
 			if (regwidth == 16) {
-				dev_err(dev, "argument 'regwidth': %d is not supported with buswidth=%d and SPI.\n", regwidth, buswidth);
+				dev_err(dev,
+					"argument 'regwidth': %d is not supported with buswidth=%d and SPI.\n",
+					regwidth,
+					buswidth);
 				return -EINVAL;
 			}
 			par->fbtftops.write_register = fbtft_write_reg8_bus9;
@@ -679,22 +683,27 @@ static int flexfb_probe_common(struct spi_device *sdev,
 			if (par->spi->master->bits_per_word_mask
 			    & SPI_BPW_MASK(9)) {
 				par->spi->bits_per_word = 9;
-			} else {
-				dev_warn(dev,
-					"9-bit SPI not available, emulating using 8-bit.\n");
-				/* allocate buffer with room for dc bits */
-				par->extra = devm_kzalloc(par->info->device,
-						par->txbuf.len + (par->txbuf.len / 8) + 8,
-						GFP_KERNEL);
-				if (!par->extra) {
-					ret = -ENOMEM;
-					goto out_release;
-				}
-				par->fbtftops.write = fbtft_write_spi_emulate_9;
+				break;
 			}
+
+			dev_warn(dev,
+				 "9-bit SPI not available, emulating using 8-bit.\n");
+			/* allocate buffer with room for dc bits */
+			par->extra = devm_kzalloc(par->info->device,
+						  par->txbuf.len
+						  + (par->txbuf.len / 8) + 8,
+						  GFP_KERNEL);
+			if (!par->extra) {
+				ret = -ENOMEM;
+				goto out_release;
+			}
+			par->fbtftops.write = fbtft_write_spi_emulate_9;
+
 			break;
 		default:
-			dev_err(dev, "argument 'buswidth': %d is not supported with SPI.\n", buswidth);
+			dev_err(dev,
+				"argument 'buswidth': %d is not supported with SPI.\n",
+				buswidth);
 			return -EINVAL;
 		}
 	} else {
@@ -707,13 +716,16 @@ static int flexfb_probe_common(struct spi_device *sdev,
 		case 16:
 			par->fbtftops.write_register = fbtft_write_reg16_bus16;
 			if (latched)
-				par->fbtftops.write = fbtft_write_gpio16_wr_latched;
+				par->fbtftops.write =
+						fbtft_write_gpio16_wr_latched;
 			else
 				par->fbtftops.write = fbtft_write_gpio16_wr;
 			par->fbtftops.write_vmem = fbtft_write_vmem16_bus16;
 			break;
 		default:
-			dev_err(dev, "argument 'buswidth': %d is not supported with parallel.\n", buswidth);
+			dev_err(dev,
+				"argument 'buswidth': %d is not supported with parallel.\n",
+				buswidth);
 			return -EINVAL;
 		}
 	}
-- 
2.18.0

