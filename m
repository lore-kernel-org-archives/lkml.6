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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36947ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D856721526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPruF9C7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D856721526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJQVPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:15:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40479 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJQVPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:15:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id b4-v6so29868925qtc.7;
        Wed, 17 Oct 2018 06:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BT2QOIMMiRd97sr79EG5BlJTLFSRW5687kUKBi+G6so=;
        b=WPruF9C7ZjadfRz+hh7ac0FlnwIL7JGjthFq/sGko7W4UFnBR9Ovm8B+O9x8vletHW
         Pv6Cty5UwSunvsh570DtTnZ1qF3WlSUzpdU4IHLQl/s+oqdFmDd8Cmjm++G00v4dQXuc
         5VFvZSAHKafSBezsfjnqiSrIZcW7nVscMKob9uP3w5dZ+TFOEpotydolhgXl1H2QkUju
         kW/qDqfzYq+eWsSEwPn9MrwQEqeR6dCuNfVgv0hKbibAS7mvmoLpMVT91Qpv+5Tf1ZTh
         cFgJWCIx90pjB+IcPVEgYsvku3kisAgiYj4fUe+kuqaOqjPLau7STa4SXCJdFikgBebp
         f+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BT2QOIMMiRd97sr79EG5BlJTLFSRW5687kUKBi+G6so=;
        b=VIoYkXN9Mw78edAGcaTwUg5kt/Xi3eBFIaCXWkAwaklFPTvq28OO/mUikpNvDhlQRH
         NcpfHXQiRd5IACH5HohQ0VNY60hnjcprWC69hfWMSWm7JFOVq18sRShIqWUsKvt0Xsut
         3FQcbDRuRDFp2E/sjXNCE2lhRqpGoPAi6S/SID4dhC1k5nU2jaYbWmJ5D8w+W67rdEKM
         wPFmyiHqXIMy84UU78NvMkZeR7EiNrRojrVSkf+uE1D3z39VuGWAW5Q72ZzRNPMFKn4E
         yGH6pRo8kscMYKEVCRCc3ndFm1OvkaKxxxeTBf9tKXDIdZZ0aEA6P4sYGLlXG2QmJcEZ
         +13A==
X-Gm-Message-State: ABuFfoi2z1msuy6fqWU5F+HgelaIrOTgjzUFw4PLMjoEyPydXpW4T4NG
        X9hJWbkvIM1qgiCzMKvO21QLhnYc
X-Google-Smtp-Source: ACcGV60bq93sPA/7uLdt5UexChjmtfG9QMCQcndgbLU6+mDscBepUgiz7XuXTYtcO/ZWYthcxmFUAQ==
X-Received: by 2002:ac8:43c8:: with SMTP id w8-v6mr25641113qtn.370.1539782396013;
        Wed, 17 Oct 2018 06:19:56 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id p3-v6sm13448121qtp.55.2018.10.17.06.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 06:19:55 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:19:51 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181017131951.be7tooycf444443x@smtp.gmail.com>
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
 <20181016123541.GW31561@phenom.ffwll.local>
 <20181017124315.khhlykapxnug6ej6@smtp.gmail.com>
 <CAKMK7uF0ucof6gwAiY1SSp5oHt3BZ18Jkui5ugvkZc4u-NOJoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uF0ucof6gwAiY1SSp5oHt3BZ18Jkui5ugvkZc4u-NOJoA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17, Daniel Vetter wrote:
