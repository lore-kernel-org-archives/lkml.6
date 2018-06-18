Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6457C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EF92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EF92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933642AbeFRNJi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:09:38 -0400
Received: from foss.arm.com ([217.140.101.70]:33844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932585AbeFRNJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:09:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35D380D;
        Mon, 18 Jun 2018 06:09:36 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55823F578;
        Mon, 18 Jun 2018 06:09:36 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 1AB2368020F; Mon, 18 Jun 2018 14:09:35 +0100 (BST)
Date:   Mon, 18 Jun 2018 14:09:35 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Ayan Kumar Halder <ayan.halder@arm.com>
Cc:     brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] drm/arm/malidp:- Rectify the width and height passed to
 rotmem_required()
Message-ID: <20180618130934.GG15072@e110455-lin.cambridge.arm.com>
References: <1529067276-18566-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1529067276-18566-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 01:54:36PM +0100, Ayan Kumar Halder wrote:
> The width and height needs to be swapped
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_planes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index 377382e..533cdde 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -244,8 +244,8 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  	if (state->rotation != DRM_MODE_ROTATE_0 || fb->modifier) {
>  		int val;
>  
> -		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_h,
> -						     state->crtc_w,
> +		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_w,
> +						     state->crtc_h,
>  						     fb->format->format,
>  						     !!(fb->modifier));

Ooops, thanks for catching this! 

Acked-by: Liviu Dudau <liviu.dudau@arm.com>


>  		if (val < 0)
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
