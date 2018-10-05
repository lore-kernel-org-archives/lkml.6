Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6511C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7394D20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIt918Dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7394D20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJEN3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:29:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36011 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJEN3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:29:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id p89-v6so10589086ljb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 23:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fel/lzrxxHJSCGnPm9lwwRawrTxkk5Et6lNhIW/DJQ4=;
        b=TIt918DlN8ZFz9ArMQF2B3B5kLM1RzZ6zHYcUj6JtX43qSZHMs0RZPGaUtSaMc6jPb
         ZvRc91myaUBlHfwfK16kqUVXu+UiBWdUeqnhrXdeJrjmCt9FYQaubqUI6NX1OoNM8IRc
         p6vdNjapJhz1jYHQmHOi7xxT5awZYScXLqGx/HMZQ01I09NVK56hPG7ThYMvaUjMZpY8
         iv+SDQ5CKiamTf+j8fMUEBmRoaM74fFBnaFFgo2PFs6TCgw7EnCYKTuAdo6Ky64h9jGn
         ido9YLb2ioJMQnX54t/F2ogetyEcF7b9zq21Xd4lGF1kaubUwdHV1M4BXbzBIDnr00pF
         xb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fel/lzrxxHJSCGnPm9lwwRawrTxkk5Et6lNhIW/DJQ4=;
        b=aNfyJ+Hb7F8DtYSNK3t8lVsa6tPvO5HQRSRDlmqSxSubfGrRHqsHY/3x3V3HhEWckY
         2Ssv/s3/rGOcE0C68+W1/UJBlbSKGU8Oczb+610cxEHWuZeGBYZ7vhP4RydiaIVdrnl5
         yi+DnqYEc2+QcqZZoyFBttSst6H+nVQIXDArRHw+pCryjTBzLkKbISUO81d8D2DsMKMe
         45TASe2R0gwtqWXMb34b5md218FAHcZzwD0SHudbxADn7DP05njXsquQ4Vm3v0mwFoT7
         KmaP6BgAd+4l4n026on/gjUgqKM3MUDmhjhHSaCILkJwzJdjrQErqLmQqVYlJ6gvHe56
         oM9g==
X-Gm-Message-State: ABuFfojNzQKU+1D45myWAQc2VjygtLokGesmBA5JbW3JBsg/M6M6UqQk
        +FJcSBzoiwVe1YVWbxKRmjuHGF3UZJ5+puQbYxA=
X-Google-Smtp-Source: ACcGV63q1sU7tfRYp1rUSZYs5BqRjT82WWPbxrfiFd+o3pQJZ88Z0XdHZIKXiIpGgyiXI1E0+6hFJ5nKr43HGUqX/GM=
X-Received: by 2002:a2e:921a:: with SMTP id k26-v6mr6165216ljg.163.1538721112354;
 Thu, 04 Oct 2018 23:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
 <20181004142942.11887-2-ricardo.ribalda@gmail.com> <20181005002125.12fd229f@bbrezillon>
In-Reply-To: <20181005002125.12fd229f@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 5 Oct 2018 08:31:35 +0200
Message-ID: <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris


On Fri, Oct 5, 2018 at 12:21 AM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Hi Ricardo,
>
> On Thu,  4 Oct 2018 16:29:42 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Allow creating gpio-addr-flash via device-tree and not just via platform
> > data.
> >
> > Mimic what physmap_of_versatile and physmap_of_gemini does to reduce
> > code duplicity.
> >
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> >  drivers/mtd/maps/Kconfig           |  8 +++
> >  drivers/mtd/maps/Makefile          |  3 +-
> >  drivers/mtd/maps/gpio-addr-flash.c | 95 +++++++++++++++++++-----------
> >  drivers/mtd/maps/gpio-addr-flash.h | 34 +++++++++++
> >  drivers/mtd/maps/physmap_of_core.c |  5 ++
> >  drivers/mtd/maps/physmap_of_gpio.c | 21 +++++++
> >  6 files changed, 129 insertions(+), 37 deletions(-)
> >  create mode 100644 drivers/mtd/maps/gpio-addr-flash.h
> >  create mode 100644 drivers/mtd/maps/physmap_of_gpio.c
> >
> > diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> > index afb36bff13a7..427143d42168 100644
> > --- a/drivers/mtd/maps/Kconfig
> > +++ b/drivers/mtd/maps/Kconfig
> > @@ -94,6 +94,14 @@ config MTD_PHYSMAP_OF_GEMINI
> >         platforms, some detection and setting up parallel mode on the
> >         external interface.
> >
> > +config MTD_PHYSMAP_OF_GPIO
> > +     bool "GPIO-assisted OF-based physical memory map handling"
> > +     depends on MTD_PHYSMAP_OF
> > +     depends on MTD_GPIO_ADDR
> > +     help
> > +       This provides some extra DT physmap parsing for flashes that are
> > +       partially physically addressed and assisted by GPIOs.
> > +
>
> Hm, so now we have the physmap_of driver which uses a function exposed
> by the gpio-addr-flash module, but this module is also declaring a
> platform_driver. It's probably working fine, but it's hard to follow.
>
> So, I decided to give it a try and started to rework a bit the physmap,
> physmap_of and gpio-addr-flash drivers. Here is the result [1] (it's
> only been compile tested). With this rework we now have a single
> driver which supports DT and !DT init and can also use GPIOs to
> extend the physical memory range in case it's not large enough to
> address the whole memory dev.
>
> Let me know what you think of this approach.
>

The code is definitely easier to follow. But I believe you should
rebase your changes on mines (1-9) and instead of 10 apply your
patch-set.:
- "mtd: maps: Merge gpio-addr-flash.c into physmap-core.c" includes
all my changes and some of them are not obvious:( Port to gpiod,
gpio_values, win_order, use new apis....)
- Also there would be 1 (or 2) fixes that should be included in stable
that we lose using your approach "mtd: maps: gpio-addr-flash: Fix
ioremapped size", "mtd: physmap_of: Release resources on error"
- And last, but not least, I want some credit for all this work ;)
After 10 iterations I guess that I deserve more than a Documentation
change, specially when my code would be on the tree.

My other concern is that maybe we are giving too much entity to
gpio-addr by including it in the core. But if you are fine with it, I
am fine with it.

If you want i can do the rebase and start testing on my board. What do
you think?

Regards!



> Regards,
>
> Boris
>
> [1]https://github.com/bbrezillon/linux-0day/commits/mtd/physmap-cleanup



--
Ricardo Ribalda
