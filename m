Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeENIiu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:38:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:6743 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752077AbeENIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:38:49 -0400
From: Vincent ABRIOU <vincent.abriou@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH 3/4] drm/panel: otm8009a: no message if probe success
Thread-Topic: [PATCH 3/4] drm/panel: otm8009a: no message if probe success
Thread-Index: AQHT2wzqXrNowIPaWE2a7Boc8iR3PaQu5kOA
Date: Mon, 14 May 2018 08:38:35 +0000
Message-ID: <b662fc6e-b4e6-4b23-e913-fea25159236d@st.com>
References: <20180423141054.13128-1-philippe.cornu@st.com>
 <20180423141054.13128-4-philippe.cornu@st.com>
In-Reply-To: <20180423141054.13128-4-philippe.cornu@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <343578B29212A34990A4A8B7D9E5C82B@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4E8cvRl008869

Hi Philippe,

Reviewed-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent

On 04/23/2018 04:10 PM, Philippe Cornu wrote:
> Remove the message in case of probe success. This comes from
> a suggestion followed in the recent integration of the
> raydium rm68200 panel.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> index de4a16d5275c..4c638b7b9943 100644
> --- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> +++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
> @@ -14,8 +14,6 @@
>   #include <linux/regulator/consumer.h>
>   #include <video/mipi_display.h>
>   
> -#define DRV_NAME "orisetech_otm8009a"
> -
>   #define OTM8009A_BACKLIGHT_DEFAULT	240
>   #define OTM8009A_BACKLIGHT_MAX		255
>   
> @@ -461,7 +459,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
>   	ctx->panel.dev = dev;
>   	ctx->panel.funcs = &otm8009a_drm_funcs;
>   
> -	ctx->bl_dev = backlight_device_register(DRV_NAME "_backlight", dev, ctx,
> +	ctx->bl_dev = backlight_device_register(dev_name(dev), dev, ctx,
>   						&otm8009a_backlight_ops, NULL);
>   	if (IS_ERR(ctx->bl_dev)) {
>   		dev_err(dev, "failed to register backlight device\n");
> @@ -483,11 +481,6 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
>   		return ret;
>   	}
>   
> -	DRM_INFO(DRV_NAME "_panel %ux%u@%u %ubpp dsi %udl - ready\n",
> -		 default_mode.hdisplay, default_mode.vdisplay,
> -		 default_mode.vrefresh,
> -		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
> -
>   	return 0;
>   }
>   
> @@ -513,7 +506,7 @@ static struct mipi_dsi_driver orisetech_otm8009a_driver = {
>   	.probe  = otm8009a_probe,
>   	.remove = otm8009a_remove,
>   	.driver = {
> -		.name = DRV_NAME "_panel",
> +		.name = "panel-orisetech-otm8009a",
>   		.of_match_table = orisetech_otm8009a_of_match,
>   	},
>   };
> 
