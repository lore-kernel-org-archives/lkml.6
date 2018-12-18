Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F69DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311E221841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WPVglQjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeLRJh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:37:29 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:53466 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:37:28 -0500
Received: by mail-it1-f170.google.com with SMTP id g85so3130819ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZMTJs4r+syibkFmbdJc+GgDoZ7sB1XfYWUrhnSVLDU=;
        b=WPVglQjfze+9y/oOcViyFJmm5O8je0BzwVxsLhE+rf0hzIfJOCdpM9Y/dpKrXE/l6z
         Q2EtxMZVOdjnpOHUTinniL3uaWb6IS7sl0eUz153ykVnDWfNq0idmp9LyiHCKTEq4BSe
         ngB/WPmKtzEAH6LxvTjryMqOf5Vnh/pOr0ZZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZMTJs4r+syibkFmbdJc+GgDoZ7sB1XfYWUrhnSVLDU=;
        b=cksfAXqgM0gU32PXVqDXSC9mZGSmhIaEv0dK47Exd/UC7BI+PHcstdi5j2bIH9o7de
         jg2zpbMH3ZtmeBDpgHyyOfQQ9rXNkKyPa+/3oa5VqWmw9DiV53zwwLfcl/IHUyiAgTEV
         0PnDTsi8E+429slAWgtEcJMHggwxX2/c0Syx8DxlQoEW06exERqUkJpgWU9UtI+j4hMT
         /MI0r0g6lGu+kqmcaWto68PWKwXw9D7Dp2PQgOVuBLs/1P9a3D69gcgrUJ6hk6oHv58C
         vee28OsFHyCJ7RUVW8wRLnO+p3nAYkHbNNZlUIFphWqPGt93jcCsfmk8V+2PnaOUlfw9
         E4bg==
X-Gm-Message-State: AA+aEWZuyAxaqoaBg5g5FQRkXQbYoNenU9EI4bXiYgfM52RGxfD2qG0S
        opOeUCkdtMtAYm8hqFaWWnKAaofH1CKM6maPFJiI0zeLgJM=
X-Google-Smtp-Source: AFSGD/V7SOkl2nx4shNZlzqycCNsNBkU3diH4tQSNN+zgWI4iWFKZfJ1faIl85oMxYRuGZGHqI5Y6GYQziWficJNVPw=
X-Received: by 2002:a05:660c:344:: with SMTP id b4mr2207766itl.51.1545125845834;
 Tue, 18 Dec 2018 01:37:25 -0800 (PST)
MIME-Version: 1.0
References: <87lg4n1izg.wl-kuninori.morimoto.gx@renesas.com> <1545127003.YuAFZ7QVEK@avalon>
In-Reply-To: <1545127003.YuAFZ7QVEK@avalon>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 18 Dec 2018 10:37:14 +0100
Message-ID: <CAKMK7uEJbMDRdGq1g6i+EqYjgsYDO0RFH64WrUjaW=16Th49ig@mail.gmail.com>
Subject: Re: [PATCH][resend] drm: dw-hdmi-i2s: convert to SPDX identifiers
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 7:47 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Morimoto-san,
>
> Thank you for the patch.
>
> On Tuesday, 18 December 2018 08:00:24 EET Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > This patch updates license to use SPDX-License-Identifier
> > instead of verbose license text.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> > few weeks passed, nothing happen. I re-post this patch again.
> > I added Andrew on Cc
>
> The driver seems to be lacking a maintainer :-S

bridge drivers all have a fallback maintainer, but none of them are
cc'ed. It's maintained in drm-misc, so you could just push the patch
too :-) Especially since you're listed:

DRM DRIVERS FOR BRIDGE CHIPS
M:    Archit Taneja <architt@codeaurora.org>
M:    Andrzej Hajda <a.hajda@samsung.com>
R:    Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
S:    Maintained
T:    git git://anongit.freedesktop.org/drm/drm-misc
F:    drivers/gpu/drm/bridge/


Cheers, Daniel

>
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c index
> > 8f9c8a6..2228689 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > @@ -1,12 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * dw-hdmi-i2s-audio.c
> >   *
> >   * Copyright (c) 2017 Renesas Solutions Corp.
> >   * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> >   */
> >  #include <drm/bridge/dw_hdmi.h>
>
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
