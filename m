Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88253C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED1C2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WciXZWxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED1C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeLACxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:53:20 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34909 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:53:20 -0500
Received: by mail-io1-f67.google.com with SMTP id u19so4888220ioc.2;
        Fri, 30 Nov 2018 07:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/glTwYkSSetiinNsajFZpYlnK/6XudvXxowqUR0Wgxo=;
        b=WciXZWxRrPSVxNoPV/82qVHfaJPMds4egtA4Ncjmd6BXsAsmUn0DGuXynpOjhzqxT4
         sAPrNmz7q7zh1rxENsVoNY/kUmRMfYCGGHTyvNxKnZEqA12+qLxvFKfxdwTAJDd4voKy
         ghIUGHtyAUn1i/wSpWYpzozqQhgM0cI3lBopcV6qonioprK6tICPNDWiFQh1Csr2YvFl
         RnLTd6CV6XTdBfp+nHGMB8I1GoiyVWL1cGfRbsnSwiBXQqI7VUlEPYH0hhRmSdz8ly/V
         05MSwATKFxJBZxb5ZX6hbTVlpk+5pWtfrL11CB3TdFItDKuPikg9N6ZLeU6yPDcIxMqO
         ZfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/glTwYkSSetiinNsajFZpYlnK/6XudvXxowqUR0Wgxo=;
        b=byN7vJxu/kn0obFCi5tmDXk88HvCB63Qu3cIk+k/C9R7orDFjdJUNIbVup/6FtEIB3
         gOiBpkbeWucyf2AL7TpgrzpoS5tUAAOCG40ZIVWVx+HEa7n6sRj4IIs4bcO/aQ07aXjb
         xkxAmSZFKy2iHAJNf2R7/PGrmi28IEwg9nqIRlL6Rvg1RFKPG4i+UlPEhyzNlSrbCEiy
         fgmORk3lwi//v/yDPutuN+jYsj4CNlcrds+LwS+PTF2kFgEXn5Gr65Mqv92tIkhTw1a4
         5CZrrJ/63yJrSxUYGr1C20S4uzw0wCBqr+f0J7PYHQTFcR3z9BiyvE9gFFanElE1G7xH
         /BVA==
X-Gm-Message-State: AA+aEWbbl4F/p0uTRDM4o1R9jDyHAvcA8p5ZKM5yYX4Xb7/FEDvzuOvm
        ixCRHmskPod3imbHrc4grZu1Mi+fDgFlxVQo+cA=
X-Google-Smtp-Source: AFSGD/VypKq1yEgdzwQamPoc3Y9TteY3IYyPCoHZA+q4JlSPOD3l21kRk0c9h0Ae7BiiEVoqJz9TicfAj6GSWdwCh1I=
X-Received: by 2002:a6b:9156:: with SMTP id t83mr5062700iod.248.1543592615272;
 Fri, 30 Nov 2018 07:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20181130150050.13762-1-robdclark@gmail.com> <20181130150050.13762-5-robdclark@gmail.com>
 <CAK8P3a07rtXfq1PApR7Nsa5mch9hcZHx3dT_u2y2ARuNpCUz9w@mail.gmail.com>
 <CAF6AEGu3fur-xuS28RmH_3Fqm+efp7KLS1P0DaBoNNMdUYJhiA@mail.gmail.com> <CAK8P3a2FZfVbGKEud+T54EUR0ZMKPeW9VzLmU2s97+TPQhroCg@mail.gmail.com>
In-Reply-To: <CAK8P3a2FZfVbGKEud+T54EUR0ZMKPeW9VzLmU2s97+TPQhroCg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 30 Nov 2018 10:43:23 -0500
Message-ID: <CAF6AEGsXYWHVpKTwqdfkF_bBU32A8G+a9NwHZOTa9fJX-GwK5w@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/msm: bump UAPI version
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:36 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Nov 30, 2018 at 4:31 PM Rob Clark <robdclark@gmail.com> wrote:
> >
> > On Fri, Nov 30, 2018 at 10:12 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Fri, Nov 30, 2018 at 4:02 PM Rob Clark <robdclark@gmail.com> wrote:
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/msm/msm_drv.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > > > index 6ebbd5010722..782cc33916d6 100644
> > > > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > > @@ -36,9 +36,11 @@
> > > >   * - 1.3.0 - adds GMEM_BASE + NR_RINGS params, SUBMITQUEUE_NEW +
> > > >   *           SUBMITQUEUE_CLOSE ioctls, and MSM_INFO_IOVA flag for
> > > >   *           MSM_GEM_INFO ioctl.
> > > > + * - 1.4.0 - softpin, MSM_RELOC_BO_DUMP, and GEM_INFO support to set/get
> > > > + *           GEM object's debug name
> > > >   */
> > > >  #define MSM_VERSION_MAJOR      1
> > > > -#define MSM_VERSION_MINOR      3
> > > > +#define MSM_VERSION_MINOR      4
> > > >  #define MSM_VERSION_PATCHLEVEL 0
> > > >
> > >
> > > I don't know the background here, but generally speaking we don't have
> > > version numbers for ioctls in kernel drivers. Instead, the old ioctls
> > > need to remain functional, but you can add new ioctl commands
> > > in addition.
> > >
> > > Is there something that makes this driver special?
> > >
> >
> > The version # indicates to userspace that some new features are
> > supported, so that new userspace on kernel can work.  For example, the
> > userspace side of setting a GEM obj debug name is:
>
> Ok, got it.
>
> > static void msm_bo_set_name(struct fd_bo *bo, const char *fmt, va_list ap)
> > {
> >     struct drm_msm_gem_info req = {
> >             .handle = bo->handle,
> >             .info = MSM_INFO_SET_NAME,
> >     };
> >     char buf[32];
> >     int sz;
> >
> >     /* bail if kernel doesn't support this: */
> >     if (bo->dev->version < FD_VERSION_SOFTPIN)
> >         return;
> >
> >     sz = vsnprintf(buf, sizeof(buf), fmt, ap);
> >
> >     req.value = VOID2U64(buf);
> >     req.len = MIN2(sz, sizeof(buf));
> >
> >     drmCommandWrite(bo->dev->fd, DRM_MSM_GEM_INFO, &req, sizeof(req));
> > }
>
> So that version check seems harmless, but also not necessary,
> at least in this case, right? I would assume that calling into
> drmCommandWrite() with an invalid command will only return
> an error, which then gets ignored, where with the check, we
> would skip the call, knowing that it wont't work.

In this case, yes, probably a better example would be v1.1.0 when
support for >4 cmd buffers was added.  For older kernels userspace has
to structure the cmdstream in a less efficient way to work around that
limitation.

I guess these are things where a dummy ioctl call to probe whether
kernel returns an error could be used.. but that gets awkward.

BR,
-R
