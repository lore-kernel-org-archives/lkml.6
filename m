Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E33820854
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 13:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WtYnVDeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfALNZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 08:25:55 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:45930 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfALNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 08:25:55 -0500
Received: by mail-io1-f54.google.com with SMTP id c2so14308189iom.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 05:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDbDzX71FLTRSuvpMryGFsUbRsJPTp3xT2ORfBYNPPU=;
        b=WtYnVDeUp/pieE8wQ6haFwzvZHTj/jaTfOfmyYsd8HcO3YGA0+bV1HkC+PC8+zTF50
         0SxHU65X7KQse9+99iprD72CWWs8w7bY9dHWddqPLy/hU3NyFIeGh6oHUK1MEWN/rpVt
         TJvCMZHlzPOCie9v/NkLFYzjCd9OAhnkobsqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDbDzX71FLTRSuvpMryGFsUbRsJPTp3xT2ORfBYNPPU=;
        b=GdQ0pEYoh516jg9mo9ThTUyH7remQpcVid8R47F13fqx6snTrbvENN4mP3L/OMkBT5
         TmBtFCOLghSEY2hPegbYG+aDY44p2BA4aBOGoDoD6fSgeRxto0hMtw3cidNEJfKuaCN8
         7sGq6L1XGyDhKqv7UDRQRvjQ0hg8IXABv4LGii28XuUGrGaEVQTteZ647KjTtD8sFyc4
         RdfRKp+024brt3cRRapSNN5aDSH4mpkKwMMnVBv5ow6xUg/gSHBZhE3PUcQe+b6lnmUD
         WAeF3ccq7AmFvQ2AERtbapohW0pJ9gm+yK29akqsU9cln9jmuhyvaDD+SdjgD9ZRBGkA
         yyCw==
X-Gm-Message-State: AJcUukfZ1JguJf/90hjRCNaB+TWvFEiezI2kvFOYMMy9flMB6/FAEC98
        0MpLjc2gdfMbbmUNJam+WmD/XOCSU3DwrsKrUZCYNQ==
X-Google-Smtp-Source: ALg8bN4aaxLrZmCvwoxctceGY16brj+8DvEBTmTYgZjt+qBh5E0dFNWzbkfXpw7pnGDBmgQ5glewSi3EkF71Kr0QtXo=
X-Received: by 2002:a6b:1411:: with SMTP id 17mr8934426iou.252.1547299551459;
 Sat, 12 Jan 2019 05:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com> <20190111211931.GA29735@ravnborg.org>
 <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com>
 <20190112101409.GA14273@ravnborg.org> <CAMty3ZBUNeFvsHDRmBFUoZG=J+EfQuKtJDOhaezcfEOykhpOeQ@mail.gmail.com>
 <20190112120056.GA7374@ravnborg.org>
In-Reply-To: <20190112120056.GA7374@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 12 Jan 2019 18:55:39 +0530
Message-ID: <CAMty3ZAvEzatWMPbtPKUhVRMSzC9icarsxK7KfXAp+gvCR74Lw@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>,
        linux-amarula@amarulasolutions.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 5:31 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> > >
> > > > > > +
> > > > > > +     msleep(st7701->sleep_delay);
> > > > > > +
> > > > > > +     gpiod_set_value(st7701->reset, 0);
> > > > > > +
> > > > > > +     gpiod_set_value(st7701->reset, 1);
> > > > > > +
> > > > > > +     gpiod_set_value(st7701->reset, 0);
> > > > > No timing constrains here? In prepare there are sleeps intermixed.
> > > >
> > > > Delay while doing unprare is not needed I suppose.
> > >
> > > If the purpose is alone to reset the display then a single write '0'
> > > should do it I think
> >
> > I even tried this just set 0, since prepare is doing a sequence, it
> > good behavior to do the reverse during handoff. ie reason I just
> > initiated this sequence.
> >
> > > And there is a requirement that it must be low for a minimum of 10 us
> > > which would be good to have here.
> >
> > Sorry, I didn't get this requirement what is this for?
> The st7701 will ignore reset pulse shorter than 10 us - see Trw in
> table 9 reset timing (page 54).
>
> But as we just assert reset (set it to 0), this timing constraint can be ignored.

But we unaware of reset pulse duration right? it's the hardware that
bring the reset assert if we set the line 0. am I correct or do we
need to explicitly wait 10us after reset initiated?
there is family of chip Sitronix st7789v which don't taking care of
this sequence (I don't know why?) in
drivers/gpu/drm/panel/panel-sitronix-st7789v.c with Page 48 of
datasheet[2]

[2] https://www.newhavendisplay.com/appnotes/datasheets/LCDs/ST7789V.pdf
