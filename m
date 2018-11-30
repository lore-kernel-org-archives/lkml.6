Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B7AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9BA20660
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQmAn+Ol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9BA20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeLAJOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:14:35 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33534 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAJOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:14:35 -0500
Received: by mail-yw1-f65.google.com with SMTP id q11so2937294ywa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIk7hkepN16ir1ITbx9n5ZX7QsxaEsJlsBiovyksU/4=;
        b=ZQmAn+Ol7rR5JS2y3YKXQBXoNrTblesmTaPpPnckaUomIzzt2U5N81aDVFUQj048/0
         kU7hXy3KKaGwLIuLvJgitFc7vb+7BqTAHSzUmcVnKF9ptzPxdwkaV4B9Zpx3uQd2UCFP
         mlSU1+CX0yvBPpoqkN+EEmxNhT/bYVok1tJ5eCsmYx4+VmcITz3G8zjVZfR/04MbUV9B
         hpgms+2RXPSIc5ToWII9Ubre0SfxUiXdDQmXfkdGkKOV88izM+PGLwvBykawMYBRAtPM
         D53Ahf+ts3DHrVwWoobFAL/4OzEEeoLmbnpkP5knVCFmZ3hrc0hr7S4unXP5ZosYBGUP
         VLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIk7hkepN16ir1ITbx9n5ZX7QsxaEsJlsBiovyksU/4=;
        b=AUkdo59QmaRGhiBQd1JlNMJll3Y2wQl0lICHq/CMUQxqHBe49QnugVZFLus4UXTW2l
         d/p1A3M03iyekuGJzdqPS28hU585Gr+Tk0LzHVYoNWQ45VcSdv5BR9OtUIHKprFtwSw/
         FliLUT8/1Uj19miT+oz25XBxDcoyMsKQXIQjd+FMGIHp8mED5OnMuSTDZOJ6ihnycCgA
         eB3n4WnOn7KFKSBydegseEzPWVyYjkh+DfWrhxRQfWltv/oeN3LPjc8sE1yrCm7p9sDh
         v04+1ibDUr4xEc4PSiVQTFTYH+SfB7F07urE5BoJM82MmAnC/Dbb+tHYhtY69LWqTNfQ
         MeKQ==
X-Gm-Message-State: AA+aEWbpgSN5F3wYOoUQMI/ODzziUwKdkl+yLRtpmGVdEYGvby7cvMze
        e+fy6yuijMoH6ichWW4XrwEYkFy51Vu/nCv/hDmByw==
X-Google-Smtp-Source: AFSGD/XXlcEw+Jt6vhgQ8pEE3eXnIAg0LInIjEtFycMKJq5cYt6DXX6JcBBs2VSVuoZ3KNw7TrzFCK9Q2bR0hdFyDK8=
X-Received: by 2002:a0d:ea16:: with SMTP id t22mr7506407ywe.341.1543615430638;
 Fri, 30 Nov 2018 14:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com>
 <20181130192737.15053-4-jarkko.sakkinen@linux.intel.com> <CA+ToGPHBNg7k3uT8yrgWuPgD113Sd44TZamYd7j=f_X2idej6Q@mail.gmail.com>
 <20181130212640.GA23772@linux.intel.com>
In-Reply-To: <20181130212640.GA23772@linux.intel.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Fri, 30 Nov 2018 20:03:37 -0200
Message-ID: <CA+ToGPEaxYxuzB__SM77J_8596u8Q+wa4uqfDn+LbwmL_NsOhA@mail.gmail.com>
Subject: Re: [PATCH RFC 03/15] drm/nouveau: replace **** with a hug
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, bskeggs@redhat.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 7:26 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, Nov 30, 2018 at 06:13:50PM -0200, Diego Viola wrote:
> > On Fri, Nov 30, 2018 at 5:30 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > In order to comply with the CoC, replace **** with a hug.
> > >
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > ---
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c        | 2 +-
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> > > index 9cc10e438b3d..55a0060881ea 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> > > @@ -446,7 +446,7 @@ init_ram_restrict(struct nvbios_init *init)
> > >  {
> > >         /* This appears to be the behaviour of the VBIOS parser, and *is*
> > >          * important to cache the NV_PEXTDEV_BOOT0 on later chipsets to
> > > -        * avoid fucking up the memory controller (somehow) by reading it
> > > +        * avoid hugging up the memory controller (somehow) by reading it
> > >          * on every INIT_RAM_RESTRICT_ZM_GROUP opcode.
> > >          *
> > >          * Preserving the non-caching behaviour on earlier chipsets just
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> > > index 3737bd27f74e..ee364c71cc2e 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> > > @@ -46,7 +46,7 @@
> > >  #define NV_PPWR_INTR_EN_SET_SUBINTR                                  0x00000800
> > >  #define NV_PPWR_INTR_EN_SET_WATCHDOG                                 0x00000002
> > >  #define NV_PPWR_INTR_EN_CLR                                              0x0014
> > > -#define NV_PPWR_INTR_EN_CLR_MASK                    /* fuck i hate envyas */ -1
> > > +#define NV_PPWR_INTR_EN_CLR_MASK                    /* hug i hate envyas */ -1
> >
> > Can you also capitalize the "i" please?
>
> Yeah, maybe I just change it as "/* I hate envyas */"?
>
> /Jarkko

Yes, that looks better.

Thanks,
Diego
