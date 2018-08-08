Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8E2C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9366D2148C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX5WRsUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9366D2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHHCpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:45:46 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:41425 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeHHCpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:45:45 -0400
Received: by mail-qk0-f194.google.com with SMTP id n85-v6so340314qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mhuROdOZW0JKxXoSj0q3dyjc3J5dNUis5SoNfXnF0n4=;
        b=iX5WRsUZUtidMrqBN1/ocZrVxXk9e3vSMdnbMSK8+Jo3qmNMCbOz/hiusaZcDboTRy
         09z6j/NUPj18Onzt1HQCgT9yImdXmrSe/fQ7sR4DmFLQXxPfqg/yveKODGcttQ1SE7dc
         LdVacG9ZgVMOKLWn9z2ZFareDStuHCKl59pSIpvkTcli51srInPAc20fJ1eAELaXFE9A
         xjG1+t6zygWlZQ1u4m26Q/cDiCjVoyC0DL3lkDZr2RJa8hdLJiCHAa8mgmHV8u9e2Vcq
         /jynI1EagR7XeoxHstpTp5qje0L2jbJVPedwzLIZeh0QIeBEYR59J01KVR5ZO+8aAkLf
         2Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mhuROdOZW0JKxXoSj0q3dyjc3J5dNUis5SoNfXnF0n4=;
        b=UCeFGi9VYwooRhckSgYs+gpbgCEb6TkTvbdbdjZu0/Tr1VDS297R1I7in9stlYEfGs
         T6nM67fHLYxlQgNkmWKx+GQo+2KKNLTFZiUjUNhXk4oXMESItHebw+ai+2QniXHSrHAZ
         czPJCrbDKjer2kbfaxPPxES2poqRnOgwRdwJwPA8AkAxX/72hfMxgFN7TOUdwENPmZA8
         l4IZQz7q4q/nnWN94Liy0WW2WqVE+4Z4DotqzlOaKRLN82pfOgq9FL1WpwAY5/7JE9H/
         UdZ/TGFfKceszkDucjAWwk6eV7bfEUtAn0ab0wggGwjYSVmcogBEqFbJYzoz9tKVO/L0
         4L9w==
X-Gm-Message-State: AOUpUlHw8kCmeveN/vWjT1BvIyHjM+MdLNYpixK8gsqh1lpYnmkVmBd8
        nJztzYR4H/t+7I9TnNNh4O0=
X-Google-Smtp-Source: AA+uWPwts5deu5357igbWJEifUdumgQ+1J5ryYjtvFVssHx7WeJtG8A2fXQ9LQFMSF4pdothApqK9g==
X-Received: by 2002:a37:8044:: with SMTP id b65-v6mr554046qkd.347.1533688126774;
        Tue, 07 Aug 2018 17:28:46 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id a19-v6sm2141365qta.50.2018.08.07.17.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:28:46 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:28:42 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/15] staging: fbtft: Fixes some lines long lines (>80) -
 Style
Message-ID: <3c7753c1fb1fdb476b825231659b3cf193e3d720.1533686201.git.leobras.c@gmail.com>
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

Trying to keep the code in the 80-char line limit.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>

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
index 383e197cf56a..e2b3ba82d01f 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -74,7 +74,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 		for (i = 0; i < len; i++)
 			buf[i] = (u8)va_arg(args, unsigned int);
 		va_end(args);
-		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device, u8, buf, len, "%s: ", __func__);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device,
+				  u8, buf, len, "%s: ", __func__);
 	}

 	va_start(args, len);
diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/fb_st7735r.c
index 9670a8989b91..c8e94f388ce5 100644
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
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index a03d8adf3f9a..64f69d1a3029 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -538,9 +538,9 @@ static unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
 	return chan << bf->offset;
 }

-static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
-			      unsigned int blue, unsigned int transp,
-			      struct fb_info *info)
+static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
+			      unsigned int green, unsigned int blue,
+			      unsigned int transp, struct fb_info *info)
 {
 	unsigned int val;
 	int ret = 1;
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 798a8fe98e95..87114502e836 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -348,11 +348,29 @@ module_exit(fbtft_driver_module_exit);

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
diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
index a2b4164ce5e4..af6c330cdf8d 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -667,11 +667,14 @@ static int flexfb_probe_common(struct spi_device *sdev,
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
+					regwidth, buswidth);
 				return -EINVAL;
 			}
 			par->fbtftops.write_register = fbtft_write_reg8_bus9;
@@ -709,13 +712,16 @@ static int flexfb_probe_common(struct spi_device *sdev,
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
---
 drivers/staging/fbtft/fb_ssd1306.c |  3 ++-
 drivers/staging/fbtft/fb_ssd1331.c |  3 ++-
 drivers/staging/fbtft/fb_st7735r.c |  6 ++++--
 drivers/staging/fbtft/fbtft-core.c |  6 +++---
 drivers/staging/fbtft/fbtft.h      | 28 +++++++++++++++++++++++-----
 drivers/staging/fbtft/flexfb.c     | 14 ++++++++++----
 6 files changed, 44 insertions(+), 16 deletions(-)

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
index 383e197cf56a..e2b3ba82d01f 100644
--- a/drivers/staging/fbtft/fb_ssd1331.c
+++ b/drivers/staging/fbtft/fb_ssd1331.c
@@ -74,7 +74,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 		for (i = 0; i < len; i++)
 			buf[i] = (u8)va_arg(args, unsigned int);
 		va_end(args);
-		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device, u8, buf, len, "%s: ", __func__);
+		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device,
+				  u8, buf, len, "%s: ", __func__);
 	}
 
 	va_start(args, len);
diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/fb_st7735r.c
index 9670a8989b91..c8e94f388ce5 100644
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
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index a03d8adf3f9a..64f69d1a3029 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -538,9 +538,9 @@ static unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
 	return chan << bf->offset;
 }
 
-static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
-			      unsigned int blue, unsigned int transp,
-			      struct fb_info *info)
+static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
+			      unsigned int green, unsigned int blue,
+			      unsigned int transp, struct fb_info *info)
 {
 	unsigned int val;
 	int ret = 1;
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 798a8fe98e95..87114502e836 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -348,11 +348,29 @@ module_exit(fbtft_driver_module_exit);
 
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
diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
index a2b4164ce5e4..af6c330cdf8d 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -667,11 +667,14 @@ static int flexfb_probe_common(struct spi_device *sdev,
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
+					regwidth, buswidth);
 				return -EINVAL;
 			}
 			par->fbtftops.write_register = fbtft_write_reg8_bus9;
@@ -709,13 +712,16 @@ static int flexfb_probe_common(struct spi_device *sdev,
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

