Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F4720868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ83dZSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeLAClD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:41:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39935 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLAClD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:41:03 -0500
Received: by mail-io1-f66.google.com with SMTP id k7so4837365iob.6;
        Fri, 30 Nov 2018 07:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyKh+wdPHTGBKsPt4SwMuCL1IaBxH4urP0uqSkby65g=;
        b=TQ83dZSAF4ji1bqyZE6rog8icnvjjPPDPewv5VF3DEOD8xL2IHbUm10z3FZQWyKewD
         xA6HdXZbAmYnMwArsS3Nz+5JSmjmueFZTAAzLoIovu36gVFELyuSMjeLzWhwaOW6WgXS
         xfcDk+jS8HoPnGBWwdRjvrlTejsOC5wndLR9YzdlmWadYBvFQaG7iGhEpK4dd2ABzClO
         Zu9aC2vvnQ69G/35VonRX3gXmkCrdGSf660ro9WavSFRMbSvE7YEMNxycJgn+qjRPkzU
         XW0owpY/LNQiqJZcKEmclqa58fFEExJjk5CheQ14KijDDZv5EK7ddpW9+Dq8GFF+rMio
         UExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyKh+wdPHTGBKsPt4SwMuCL1IaBxH4urP0uqSkby65g=;
        b=MzLBESueaCs7KpLJKfG2hzj68WTUhJ6d1JLvPNGxVG7wEbrNwQLvNMOrNpeRrlMXL/
         aw7qae3If8LXMarvWdj0IKzomlupwmUE47VJ9vJwSkMNxW19yXvkTDqtqdffC+n9w13L
         SDJWBvwU6eroJjSMdNLoaQ3aBR2HJGPI0nbApoI+YTrURcgCVIMifJ9C4Nq/heASoZLq
         NhqNVb2MRhZurb62tMdpZ2BSBWcGe8KJzmXGI9yEzJL0AFIQGIN9/ACR609YFjWlcJH1
         EWEfI+TtFURIMm0S84aMqKQpU9e4nN0rkXDLiX4EMIEz/CvJLzJf8qMlZR2UonNneErH
         IauQ==
X-Gm-Message-State: AA+aEWaLg0eCZOexuevicIgdGzXZeZHTdNcwmLZVncCOzeGa7SRt78zk
        4glNEFYUdaNvkIfXjdMwc1AnJEtYCshGUHZEVEw=
X-Google-Smtp-Source: AFSGD/UrY+B6iOJBta5d52nfufrys3sNN35twK2ini1Ad8RcudHw9ZnXlDcb8qUg9A+CK6zbGnhTPUG/DNLiePoRU3M=
X-Received: by 2002:a6b:9156:: with SMTP id t83mr5024298iod.248.1543591880877;
 Fri, 30 Nov 2018 07:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20181130150050.13762-1-robdclark@gmail.com> <20181130150050.13762-5-robdclark@gmail.com>
 <CAK8P3a07rtXfq1PApR7Nsa5mch9hcZHx3dT_u2y2ARuNpCUz9w@mail.gmail.com>
In-Reply-To: <CAK8P3a07rtXfq1PApR7Nsa5mch9hcZHx3dT_u2y2ARuNpCUz9w@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 30 Nov 2018 10:31:09 -0500
Message-ID: <CAF6AEGu3fur-xuS28RmH_3Fqm+efp7KLS1P0DaBoNNMdUYJhiA@mail.gmail.com>
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

On Fri, Nov 30, 2018 at 10:12 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Nov 30, 2018 at 4:02 PM Rob Clark <robdclark@gmail.com> wrote:
> >
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/msm_drv.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index 6ebbd5010722..782cc33916d6 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -36,9 +36,11 @@
> >   * - 1.3.0 - adds GMEM_BASE + NR_RINGS params, SUBMITQUEUE_NEW +
> >   *           SUBMITQUEUE_CLOSE ioctls, and MSM_INFO_IOVA flag for
> >   *           MSM_GEM_INFO ioctl.
> > + * - 1.4.0 - softpin, MSM_RELOC_BO_DUMP, and GEM_INFO support to set/get
> > + *           GEM object's debug name
> >   */
> >  #define MSM_VERSION_MAJOR      1
> > -#define MSM_VERSION_MINOR      3
> > +#define MSM_VERSION_MINOR      4
> >  #define MSM_VERSION_PATCHLEVEL 0
> >
>
> I don't know the background here, but generally speaking we don't have
> version numbers for ioctls in kernel drivers. Instead, the old ioctls
> need to remain functional, but you can add new ioctl commands
> in addition.
>
> Is there something that makes this driver special?
>

The version # indicates to userspace that some new features are
supported, so that new userspace on kernel can work.  For example, the
userspace side of setting a GEM obj debug name is:


static void msm_bo_set_name(struct fd_bo *bo, const char *fmt, va_list ap)
{
    struct drm_msm_gem_info req = {
            .handle = bo->handle,
            .info = MSM_INFO_SET_NAME,
    };
    char buf[32];
    int sz;

    /* bail if kernel doesn't support this: */
    if (bo->dev->version < FD_VERSION_SOFTPIN)
        return;

    sz = vsnprintf(buf, sizeof(buf), fmt, ap);

    req.value = VOID2U64(buf);
    req.len = MIN2(sz, sizeof(buf));

    drmCommandWrite(bo->dev->fd, DRM_MSM_GEM_INFO, &req, sizeof(req));
}


(The old userspace on new kernel case is handled by zero padding in drm_ioctl())


BR,
-R
