Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84C4C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C545208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C545208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeJETgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:36:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50942 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:36:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A973C7A9;
        Fri,  5 Oct 2018 05:38:07 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78C773F5A0;
        Fri,  5 Oct 2018 05:38:07 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id BE91B6800B1; Fri,  5 Oct 2018 13:38:05 +0100 (BST)
Date:   Fri, 5 Oct 2018 13:38:05 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/arm/malidp: remove set but not used variable
 'afbc_superblock_size'
Message-ID: <20181005123805.GE1156@e110455-lin.cambridge.arm.com>
References: <1538737393-112861-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1538737393-112861-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 11:03:13AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/arm/malidp_drv.c: In function 'malidp_verify_afbc_framebuffer_size':
> drivers/gpu/drm/arm/malidp_drv.c:318:6: warning:
>  variable 'afbc_superblock_size' set but not used [-Wunused-but-set-variable]
>   u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
> 
> It never used since be introduced in
> commit 3dae1c0919d8 ("drm/arm/malidp: Implemented the size validation for AFBC framebuffers")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 9021485..1b0ede6 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -315,7 +315,7 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
>  	int n_superblocks = 0;
>  	const struct drm_format_info *info;
>  	struct drm_gem_object *objs = NULL;
> -	u32 afbc_superblock_size = 0, afbc_superblock_height = 0;
> +	u32 afbc_superblock_height = 0;
>  	u32 afbc_superblock_width = 0, afbc_size = 0;
>  
>  	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
> @@ -333,9 +333,6 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
>  	n_superblocks = (mode_cmd->width / afbc_superblock_width) *
>  		(mode_cmd->height / afbc_superblock_height);
>  
> -	afbc_superblock_size = info->cpp[0] * afbc_superblock_width *
> -		afbc_superblock_height;
> -

Ah, that doesn't look right, it seems some code was dropped out of the
upstream patch. I will send a fix for it now.

Best regards,
Liviu

>  	afbc_size = ALIGN(n_superblocks * AFBC_HEADER_SIZE, 128);
>  
>  	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {
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
