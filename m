Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9233C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38E920656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfAOKMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:12:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46692 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfAOKMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:12:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA9C21596;
        Tue, 15 Jan 2019 02:12:21 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8474E3F70D;
        Tue, 15 Jan 2019 02:12:21 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id D833468012C; Tue, 15 Jan 2019 10:12:19 +0000 (GMT)
Date:   Tue, 15 Jan 2019 10:12:19 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "James Qian Wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mali-dp tree
Message-ID: <20190115101219.GP20661@e110455-lin.cambridge.arm.com>
References: <20190115104619.516be4b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115104619.516be4b9@canb.auug.org.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:46:19AM +1100, Stephen Rothwell wrote:
> Hi Liviu,

Hi Stephen,

> 
> After merging the mali-dp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c: In function 'komeda_pipeline_obj_add':
> drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:48:30: error: passing argument 1 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   drm_atomic_private_obj_init(&pipe->obj, &st->obj,
>                               ^~~~~~~~~~
> In file included from drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:11,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_dev.h:12,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:7:
> include/drm/drm_atomic.h:437:53: note: expected 'struct drm_device *' but argument is of type 'struct drm_private_obj *'
>  void drm_atomic_private_obj_init(struct drm_device *dev,
>                                   ~~~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:48:42: error: passing argument 2 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   drm_atomic_private_obj_init(&pipe->obj, &st->obj,
>                                           ^~~~~~~~
> In file included from drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:11,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_dev.h:12,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:7:
> include/drm/drm_atomic.h:438:30: note: expected 'struct drm_private_obj *' but argument is of type 'struct drm_private_state *'
>       struct drm_private_obj *obj,
>       ~~~~~~~~~~~~~~~~~~~~~~~~^~~
> drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:49:9: error: passing argument 3 of 'drm_atomic_private_obj_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
>          &komeda_pipeline_obj_funcs);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:11,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_dev.h:12,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:7:
> include/drm/drm_atomic.h:439:32: note: expected 'struct drm_private_state *' but argument is of type 'const struct drm_private_state_funcs *'
>       struct drm_private_state *state,
>       ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
> drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:48:2: error: too few arguments to function 'drm_atomic_private_obj_init'
>   drm_atomic_private_obj_init(&pipe->obj, &st->obj,
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:11,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_dev.h:12,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c:7:
> include/drm/drm_atomic.h:437:6: note: declared here
>  void drm_atomic_private_obj_init(struct drm_device *dev,
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   61f1c4a8ab75 ("drm/komeda: Attach komeda_dev to DRM-KMS")
> 
> interacting with commit
> 
>   b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")
> 
> from the drm tree.
> 
> I have applied the following merge fix patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 15 Jan 2019 10:42:04 +1100
> Subject: [PATCH] drm/komeda: merge fix for drm_atomic_private_obj_init() API change
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> index 9edfd6ab0c12..f1c9e3fefa86 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
> @@ -45,7 +45,7 @@ static int komeda_pipeline_obj_add(struct komeda_kms_dev *kms,
>  		return -ENOMEM;
>  
>  	st->pipe = pipe;
> -	drm_atomic_private_obj_init(&pipe->obj, &st->obj,
> +	drm_atomic_private_obj_init(&kms->base, &pipe->obj, &st->obj,
>  				    &komeda_pipeline_obj_funcs);

That looks like the right fix, thank you for that! I will roll your
patch into my tree.

Best regards,
Liviu

>  
>  	return 0;
> -- 
> 2.20.1
> 
> -- 
> Cheers,
> Stephen Rothwell



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
