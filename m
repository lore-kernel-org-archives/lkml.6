Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F068C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F57020644
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av52P7Hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F57020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJCWpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:45:21 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38939 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeJCWpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:45:21 -0400
Received: by mail-lf1-f65.google.com with SMTP id w21-v6so4528819lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/3MzC4UtSDm27UecYvCUrDDNblZ9QnRKZvGaUz8yCA=;
        b=Av52P7HjWbPXAHJUnghTUj6qLx4UVGQbvxSfRdOlyodm07BBCHehusPGIdljKY+cF4
         g7fJjdWXbvr4b4B7vKYYgNXGtAcF4LUKrPVR5wbbiGY3a5+Dyzat8Qa5WbPMclGTEx1V
         uRVg+gPhGVJElNaLCRjLpDxiPvyvq7tx4hVZ7hUlbnfHm7jexeRGtUNPjGRb0LBJdWcn
         PMXI+D19l0v0WTQ+JXM1wYG/blUMnRkdClD0Qgvdvohmo4yphnbFBmTBYO9XcuXtfGt3
         2CHnocbjY1PrhuxTlCmxleuK2nnM2X88tC1dLoOf31KmnZAE4FvYor+t1IUvvIdcb4Uk
         fvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/3MzC4UtSDm27UecYvCUrDDNblZ9QnRKZvGaUz8yCA=;
        b=YGGFZ84QUy5YOLxd47N8KOk/ae5s7IHjAehKcUQfbF7L5zRl21dTFihP2XoEAmupeh
         oklLrLporQ17t7xHhH1jNr2jQy2kBjcA/9uaBy4CHaJqYvRrUJriJM6GvdFuBvkg4Cw8
         SBkQNWq/ZgSpPM3vU+m53q/XZeujRxO3BhNFRRrpuHHH2F1zMXx2E72EUkd9dqoMrju2
         ben7XhYdmBPHV3wywM/nPpHEECOWgBPHO3UTT6yWjN9npb4SSEaoCI6W9QUjGYOTp5RJ
         1KY8G4TDlvzrzFUzmjXn4WLrAzrJGnvRhVP9Ha9JLOIoQCgn7VHxV9eNLbrpCvGEsVpE
         Z9Ig==
X-Gm-Message-State: ABuFfojLdTiUaMFDziKRuRmraxrRZ0DnO7r8BJowOd5hqWHCprMt3fpw
        NSxB00Rw6Ae8nhRQtZlZh8ACTO0HjtfhCuAXlag=
X-Google-Smtp-Source: ACcGV62phB6l3f9wUXjg1Wqs62Luq2ODfmz3Ggpt+jqNgGIetymYa3biMHsDy3lCgPnwJas3V7ZlhyTWHb5V4URCWYo=
X-Received: by 2002:a19:169d:: with SMTP id 29-v6mr1386503lfw.151.1538582180551;
 Wed, 03 Oct 2018 08:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
 <20181001124351.31615-6-ricardo.ribalda@gmail.com> <20181003171114.51ab47b8@bbrezillon>
 <20181003171727.145e7e41@bbrezillon>
In-Reply-To: <20181003171727.145e7e41@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 3 Oct 2018 17:56:03 +0200
Message-ID: <CAPybu_0uheoKRd01V_WQg10gaY2xkkZTxXuz+LKunMoSe97GYg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] mtd: maps: gpio-addr-flash: Convert to gpiod
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris
On Wed, Oct 3, 2018 at 5:17 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Wed, 3 Oct 2018 17:11:14 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>
> > Hi Ricardo,
> >
> > On Mon,  1 Oct 2018 14:43:49 +0200
> > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> >
> > > @@ -248,14 +252,19 @@ static int gpio_flash_probe(struct platform_device *pdev)
> > >
> > >     i = 0;
> > >     do {
> > > -           if (devm_gpio_request(&pdev->dev, state->gpio_addrs[i],
> > > -                                 DRIVER_NAME)) {
> > > +           unsigned int *gpio_id = (unsigned int *)gpios->start;
> > > +
> > > +           if (devm_gpio_request_one(&pdev->dev, gpio_id[i], GPIOD_OUT_LOW,
> > > +                                   DRIVER_NAME)) {
> > >                     dev_err(&pdev->dev, "failed to request gpio %d\n",
> > > -                           state->gpio_addrs[i]);
> > > +                           gpio_id[i]);
> > >                     return -EBUSY;
> > >             }
> > > -           gpio_direction_output(state->gpio_addrs[i], 0);
> > > -   } while (++i < state->gpio_count);
> > > +
> > > +           state->gpios->desc[i] = gpio_to_desc(gpio_id[i]);
> > > +           if (!state->gpios->desc[i])
> > > +                   return -EINVAL;
> > > +   } while (++i < state->gpios->ndescs);
> >
> > Actually, I was thinking about using devm_gpiod_get_array() here and
> > defining a gpio lookup table in the board file registering the device.
> > This way, adding support for DT based parsing is transparent.
>
> It's actually easier than I thought since no one is registering such a
> device, so all you have to do is call devm_gpiod_get_array() and have a
> struct gpio_descs pointer in struct async_state.

That is what I do in patch 8/8 for DT based parsing.

I am am doing the gpio_to_desc and other to maintain compatibility
with old platform board files (in and out tree).

I think is important to maintain that compatibility, but you decide ;)

Cheers

-- 
Ricardo Ribalda
