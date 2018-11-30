Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F191BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F4720834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F4720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeLACqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:46:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45739 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeLACqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:46:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so6289908qtr.12;
        Fri, 30 Nov 2018 07:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4i/GPNuhGxCoeSxp7OEeQX2RffUcF6hqg9S/Lw8mn0o=;
        b=UuWpIUZMSvVoDmwJpB8rYjZl+d+VLMY6T+8NodWltnNI9nsZvOE9O+crL3qCuJ678c
         rqYsy+aBC2Wr20zykq3HwJlMPuK3BjzTrMRiqXejDowGeqngIzyorx+KhRe/izYBf2su
         h0WxVv58cxD5+5mH49LJrXFJOvv4TAppAmJiC4gp+dmDMlExEgdVRbik+wPmNhMnUfhz
         25Z7c97lnIWjEpxfKs9F132o+AQy1DvGeAMbBiPA+TOjZbvx+bc4ku5FASyH84jp3S66
         EqWNcDLZlqlHeYH8N6rMK/8pCy7Q3nb7Ihn876DlAE792R8sRY+vGr2tyf3Ax60RSZbi
         LFsQ==
X-Gm-Message-State: AA+aEWYLszJcjQXxVHDFlyDtkhbYmWSMqbO/VgxPoqwEGRSEE/G1MirR
        hLvgIqRhVbPzkN16yQui+N/Ggtdee+JgUcPg8VO/SLJ8
X-Google-Smtp-Source: AFSGD/VKDChSGrY4IoVru1UAKBXzJklMKG4jLB9P85DtrRyb31XQIUxuaQS/qLJJ95bfw+52T9myOOA2czdqbkeZqU0=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr5819155qtr.319.1543592185283;
 Fri, 30 Nov 2018 07:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20181130150050.13762-1-robdclark@gmail.com> <20181130150050.13762-5-robdclark@gmail.com>
 <CAK8P3a07rtXfq1PApR7Nsa5mch9hcZHx3dT_u2y2ARuNpCUz9w@mail.gmail.com> <CAF6AEGu3fur-xuS28RmH_3Fqm+efp7KLS1P0DaBoNNMdUYJhiA@mail.gmail.com>
In-Reply-To: <CAF6AEGu3fur-xuS28RmH_3Fqm+efp7KLS1P0DaBoNNMdUYJhiA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Nov 2018 16:36:07 +0100
Message-ID: <CAK8P3a2FZfVbGKEud+T54EUR0ZMKPeW9VzLmU2s97+TPQhroCg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/msm: bump UAPI version
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 4:31 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Fri, Nov 30, 2018 at 10:12 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Nov 30, 2018 at 4:02 PM Rob Clark <robdclark@gmail.com> wrote:
> > >
> > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > ---
> > >  drivers/gpu/drm/msm/msm_drv.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > > index 6ebbd5010722..782cc33916d6 100644
> > > --- a/drivers/gpu/drm/msm/msm_drv.c
> > > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > > @@ -36,9 +36,11 @@
> > >   * - 1.3.0 - adds GMEM_BASE + NR_RINGS params, SUBMITQUEUE_NEW +
> > >   *           SUBMITQUEUE_CLOSE ioctls, and MSM_INFO_IOVA flag for
> > >   *           MSM_GEM_INFO ioctl.
> > > + * - 1.4.0 - softpin, MSM_RELOC_BO_DUMP, and GEM_INFO support to set/get
> > > + *           GEM object's debug name
> > >   */
> > >  #define MSM_VERSION_MAJOR      1
> > > -#define MSM_VERSION_MINOR      3
> > > +#define MSM_VERSION_MINOR      4
> > >  #define MSM_VERSION_PATCHLEVEL 0
> > >
> >
> > I don't know the background here, but generally speaking we don't have
> > version numbers for ioctls in kernel drivers. Instead, the old ioctls
> > need to remain functional, but you can add new ioctl commands
> > in addition.
> >
> > Is there something that makes this driver special?
> >
>
> The version # indicates to userspace that some new features are
> supported, so that new userspace on kernel can work.  For example, the
> userspace side of setting a GEM obj debug name is:

Ok, got it.

> static void msm_bo_set_name(struct fd_bo *bo, const char *fmt, va_list ap)
> {
>     struct drm_msm_gem_info req = {
>             .handle = bo->handle,
>             .info = MSM_INFO_SET_NAME,
>     };
>     char buf[32];
>     int sz;
>
>     /* bail if kernel doesn't support this: */
>     if (bo->dev->version < FD_VERSION_SOFTPIN)
>         return;
>
>     sz = vsnprintf(buf, sizeof(buf), fmt, ap);
>
>     req.value = VOID2U64(buf);
>     req.len = MIN2(sz, sizeof(buf));
>
>     drmCommandWrite(bo->dev->fd, DRM_MSM_GEM_INFO, &req, sizeof(req));
> }

So that version check seems harmless, but also not necessary,
at least in this case, right? I would assume that calling into
drmCommandWrite() with an invalid command will only return
an error, which then gets ignored, where with the check, we
would skip the call, knowing that it wont't work.

      Arnd
