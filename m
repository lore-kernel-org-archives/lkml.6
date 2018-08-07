Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CF8C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6CD21888
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dBTWuCtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6CD21888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeHGKSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:18:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57552 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbeHGKSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:18:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7783sWW175348;
        Tue, 7 Aug 2018 08:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=i20FsCuo7u7cJO05/iHZKxDu1Zde3QNJTqGcJSJ4dB4=;
 b=dBTWuCtgV4ZzkiuM01Y+0DJLhCqpCbS8nCqtZH5aQzMTRRkVy3S0Q8OzrU+M0Plk6o2T
 xioAD44UaZLVcshK6c/FBZbCVB/iu08xdjQZxMpscnU6DOT8m8uVSIWdNVDwoomR44rT
 98n4iCp6ODfk6rjFkFEroaGvxgl/mZoh9yzU8lNxUMypy+ioLlAMCdYD+wuBZxin/J9h
 4nTJ1K+NRhJBFW1a2xgb8t3xadNFwlbbhfHNsKgBtlvz9TVM/CdiNCHh/q30n0I96MWj
 NlW79k9IpWEeu/Z/oFWpndh9PTcSKW9uO4PWiLGtL9sCMbdRLYfOkapAwLNt/Z6XGWwY ig== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kn4spr3b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Aug 2018 08:05:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7785Ceu001559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Aug 2018 08:05:12 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7785B4K012507;
        Tue, 7 Aug 2018 08:05:11 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Aug 2018 01:05:09 -0700
Date:   Tue, 7 Aug 2018 11:05:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] staging: fbtft: Fixes some alignment and line > 80
 char issues - Style
Message-ID: <20180807080503.6kaptvw27updt55x@mwanda>
References: <cover.1533614243.git.leobras.c@gmail.com>
 <c3d5c1c1087897c1079ff996a216c1fe75b0c494.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3d5c1c1087897c1079ff996a216c1fe75b0c494.1533614243.git.leobras.c@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8977 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808070083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split this up into two patches.  One which changes alignment and one
which does the 80 character limit...

