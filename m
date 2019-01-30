Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B45DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04022087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jrqFKCgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbfA3Qfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:35:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46169 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732026AbfA3Qfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:35:42 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so75732edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcbDwxib+qoiOKinWuWer9A50wdrbm5rxdi3sgECnCE=;
        b=jrqFKCgcMUFx3kVysc/dOpcL4jrwcAE5QhJWaZkF91gh5fcChqlrHkf2eQtpD6u8sP
         IafCtv1Hra9o2hS9fkUMuypTNj4P9bLYToggxkBAirhbm7yggaAqcHKpNfkJn02lEUiZ
         R9DFu0xE3zVy7Ku7NY3CTzUki66qxZdcuYEGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=mcbDwxib+qoiOKinWuWer9A50wdrbm5rxdi3sgECnCE=;
        b=TJmBqORHSg8dpA6lAH5AuQlEviLz7KMbUUGUnymLB+/No6wQuKDIxwYFQeebsP52KQ
         kA2eVKmFba2/AztIdYdTKFlun3FOfh/gpzddTaogpqqhijTmP14l4S1LvEyaAMKMNmD9
         jMDfd/RBLX0J6vH5jvtEen7bCXuGLUI7yGHWfXsbM7uA7ceQ8s8dTYtaQbedoMbQIKtT
         UA37nPO0EuyRp4EflbdEhw8pOJYTlhNfACCoXc6qdZRGqx94Z9utqppLlza61sSyW+iI
         /R8xGQLDB+fFT11pzPBLBX2aQa60XO9XQANbtQZzhyJtjGC9Nz8K+4RlGpXUhpP6xRCG
         JwAg==
X-Gm-Message-State: AJcUukehnuomlTPj29ieNtZOo/cRfQh5aNRV2VCqA7M/7eBPvl4VFWRa
        fV2aDOomFByuKFvJ3QjyhLMaVQ==
X-Google-Smtp-Source: ALg8bN6DxaS+FX45EPInRKPYhTbTazf0XZj85EioTd8oLzCJN8D2+f29Ptfecb471XgQBHeztrZrhw==
X-Received: by 2002:a50:a786:: with SMTP id i6mr30560355edc.37.1548866140164;
        Wed, 30 Jan 2019 08:35:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z6-v6sm379531ejq.63.2019.01.30.08.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:35:37 -0800 (PST)
Date:   Wed, 30 Jan 2019 17:35:35 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/savage: mark expected switch fall-throughs
Message-ID: <20190130163535.GH3271@phenom.ffwll.local>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190129202005.GA25789@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129202005.GA25789@embeddedor>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:20:06PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/gpu/drm/savage/savage_state.c:301:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/gpu/drm/savage/savage_state.c:438:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/gpu/drm/savage/savage_state.c:559:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/gpu/drm/savage/savage_state.c:697:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

This and the via patch merged to drm-misc-next, thanks.
-Daniel

> ---
>  drivers/gpu/drm/savage/savage_state.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/savage/savage_state.c b/drivers/gpu/drm/savage/savage_state.c
> index 7559a820bd43..ebb8b7d32b33 100644
> --- a/drivers/gpu/drm/savage/savage_state.c
> +++ b/drivers/gpu/drm/savage/savage_state.c
> @@ -299,6 +299,7 @@ static int savage_dispatch_dma_prim(drm_savage_private_t * dev_priv,
>  	case SAVAGE_PRIM_TRILIST_201:
>  		reorder = 1;
>  		prim = SAVAGE_PRIM_TRILIST;
> +		/* fall through */
>  	case SAVAGE_PRIM_TRILIST:
>  		if (n % 3 != 0) {
>  			DRM_ERROR("wrong number of vertices %u in TRILIST\n",
> @@ -436,6 +437,7 @@ static int savage_dispatch_vb_prim(drm_savage_private_t * dev_priv,
>  	case SAVAGE_PRIM_TRILIST_201:
>  		reorder = 1;
>  		prim = SAVAGE_PRIM_TRILIST;
> +		/* fall through */
>  	case SAVAGE_PRIM_TRILIST:
>  		if (n % 3 != 0) {
>  			DRM_ERROR("wrong number of vertices %u in TRILIST\n",
> @@ -557,6 +559,7 @@ static int savage_dispatch_dma_idx(drm_savage_private_t * dev_priv,
>  	case SAVAGE_PRIM_TRILIST_201:
>  		reorder = 1;
>  		prim = SAVAGE_PRIM_TRILIST;
> +		/* fall through */
>  	case SAVAGE_PRIM_TRILIST:
>  		if (n % 3 != 0) {
>  			DRM_ERROR("wrong number of indices %u in TRILIST\n", n);
> @@ -695,6 +698,7 @@ static int savage_dispatch_vb_idx(drm_savage_private_t * dev_priv,
>  	case SAVAGE_PRIM_TRILIST_201:
>  		reorder = 1;
>  		prim = SAVAGE_PRIM_TRILIST;
> +		/* fall through */
>  	case SAVAGE_PRIM_TRILIST:
>  		if (n % 3 != 0) {
>  			DRM_ERROR("wrong number of indices %u in TRILIST\n", n);
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
