Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0FFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C4920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fnQwowEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C4920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbeKFXZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:25:24 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41931 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388048AbeKFXZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:25:24 -0500
Received: by mail-io1-f65.google.com with SMTP id a5-v6so9264009ioq.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Wj7IXn/A5LLYERFQY9zRIKBiWloSmO1Zg7RiX2waps=;
        b=fnQwowEVZXpOci1SVgWdABTPVnuacNE1bKRmBg6Jes5Oc/hMKiuLNCbl5AV/TowJfP
         ucGWB63wN1DUQM0elPFAd5ifQW3438e+zj3ur3UtXqPzqZ0npCqz4Ykb1kzWd3fomlE2
         Ei6WyA3dnuX1G/plQ2L9JhLVnBTMmwDxwVoi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Wj7IXn/A5LLYERFQY9zRIKBiWloSmO1Zg7RiX2waps=;
        b=IBzmOI2GX5EivxdD5ulKkKkjoxpqkHQ/4SBoI3y2eTFfvvK2WDT8gcc687kfDWazKb
         88Sa4wr87KJ+lkur2gt2urlXB0/tDxSyjae7U8zsCn5+vZA6rxYomod0f64Uw58V4AOJ
         Yg9/a1RKturu0uTUEfEpfLCRxm0DH85RUryUNDPTYpwRjb3TajbDqTVNns/M4uUAugOz
         YGtZJMPxvqjaNU0e6BTEnwIrezWDMc8q+F0W/GsqBO+aQgV7MoTAy55JB9XJWvVRZhP3
         eGcEICQ9iB+j3ctH7sd8alNE0xDizGZyAXoo/VVqXqdO2vjmHKlNA+rM9UFz26LwkPr/
         Kbkw==
X-Gm-Message-State: AGRZ1gI9iraQU45LcJdTyMdIahLTmdMBrEnNqbeakAIX5tAyCQbz7e+z
        19hdgo58w23HSlfG+yoGAQzjJkEhqGfq20zxCRWUeA==
X-Google-Smtp-Source: AJdET5ccm8tOu/jgYgz6oQOn8CLyT3/0ZOkyXPysPM0vcWlfkTdvIkAnc6grcHMz+sSX5Zhn+4APhhSPhkmhPUOctm0=
X-Received: by 2002:a5e:d510:: with SMTP id e16-v6mr8058008iom.291.1541512801088;
 Tue, 06 Nov 2018 06:00:01 -0800 (PST)
MIME-Version: 1.0
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com>
 <20181106111310.GP21967@phenom.ffwll.local> <c991c4cc-317c-19e7-a106-ce675f239559@baylibre.com>
In-Reply-To: <c991c4cc-317c-19e7-a106-ce675f239559@baylibre.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 6 Nov 2018 14:59:49 +0100
Message-ID: <CAKMK7uG5rYM6BFmx1VOVV4nve9fu8fgg06owjxS8etvQezd+MQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/meson: Add support for Overlay and OSD Plane scaling
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 2:37 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Daniel,
>
> On 06/11/2018 12:13, Daniel Vetter wrote:
> > On Tue, Nov 06, 2018 at 10:39:59AM +0100, Neil Armstrong wrote:
> >> This serie adds support for :
> >> - Overlay Plane blended with the primary plane, we can describe as "behind"
> >> - Primary Plane up-scaling up to 5x factor to support the OSD plane being
> >>   upscaled from 1920x1080 when the display mode is set as 3840x2160.
> >>
> >> These patches depends on the "drm/meson: Allow using optional canvas provider"
> >> patchset from Maxime Jourdan at [1]
> >>
> >> [1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=38355
> >>
> >> Neil Armstrong (3):
> >>   drm/meson: Support Overlay plane for video rendering
> >>   drm/meson: move OSD scaler management into plane atomic update
> >>   drm/meson: Add primary plane scaling
> >
> > Got bored, read a bit your patch series. Two things I've noticed:
>
> Great you got bored today !
>
> > - We need to drop the crtc_state argument from
> >   drm_atomic_helper_check_plane_state(), some drivers (not meson) do
> >   really funny stuff with this.
>
> Should drm_atomic_get_crtc_state() be integrated into drm_atomic_helper_check_plane_state() ?

Yeah. But I think I'll bake that into a nice todo.rst task for the
next intern. It's kinda the perfect task, including some cleanup in
armada and a bit of wtf in hdlcd.

> > - I think your osd1_commit = true update is racy with the interrupt
> >   handler checking it. Needs at least a few memory barriers. Since helpers
> >   guarantee that you can't overtake a preceending update (you do the
> >   vblank handling after the updating) that should be ok, except you arm
> >   the vblank before setting up registers, so this might race too.
>
> Yeah, I need to do a cleanup of this at some point...

Usually we solved this by wrapping everything (i.e. from atomic_begin
to atomic_flush) under a commit spinlock. Same with the entire
interrupt handler. You can do more complicated ofc, but this tends to
get the job done and very obviously avoids all the races. Also as long
as you don't have any register writes in there it should be fast
enough. If not, prepare all the register data as a separate allocation
and then just exchange the pointers.
-Daniel

>
> >
> > Anyway all unrelated, so feel free to smash an
> >
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> > on the entire series.
>
> thanks !
>
> Will push to drm-misc-next once the branch is ready.
>
> Neil
>
> >
> > Cheers, Daniel
> >
> >>
> >>  drivers/gpu/drm/meson/Makefile          |   2 +-
> >>  drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
> >>  drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
> >>  drivers/gpu/drm/meson/meson_crtc.c      | 251 +++++++++++++-
> >>  drivers/gpu/drm/meson/meson_drv.c       |  29 +-
> >>  drivers/gpu/drm/meson/meson_drv.h       |  62 ++++
> >>  drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
> >>  drivers/gpu/drm/meson/meson_overlay.h   |  14 +
> >>  drivers/gpu/drm/meson/meson_plane.c     | 177 ++++++++--
> >>  drivers/gpu/drm/meson/meson_registers.h |   3 +
> >>  drivers/gpu/drm/meson/meson_viu.c       |  15 +
> >>  drivers/gpu/drm/meson/meson_vpp.c       |  90 +++--
> >>  12 files changed, 1156 insertions(+), 91 deletions(-)
> >>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
> >>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.h
> >>
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
