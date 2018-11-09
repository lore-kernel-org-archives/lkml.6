Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB44C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAE320840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAE320840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeKIU1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:27:00 -0500
Received: from foss.arm.com ([217.140.101.70]:57058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeKIU1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:27:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1509A78;
        Fri,  9 Nov 2018 02:46:57 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B22E63F718;
        Fri,  9 Nov 2018 02:46:57 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 1748968012E; Fri,  9 Nov 2018 10:46:56 +0000 (GMT)
Date:   Fri, 9 Nov 2018 10:46:56 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/arm/malidp: Consider rotation memory requirement in
 case of AFBC framebuffer
Message-ID: <20181109104655.GC3512@e110455-lin.cambridge.arm.com>
References: <1541759832-19211-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1541759832-19211-1-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:37:19AM +0000, Ayan Halder wrote:
> Rotation memory for layers is shared with AFBC decoder block. Thus one needs to
> calculate rotation memory requirement in case of AFBC framebuffer. This is
> used later to verify if it can be sufficed by the hardware rotation memory
> availibility.
> 
> Fixes: 66da13a ("drm/arm/malidp: Validate rotations for compressed/uncompressed framebuffers for each layer")
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  drivers/gpu/drm/arm/malidp_planes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> index c9a6d3e..3f4dc64 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> @@ -470,7 +470,7 @@ static int malidp_de_plane_check(struct drm_plane *plane,
>  	}
>  
>  	ms->rotmem_size = 0;
> -	if (state->rotation & MALIDP_ROTATED_MASK) {
> +	if ((state->rotation & MALIDP_ROTATED_MASK) || fb->modifier) {
>  		int val;
>  
>  		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_w,
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