> On Wed, Oct 17, 2018 at 2:43 PM Rodrigo Siqueira
> <rodrigosiqueiramelo@gmail.com> wrote:
> >
> > Hi,
> >
> > First of all, thanks to all for the reviewers and feedbacks.
> >
> > On 10/16, Daniel Vetter wrote:
> > > On Mon, Oct 15, 2018 at 02:05:29PM -0300, Rodrigo Siqueira wrote:
> > > > For historical reason, the function drm_wait_vblank_ioctl always return
> > > > -EINVAL if something gets wrong. This scenario limits the flexibility
> > > > for the userspace make detailed verification of the problem and take
> > > > some action. In particular, the validation of “if (!dev->irq_enabled)”
> > > > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > > > support vblank or not. If the driver does not support VBlank, the
> > > > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > > > the real issue; this patch changes this behavior by return EOPNOTSUPP.
> > > > Additionally, some operations are unsupported by this function, and
> > > > returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> > > > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> > > > libdrm, which is used by many compositors; because of this, it is
> > > > important to check if this change breaks any compositor. In this sense,
> > > > the following projects were examined:
> > > >
> > > > * Drm-hwcomposer
> > > > * Kwin
> > > > * Sway
> > > > * Wlroots
> > > > * Wayland-core
> > > > * Weston
> > > > * Xorg (67 different drivers)
> > > >
> > > > For each repository the verification happened in three steps:
> > > >
> > > > * Update the main branch
> > > > * Look for any occurrence "drmWaitVBlank" with the command:
> > > >   git grep -n "drmWaitVBlank"
> > > > * Look in the git history of the project with the command:
> > > >   git log -SdrmWaitVBlank
> > > >
> > > > Finally, none of the above projects validate the use of EINVAL which
> > > > make safe, at least for these projects, to change the return values.
> > > >
> > > > Change since V1:
> > > >  Daniel Vetter and Chris Wilson
> > > >  - Replace ENOTTY by EOPNOTSUPP
> > > >  - Return EINVAL if the parameters are wrong
> > > >
> > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > >
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > >
> > > Can you pls also let intel-gfx-ci test this patch? You just need to
> > > include intel-gfx@lists.freedesktop.org in your recipient list.
> >
> > I did know about intel-gfx-ci, really nice:)
> >
> > Should I CC this mailing list if I send patches to the DRM core, amdgpu,
> > i915, vc4, vgem, and virtio-gpu? I suppose that IGT is running on the
> > CI, right?
> 
> It's only intel gpus (well and one special amd one) running igt on a
> _lot_ of different machines.
> 
> > Another question, do I need to send a V3 with intel-gfx-ci?
> 
> If the patch-set is unchanged people use the "FOR CI" subject prefix
> when resending, instead of incrementing the version number.

Ok, I will do it.
 
> > > For merging, since you plan to stick around doing kms stuff a bit: Want
> > > commit rights for drm-misc?
> > >
> > > https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html
> >
> > Yes, I want :)
> > I will need some guidance, in the beginning, to get confident about the
> > processes. If you can help me with this, I will be glad to play around
> > with 'dim' and the merging tasks.
> 
> Sure, just ping me on irc. First you need a freedesktop.org ssh account:
> 
> https://www.freedesktop.org/wiki/AccountRequests/
> 
> You need to request access to the drm-misc group. Once you have the
> bugzilla, pls ping me so I can ack it.

Ok, first I will carefully read the documentation. Next, I will
request the access. I will ping you on IRC after I get the account.

Thanks

> Thanks, Daniel
> 
> >
> > Best Regards
> >
> > > Cheers, Daniel
> > >
> > > > ---
> > > >  drivers/gpu/drm/drm_vblank.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > > > index 98e091175921..80f5a3bb427e 100644
> > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> > > >     unsigned int flags, pipe, high_pipe;
> > > >
> > > >     if (!dev->irq_enabled)
> > > > -           return -EINVAL;
> > > > +           return -EOPNOTSUPP;
> > > >
> > > >     if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > > > -           return -EINVAL;
> > > > +           return -EOPNOTSUPP;
> > > >
> > > >     if (vblwait->request.type &
> > > >         ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> > > > --
> > > > 2.19.1
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> >
> > --
> > Rodrigo Siqueira
> > https://siqueira.tech
> > https://twitter.com/siqueirajordao
> > Graduate Student
> > Department of Computer Science
> > University of São Paulo
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

-- 
Rodrigo Siqueira
https://siqueira.tech
https://twitter.com/siqueirajordao
Graduate Student
Department of Computer Science
University of São Paulo
