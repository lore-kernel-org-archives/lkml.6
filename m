Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA2FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7442148D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BqcbYpBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeLZJja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:39:30 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:34180 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLZJja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 04:39:30 -0500
Received: from avalon.localnet (unknown [91.182.109.47])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0675C53D;
        Wed, 26 Dec 2018 10:39:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1545817168;
        bh=ADEi63n9BJkQtWF+CVL7tlbAxH8U0Ji3rriPytkCzaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BqcbYpBFXEo035pbXn0UdhVqtNZfLG4+3OsgyEmj7tg7izQpRF4KvBD/xb/R67ReQ
         zYAeMwPJ8Tu1gD5riXvg1KxnsMnJ+e6xe7jgP4RS9Z6rUmJiBG8IRVqO9XrQDs4C0I
         CWXSLwDDv/1D0tef3Gb8ZGMUVx5W7+IUHckXJbPw=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: Re: [PATCH] drm/bridge/panel: Remove duplicate header
Date:   Wed, 26 Dec 2018 11:40:23 +0200
Message-ID: <1891132.39bZHgSTRL@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181224143218.GA3170@hp-pavilion-15-notebook-pc-brajeswar>
References: <20181224143218.GA3170@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brajeswar,

Thank you for the patch.

On Monday, 24 December 2018 16:32:18 EET Brajeswar Ghosh wrote:
> Remove drm/drm_panel.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  drivers/gpu/drm/bridge/panel.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 7cbaba213ef6..402b318eeeb2 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -15,7 +15,6 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_modeset_helper_vtables.h>
> -#include <drm/drm_panel.h>

While at it, how about sorting headers alphabetically to make sure this won't 
happen again ?

With that change,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  struct panel_bridge {
>  	struct drm_bridge bridge;

-- 
Regards,

Laurent Pinchart



