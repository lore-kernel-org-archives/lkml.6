Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB3C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897182081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897182081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeKCBmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:42:39 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:37398 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeKCBmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:42:39 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D420080312;
        Fri,  2 Nov 2018 17:34:50 +0100 (CET)
Date:   Fri, 2 Nov 2018 17:34:49 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-kernel@vger.kernel.org, airlied@linux.ie,
        thierry.reding@gmail.com, adam.ford@logicpd.com,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/panel: simple: Add Ampire am800480b3tmqw
Message-ID: <20181102163449.GA25035@ravnborg.org>
References: <20181101125138.27848-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101125138.27848-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=aDtu_6vVvJ-Pg3724GMA:9
        a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam

On Thu, Nov 01, 2018 at 07:51:38AM -0500, Adam Ford wrote:
> This adds support for the Ampire am800480b3tmqw display,
> a 7" 24-bit RGB panel wtih 800x480 resolution.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 97964f7f2ace..71e878f63c5b 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -436,6 +436,31 @@ static const struct panel_desc ampire_am800480r3tmqwa1h = {
>  	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
>  };
>  
> +static const struct drm_display_mode ampire_am800480b3tmqw_mode = {
> +	.clock = 30000,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 210,
> +	.hsync_end = 800 + 210 + 46,
> +	.htotal = 800 + 210 + 46 + 0,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 22,
> +	.vsync_end = 480 + 22 + 23,
> +	.vtotal = 480 + 22 + 23 + 0,
> +	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> +};
+1 to see .flags specified


> +
> +static const struct panel_desc ampire_am800480b3tmqw = {
> +	.modes = &ampire_am800480b3tmqw_mode,
> +	.num_modes = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 152,
> +		.height = 91,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RBG888_1X24,
> +};
Likewise good to see .bus_format specified.

But .bus_flags are not specified. 

From the header file:

<<<<<<<<<<<<<<<<<<<<
#define DRM_BUS_FLAG_DE_LOW             (1<<0)
#define DRM_BUS_FLAG_DE_HIGH            (1<<1)
/* drive data on pos. edge */
#define DRM_BUS_FLAG_PIXDATA_POSEDGE    (1<<2)
/* drive data on neg. edge */
#define DRM_BUS_FLAG_PIXDATA_NEGEDGE    (1<<3)
/* data is transmitted MSB to LSB on the bus */
#define DRM_BUS_FLAG_DATA_MSB_TO_LSB    (1<<4)
/* data is transmitted LSB to MSB on the bus */
#define DRM_BUS_FLAG_DATA_LSB_TO_MSB    (1<<5)
/* drive sync on pos. edge */
#define DRM_BUS_FLAG_SYNC_POSEDGE       (1<<6)
/* drive sync on neg. edge */
#define DRM_BUS_FLAG_SYNC_NEGEDGE       (1<<7)

        /**
         * @bus_flags: Additional information (like pixel signal polarity) for
         * the pixel data on the bus, using DRM_BUS_FLAGS\_ defines.
         */
        u32 bus_flags;
>>>>>>>>>>>>>>>><

Many panels leave out .bus_flags - and I wonder if this is
because default is OK or because most other panels does so.

I had problems with my display that the text looked blurred
when bus_flags was no specified (using defaults).
This was one issue I had when migrating from 4.4 kernel
to a recent kernel.

So therefore it would good to have .bus_flags specified too
if for nothing else then for documentation purposes.

	Sam
