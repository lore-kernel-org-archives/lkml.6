Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEEBECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6749C2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+suPldJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6749C2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJQUix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:38:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37695 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:38:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id x8-v6so16340579qka.4;
        Wed, 17 Oct 2018 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1cMvQ+7IG8Q6sT60r4ait7u8wOgBOuSOnbIvVke1+Ks=;
        b=a+suPldJVwjHWpcstiYqLeN4lhw8oLtIGfXrbSyHylLWG0FQVOPdX3NA4c75JcD/aB
         hN8ld+GIRoPxzZf3loCm4blzbZgIgOW3oI8NYyxTyN5iuptFHq1WyO64QWkVD0bMwv5O
         /D2u5AeDwRw7Y13fWYy8O1Sko0B3uljXLrGOIdUQ9V/ACKbNONE8hiyFrrwmMFwW2PC0
         Q5GAlAydYzh5uGDzJpRzkat8vQIP+8Ya5EOSDa8o6SnU7cSZCUk/sv+ROGqj0FffOKiu
         F2b0xfwGSyzZQW1v5EU08Sa6nidOjrR70nTzk0ZL2gdabGPl5iBAaCMZAi9qRs8yHhAx
         n8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1cMvQ+7IG8Q6sT60r4ait7u8wOgBOuSOnbIvVke1+Ks=;
        b=W/jQyxxLouBsjjFcJ4c8OEUzacA2GR+96+AgXTxXGQNsYTcnsEY4nB88+rZgm6ObLC
         /CHl8qAhjTD46Z9fjdOW2ZxJYxIRkW5+/5upjt/EyUVBDNKilLIP1Hz2u+JSVfDDsWbq
         05JPgc3FtIdqllbt8BOUMg7r7sL+5qnrPo+oe1KszTiMA0H5U/suzEwGVB08GWJ8dTd/
         fU3TXombxA0wnd2SxgQMXKnLjxRf/blSDkCSA0YXC23miLBAyhgGzRWNXknJVYH4eXEg
         WT7LSXhOImAfnFcooELy9GPlQy7T/JGIY939p+zi2c9aRlWAwa8kqSU2/rvPivES49b5
         aK0A==
X-Gm-Message-State: ABuFfojpbo3hDso39aPYRSGcVgrR5hZQO+vwKxHVnTbk06aeZgg/sl+i
        u3gbSZraZUwTkOkw4jFhDxTFOqDM
X-Google-Smtp-Source: ACcGV63vtmk0m14pYnkGzQsS79rqmIxgagoXzc0eUsWO8qeonHTVotcJNFBo9yMU0Fs9l7h0Xany7g==
X-Received: by 2002:ae9:eb05:: with SMTP id b5-v6mr24152710qkg.127.1539780200117;
        Wed, 17 Oct 2018 05:43:20 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id u23-v6sm12616033qth.45.2018.10.17.05.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 05:43:19 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:43:15 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181017124315.khhlykapxnug6ej6@smtp.gmail.com>
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
 <20181016123541.GW31561@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016123541.GW31561@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all, thanks to all for the reviewers and feedbacks.

On 10/16, Daniel Vetter wrote:
> On Mon, Oct 15, 2018 at 02:05:29PM -0300, Rodrigo Siqueira wrote:
> > For historical reason, the function drm_wait_vblank_ioctl always return
> > -EINVAL if something gets wrong. This scenario limits the flexibility
> > for the userspace make detailed verification of the problem and take
> > some action. In particular, the validation of “if (!dev->irq_enabled)”
> > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > support vblank or not. If the driver does not support VBlank, the
> > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > the real issue; this patch changes this behavior by return EOPNOTSUPP.
> > Additionally, some operations are unsupported by this function, and
> > returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> > libdrm, which is used by many compositors; because of this, it is
> > important to check if this change breaks any compositor. In this sense,
> > the following projects were examined:
> > 
> > * Drm-hwcomposer
> > * Kwin
> > * Sway
> > * Wlroots
> > * Wayland-core
> > * Weston
> > * Xorg (67 different drivers)
> > 
> > For each repository the verification happened in three steps:
> > 
> > * Update the main branch
> > * Look for any occurrence "drmWaitVBlank" with the command:
> >   git grep -n "drmWaitVBlank"
> > * Look in the git history of the project with the command:
> >   git log -SdrmWaitVBlank
> > 
> > Finally, none of the above projects validate the use of EINVAL which
> > make safe, at least for these projects, to change the return values.
> > 
> > Change since V1:
> >  Daniel Vetter and Chris Wilson
> >  - Replace ENOTTY by EOPNOTSUPP
> >  - Return EINVAL if the parameters are wrong
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Can you pls also let intel-gfx-ci test this patch? You just need to
> include intel-gfx@lists.freedesktop.org in your recipient list.

I did know about intel-gfx-ci, really nice:)

Should I CC this mailing list if I send patches to the DRM core, amdgpu,
i915, vc4, vgem, and virtio-gpu? I suppose that IGT is running on the
CI, right?

Another question, do I need to send a V3 with intel-gfx-ci?
 
> For merging, since you plan to stick around doing kms stuff a bit: Want
> commit rights for drm-misc?
> 
> https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html

Yes, I want :)
I will need some guidance, in the beginning, to get confident about the
processes. If you can help me with this, I will be glad to play around
with 'dim' and the merging tasks.

Best Regards

> Cheers, Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 98e091175921..80f5a3bb427e 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> >  	unsigned int flags, pipe, high_pipe;
> >  
> >  	if (!dev->irq_enabled)
> > -		return -EINVAL;
> > +		return -EOPNOTSUPP;
> >  
> >  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > -		return -EINVAL;
> > +		return -EOPNOTSUPP;
> >  
> >  	if (vblwait->request.type &
> >  	    ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> > -- 
> > 2.19.1
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Rodrigo Siqueira
https://siqueira.tech
https://twitter.com/siqueirajordao
Graduate Student
Department of Computer Science
University of São Paulo
