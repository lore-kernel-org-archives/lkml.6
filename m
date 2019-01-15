Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B666C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5168E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfAOWMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:12:39 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:34656 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbfAOWMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:12:38 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 17:12:37 EST
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 504AC80478;
        Tue, 15 Jan 2019 23:12:34 +0100 (CET)
Date:   Tue, 15 Jan 2019 23:12:32 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas.Ferre@microchip.com, Cristian.Birsan@microchip.com
Subject: Re: [PATCH v2 3/3] drm/panel: simple: add support for PDA
 91-00156-A0 panel
Message-ID: <20190115221232.GA11283@ravnborg.org>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547458584-29548-4-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=XYAwZIGsAAAA:8 a=AlPfrvoXxqGtgr3-n_gA:9
        a=CjuIK1q_8ugA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen.

Patch looks good, but a small improvement proposal.

On Mon, Jan 14, 2019 at 09:43:31AM +0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9c69e73..61361ba 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2008,6 +2008,30 @@ static const struct panel_desc ortustech_com43h4m85ulc = {
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
>  };
>  
> +static const struct drm_display_mode pda_91_00156_a0_mode = {
> +	.clock = 33300,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 1,
> +	.hsync_end = 800 + 1 + 64,
> +	.htotal = 800 + 1 + 64 + 64,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 1,
> +	.vsync_end = 480 + 1 + 23,
> +	.vtotal = 480 + 1 + 23 + 22,
> +	.vrefresh = 60,
> +};
.flags are omitted, as it is for many panels in simple-panel.
drm_modes.h do not document any default, so we must assume default equals no flags.

I would expect two of these as a minimum:
DRM_MODE_FLAG_PHSYNC: horizontal sync is active high.
DRM_MODE_FLAG_NHSYNC: horizontal sync is active low.
DRM_MODE_FLAG_PVSYNC: vertical sync is active high.
DRM_MODE_FLAG_NVSYNC: vertical sync is active low.

But it obviously works for a lot of panel, so one
may say why bother with it.

> +
> +static const struct panel_desc pda_91_00156_a0  = {
> +	.modes = &pda_91_00156_a0_mode,
> +	.num_modes = 1,
> +	.size = {
> +		.width = 152,
> +		.height = 91,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +};
.bus_format is specified - good!

Consider if .bus_flags needs to be specified.
(More or less same argumentation like for .flags above).

I could not find any data-sheet on the panel,
so I could not check if it is OK that all delays are 0.

So to recap - things looks fine, but consider to be more explicit
in .flags, bus_flags, and check if it is OK that all timing parameters are 0.

	Sam
