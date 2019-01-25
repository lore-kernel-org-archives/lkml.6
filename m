Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A54C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804A7218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGfx4zWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfAYF5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 00:57:03 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43797 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfAYF5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 00:57:03 -0500
Received: by mail-yw1-f67.google.com with SMTP id n21so3458833ywd.10;
        Thu, 24 Jan 2019 21:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIq5VzwbevlyF+FQ7R0JLZtfms9gCxDV+ruYNPlLjHw=;
        b=vGfx4zWdd8JZhq/FjnbKasft/97BhsFUkAUT7F+lzWu2V9yf1mxvqXSoVmymS9ySwN
         d5nOZTuSTB2ic6CuLJs1G7O4fphspSFIR6A7TmQb9HejyGHwgfl6tMGCfJMoeGZi+9iS
         N11Wtdq8VQ2dKnhePfHzRIW2eflPxI3dWCX+BPxD21U+Ker754ZeXbivrcYegul+TKu4
         oAKQ+Jym1Bd0F1JQkeHT3MMnvtJ5ZFrP30rXw1pw55wKafLVkM9bCDBvAe41p5nvS9ga
         6yOMdQYaDVFovCS9XNxIGb4N8agNe8PatQfre7JbC2QglffJ0KzkDkxrUjMSH9qKT739
         x1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIq5VzwbevlyF+FQ7R0JLZtfms9gCxDV+ruYNPlLjHw=;
        b=OL7qJZpdotuEnLFA/jp0+m/U/zwaz7pfyiCJNS3/N5DdDbWF12KFZo4uMGzA2BgtF5
         Gze317kfVfvEOoXK+eKGRzzJN62CjIed4GPe+dY46Hai2jIJ/iaCxcMeo+o4z0ob7/UM
         XibW0H91rOmZego1iR66QhRXRos47vpFQOdCYHrUkRoywyOEqpvOl51nFF9N+nScQNtK
         80PJrBl6dGFJazaoeziLgqHQKl3KHoZNoN9tskIhmtOkF1IYwxXCw18r9CqdwvIP/qeZ
         8mdBH8B68XU/R9ibA4gFE7AgU/DCsjHAJDMS4yTzwk/3Ce7Cz7w+jAPEWdYVUilMrroi
         4VIA==
X-Gm-Message-State: AJcUukeWP5smaRvf0hMo3m5YC1SXREaMphZVsujAFWWLI5PUdoFVc0ym
        WUZXFmEoYJYbXc89ZlEthLbV2/Y5C0biMBaY1U4=
X-Google-Smtp-Source: ALg8bN6p1JA8l9f7GAFoEaIoKcU2Zp214QnwcUXzAKBUiEzDBNzoN73UC8tsffxbqgfJyyeR9H8ubZ2u3zU8C9qduvM=
X-Received: by 2002:a81:4411:: with SMTP id r17mr9442063ywa.16.1548395821488;
 Thu, 24 Jan 2019 21:57:01 -0800 (PST)
MIME-Version: 1.0
References: <1548381414-20561-1-git-send-email-justinpopo6@gmail.com> <ac0a8ff6-92f5-09ef-932b-aba6378f1f47@gmail.com>
In-Reply-To: <ac0a8ff6-92f5-09ef-932b-aba6378f1f47@gmail.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Thu, 24 Jan 2019 21:56:50 -0800
Message-ID: <CAJx26kWg=9FQonEWRQ2OjQWEStRQ_p8OOgperFp+9E_UdQGYNQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads7950: inconsistency with spi msg
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Florian


On Thu, Jan 24, 2019 at 8:30 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
> Hi Justin,
>
> On 1/24/19 5:56 PM, justinpopo6@gmail.com wrote:
> > From: Justin Chen <justinpopo6@gmail.com>
> >
> > To read a channel we require 3 cycles to send, process, and receive
> > the data. The transfer buffer for the third transaction is left blank.
> > This leaves it up to the SPI driver to decide what to do.
> >
> > In one particular case, if the tx buffer is not set the spi driver
> > sets it to 0xff. This puts the ADC in a alarm programming state,
> > therefore the following read to a channel becomes erroneous.
> >
> > Instead of leaving us to the mercy of the SPI driver, we send the
> > ADC cmd on the third transaction to prevent inconsistent behavior.
>
> Do you think this warrants a Fixes: tag?
>
This was an issue when the driver was introduced. Should I tag that
commit the introduced the driver?
> >
> > Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> > ---
> >  drivers/iio/adc/ti-ads7950.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> > index 0ad6359..5453e10 100644
> > --- a/drivers/iio/adc/ti-ads7950.c
> > +++ b/drivers/iio/adc/ti-ads7950.c
> > @@ -422,6 +422,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
> >       st->scan_single_xfer[1].tx_buf = &st->single_tx;
> >       st->scan_single_xfer[1].len = 2;
> >       st->scan_single_xfer[1].cs_change = 1;
> > +     st->scan_single_xfer[2].rx_buf = &st->single_tx;
>
> Should this be st->scan_single_xfer[2].tx_buf?
>
Oh yes. Good catch. Careless mistake! v2 incoming.
> >       st->scan_single_xfer[2].rx_buf = &st->single_rx;
> >       st->scan_single_xfer[2].len = 2;
> >
> >
>
> --
> Florian
