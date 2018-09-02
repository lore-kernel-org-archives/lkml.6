Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93228C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4607B20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4607B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeIBOEV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:04:21 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43598 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeIBOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:04:21 -0400
Received: by mail-ua1-f65.google.com with SMTP id f4-v6so11184838uao.10;
        Sun, 02 Sep 2018 02:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g25akXDdGiXrD35dmFnUdga22B27oLphtxx6Y8I9AN4=;
        b=S47EpXm7P3fKOSG51A0U8IQKUwcotVYqeHVZHSVEdtTXP45yBKy8eq8IPmUj6oAL3f
         q9IdcwLCDNq+G9QkktQ+2ESJ6IazV+sTaqyYvq+mZXyvvNMTRhoi/CBdargUZNDUspVh
         gAmqaPqlCBV5iy1S7tWzuNXPkRu2boZMhPSu4tR2NQzZ0dH8V/lwZfrY8g9J3B0v2RXK
         9a4UmYT3CRqbS6zWafx6u6cal8UqI8G6iPcVh8HQ7VeUcv2dJDRIBibrRi8uwcI1FZBQ
         LsS6Dl0xzj4pWeTgP2exDwSxsIRsMNsWk5oAYU+M3xM3wb+pfi5DUNhXuYm/1O3ugKUS
         eTGw==
X-Gm-Message-State: APzg51Dogfn9R7hKo5gVoWLzvz5W6KE3WeBo6IWTfILO3zQF8Kejh5MA
        vRW5Fzj75fYrV9ROUu0EjqnM9oaHgX31l1oFmZNzYQ==
X-Google-Smtp-Source: ANB0VdbSfElCpR+LxsYF7pEeHvZQ9JKm1wHUjh0m52Q3dS9LNtlUdhENKTk4O9+j4ZQ4AeweHDFyP7IlCJzFXZDHlcE=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr13583714uae.47.1535881750824;
 Sun, 02 Sep 2018 02:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180823212436.17423-1-geert@linux-m68k.org> <20180825093055.2cee2159@archlinux>
 <20180902095916.6aa5e5f6@archlinux>
In-Reply-To: <20180902095916.6aa5e5f6@archlinux>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Sep 2018 11:48:57 +0200
Message-ID: <CAMuHMdWY3cjDHOGzMoh9maYJRq_RwerLzD4=eFnsE6yz5CjEYw@mail.gmail.com>
Subject: Re: [PATCH] iio: light: isl29501: Simplify code to kill compiler warning
To:     jic23@jic23.retrosnub.co.uk
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, m.othacehe@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Sep 2, 2018 at 10:59 AM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
> On Sat, 25 Aug 2018 09:30:55 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Thu, 23 Aug 2018 23:24:35 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > > With gcc 4.1.2:
> > >
> > >     drivers/iio/proximity/isl29501.c: In function ‘isl29501_register_write’:
> > >     drivers/iio/proximity/isl29501.c:235: warning: ‘msb’ may be used uninitialized in this function
> > >
> > > While this is a false positive, it can easily be avoided by removing the
> > > "msb" intermediate variable.
> > > Remove the "lsb" intermediate variable for consistency.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > Looks sensible to me, but I'd obviously like to leave a little time for
> > Mathieu to comment as it's his driver.
> Long enough. I guess Mathieu is busy so I'll apply this (mostly before
> it goes so far back in my email that I loose it)
>
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.  I thought about marking for stable
> to reduce noise but decided that compiler is old enough (and I've not
> seen it with GCC 8 IIRC) that I wouldn't bother.

Thanks!

> Basically I'm taking this on the merits of it being better code rather
> than the warning fix :)

JFTR: I only send patches for these warnings if they (a) fix a real bug, or (b)
improve the code.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