On Tue, Aug 07, 2018 at 01:05:33AM -0300, Leonardo Brás wrote:
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  drivers/staging/fbtft/fb_ssd1289.c   |  6 +--
>  drivers/staging/fbtft/fb_ssd1306.c   |  3 +-
>  drivers/staging/fbtft/fb_ssd1331.c   |  9 ++++-
>  drivers/staging/fbtft/fb_ssd1351.c   | 43 +++++++++++++--------
>  drivers/staging/fbtft/fb_st7735r.c   | 19 +++++++---
>  drivers/staging/fbtft/fb_st7789v.c   | 13 +++----
>  drivers/staging/fbtft/fb_watterott.c | 17 +++++----
>  drivers/staging/fbtft/fbtft-bus.c    | 21 ++++++----
>  drivers/staging/fbtft/fbtft-core.c   | 57 ++++++++++++++++++----------
>  drivers/staging/fbtft/fbtft-io.c     | 17 +++++----
>  drivers/staging/fbtft/fbtft-sysfs.c  |  4 +-
>  drivers/staging/fbtft/fbtft.h        | 38 +++++++++++++++----
>  drivers/staging/fbtft/fbtft_device.c | 44 +++++++++++----------
>  drivers/staging/fbtft/flexfb.c       | 46 +++++++++++++---------
>  14 files changed, 214 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/fb_ssd1289.c
> index 46116d06522c..67b3f8548241 100644
> --- a/drivers/staging/fbtft/fb_ssd1289.c
> +++ b/drivers/staging/fbtft/fb_ssd1289.c
> @@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0x0E, 0x2B00);
>  	write_reg(par, 0x1E, 0x00B7);
>  	write_reg(par, 0x01,
> -		BIT(13) | (par->bgr << 11) | BIT(9) | (HEIGHT - 1));
> +		  BIT(13) | (par->bgr << 11) | BIT(9) | (HEIGHT - 1));
>  	write_reg(par, 0x02, 0x0600);
>  	write_reg(par, 0x10, 0x0000);
>  	write_reg(par, 0x05, 0x0000);
> @@ -98,8 +98,8 @@ static int set_var(struct fbtft_par *par)
>  	if (par->fbtftops.init_display != init_display) {
>  		/* don't risk messing up register 11h */
>  		fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
> -			"%s: skipping since custom init_display() is used\n",
> -			__func__);
> +			      "%s: skipping since custom init_display() is used\n",
> +			      __func__);
>  		return 0;
>  	}
>  
> diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/fb_ssd1306.c
> index 9276be499303..f5e0ec1c01dc 100644
> --- a/drivers/staging/fbtft/fb_ssd1306.c
> +++ b/drivers/staging/fbtft/fb_ssd1306.c
> @@ -184,7 +184,8 @@ static int write_vmem(struct fbtft_par *par, size_t offset, size_t len)
>  		for (y = 0; y < yres / 8; y++) {
>  			*buf = 0x00;
>  			for (i = 0; i < 8; i++)
> -				*buf |= (vmem16[(y * 8 + i) * xres + x] ? 1 : 0) << i;
> +				*buf |= (vmem16[(y * 8 + i) * xres + x] ?
> +					 1 : 0) << i;
>  			buf++;
>  		}
>  	}
> diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/fb_ssd1331.c
> index 383e197cf56a..4c7500991a5b 100644
> --- a/drivers/staging/fbtft/fb_ssd1331.c
> +++ b/drivers/staging/fbtft/fb_ssd1331.c
> @@ -74,7 +74,14 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
>  		for (i = 0; i < len; i++)
>  			buf[i] = (u8)va_arg(args, unsigned int);
>  		va_end(args);
> -		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device, u8, buf, len, "%s: ", __func__);
> +		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER,
> +				  par,
> +				  par->info->device,
> +				  u8,
> +				  buf,
> +				  len,
> +				  "%s: ",
> +				  __func__);

Do it like this:

		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device,
				  u8, buf, len, "%s: ", __func__);


