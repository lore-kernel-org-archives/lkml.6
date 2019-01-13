Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A57C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0A320663
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/Lk8Q/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfAMUX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:23:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46403 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfAMUX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:23:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id y20so24455492qtm.13;
        Sun, 13 Jan 2019 12:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4XD1SHDzYh2nQxz2nn4PAa18fCDeSDyXBRc9vRQvBAQ=;
        b=k/Lk8Q/8JjsjH3p8Fxc8tX8RzI50eWKPgDJfIZvVUd129ww8akm47XmBxUmkBCfiwx
         8Jjl7g2K61fQhE7QEqXLablu98ypEnVmZlqBa+ln36+fAto33Wxot0GC8+Fmw1uQeTjq
         2k0FkL+leynTm4zJH9zCUkMqnkjwH81/DoKzERMB3jaCqeUoMjT0jvPeJY0W1xYKhyjm
         unYhMsyg9x1ZKW9nK7OJ4OKsBGtKDmf05IlOe0YWeLMJKsS0sLe4DAgrrZUEK361O64Q
         gVYl1op3gVkscal/dL5x9+hflg7Iye4z4t8NG+XRLR7KXJbJBq2SMFj6pSHDVmWClXW5
         PniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4XD1SHDzYh2nQxz2nn4PAa18fCDeSDyXBRc9vRQvBAQ=;
        b=TQBSTZmfG7LeaIo08hTZG2d9ATcyqVySTn/qGOXJOp+X9hr2VU/c7We/NcHW3M2294
         YrbMkpPEX+NTAmS+irjFHJgAbYV7saJHD3LA0JVn4NikSoj2xQ7piPBcyhPyWZPhjj6c
         3lLvXNquOSKkoj46fvEoB6mx1h9IY1V/d/29lV0XVQIz4e8IicofQN4oiL6l+kRAWW6C
         EHEwGYu+luXz6AXTCC0wL1n405qQ+5s1ud7T29hkGD9y9BrJyh/t5wVFunLMxtVTNdjs
         llqrhKopAPetQi9vwIXQM1xPsiRYg0iAk3p8h+9C5EEvb39Nlj3+gj51Qc7fDZShjugs
         9kJQ==
X-Gm-Message-State: AJcUukdiSo/QzPdtvR42A5t/tRq6KZSoEba0Xq4/uc1lkBqz8++y8zkr
        w5wt04FuI5qi7Cyn7fdgYBw=
X-Google-Smtp-Source: ALg8bN5xiKulS30v/pgk6GeZp2qGSlsRw8jyk3gieNkrgRWDTXBup368k/NQSJH50480ANqaKGTy3A==
X-Received: by 2002:a0c:b517:: with SMTP id d23mr21935257qve.221.1547411007618;
        Sun, 13 Jan 2019 12:23:27 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id y68sm15516925qkd.49.2019.01.13.12.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 12:23:26 -0800 (PST)
Date:   Sun, 13 Jan 2019 18:23:23 -0200
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20190113202323.co7upmn5fg32b7gn@smtp.gmail.com>
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

Hi,

I resend this patch for CI via “intel-gfx@lists.freedesktop.org” as
Daniel suggested, and I got a feedback that reported an issue as can be
seen here:

   https://patchwork.freedesktop.org/series/51147/

After a careful analysis of what happened, I concluded that the problem
is related to the function “igt_wait_for_vblank_count()” in “igt_kms.c”.
This function has the following assert:

   igt_assert(drmWaitVBlank(drm_fd, &wait_vbl) == 0)

This function only checks if everything went well with the
drmWaitVBlank() operation and does not make any other validation. IMHO
the patch is correct, and the problem pointed out by CI is not related
to this change.

Make sense?

Best Regards

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
> 
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
> 
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
