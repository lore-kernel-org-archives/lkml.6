Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCMIs5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:48:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:65312 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751666AbeCMIsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:48:54 -0400
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Yannick FERTRE <yannick.fertre@st.com>,
        Vikas MANOCHA <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philippe CORNU <philippe.cornu@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        "Simon Glass" <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] video: stm32: stm32_ltdc: update debug log
Thread-Topic: [PATCH v2 02/10] video: stm32: stm32_ltdc: update debug log
Thread-Index: AQHTsj1TW7mF4mCqBkeNY1FYN4aH5aPN2uMA
Date: Tue, 13 Mar 2018 08:48:32 +0000
Message-ID: <98fdd796-befe-61b4-ec02-819420ac9d66@st.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
 <1520005451-23217-3-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1520005451-23217-3-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F33010E319B8D49AB59FBFD74C4778B@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2D8nCtw031279

Hi Yannick

On 03/02/2018 04:44 PM, yannick fertre wrote:
> Replace  macro debug by pr_error, pr_warn or pr_info.
> 
> Signed-off-by: yannick fertre <yannick.fertre@st.com>
> ---
>   drivers/video/stm32/stm32_ltdc.c | 62 ++++++++++++++++++++--------------------
>   1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index bd9c0de..e95f35c 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -176,13 +176,13 @@ static u32 stm32_ltdc_get_pixel_format(enum video_log2_bpp l2bpp)
>   	case VIDEO_BPP2:
>   	case VIDEO_BPP4:
>   	default:
> -		debug("%s: warning %dbpp not supported yet, %dbpp instead\n",
> -		      __func__, VNBITS(l2bpp), VNBITS(VIDEO_BPP16));
> +		pr_warn("%s: warning %dbpp not supported yet, %dbpp instead\n",
> +			__func__, VNBITS(l2bpp), VNBITS(VIDEO_BPP16));
>   		pf = PF_RGB565;
>   		break;
>   	}
>   
> -	debug("%s: %d bpp -> ltdc pf %d\n", __func__, VNBITS(l2bpp), pf);
> +	pr_info("%s: %d bpp -> ltdc pf %d\n", __func__, VNBITS(l2bpp), pf);
>   
>   	return (u32)pf;
>   }
> @@ -249,7 +249,7 @@ static void stm32_ltdc_set_mode(struct stm32_ltdc_priv *priv,
>   
>   	/* Signal polarities */
>   	val = 0;
> -	debug("%s: timing->flags 0x%08x\n", __func__, timings->flags);
> +	pr_info("%s: timing->flags 0x%08x\n", __func__, timings->flags);
>   	if (timings->flags & DISPLAY_FLAGS_HSYNC_HIGH)
>   		val |= GCR_HSPOL;
>   	if (timings->flags & DISPLAY_FLAGS_VSYNC_HIGH)
> @@ -343,26 +343,26 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   
>   	priv->regs = (void *)dev_read_addr(dev);
>   	if ((fdt_addr_t)priv->regs == FDT_ADDR_T_NONE) {
> -		debug("%s: ltdc dt register address error\n", __func__);
> +		pr_err("%s: ltdc dt register address error\n", __func__);

As you get access to the struct udevice, prefer dev_err() here.

>   		return -EINVAL;
>   	}
>   
>   	ret = clk_get_by_index(dev, 0, &pclk);
>   	if (ret) {
> -		debug("%s: peripheral clock get error %d\n", __func__, ret);
> +		pr_err("%s: peripheral clock get error %d\n", __func__, ret);

ditto

>   		return ret;
>   	}
>   
>   	ret = clk_enable(&pclk);
>   	if (ret) {
> -		debug("%s: peripheral clock enable error %d\n",
> -		      __func__, ret);
> +		pr_err("%s: peripheral clock enable error %d\n",
> +		       __func__, ret);
ditto
>   		return ret;
>   	}
>   
>   	ret = reset_get_by_index(dev, 0, &rst);
>   	if (ret) {
> -		debug("%s: missing ltdc hardware reset\n", __func__);
> +		pr_err("%s: missing ltdc hardware reset\n", __func__);
ditto
>   		return -ENODEV;
>   	}
>   
> @@ -372,41 +372,40 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   #ifdef CONFIG_VIDEO_BRIDGE
>   	ret = uclass_get_device(UCLASS_VIDEO_BRIDGE, 0, &bridge);
>   	if (ret) {
> -		debug("%s: No video bridge, or no backlight on bridge\n",
> -		      __func__);
> +		pr_info("%s: No video bridge, or no backlight on bridge\n",
> +			__func__);

dev_info()

>   	}
>   
>   	if (bridge) {
>   		ret = video_bridge_attach(bridge);
>   		if (ret) {
> -			debug("%s: fail to attach bridge\n", __func__);
> +			pr_err("%s: fail to attach bridge\n", __func__);

dev_err()

>   			return ret;
>   		}
>   	}
>   #endif
>   	ret = uclass_first_device(UCLASS_PANEL, &panel);
>   	if (ret) {
> -		debug("%s: panel device error %d\n", __func__, ret);
> +		pr_err("%s: panel device error %d\n", __func__, ret);

ditto

>   		return ret;
>   	}
>   
>   	ret = fdtdec_decode_display_timing(gd->fdt_blob, dev_of_offset(panel),
>   					   0, &timings);
>   	if (ret) {
> -		debug("%s: decode display timing error %d\n",
> -		      __func__, ret);
> +		pr_err("%s: decode display timing error %d\n", __func__, ret);

ditto

>   		return ret;
>   	}
>   
>   	rate = clk_set_rate(&pclk, timings.pixelclock.typ);
>   	if (rate < 0) {
> -		debug("%s: fail to set pixel clock %d hz %d hz\n",
> -		      __func__, timings.pixelclock.typ, rate);
> +		pr_err("%s: fail to set pixel clock %d hz %d hz\n",
> +		       __func__, timings.pixelclock.typ, rate);

ditto

>   		return rate;
>   	}
>   
> -	debug("%s: Set pixel clock req %d hz get %d hz\n", __func__,
> -	      timings.pixelclock.typ, rate);
> +	pr_info("%s: Set pixel clock req %d hz get %d hz\n", __func__,
> +		timings.pixelclock.typ, rate);
>   
>   	/* TODO Below parameters are hard-coded for the moment... */
>   	priv->l2bpp = VIDEO_BPP16;
> @@ -417,12 +416,12 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	priv->crop_h = timings.vactive.typ;
>   	priv->alpha = 0xFF;
>   
> -	debug("%s: %dx%d %dbpp frame buffer at 0x%lx\n", __func__,
> -	      timings.hactive.typ, timings.vactive.typ,
> -	      VNBITS(priv->l2bpp), uc_plat->base);
> -	debug("%s: crop %d,%d %dx%d bg 0x%08x alpha %d\n", __func__,
> -	      priv->crop_x, priv->crop_y, priv->crop_w, priv->crop_h,
> -	      priv->bg_col_argb, priv->alpha);
> +	pr_info("%s: %dx%d %dbpp frame buffer at 0x%lx\n", __func__,
> +		timings.hactive.typ, timings.vactive.typ,
> +		VNBITS(priv->l2bpp), uc_plat->base);
> +	pr_info("%s: crop %d,%d %dx%d bg 0x%08x alpha %d\n", __func__,
> +		priv->crop_x, priv->crop_y, priv->crop_w, priv->crop_h,
> +		priv->bg_col_argb, priv->alpha);


dev_info()

>   
>   	/* Configure & start LTDC */
>   	stm32_ltdc_set_mode(priv, &timings);
> @@ -437,22 +436,22 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	if (bridge) {
>   		ret = video_bridge_set_backlight(bridge, 80);
>   		if (ret) {
> -			debug("%s: fail to set backlight\n", __func__);
> +			pr_err("%s: fail to set backlight\n", __func__);

dev_err()

>   			return ret;
>   		}
>   	} else {
>   		ret = panel_enable_backlight(panel);
>   		if (ret) {
> -			debug("%s: panel %s enable backlight error %d\n",
> -			      __func__, panel->name, ret);
> +			pr_err("%s: panel %s enable backlight error %d\n",
> +			       __func__, panel->name, ret);

ditto

>   			return ret;
>   		}
>   	}
>   #else
>   	ret = panel_enable_backlight(panel);
>   	if (ret) {
> -		debug("%s: panel %s enable backlight error %d\n",
> -		      __func__, panel->name, ret);
> +		pr_err("%s: panel %s enable backlight error %d\n",
> +		       __func__, panel->name, ret);

ditto

>   		return ret;
>   	}
>   #endif
> @@ -468,7 +467,8 @@ static int stm32_ltdc_bind(struct udevice *dev)
>   	uc_plat->size = CONFIG_VIDEO_STM32_MAX_XRES *
>   			CONFIG_VIDEO_STM32_MAX_YRES *
>   			(CONFIG_VIDEO_STM32_MAX_BPP >> 3);
> -	debug("%s: frame buffer max size %d bytes\n", __func__, uc_plat->size);
> +	pr_info("%s: frame buffer max size %d bytes\n", __func__,

dev_info()

> +		uc_plat->size);
>   
>   	return 0;
>   }
> 

Thanks

Patrice
