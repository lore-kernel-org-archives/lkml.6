Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB6320858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml70Wpcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB6320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeJIAE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:04:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38343 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIAE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:04:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so21645546qtf.5;
        Mon, 08 Oct 2018 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dnO+Xz7FHHsZ8eMV5d3e7ehUtNddWjhrLFawrGafuF0=;
        b=Ml70WpcySuCI9KZk2Ci6Yssj8Edsh3/QZlqdCTIFmN9sQ/LK6PLjyF7yuf9/MxLGbD
         tEaNq31/xMkupA0FbeMIaqUk1AV+FuKVO/anZ4T2umi8eIJ7kdaaJv9YvUm1Mc7QKSD8
         L11y1RO/Abhdla/dXp+FajRAlHeygegVc4im4R5yb7xjdjLTQT9RgwbC7MomXXc4cqre
         G847nN6d4FfyZJb1r/Qdb0rYksZ1ABJGn21PXLVtBUfgpWBie0DfLteTie4UrRGIKxpK
         lO9uGUdNk8tvDmlQWKYN8qNp/4gsDymyABX1/cqgwf+2Rp+XjgR6ImkhRNDAYYg7Nv3u
         gdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dnO+Xz7FHHsZ8eMV5d3e7ehUtNddWjhrLFawrGafuF0=;
        b=TAfy1Bku/JSvZniaC7+FL9LwbhJsiVcy94xyJZvXOEp0P/A/mnr3ipz1jNR1yvBiSX
         o/jp4GARo4DvH1SNIQo85NF9Wwz8uAPMEhS7xS+p0QSJjnm3IWaAUXx+hIWgh6nmcaGe
         6tPwOSN4PsdC/voa00n1m8aD/0KZHpfgaO3oZCCE4go9h2vHCV1x0liejmvSJeS9VunI
         4J5W4Nq6MaqUrREARLJG8PgN5AhnLXdmOOEJg/pNSZsoVNYiulTP1WgeY7WLN07M9Dwa
         re3G8SUmpTjO0H4yxiaqImvtU+cOSmozs+ynL9yZY7FBp88olcvf7GaNpQUFnjg9Dymf
         bhfw==
X-Gm-Message-State: ABuFfojCwrKAeBd1QcxNvkuSfHquAzFhQJkfEJlndqUJ8QCOJnFuzLes
        eERog9b+v/VSdXm8e6Df+bQ=
X-Google-Smtp-Source: ACcGV62ej/qdoFd0Wp92b9UX9qAyb2BX6nuI5rPmTeKgONW0BBCZWXqX8TfER0mqZ/jsDevcN6pXTw==
X-Received: by 2002:a0c:c686:: with SMTP id d6-v6mr19237421qvj.147.1539017538102;
        Mon, 08 Oct 2018 09:52:18 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s90-v6sm10289188qks.80.2018.10.08.09.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 09:52:17 -0700 (PDT)
Date:   Mon, 8 Oct 2018 13:52:13 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20181008165213.vejfqe6ohiejeeq2@smtp.gmail.com>
References: <20181008145220.p34dllgsiw6rlpod@smtp.gmail.com>
 <153901080237.31254.10116385737520796385@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <153901080237.31254.10116385737520796385@skylake-alporthouse-com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08, Chris Wilson wrote:
> Quoting Rodrigo Siqueira (2018-10-08 15:52:20)
> > For historical reason, the function drm_wait_vblank_ioctl always return
> > -EINVAL if something gets wrong. This scenario limits the flexibility
> > for the userspace make detailed verification of the problem and take
> > some action. In particular, the validation of “if (!dev->irq_enabled)”
> > in the drm_wait_vblank_ioctl is responsible for checking if the driver
> > support vblank or not. If the driver does not support VBlank, the
> > function drm_wait_vblank_ioctl returns EINVAL which does not represent
> > the real issue; this patch changes this behavior by return ENOTTY
> > (Inappropriate ioctl for device). Additionally, some operations are
> > unsupported by this function, and returns EINVAL; this patch changes the
> > return value to EOPNOTSUPP (Operation not supported). Lastly, the
> > function drm_wait_vblank_ioctl is invoked by libdrm, which is used by
> > many compositors; because of this, it is important to check if this
> > change breaks any compositor. In this sense, the following projects were
> > examined:
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
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_vblank.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> > index 98e091175921..88ec6fb49afb 100644
> > --- a/drivers/gpu/drm/drm_vblank.c
> > +++ b/drivers/gpu/drm/drm_vblank.c
> > @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> >         unsigned int flags, pipe, high_pipe;
> >  
> >         if (!dev->irq_enabled)
> > -               return -EINVAL;
> > +               return -ENOTTY;
> 
> Arguable.

Hi Chris, thanks for your review :)

Originally, I noticed that DRM does not provide a mechanism for checking
if VBlank is supported or not by the driver. IMHO return ENOTTY can be
useful for virtual drivers and some specific devices; the userspace can
take this information and infer some information about the device,
consequently, handling different scenarios. This issue was raised when I
was working to implement the virtual mode in the VKMS (no vblank) and
tried to patch IGT to handle modules that do not support Vblank.
Finally, I believe that  ENOTTY precisely describes the condition
"if (!dev->irq_enabled)". Make sense?

> >  
> >         if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > -               return -EINVAL;
> 
> User error -> einval.

Here, my primary motivation to add EOPNOTSUPP came from the comment in
_DRM_VBLANK_SIGNAL, which says:

_DRM_VBLANK_SIGNAL = 0x40000000 /**< Send signal instead of blocking, unsupported */

Then I thought that EOPNOTSUPP could better describe this situation.
 
> > +               return -EOPNOTSUPP;
> >  
> >         if (vblwait->request.type &
> >             ~(_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> > @@ -1545,7 +1545,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
> >                           vblwait->request.type,
> >                           (_DRM_VBLANK_TYPES_MASK | _DRM_VBLANK_FLAGS_MASK |
> >                            _DRM_VBLANK_HIGH_CRTC_MASK));
> > -               return -EINVAL;
> > +               return -EOPNOTSUPP;
> 
> User error -> einval.

About this one, you are right. Sorry, I misunderstood that part of the
code.

Thanks again.

> -Chris
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Rodrigo Siqueira
http://siqueira.tech
Graduate Student
Department of Computer Science
University of São Paulo
