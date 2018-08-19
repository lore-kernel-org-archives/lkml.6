Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF12C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856E9213A2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 14:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="b6Al+nl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856E9213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeHSRSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 13:18:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52360 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeHSRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 13:18:18 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ABE5ACE;
        Sun, 19 Aug 2018 16:06:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1534687600;
        bh=mC1khrnz6XA8gJwayujJ0O7OBilB76sLcwAySZLwyQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6Al+nl+y+S76cmfM328MhBkCzYL0Egi4qGt7+YqKlPej7GRK51zx9+jDJyuXLNpy
         jBd5GmLPK20WrsKNWkS9cmOoF6mJs+2ZXxuNh1bEUqKgdnE0+Dpje5FEa/SLwb8jIW
         v6IW83d04cdobwT87h5aNITKSfw0T+B1mlVOxaxA=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] drm: omapdrm: displays: fix port_num for opa362 output
Date:   Sun, 19 Aug 2018 17:07:34 +0300
Message-ID: <6854891.0j5LuaEH9O@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <dccf0cafc194743cd037513ef19e889fb880892d.1532701471.git.hns@goldelico.com>
References: <dccf0cafc194743cd037513ef19e889fb880892d.1532701471.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Thank you for the patch.

On Friday, 27 July 2018 17:24:32 EEST H. Nikolaus Schaller wrote:
> The opa362 amplifier has two ports, an input (usually connected
> to the OMAP3 VENC) and an output port connected to the external
> connector.
> 
> These are usually defined as input port@0 and outpt port@1 in
> the DT and really distinguished by the reg = <port_num> property
> of these nodes.
> 
> But we are missing to define the output port as number 1 so
> it does not match the DT entry.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

I think this patch is superseded by "[PATCH v3 36/61] drm/omap: dss: Replace 
omap_dss_device port number with bitmask" which should get merged in v4.20.

> ---
>  drivers/gpu/drm/omapdrm/displays/encoder-opa362.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
> b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c index
> afee1b8b457a..296d46f060b2 100644
> --- a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
> +++ b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
> @@ -208,6 +208,7 @@ static int opa362_probe(struct platform_device *pdev)
>  	dssdev->type = OMAP_DISPLAY_TYPE_VENC;
>  	dssdev->output_type = OMAP_DISPLAY_TYPE_VENC;
>  	dssdev->owner = THIS_MODULE;
> +	dssdev->port_num = 1;	/* second port */
> 
>  	r = omapdss_register_output(dssdev);
>  	if (r) {

-- 
Regards,

Laurent Pinchart



