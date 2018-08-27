Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90571C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35779208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wBWhd2gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35779208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH0RYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:24:06 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33210 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeH0RYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:24:06 -0400
Received: by mail-it0-f67.google.com with SMTP id j198-v6so11195340ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CFFa2lvF5oaI3bU1emNkaZ6B/T2Hkocyox+4q5Cz66w=;
        b=wBWhd2gT++Pd9qXQZd8NIB3xeAsZZY4Vq2ZHE1B9C7yt2LOzlRTeE/vx5ul50vgVVG
         U0QsweS26VJT1lS6VxfiwlTxRdcWATPp72UbeAeHNiIJ+dejxQR/9NuKBLqRJbRgr5tq
         qgpXwqGcjWYA1y/twRg8eHSDnDKfIthDp8pCEKPmukjhDTzGtHvPwk+ZpOvlajwYIqii
         vkY4cqrLvdGAPFdQnMYTp5w2AtmOCJkhXaGq+CLorQ8GXl3pTCxTEsz/bIpryv7Tr4T0
         M5cQP8S3mUn+MTV8doW/IypGMniRItB3sGb0BxkO2epL+MWh2BQ8/x6gLdgLpFP10vkQ
         U6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CFFa2lvF5oaI3bU1emNkaZ6B/T2Hkocyox+4q5Cz66w=;
        b=Bk/XFIJl4BaHYuCIVnCBZpYC3d/XOVYBtuWu50L5b/jIdhXOoUlMPnAwi2s2acpD3u
         UELydkQEWD7M9UvHH0v9G5/DCQ3bREZjTH0myGXDWleHRTq01NX930PRTiJ6ngGAg/HU
         16HrrOMN4EZVtvJjZAX2jHlA0CIyGFF4hjUmCYZpMzIghEQOW2OHOSTFTlPYbV7HqKQa
         WZJoWJI4PHs8tzEgrR8ufFXaY8uLnMJ3d7DMpRDMAE0kloYCSsrVY7p1tC6GuyMdakwv
         MnQynNh5VHBoAQ+JZsQk8awgBO12NNk3mnpsiQEJdMn+uGz2xTcgBZSVCIKVqHFE4+K1
         RVMg==
X-Gm-Message-State: APzg51CXk+zTITpNffrSmFXNVl+zd4m02jHJHPttqry/raY8Jb8mDbWT
        TcjHgVKvyKvtilw5QwAzJ3w9YmCZPNvpc6CRrwVNpw==
X-Google-Smtp-Source: ANB0VdZGXi0S+dBaf+E9Qn4XNON4YH75TwI9tZGdmfudY03soYUqkN36KAxTBI8yQiiqqstCGCjTw9ubWEpfFduOJ1c=
X-Received: by 2002:a24:3d02:: with SMTP id n2-v6mr7025530itn.111.1535377044370;
 Mon, 27 Aug 2018 06:37:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 06:37:23
 -0700 (PDT)
In-Reply-To: <20180827110055.122988d0@bbrezillon>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180810080526.27207-2-brgl@bgdev.pl>
 <20180824170848.29594318@bbrezillon> <20180824152740.GD27483@lunn.ch>
 <20180825082722.567e8c9a@bbrezillon> <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 27 Aug 2018 15:37:23 +0200
