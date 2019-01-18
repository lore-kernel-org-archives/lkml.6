Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7396FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8C120657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VnEez5B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfARPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:24:05 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53148 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfARPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:24:05 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD9F453E;
        Fri, 18 Jan 2019 16:24:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547825042;
        bh=ir/IZfzR0o+AwiDSggKWLEx9FlMAuxb+mAet7ANCEHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnEez5B6hthlaKtdKQkemeNdToAc511TTQnbwLucVw3iFUl3f2sTK03tXR+Jm24Mn
         6UqK5OHRVabJLwrRdOOa0njrHwC5rOue5gm0skN1Rk0NNvwLJNg4IC4sXAAxltDc25
         0XbvemEATdM1aNPnPKKDVJKkd8bUcwm+ClrSGGGc=
Date:   Fri, 18 Jan 2019 17:24:03 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 7/8] drmi/rcar-du: prepare for drmP.h removal from
 drm_modeset_helper.h
Message-ID: <20190118152403.GF5275@pendragon.ideasonboard.com>
References: <20190112193251.20450-1-sam@ravnborg.org>
 <20190112193251.20450-8-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190112193251.20450-8-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch.

On Sat, Jan 12, 2019 at 08:32:50PM +0100, Sam Ravnborg wrote:
> The use of drmP.h is discouraged and removal of it from
> drm_modeset_helper.h caused rcar-du to fail to build.
> 
> This patch introduce the necessary fixes to prepare for the
> drmP.h removal from drm_modeset_helper.h.
> 
> Build tested on arm x86 and arm allmodconfig.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> index 534a128a869d..8010ed702509 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> @@ -10,6 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>

-- 
Regards,

Laurent Pinchart
