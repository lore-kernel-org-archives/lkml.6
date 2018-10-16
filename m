Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02D2C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A71C2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="NIXsMjoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A71C2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeJQBpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:45:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41630 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeJQBpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:45:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id l41-v6so26760827qtl.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6jbX9SMoH/ZlXoUdvLHsqUIWxy8e5wiSEb1rP1JCA9g=;
        b=NIXsMjohFTQEMNZtOCfH/UbjhvOg/QFKwCKF7BsaroFbJj5URU99eenmxwWbihOC9m
         GS65n0eP/2pyNClC6Av2NlMzmbysSQ24vlnkzYsv1W/nfsFWCwBtHcWkgFH2fU6nI/e8
         4tG1+gFpr8qD7p6/ol7PDr3pUtBKEf/FBeNcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6jbX9SMoH/ZlXoUdvLHsqUIWxy8e5wiSEb1rP1JCA9g=;
        b=FHO88Qxmmw9f+pTClb06SUGSqNsNJNSIDBWiAWJJGacGtqdDXB/uzlpB9ODEx0S7Dz
         hDOjPGBqlriZfsIzoISul3b0Msy10xS/ElJqFayy4WEOrJY5ST+M4RSHcxu+h9gXpgTE
         Qrdco4RR9pLxLDjEsX6cfrDla/yzG2K876mJBdevaPXlBqv1KbgLLgC0vFTEH2xkNltJ
         dT5a8mzgt35GmHGtSNe9LbhAOlbSpWJdJ4UjudrFK8D1SwyXFN8CPKdNgQeaKgGeDyMZ
         wR3zXxBHFH5sH+KMEry0pcrpal+3rJW300m71MbuDmJyyGQGfwO2Mw/W2uv2tM6UFWpl
         wyMg==
X-Gm-Message-State: ABuFfog4yzdIBnGzBocQ73umiaV/3FXjLFXFE8fodt7yloR+2s8F6CJE
        qB95prvCS6wfQORmhjWNzJZVF3NVaScQAsZo9O3fEQ==
X-Google-Smtp-Source: ACcGV60FLBktLtcAkUA0E5IqCykG4QT/ssNoV56Yn+SV8+8FXCgjMSTzNJlJmePvqH2noDm8Qm4ez10gW58C8j4lA3w=
X-Received: by 2002:a05:6214:188:: with SMTP id q8mr10050688qvr.227.1539712447987;
 Tue, 16 Oct 2018 10:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
 <57b40f9f-24d2-27de-4895-5a76ff267643@linux.intel.com> <20181016163831.GA31561@phenom.ffwll.local>
 <20181016172803.GH9144@intel.com>
In-Reply-To: <20181016172803.GH9144@intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 16 Oct 2018 19:53:56 +0200
Message-ID: <CAKMK7uEYM2nfPV5NmcxD12oVEWLmTd0-4Ox+A570SGRVULFAmw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
To:     "Syrjala, Ville" <ville.syrjala@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 7:28 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Oct 16, 2018 at 06:38:31PM +0200, Daniel Vetter wrote:
> > On Tue, Oct 16, 2018 at 03:36:20PM +0200, Maarten Lankhorst wrote:
> > > Op 15-10-18 om 19:05 schreef Rodrigo Siqueira:
> > > > For historical reason, the function drm_wait_vblank_ioctl always re=
turn
> > > > -EINVAL if something gets wrong. This scenario limits the flexibili=
ty
> > > > for the userspace make detailed verification of the problem and tak=
e
> > > > some action. In particular, the validation of =E2=80=9Cif (!dev->ir=
q_enabled)=E2=80=9D
> > > > in the drm_wait_vblank_ioctl is responsible for checking if the dri=
ver
> > > > support vblank or not. If the driver does not support VBlank, the
> > > > function drm_wait_vblank_ioctl returns EINVAL which does not repres=
ent
> > > > the real issue; this patch changes this behavior by return EOPNOTSU=
PP.
> > > > Additionally, some operations are unsupported by this function, and
> > > > returns EINVAL; this patch also changes the return value to EOPNOTS=
UPP
> > > > in this case. Lastly, the function drm_wait_vblank_ioctl is invoked=
 by
> > > > libdrm, which is used by many compositors; because of this, it is
> > > > important to check if this change breaks any compositor. In this se=
nse,
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
> > > > Finally, none of the above projects validate the use of EINVAL whic=
h
> > > > make safe, at least for these projects, to change the return values=
.
> > > >
> > > > Change since V1:
> > > >  Daniel Vetter and Chris Wilson
> > > >  - Replace ENOTTY by EOPNOTSUPP
> > > >  - Return EINVAL if the parameters are wrong
> > > >
> > > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_vblank.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vbl=
ank.c
> > > > index 98e091175921..80f5a3bb427e 100644
> > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > @@ -1533,10 +1533,10 @@ int drm_wait_vblank_ioctl(struct drm_device=
 *dev, void *data,
> > > >   unsigned int flags, pipe, high_pipe;
> > > >
> > > >   if (!dev->irq_enabled)
> > > > -         return -EINVAL;
> > > > +         return -EOPNOTSUPP;
> > > Change to -EIO?
> > >
> > > If userspace would ever print this out, it would print the following
> > > confusing message to userspace:
> > > "Operation not supported on transport endpoint"
> >
> > You're a bit late, EOPNOTSUPP is not established already in upstream fo=
r
> > this. And -EIO is taken already for "the gpu is dead".
> >
> > > >
> > > >   if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
> > > > -         return -EINVAL;
> > > > +         return -EOPNOTSUPP;
> > > I would keep this -EINVAL, tbh and making it part of the below if sta=
tement..
> >
> > We discussed this, it's different: This here is an ioctl flag that's no
> > longer supported, the below is just an invalid request. Hence different
> > errno.
> >
> > I think you missed a bit with your bikeshed :-)
>
> I think I too agree with the -EINVAL here as this flag is never
> supported, whereas -EOPNOTSUPP seems to mean "this flag is still
> valid, but not supported by your current hardware/driver
> configuration".

Michel D=C3=A4nzer claims this was support way back in 2.6.29 or so :-)

> Also drm_invalid_op() uses -EINVAL for deprecated features as well.

Should probably adjust that too. The entire EOPNOTSUPP color choice is
very brand new ...
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
