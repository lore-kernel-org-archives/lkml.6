Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45244C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C052086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gReM9Bqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C052086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJPR4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:56:51 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36772 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:56:51 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DDEF61A81;
        Tue, 16 Oct 2018 12:07:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539684428;
        bh=VolwqHG6RB27aKVdw7JhyL4K5q3qWJdPdt63PWmddqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gReM9BqvyLfMwr2cGEhDJaKvr3n+1D9qX3bISRpMSVyDIr/D48b3rH0hI8Gc4XBVw
         kUnHZ0yB+MnFUVTeeW31hb79mR/H3T9y3YBUQcX22Pi05BEx8UTiJ/1DfbE+SSGRTf
         w2o5U/zTNqk5pFx3V51RCj2HaUkoBbBgliv6763U=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: rcar-du: Fix the return value in case of error in 'rcar_du_crtc_set_crc_source()'
Date:   Tue, 16 Oct 2018 13:07:16 +0300
Message-ID: <2042905.omcotxa4GD@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181016065825.23206-1-christophe.jaillet@wanadoo.fr>
References: <20181016065825.23206-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch.

On Tuesday, 16 October 2018 09:58:25 EEST Christophe JAILLET wrote:
> We return 0 unconditionally in 'rcar_du_crtc_set_crc_source()'.
> However, 'ret' is set to some error codes if some function calls fail.
> 
> Return 'ret' instead to propagate the error code.
> 
> Fixes: 47a52d024e89 ("media: drm: rcar-du: Add support for CRC computation")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c index 8a9e5e6f16b4..6eb0a95ad5a6
> 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -940,7 +940,7 @@ static int rcar_du_crtc_set_crc_source(struct drm_crtc
> *crtc, drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);
> 
> -	return 0;
> +	return ret;
>  }
> 
>  static const struct drm_crtc_funcs crtc_funcs_gen2 = {


-- 
Regards,

Laurent Pinchart