>  	}
>  
>  	va_start(args, len);
> diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
> index 1b92691ac7cc..8abee5450ca1 100644
> --- a/drivers/staging/fbtft/fb_ssd1351.c
> +++ b/drivers/staging/fbtft/fb_ssd1351.c
> @@ -126,35 +126,45 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
>  	for (i = 0; i < 63; i++) {
>  		if (i > 0 && curves[i] < 2) {
>  			dev_err(par->info->device,
> -				"Illegal value in Grayscale Lookup Table at index %d. Must be greater than 1\n", i);
> +				"Illegal value in Grayscale Lookup Table at index %d. Must be greater than 1\n",
> +				i);

You would think this warning should print what's stored in curves[i].

>  			return -EINVAL;
>  		}
>  		acc += curves[i];
>  		tmp[i] = acc;
>  		if (acc > 180) {
>  			dev_err(par->info->device,
> -				"Illegal value(s) in Grayscale Lookup Table. At index=%d, the accumulated value has exceeded 180\n", i);
> +				"Illegal value(s) in Grayscale Lookup Table. At index=%d, the accumulated value has exceeded 180\n",
> +				i);
>  			return -EINVAL;
>  		}
>  	}
>  
>  	write_reg(par, 0xB8,
> -	tmp[0], tmp[1], tmp[2], tmp[3], tmp[4], tmp[5], tmp[6], tmp[7],
> -	tmp[8], tmp[9], tmp[10], tmp[11], tmp[12], tmp[13], tmp[14], tmp[15],
> -	tmp[16], tmp[17], tmp[18], tmp[19], tmp[20], tmp[21], tmp[22], tmp[23],
> -	tmp[24], tmp[25], tmp[26], tmp[27], tmp[28], tmp[29], tmp[30], tmp[31],
> -	tmp[32], tmp[33], tmp[34], tmp[35], tmp[36], tmp[37], tmp[38], tmp[39],
> -	tmp[40], tmp[41], tmp[42], tmp[43], tmp[44], tmp[45], tmp[46], tmp[47],
> -	tmp[48], tmp[49], tmp[50], tmp[51], tmp[52], tmp[53], tmp[54], tmp[55],
> -	tmp[56], tmp[57], tmp[58], tmp[59], tmp[60], tmp[61], tmp[62]);
> +		  tmp[0],  tmp[1],  tmp[2],  tmp[3],
> +		  tmp[4],  tmp[5],  tmp[6],  tmp[7],
> +		  tmp[8],  tmp[9],  tmp[10], tmp[11],
> +		  tmp[12], tmp[13], tmp[14], tmp[15],
> +		  tmp[16], tmp[17], tmp[18], tmp[19],
> +		  tmp[20], tmp[21], tmp[22], tmp[23],
> +		  tmp[24], tmp[25], tmp[26], tmp[27],
> +		  tmp[28], tmp[29], tmp[30], tmp[31],
> +		  tmp[32], tmp[33], tmp[34], tmp[35],
> +		  tmp[36], tmp[37], tmp[38], tmp[39],
> +		  tmp[40], tmp[41], tmp[42], tmp[43],
> +		  tmp[44], tmp[45], tmp[46], tmp[47],
> +		  tmp[48], tmp[49], tmp[50], tmp[51],
> +		  tmp[52], tmp[53], tmp[54], tmp[55],
> +		  tmp[56], tmp[57], tmp[58], tmp[59],
> +		  tmp[60], tmp[61], tmp[62]);
>  
>  	return 0;
>  }
>  
>  static int blank(struct fbtft_par *par, bool on)
>  {
> -	fbtft_par_dbg(DEBUG_BLANK, par, "%s(blank=%s)\n",
> -		__func__, on ? "true" : "false");
> +	fbtft_par_dbg(DEBUG_BLANK, par, "(%s=%s)\n",
> +		      __func__, on ? "true" : "false");

The message change is unrelated.

>  	if (on)
>  		write_reg(par, 0xAE);
>  	else
> @@ -185,8 +195,8 @@ static int update_onboard_backlight(struct backlight_device *bd)
>  	bool on;
>  
>  	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
> -		"%s: power=%d, fb_blank=%d\n",
> -		__func__, bd->props.power, bd->props.fb_blank);
> +		      "%s: power=%d, fb_blank=%d\n",
> +		      __func__, bd->props.power, bd->props.fb_blank);
>  
>  	on = (bd->props.power == FB_BLANK_UNBLANK) &&
>  	     (bd->props.fb_blank == FB_BLANK_UNBLANK);
> @@ -209,7 +219,10 @@ static void register_onboard_backlight(struct fbtft_par *par)
>  	bl_props.power = FB_BLANK_POWERDOWN;
>  
>  	bd = backlight_device_register(dev_driver_string(par->info->device),
> -				par->info->device, par, &bl_ops, &bl_props);
> +				       par->info->device,
> +				       par,
> +				       &bl_ops,
> +				       &bl_props);
>  	if (IS_ERR(bd)) {
>  		dev_err(par->info->device,
>  			"cannot register backlight device (%ld)\n",
> diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/fb_st7735r.c
> index e24af0a7f2de..c8e94f388ce5 100644
> --- a/drivers/staging/fbtft/fb_st7735r.c
> +++ b/drivers/staging/fbtft/fb_st7735r.c
> @@ -130,8 +130,10 @@ static int set_var(struct fbtft_par *par)
>  
>  /*
>   * Gamma string format:
> - * VRF0P VOS0P PK0P PK1P PK2P PK3P PK4P PK5P PK6P PK7P PK8P PK9P SELV0P SELV1P SELV62P SELV63P
> - * VRF0N VOS0N PK0N PK1N PK2N PK3N PK4N PK5N PK6N PK7N PK8N PK9N SELV0N SELV1N SELV62N SELV63N
> + * VRF0P VOS0P PK0P PK1P PK2P PK3P PK4P
> + *	       PK5P PK6P PK7P PK8P PK9P SELV0P SELV1P SELV62P SELV63P
> + * VRF0N VOS0N PK0N PK1N PK2N PK3N PK4N
> + *	       PK5N PK6N PK7N PK8N PK9N SELV0N SELV1N SELV62N SELV63N
>   */
>  #define CURVE(num, idx)  curves[(num) * par->gamma.num_values + (idx)]
>  static int set_gamma(struct fbtft_par *par, u32 *curves)
> @@ -145,13 +147,18 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
>  
>  	for (i = 0; i < par->gamma.num_curves; i++)
>  		write_reg(par, 0xE0 + i,
> -			CURVE(i, 0), CURVE(i, 1), CURVE(i, 2), CURVE(i, 3),
> -			CURVE(i, 4), CURVE(i, 5), CURVE(i, 6), CURVE(i, 7),
> -			CURVE(i, 8), CURVE(i, 9), CURVE(i, 10), CURVE(i, 11),
> -			CURVE(i, 12), CURVE(i, 13), CURVE(i, 14), CURVE(i, 15));
> +			  CURVE(i, 0),  CURVE(i, 1),
> +			  CURVE(i, 2),  CURVE(i, 3),
> +			  CURVE(i, 4),  CURVE(i, 5),
> +			  CURVE(i, 6),  CURVE(i, 7),
> +			  CURVE(i, 8),  CURVE(i, 9),
> +			  CURVE(i, 10), CURVE(i, 11),
> +			  CURVE(i, 12), CURVE(i, 13),
> +			  CURVE(i, 14), CURVE(i, 15));
>  
>  	return 0;
>  }
> +
>  #undef CURVE
>  
>  static struct fbtft_display display = {
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> index 7d7573a7b615..3c3f387936e8 100644
> --- a/drivers/staging/fbtft/fb_st7789v.c
> +++ b/drivers/staging/fbtft/fb_st7789v.c
> @@ -201,13 +201,12 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
>  		c = i * par->gamma.num_values;
>  		for (j = 0; j < par->gamma.num_values; j++)
>  			curves[c + j] &= gamma_par_mask[j];
> -		write_reg(
> -			par, PVGAMCTRL + i,
> -			curves[c + 0], curves[c + 1], curves[c + 2],
> -			curves[c + 3], curves[c + 4], curves[c + 5],
> -			curves[c + 6], curves[c + 7], curves[c + 8],
> -			curves[c + 9], curves[c + 10], curves[c + 11],
> -			curves[c + 12], curves[c + 13]);
> +		write_reg(par, PVGAMCTRL + i,
> +			  curves[c + 0],  curves[c + 1],  curves[c + 2],
> +			  curves[c + 3],  curves[c + 4],  curves[c + 5],
> +			  curves[c + 6],  curves[c + 7],  curves[c + 8],
> +			  curves[c + 9],  curves[c + 10], curves[c + 11],
> +			  curves[c + 12], curves[c + 13]);
>  	}
>  	return 0;
>  }
> diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
> index 9d5979b3cfb8..47ed8b9c5020 100644
> --- a/drivers/staging/fbtft/fb_watterott.c
> +++ b/drivers/staging/fbtft/fb_watterott.c
> @@ -46,7 +46,8 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
>  	va_end(args);
>  
>  	fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
> -		par->info->device, u8, par->buf, len, "%s: ", __func__);
> +			  par->info->device, u8, par->buf,
> +			  len, "%s: ", __func__);
>  
>  	ret = par->fbtftops.write(par, par->buf, len);
>  	if (ret < 0) {
> @@ -174,8 +175,9 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0x00);
>  
>  	version = firmware_version(par);
> -	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Firmware version: %x.%02x\n",
> -						version >> 8, version & 0xFF);
> +	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
> +		      "Firmware version: %x.%02x\n",
> +		      version >> 8, version & 0xFF);
>  
>  	if (mode == 332)
>  		par->fbtftops.write_vmem = write_vmem_8bit;
> @@ -226,9 +228,9 @@ static int backlight_chip_update_status(struct backlight_device *bd)
>  	int brightness = bd->props.brightness;
>  
>  	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
> -		"%s: brightness=%d, power=%d, fb_blank=%d\n",
> -		__func__, bd->props.brightness, bd->props.power,
> -		bd->props.fb_blank);
> +		      "%s: brightness=%d, power=%d, fb_blank=%d\n",
> +		      __func__, bd->props.brightness, bd->props.power,
> +		      bd->props.fb_blank);
>  
>  	if (bd->props.power != FB_BLANK_UNBLANK)
>  		brightness = 0;
> @@ -256,7 +258,8 @@ static void register_chip_backlight(struct fbtft_par *par)
>  	bl_props.brightness = DEFAULT_BRIGHTNESS;
>  
>  	bd = backlight_device_register(dev_driver_string(par->info->device),
> -				par->info->device, par, &bl_ops, &bl_props);
> +				       par->info->device, par,
> +				       &bl_ops, &bl_props);
>  	if (IS_ERR(bd)) {
>  		dev_err(par->info->device,
>  			"cannot register backlight device (%ld)\n",
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 871b307d83cb..5c768c658258 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -79,7 +79,8 @@ void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  			*(((u8 *)buf) + i) = (u8)va_arg(args, unsigned int);
>  		va_end(args);
>  		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,
> -			par->info->device, u8, buf, len, "%s: ", __func__);
> +				  par->info->device, u8, buf, len, "%s: ",
> +				  __func__);
>  	}
>  	if (len <= 0)
>  		return;
> @@ -129,7 +130,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
>  	size_t startbyte_size = 0;
>  
>  	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
> -		__func__, offset, len);
> +		      __func__, offset, len);
>  
>  	remain = len / 2;
>  	vmem16 = (u16 *)(par->info->screen_buffer + offset);
> @@ -153,8 +154,10 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
>  
>  	while (remain) {
>  		to_copy = min(tx_array_size, remain);
> -		dev_dbg(par->info->device, "    to_copy=%zu, remain=%zu\n",
> -						to_copy, remain - to_copy);
> +		dev_dbg(par->info->device,
> +			"to_copy=%zu, remain=%zu\n",
> +			to_copy,
> +			remain - to_copy);

I haven't commented on all these, but I'm hoping that you will redo
them all, yeah?

		dev_dbg(par->info->device, "to_copy=%zu, remain=%zu\n",
			to_copy, remain - to_copy);

>  
>  		for (i = 0; i < to_copy; i++)
>  			txbuf16[i] = cpu_to_be16(vmem16[i]);
> @@ -183,7 +186,7 @@ int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
>  	int ret = 0;
>  
>  	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
> -		__func__, offset, len);
> +		      __func__, offset, len);
>  
>  	if (!par->txbuf.buf) {
>  		dev_err(par->info->device, "%s: txbuf.buf is NULL\n", __func__);
> @@ -197,8 +200,10 @@ int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
>  
>  	while (remain) {
>  		to_copy = min(tx_array_size, remain);
> -		dev_dbg(par->info->device, "    to_copy=%zu, remain=%zu\n",
> -						to_copy, remain - to_copy);
> +		dev_dbg(par->info->device,
> +			"to_copy=%zu, remain=%zu\n",
> +			to_copy,
> +			remain - to_copy);
>  
>  #ifdef __LITTLE_ENDIAN
>  		for (i = 0; i < to_copy; i += 2) {
> @@ -233,7 +238,7 @@ int fbtft_write_vmem16_bus16(struct fbtft_par *par, size_t offset, size_t len)
>  	u16 *vmem16;
>  
>  	fbtft_par_dbg(DEBUG_WRITE_VMEM, par, "%s(offset=%zu, len=%zu)\n",
> -		__func__, offset, len);
> +		      __func__, offset, len);
>  
>  	vmem16 = (u16 *)(par->info->screen_buffer + offset);
>  
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 731e47149af8..4660a9f9eace 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -137,8 +137,8 @@ static int fbtft_request_gpios(struct fbtft_par *par)
>  			flags = fbtft_request_gpios_match(par, gpio);
>  		if (flags != FBTFT_GPIO_NO_MATCH) {
>  			ret = devm_gpio_request_one(par->info->device,
> -					gpio->gpio, flags,
> -					par->info->device->driver->name);
> +					      gpio->gpio, flags,
> +					      par->info->device->driver->name);
>  			if (ret < 0) {
>  				dev_err(par->info->device,
>  					"%s: gpio_request_one('%s'=%d) failed with %d\n",
> @@ -249,8 +249,11 @@ static int fbtft_backlight_update_status(struct backlight_device *bd)
>  	bool polarity = par->polarity;
>  
>  	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
> -		"%s: polarity=%d, power=%d, fb_blank=%d\n",
> -		__func__, polarity, bd->props.power, bd->props.fb_blank);
> +		      "%s: polarity=%d, power=%d, fb_blank=%d\n",
> +		      __func__,
> +		      polarity,
> +		      bd->props.power,
> +		      bd->props.fb_blank);
>  
>  	if ((bd->props.power == FB_BLANK_UNBLANK) &&
>  	    (bd->props.fb_blank == FB_BLANK_UNBLANK))
> @@ -372,7 +375,7 @@ static void fbtft_update_display(struct fbtft_par *par, unsigned int start_line,
>  	if (start_line > par->info->var.yres - 1 ||
>  	    end_line > par->info->var.yres - 1) {
>  		dev_warn(par->info->device,
> -			"%s: start_line=%u or end_line=%u is larger than max=%d. Shouldn't happen, will do full display update\n",
> +			 "%s: start_line=%u or end_line=%u is larger than max=%d. Shouldn't happen, will do full display update\n",
>  			 __func__, start_line,
>  			 end_line, par->info->var.yres - 1);
>  		start_line = 0;
> @@ -538,8 +541,11 @@ static unsigned int chan_to_field(unsigned int chan, struct fb_bitfield *bf)
>  	return chan << bf->offset;
>  }
>  
> -static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red, unsigned int green,
> -			      unsigned int blue, unsigned int transp,
> +static int fbtft_fb_setcolreg(unsigned int regno,
> +			      unsigned int red,
> +			      unsigned int green,
> +			      unsigned int blue,
> +			      unsigned int transp,
>  			      struct fb_info *info)
>  {
>  	unsigned int val;
> @@ -818,7 +824,9 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
>  
>  	if (par->gamma.curves && gamma) {
>  		if (fbtft_gamma_parse_str(par,
> -			par->gamma.curves, gamma, strlen(gamma)))
> +					  par->gamma.curves,
> +					  gamma,
> +					  strlen(gamma)))
>  			goto alloc_fail;
>  	}
>  
> @@ -1045,8 +1053,8 @@ static int fbtft_init_display_dt(struct fbtft_par *par)
>  			while (p && !(val & 0xFFFF0000)) {
>  				if (i > 63) {
>  					dev_err(par->info->device,
> -					"%s: Maximum register values exceeded\n",
> -					__func__);
> +						"%s: Maximum register values exceeded\n",
> +						__func__);
>  					return -EINVAL;
>  				}
>  				buf[i++] = val;
> @@ -1166,8 +1174,8 @@ int fbtft_init_display(struct fbtft_par *par)
>  			while (par->init_sequence[i] >= 0) {
>  				if (j > 63) {
>  					dev_err(par->info->device,
> -					"%s: Maximum register values exceeded\n",
> -					__func__);
> +						"%s: Maximum register values exceeded\n",
> +						__func__);
>  					return -EINVAL;
>  				}
>  				buf[j++] = par->init_sequence[i++];
> @@ -1193,19 +1201,22 @@ int fbtft_init_display(struct fbtft_par *par)
>  		case -2:
>  			i++;
>  			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
> -				"init: mdelay(%d)\n", par->init_sequence[i]);
> +				      "init: mdelay(%d)\n",
> +				      par->init_sequence[i]);
>  			mdelay(par->init_sequence[i++]);
>  			break;
>  		default:
>  			dev_err(par->info->device,
>  				"unknown delimiter %d at position %d\n",
> -				par->init_sequence[i], i);
> +				par->init_sequence[i],
> +				i);
>  			return -EINVAL;
>  		}
>  	}
>  
>  	dev_err(par->info->device,
> -		"%s: something is wrong. Shouldn't get here.\n", __func__);
> +		"%s: something is wrong. Shouldn't get here.\n",
> +		__func__);
>  	return -EINVAL;
>  }
>  EXPORT_SYMBOL(fbtft_init_display);
> @@ -1225,8 +1236,9 @@ static int fbtft_verify_gpios(struct fbtft_par *par)
>  
>  	fbtft_par_dbg(DEBUG_VERIFY_GPIOS, par, "%s()\n", __func__);
>  
> -	if (pdata->display.buswidth != 9 && par->startbyte == 0 &&
> -							par->gpio.dc < 0) {
> +	if (pdata->display.buswidth != 9 &&
> +	    par->startbyte == 0 &&
> +	    par->gpio.dc < 0) {
>  		dev_err(par->info->device,
>  			"Missing info about 'dc' gpio. Aborting.\n");
>  		return -EINVAL;
> @@ -1321,7 +1333,8 @@ static struct fbtft_platform_data *fbtft_probe_dt(struct device *dev)
>   * Return: 0 if successful, negative if error
>   */
>  int fbtft_probe_common(struct fbtft_display *display,
> -			struct spi_device *sdev, struct platform_device *pdev)
> +			struct spi_device *sdev,
> +			struct platform_device *pdev)
>  {
>  	struct device *dev;
>  	struct fb_info *info;
> @@ -1393,11 +1406,13 @@ int fbtft_probe_common(struct fbtft_display *display,
>  			par->spi->bits_per_word = 9;
>  		} else {
>  			dev_warn(&par->spi->dev,
> -				"9-bit SPI not available, emulating using 8-bit.\n");
> +				 "9-bit SPI not available, emulating using 8-bit.\n");
>  			/* allocate buffer with room for dc bits */
>  			par->extra = devm_kzalloc(par->info->device,
> -				par->txbuf.len + (par->txbuf.len / 8) + 8,
> -				GFP_KERNEL);
> +						  par->txbuf.len
> +						  + (par->txbuf.len / 8)
> +						  + 8,
> +						  GFP_KERNEL);

I feel like this is not a readability improvement.


>  			if (!par->extra) {
>  				ret = -ENOMEM;
>  				goto out_release;
> diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
> index 712096659aa0..8327f8f26ab1 100644
> --- a/drivers/staging/fbtft/fbtft-sysfs.c
> +++ b/drivers/staging/fbtft/fbtft-sysfs.c
> @@ -126,7 +126,9 @@ static ssize_t store_gamma_curve(struct device *device,
>  
>  	mutex_lock(&par->gamma.lock);
>  	memcpy(par->gamma.curves, tmp_curves,
> -	       par->gamma.num_curves * par->gamma.num_values * sizeof(tmp_curves[0]));
> +	       par->gamma.num_curves
> +	       * par->gamma.num_values
> +	       * sizeof(tmp_curves[0]));

The operator goes on the first line:

 	memcpy(par->gamma.curves, tmp_curves,
	       par->gamma.num_curves * par->gamma.num_values *
	       sizeof(tmp_curves[0]));

But really, the original is probably best.  Just go over the 80 character
limit if it improve readability.

regards,
dan carpenter
