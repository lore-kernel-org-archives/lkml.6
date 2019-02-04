Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8BEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E52214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="urgFJKgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfBDIOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:14:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44630 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfBDIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:14:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x148DpsZ066056;
        Mon, 4 Feb 2019 02:13:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549268031;
        bh=oSczJSEU8cgvVbdCCsgC+AEOnCIS3rQD8g2sIZ6BFYk=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=urgFJKgO4Q+uoxjAcIIDNoVNEZmpmVTyRhGBB+UVjGHtdhfOJewW5Qxf7gBX7p6fz
         bYkWQbCeVcRlZZivdPGhaDWOMS9nUYxgtZ098OVhGNbzYqprJJhzajdvO2k2otVpBw
         UxRpTVwWmDDY35MsLq9QGQROTNqZHiztCvypkxrI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x148DoqV070920
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 02:13:51 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 02:13:49 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 02:13:49 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x148DlQv019771;
        Mon, 4 Feb 2019 02:13:47 -0600
Subject: Re: [PATCH 1/2] drm/omap: panel-tpo-td028ttec1: add backlight support
To:     Andreas Kemnade <andreas@kemnade.info>
References: <20190119182131.9341-1-andreas@kemnade.info>
 <20190119182131.9341-2-andreas@kemnade.info>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <laurent.pinchart@ideasonboard.com>, <sre@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <letux-kernel@openphoenux.org>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <9eb955aa-3a87-7f25-21ce-c177b67de522@ti.com>
Date:   Mon, 4 Feb 2019 10:13:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119182131.9341-2-andreas@kemnade.info>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/01/2019 20:21, Andreas Kemnade wrote:
> This panel has a backlight, so fetch it from devicetree using the
> as documented in panel-common.txt. It is implemented the same way as in

Extra words above, or maybe some are missing...

> panel-dpi.c
> This ensures the backlight is also disabled when the display is
> turned off like when doing xset dpms force off.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c    | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> index 7ddc8c574a61..f326ba9dcf62 100644
> --- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> +++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
> @@ -35,6 +35,8 @@ struct panel_drv_data {
>  
>  	struct videomode vm;
>  
> +	struct backlight_device *backlight;
> +
>  	struct spi_device *spi_dev;
>  };
>  
> @@ -268,6 +270,8 @@ static int td028ttec1_panel_enable(struct omap_dss_device *dssdev)
>  
>  	r |= jbt_ret_write_0(ddata, JBT_REG_DISPLAY_ON);
>  
> +	backlight_enable(ddata->backlight);
> +
>  	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
>  
>  transfer_err:
> @@ -283,6 +287,8 @@ static void td028ttec1_panel_disable(struct omap_dss_device *dssdev)
>  	if (!omapdss_device_is_enabled(dssdev))
>  		return;
>  
> +	backlight_disable(ddata->backlight);
> +
>  	dev_dbg(dssdev->dev, "td028ttec1_panel_disable()\n");
>  
>  	jbt_ret_write_0(ddata, JBT_REG_DISPLAY_OFF);
> @@ -321,6 +327,15 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
>  
>  	dev_dbg(&spi->dev, "%s\n", __func__);
>  
> +	ddata = devm_kzalloc(&spi->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (ddata == NULL)
> +		return -ENOMEM;
> +
> +	ddata->backlight = devm_of_find_backlight(&spi->dev);
> +
> +	if (IS_ERR(ddata->backlight))
> +		return PTR_ERR(ddata->backlight);
> +

Is there a reason for moving the ddata alloc here, instead of keeping it
where it was?

>  	spi->bits_per_word = 9;
>  	spi->mode = SPI_MODE_3;
>  
> @@ -330,9 +345,6 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
>  		return r;
>  	}
>  
> -	ddata = devm_kzalloc(&spi->dev, sizeof(*ddata), GFP_KERNEL);
> -	if (ddata == NULL)
> -		return -ENOMEM;
>  

This leaves an extra empty line here.

>  	dev_set_drvdata(&spi->dev, ddata);
>  

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
