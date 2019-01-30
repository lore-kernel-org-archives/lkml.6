Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E22C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E7820989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoLftjd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfA3PLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:11:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44990 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3PLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:11:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so20982972lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNZCeZVqbUm6oQeZS0YiFFyBdXUCwSJZgzCXxqigqVQ=;
        b=UoLftjd4cvrRyn5Nobjo1IUQDarD2wl1i8rZpOX2e/w4BzX4KXRw+Sa5WirVwMh7k/
         vZsjo7m85JOW5r9ccinm9NPj92MSZfr9mu2IJieNf9p0sm4m68er5bQOH/R9N6nygjy2
         RCl7tPYXjYwjEPagKSnylcZi7TOUpBnU4expwa8xLJMbJzIaIyBlOL0OnB4KqVn1dCdr
         a42ZhOe3aSWt6x7VYN7vvNmaQAYgQEUqiHxlzqyVLYlpVxdvj46MQ4MkJbL6uyfoDbEQ
         X4XvzJIk0gFfAatZkJWP6Zyujvmy8jzxfI6MUNEVmJQ3q7C2GZB5o8QrOQyPhM8f2r+p
         OApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNZCeZVqbUm6oQeZS0YiFFyBdXUCwSJZgzCXxqigqVQ=;
        b=WQ22jd9kg1oM60VbpPo5uHlpvvHniqoA9EV7rNWc9q9XaCHwsMUj3zJHj833XObbpB
         +l4cmmALgxBcVtjUAe2Abdf7DdRwZZOIj5R/SaQOH9OTe7QyFoAZRCzX/iBUYzpC6XuN
         FaBCEfO6qfCxI5bbLUJmNHkVm8+H6CEaDHA2GBwpQrXX+usEBBPjebkLE7Bxsg5BhTic
         wrPqP72lnYjTmdMFuwzXatw9pLaAVYolhUtDKfPGOYbZcugdZsNv+EaW5plgHgb59qUC
         UNF/UOYC+Bl/0jlwaxcD/OQjYZpXyFLFlY/+f5vqToSLSqatdxH8b2LkB443oEMShqJz
         1s1g==
X-Gm-Message-State: AJcUukcGDhenr0ROXZle3+3a1FKHj8fisKDzQyZs5skbqHb2YdVrNU8A
        nqOJ27FevyP+IqqQ4vEav2r0s8qc1kuNH9Ozf9E=
X-Google-Smtp-Source: AHgI3IZ0DFus0wjTF2zvy3deuyYuAsPvns5lKb4Owx3t+cW4IDf1EtjViEC8DY52bZ3opMssXFi8Ek22O1VTniwltf4=
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr13098488ljb.106.1548861074748;
 Wed, 30 Jan 2019 07:11:14 -0800 (PST)
MIME-Version: 1.0
References: <20181224143218.GA3170@hp-pavilion-15-notebook-pc-brajeswar>
 <1891132.39bZHgSTRL@avalon> <CAFqtX7kfsgc+VRuSB_TQhFk4DqCChaR6uBZEsnhuwLPCg_k2xw@mail.gmail.com>
In-Reply-To: <CAFqtX7kfsgc+VRuSB_TQhFk4DqCChaR6uBZEsnhuwLPCg_k2xw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 30 Jan 2019 20:45:18 +0530
Message-ID: <CAFqt6zbaFhJg-+ngL2fjcFaQJ0iEgEyMDFetM2_c3BDLpkWJtg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/panel: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>, a.hajda@samsung.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 8:07 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> On Wed, Dec 26, 2018 at 3:09 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Brajeswar,
> >
> > Thank you for the patch.
> >
> > On Monday, 24 December 2018 16:32:18 EET Brajeswar Ghosh wrote:
> > > Remove drm/drm_panel.h which is included more than once
> > >
> > > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > > ---
> > >  drivers/gpu/drm/bridge/panel.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> > > index 7cbaba213ef6..402b318eeeb2 100644
> > > --- a/drivers/gpu/drm/bridge/panel.c
> > > +++ b/drivers/gpu/drm/bridge/panel.c
> > > @@ -15,7 +15,6 @@
> > >  #include <drm/drm_crtc_helper.h>
> > >  #include <drm/drm_encoder.h>
> > >  #include <drm/drm_modeset_helper_vtables.h>
> > > -#include <drm/drm_panel.h>
> >
> > While at it, how about sorting headers alphabetically to make sure this won't
> > happen again ?
> >
> > With that change,
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> If no further comment, can we get this patch in queue for 5.1 ?

You already got a feedback from Laurent.
>
> >
> > >  struct panel_bridge {
> > >       struct drm_bridge bridge;
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
> >
> >
> >
