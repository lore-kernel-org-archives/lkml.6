Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FC0C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7704120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmCLpcgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7704120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeLACiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:38:25 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53132 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLACiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:38:25 -0500
Received: by mail-it1-f196.google.com with SMTP id i7so9668817iti.2;
        Fri, 30 Nov 2018 07:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VHtoCl5ePpmDOnLuoo5ijHjoE4klL5JGfSx9dGl6V4=;
        b=QmCLpcgD3FNeyQr6vnB6jVqfjiUV885LtEVDGPummIkCoRDE8sJoBBjepMuXSMbWrI
         uJtYh908oYnNSrXy6cT4noUZG6T8eq2OOr+phdUV8em+xkBPUqzDaRNdTEh5BoGv0+ow
         Gd93qghsm6bz6DP27/83MadI2DBx92xi98Y7g+sQqK8D7NFN95vUDh1fYbqZyhn2fl5e
         L+Gd0kuKrOnoUqqLQITAHpGfhkOi47jx4cs1207Mde6jGUo61eVYtxcP0LQzA+zf8pO1
         l4RM93grKcw8dAegFG/EN2wasWnv9ykFiukSKsX8h5olN33dYyyY14hDRv4+nJoGVXRg
         NpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VHtoCl5ePpmDOnLuoo5ijHjoE4klL5JGfSx9dGl6V4=;
        b=eAlft6lHjEDCUNZe8xscphMk8qGWhHQrrkDzkT79t8lcsGKMFU2sEfGEMvmbi5bFR/
         MxdDqPKnKmDV95E+WbUgsBfYuP8S6LTFAYiTZP5j9JU2aIH795NRXV6xp9Hj/7ZYVZKz
         EuKc8Z4Szhpw2kHpP8ADHMM021CoMqrbWSBJ3LwArt6/Qg3K3oRUt2aMc0/N/FUxXC41
         ufjiL4bdZ8UJyzPEoach3rL8d6CDEraXuvct6lArgfcrqg4Z/HIBDoRNdae0d3isWSaP
         z4PXfDLtXcGRG+K5JEnfkaOVgkKZ7/HNI+S2UifwlrP/TSYjM5I+D37Gh7akzO/rcnMZ
         u3mg==
X-Gm-Message-State: AA+aEWaxN0BmGCLcDzVn4dUfqFUgHNwyxJCwD6+Wj9b0wCGwpUP+Tp2y
        36bplGWKjdWlPC8vAbyZqvSQhpmEn4CVE7j6Wmw=
X-Google-Smtp-Source: AFSGD/Wr3X1VXNUtVtOcjJDCwDVKr782xtfFFN6qC5SuWWZysUrwr634GPZZgeO0RHy9SUfrdRJgPxO9KQ8j7H55vjk=
X-Received: by 2002:a24:3dd5:: with SMTP id n204mr5976307itn.104.1543591723578;
 Fri, 30 Nov 2018 07:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20181130150050.13762-1-robdclark@gmail.com> <20181130150050.13762-3-robdclark@gmail.com>
 <CAK8P3a2ePkk21bz=N=97aMGJVoxSu-cULjLZbf03W4jhSQAGJA@mail.gmail.com>
In-Reply-To: <CAK8P3a2ePkk21bz=N=97aMGJVoxSu-cULjLZbf03W4jhSQAGJA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 30 Nov 2018 10:28:30 -0500
Message-ID: <CAF6AEGt8ziZ3tHG9A-xg3_yK_ssOmVWM56zHiUs2pvQJvVYmzQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/msm: rework GEM_INFO ioctl
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

On Fri, Nov 30, 2018 at 10:14 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Nov 30, 2018 at 4:02 PM Rob Clark <robdclark@gmail.com> wrote:
> >
>
> > -
> > -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> > +/* Get or set GEM buffer info.  The requested value can be passed
> > + * directly in 'value', or for data larger than 64b 'value' is a
> > + * pointer to userspace buffer, with 'len' specifying the number of
> > + * bytes copied into that buffer.  For info returned by pointer,
> > + * calling the GEM_INFO ioctl with null 'value' will return the
> > + * required buffer size in 'len'
> > + */
> > +#define MSM_INFO_GET_OFFSET    0x00   /* get mmap() offset, returned by value */
> > +#define MSM_INFO_GET_IOVA      0x01   /* get iova, returned by value */
> >
> >  struct drm_msm_gem_info {
> >         __u32 handle;         /* in */
> > -       __u32 flags;          /* in - combination of MSM_INFO_* flags */
> > -       __u64 offset;         /* out, mmap() offset or iova */
> > +       __u32 info;           /* in - one of MSM_INFO_* */
> > +       __u64 value;          /* in or out */
> > +       __u32 len;            /* in or out */
> >  };
>
> As structure with implicit padding has the problem of possibly leaking
> kernel stack data. It's better to make the padding explicit here so you
> can zero it from the kernel. Also, as I mentioned in the other patch,
> you probably need a new data structure and ioctl command number
> to keep compatiblity with the old interface.

hmm, right, pad field is a good idea.  As far as compat, drm_ioctl()
handles zero-padding so adding new ioctl struct members at the end is
safe (as long as a zero value somehow results in previous behavior)

BR,
-R

>
>      Arnd
