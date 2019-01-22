Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C54C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5661221019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dKT27ChY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfAVVE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:04:26 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:56044 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVVE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:04:26 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0FEA8575;
        Tue, 22 Jan 2019 22:04:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1548191064;
        bh=+yh++EyvL5DNIW33ft1jcIWPSb9v2f7fwqV6VtHUJRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKT27ChYFDaoOeMCRYs9qLdmuEe9B9sDmMiwrqY2WUU5TNS+I4kxLHTGbvMpTyo1O
         0wzUy0G9j6R9Kincp6RX4ORRymrq1oN5M95wprQqhp97kz2rY9HEprKphrMAbqJTuL
         gDhJazUsy9ZDjH2RjsSc9ReWnu5/y0XIKyasf2Zw=
Date:   Tue, 22 Jan 2019 23:04:23 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/bridge: lvds-encoder: remove surplus NULL checks
Message-ID: <20190122210423.GJ3264@pendragon.ideasonboard.com>
References: <be258481-b3e4-8051-abb2-ca430ecc2836@samsung.com>
 <20190118231129.8281-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118231129.8281-1-peda@axentia.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you for the patch.

On Fri, Jan 18, 2019 at 11:11:38PM +0000, Peter Rosin wrote:
> The gpio API explicitly allows skipping the NULL check, precisely to
> allow for neat support for optional gpios. Which is exactly what is at
> play here.
> 
> Reported-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/lvds-encoder.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
> index 36d8557bc097..584007eaf6e1 100644
> --- a/drivers/gpu/drm/bridge/lvds-encoder.c
> +++ b/drivers/gpu/drm/bridge/lvds-encoder.c
> @@ -36,8 +36,7 @@ static void lvds_encoder_enable(struct drm_bridge *bridge)
>  							 struct lvds_encoder,
>  							 bridge);
>  
> -	if (lvds_encoder->powerdown_gpio)
> -		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);
> +	gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);
>  }
>  
>  static void lvds_encoder_disable(struct drm_bridge *bridge)
> @@ -46,8 +45,7 @@ static void lvds_encoder_disable(struct drm_bridge *bridge)
>  							 struct lvds_encoder,
>  							 bridge);
>  
> -	if (lvds_encoder->powerdown_gpio)
> -		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);
> +	gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);
>  }
>  
>  static struct drm_bridge_funcs funcs = {

-- 
Regards,

Laurent Pinchart
