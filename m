Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB04DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283B320675
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TDdjwhlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfALKqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 05:46:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41947 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfALKql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 05:46:41 -0500
Received: by mail-io1-f66.google.com with SMTP id s22so14159039ioc.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 02:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4pv4Rbd0QxbOm7zJOHgqCCj023O1SjBfCx07d5B9+0=;
        b=TDdjwhlL5g6u1fDAhllZ8zn0UjkSAyx16ze0vVrWqZ0MQ5ERC4n4v44qK3+2UiKjCB
         UlzFe6Bg4r7cJ48QKUZxCr+xojobpgjWa1nvYe8PEkMNzRIgu5cJuir4gl/Ch5SAEGCr
         4HfQhLFZ2uUSFmWt6akWxlScNJIyHOZZ0AT5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4pv4Rbd0QxbOm7zJOHgqCCj023O1SjBfCx07d5B9+0=;
        b=ivbbz6wgkYAfprrLJc7rRBQpEQNq6aLC9Qk7CjvXze4QlQ1XSA8mkYARrp01jlUZjZ
         U2NrS51epszJUh5jrdHTsc2ZHc3zyvN298RtFWPej4v1jXqcPLvEJH6VOn6JKQHKPgOx
         oepFC1Ayryg804981SM9iEOtrU+ccSOlnqJoLaUuJCFlqAHoIZgnbfT+aLbaQQS1G4ol
         5kr/BXAv2yOdngr3ZZCwtHmSOPCti/OCYiNAe5sPMSV7x5SGYTHV+uwI3lUpN5VMu89I
         QoMYzGXuI6aoeX5iprGuJpfrqWGMMyhAMELEGQhKd48IO6YEonW42bihCaHvbTAthZ6F
         Xacg==
X-Gm-Message-State: AJcUukei7GCrc6g3W/t6JqeNwfNMru3V83tdDjrZzU4LdYh+VryWYB9t
        L0YDEWtdWGRBtOMYDjbHHlTNts4m2PNtO61IwhONwg==
X-Google-Smtp-Source: ALg8bN7cPIAeKhITR8Mq9x7duSyr5YpTotUnagsHjcFj2O3JqIxcVBlA+9Y5mJIfBeev28PV/JeUH8IZcpKKGshvnE4=
X-Received: by 2002:a6b:7a0a:: with SMTP id h10mr10994139iom.114.1547290000431;
 Sat, 12 Jan 2019 02:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com> <20190111211931.GA29735@ravnborg.org>
 <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com> <20190112101409.GA14273@ravnborg.org>
In-Reply-To: <20190112101409.GA14273@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 12 Jan 2019 16:16:28 +0530
Message-ID: <CAMty3ZBUNeFvsHDRmBFUoZG=J+EfQuKtJDOhaezcfEOykhpOeQ@mail.gmail.com>
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

On Sat, Jan 12, 2019 at 3:44 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan.
>
> > On Sat, Jan 12, 2019 at 2:49 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Jagan.
> > >
> > > Gave this another more detailed read - triggered some additional comments.
> > > Depite the comments it looks good, and this is all more or
> > > less cosmetic improvements.
> >
> > Thanks for the review.
> >
> > >
> > >         Sam
> > >
> > > > +struct st7701_panel_desc {
> > > > +     const struct drm_display_mode *mode;
> > > > +     unsigned int lanes;
> > > > +     unsigned long flags;
> > > > +     enum mipi_dsi_pixel_format format;
> > > > +     const char *const *supply_names;
> > > > +     unsigned int num_supplies;
> > > > +     unsigned int panel_sleep_delay;
> > > > +};
> > > > +
> > > > +struct st7701 {
> > > > +     struct drm_panel panel;
> > > > +     struct mipi_dsi_device *dsi;
> > > > +     const struct st7701_panel_desc *desc;
> > > > +
> > > > +     struct backlight_device *backlight;
> > > > +     struct regulator_bulk_data *supplies;
> > > > +     unsigned int num_supplies;
> > > I cannot see that num_supplies in this struct are used?
> >
> > Yes it is used in the code, please check in struct st7701_panel_desc.
> I have applied the patch and deleted num_supplies - now build errors.
> So num_supplies in struct st7701 is not used and should be deleted.

Sorry, now I found it thanks, will drop in next version.

>
> > > > +static int st7701_prepare(struct drm_panel *panel)
> > > > +{
> > > > +     struct st7701 *st7701 = panel_to_st7701(panel);
> > > > +     int ret;
> > > > +
> > > > +     gpiod_set_value(st7701->reset, 0);
> > > > +     msleep(20);
> > > > +
> > > > +     ret = regulator_bulk_enable(st7701->desc->num_supplies,
> > > > +                                 st7701->supplies);
> > > > +     if (ret < 0)
> > > > +             return ret;
> > > > +     msleep(20);
> > > > +
> > > > +     gpiod_set_value(st7701->reset, 1);
> > > > +     msleep(20);
> > > > +
> > > > +     gpiod_set_value(st7701->reset, 0);
> > > > +     msleep(30);
> > > > +
> > > > +     gpiod_set_value(st7701->reset, 1);
> > > > +     msleep(150);
> > > > +
> > > > +     st7701_init_sequence(st7701);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > >
> > > > +static int st7701_unprepare(struct drm_panel *panel)
> > > > +{
> > > > +     struct st7701 *st7701 = panel_to_st7701(panel);
> > > > +
> > > > +     ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
>
> Should this be MIPI_DCS_ENTER_SLEEP_MODE?
>
> Note - you have shortcuts fot the standard commands like
> in this case:
>
>         mipi_dsi_dcs_enter_sleep_mode(st7701->dsi);

I even tried this, but the difference wrt ST7701 can pass, same
command with type MIPI_DSI_DCS_SHORT_WRITE_PARAM but the default
mipi_dsi_dcs_enter_sleep_mode has length 0 so it's
MIPI_DSI_DCS_SHORT_WRITE type. ie reason I have not used.

>
> Thay could be introduced in many palces, but I also like how all the
> commands follows a consistent way to be issued.
> So consider this only if this was new for you.
>
>
> > > > +
> > > > +     msleep(st7701->sleep_delay);
> > > > +
> > > > +     gpiod_set_value(st7701->reset, 0);
> > > > +
> > > > +     gpiod_set_value(st7701->reset, 1);
> > > > +
> > > > +     gpiod_set_value(st7701->reset, 0);
> > > No timing constrains here? In prepare there are sleeps intermixed.
> >
> > Delay while doing unprare is not needed I suppose.
>
> If the purpose is alone to reset the display then a single write '0'
> should do it I think

I even tried this just set 0, since prepare is doing a sequence, it
good behavior to do the reverse during handoff. ie reason I just
initiated this sequence.

> And there is a requirement that it must be low for a minimum of 10 us
> which would be good to have here.

Sorry, I didn't get this requirement what is this for?

>
> I aslo found in chapter 9. (page 163 - second line) this statement:
> "VDDA and VDDI must be powered down with minimum 120msec."

Yes unprepare is doing the same, it exit from sleep out mode and wait
for 120msec and do the reset.

>
> This is similar to the unprepare delay to be found in simple-panel.c
> So an unprepare delay seems in order here.

Look like simple-panel.c is doing delay after reset initiated and
regulator disabled.