Message-ID: <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sven Van Asbroeck <svendev@arcx.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, Naren <naren.kernel@gmail.com>,
        netdev <netdev@vger.kernel.org>, Alban Bedel <albeu@free.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-27 11:00 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> On Mon, 27 Aug 2018 10:56:29 +0200
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>> 2018-08-25 8:27 GMT+02:00 Boris Brezillon <boris.brezillon@bootlin.com>:
>> > On Fri, 24 Aug 2018 17:27:40 +0200
>> > Andrew Lunn <andrew@lunn.ch> wrote:
>> >
>> >> On Fri, Aug 24, 2018 at 05:08:48PM +0200, Boris Brezillon wrote:
>> >> > Hi Bartosz,
>> >> >
>> >> > On Fri, 10 Aug 2018 10:04:58 +0200
>> >> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> >> >
>> >> > > +struct nvmem_cell_lookup {
>> >> > > + struct nvmem_cell_info  info;
>> >> > > + struct list_head        list;
>> >> > > + const char              *nvmem_name;
>> >> > > +};
>> >> >
>> >> > Hm, maybe I don't get it right, but this looks suspicious. Usually the
>> >> > consumer lookup table is here to attach device specific names to
>> >> > external resources.
>> >> >
>> >> > So what I'd expect here is:
>> >> >
>> >> > struct nvmem_cell_lookup {
>> >> >     /* The nvmem device name. */
>> >> >     const char *nvmem_name;
>> >> >
>> >> >     /* The nvmem cell name */
>> >> >     const char *nvmem_cell_name;
>> >> >
>> >> >     /*
>> >> >      * The local resource name. Basically what you have in the
>> >> >      * nvmem-cell-names prop.
>> >> >      */
>> >> >     const char *conid;
>> >> > };
>> >> >
>> >> > struct nvmem_cell_lookup_table {
>> >> >     struct list_head list;
>> >> >
>> >> >     /* ID of the consumer device. */
>> >> >     const char *devid;
>> >> >
>> >> >     /* Array of cell lookup entries. */
>> >> >     unsigned int ncells;
>> >> >     const struct nvmem_cell_lookup *cells;
>> >> > };
>> >> >
>> >> > Looks like your nvmem_cell_lookup is more something used to attach cells
>> >> > to an nvmem device, which is NVMEM provider's responsibility not the
>> >> > consumer one.
>> >>
>> >> Hi Boris
>> >>
>> >> There are cases where there is not a clear providier/consumer split. I
>> >> have an x86 platform, with a few at24 EEPROMs on it. It uses an off
>> >> the shelf Komtron module, placed on a custom carrier board. One of the
>> >> EEPROMs contains the hardware variant information. Once i know the
>> >> variant, i need to instantiate other I2C, SPI, MDIO devices, all using
>> >> platform devices, since this is x86, no DT available.
>> >>
>> >> So the first thing my x86 platform device does is instantiate the
>> >> first i2c device for the AT24. Once the EEPROM pops into existence, i
>> >> need to add nvmem cells onto it. So at that point, the x86 platform
>> >> driver is playing the provider role. Once the cells are added, i can
>> >> then use nvmem consumer interfaces to get the contents of the cell,
>> >> run a checksum, and instantiate the other devices.
>> >>
>> >> I wish the embedded world was all DT, but the reality is that it is
>> >> not :-(
>> >
>> > Actually, I'm not questioning the need for this feature (being able to
>> > attach NVMEM cells to an NVMEM device on a platform that does not use
>> > DT). What I'm saying is that this functionality is provider related,
>> > not consumer related. Also, I wonder if defining such NVMEM cells
>> > shouldn't go through the provider driver instead of being passed
>> > directly to the NVMEM layer, because nvmem_config already have a fields
>> > to pass cells at registration time, plus, the name of the NVMEM cell
>> > device is sometimes created dynamically and can be hard to guess at
>> > platform_device registration time.
>> >
>>
>> In my use case the provider is at24 EEPROM driver. This is where the
>> nvmem_config lives but I can't image a correct and clean way of
>> passing this cell config to the driver from board files without using
>> new ugly fields in platform_data which this very series is trying to
>> remove. This is why this cell config should live in machine code.
>
> Okay.
>
>>
>> > I also think non-DT consumers will need a way to reference exiting
>> > NVMEM cells, but this consumer-oriented nvmem cell lookup table should
>> > look like the gpio or pwm lookup table (basically what I proposed in my
>> > previous email).
>>
>> How about introducing two new interfaces to nvmem: one for defining
>> nvmem cells from machine code and the second for connecting these
>> cells with devices?
>
> Yes, that's basically what I was suggesting: move what you've done in
> nvmem-provider.h (maybe rename some of the structs to make it clear
> that this is about defining cells not referencing existing ones), and
> add a new consumer interface (based on what other subsystems do) in
> nvmem-consumer.h.
>
> This way you have both things clearly separated, and if a driver is
> both a consumer and a provider you'll just have to include both headers.
>
> Regards,
>
> Boris

I didn't notice it before but there's a global list of nvmem cells
with each cell referencing its owner nvmem device. I'm wondering if
this isn't some kind of inversion of ownership. Shouldn't each nvmem
device have a separate list of nvmem cells owned by it? What happens
if we have two nvmem providers with the same names for cells? I'm
asking because dev_id based lookup doesn't make sense if internally
nvmem_cell_get_from_list() doesn't care about any device names (takes
only the cell_id as argument).

This doesn't cause any trouble now since there are no users defining
cells in nvmem_config - there are only DT users - but this must be
clarified before I can advance with correctly implementing nvmem
lookups.

BTW: of_nvmem_cell_get() seems to always allocate an nvmem_cell
instance even if the cell for this node was already added to the nvmem
device.

Bart
