Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B843BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70384218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kwE2jYEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeLSS1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:27:13 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55356 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbeLSS1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:27:12 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so11116791ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 10:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfqcCqx8fHu6FED3rlKQxbGhEQNL5yPTNPFB4gRD2zA=;
        b=kwE2jYEnCpXqDtnzOPsJOHgDRciOa5Sb19XjiuJ9ky/KPueKFfpVM/R2NL4FCTty9Q
         jL9w3glWYKtHMQKLs+ZMqNooWmCZ+YQTgBQccKw/9IQae34jH/F4ax0E7D4AtOvaO9jE
         McGP8GaSEM2VvR8/u4zt+rcvfSLmW8G8NoNuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfqcCqx8fHu6FED3rlKQxbGhEQNL5yPTNPFB4gRD2zA=;
        b=ZlKZYS0QQHHm4Ivw2GmYPDE/O+odY+y8PRVZx7gIvi+OuuRGsc6gtqgIqSyl2+KqMQ
         5QDxzjJqSd58d3dLquElizHAV4E7TdRvWQ46w/1KQePeBfuHkl1DEnKbqbjvkLYaCkzg
         TO2BFQruLy+3jSi7CctlimxCJxIWfgOklt+qZbKdlhnflISGR2p4Xjw1lmn05TDy9kiB
         4dLejRVWywHaaAVrD+oCGLAj4uvWLzCj8hozJxm1X9cVMEhG1J/ZoeZYeUF3KQIfmQ45
         NSPwhD0uj4XsVkk504R9LXcfKKe45E3gO+h+Xdd2oPjaocpQqAVd5PfQPxGEw/L4aDaA
         lemw==
X-Gm-Message-State: AA+aEWYf9PWY10mMTk98sX910V7xd6S/1egWBaT1jAIOvz2fykjXt91z
        DUj0cge8osNuK67TIqLxXjZNIcpKdMHLuCc/dxp5smTa
X-Google-Smtp-Source: AFSGD/UNmhIW0kn/rOMg+WXnO4qELDNAqtXt671G91uheYTbQzT7YlAEcAv1blIe3oNyMOKoh2xcUkRG/PLNdgR8umI=
X-Received: by 2002:a02:781e:: with SMTP id p30mr21177260jac.85.1545244031631;
 Wed, 19 Dec 2018 10:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20181218133821.sykwt6wdeo7uf6o7@smtp.gmail.com>
 <20181219131254.GR21184@phenom.ffwll.local> <20181219172943.yvccbanfeod3hcoj@smtp.gmail.com>
In-Reply-To: <20181219172943.yvccbanfeod3hcoj@smtp.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 19 Dec 2018 19:27:00 +0100
Message-ID: <CAKMK7uHFH1cYWoQfwOOU5arzfgQ+T2BEQXHkp3ghcdZOWQkX5Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm: i915: Delete base.id prints
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 6:29 PM Shayenne Moura
<shayenneluzmoura@gmail.com> wrote:
>
> On 12/19, Daniel Vetter wrote:
> > On Tue, Dec 18, 2018 at 11:38:21AM -0200, Shayenne Moura wrote:
> > > This patch removes base.id prints from drm_display_mode
> > > objects in i915 files. It removes dependency from drm_mode_object.
> > >
> > > Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>
> >
> > Again I think better to switch to DRM_MODE_FMT/ARG.
> > -Daniel
> >
>
> This one has a different print style. Is it okay to change to DRM_MODE_FMT?

Yeah, standardizing sounds good, just mention in the commit message if
something has changed. This is all debug information, so no issue if
we change the output format slightly.
-Daniel

>
> Best,
> Shayenne
> > > ---
> > >  drivers/gpu/drm/i915/i915_debugfs.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> > > index 7f455bca528e..61dd7bb3fa85 100644
> > > --- a/drivers/gpu/drm/i915/i915_debugfs.c
> > > +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> > > @@ -2948,8 +2948,8 @@ static void intel_seq_print_mode(struct seq_file *m, int tabs,
> > >     for (i = 0; i < tabs; i++)
> > >             seq_putc(m, '\t');
> > >
> > > -   seq_printf(m, "id %d:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
> > > -              mode->base.id, mode->name,
> > > +   seq_printf(m, "name:\"%s\" freq %d clock %d hdisp %d hss %d hse %d htot %d vdisp %d vss %d vse %d vtot %d type 0x%x flags 0x%x\n",
> > > +              mode->name,
> > >                mode->vrefresh, mode->clock,
> > >                mode->hdisplay, mode->hsync_start,
> > >                mode->hsync_end, mode->htotal,
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
