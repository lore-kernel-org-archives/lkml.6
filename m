Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB165C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F22208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F22208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbeKPBTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:19:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37925 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeKPBTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:19:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so32242459qkg.5;
        Thu, 15 Nov 2018 07:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0N/pBTn+ZsgrWeJGG17owgymeafW3HxGK+Us5vI20I=;
        b=nemDIPokDNWY0Y2SaFvAXrt11WpADUQBCqnGoEHEhueyVkLZnLkpyLRktugE3pXEw7
         iA4PEKwZLYoZeZagS6U6AhhlSZ17G15uxuVL58vS/FvzGnK3OesXARd9Gwf64/rP2ftp
         gmXpO9NcyErbrY3Dl229cNJq3IylK3IVcZzt9ua6KWVHz2Rj1Yv7LshpryaZ02MB6Q21
         5MwN3lKpKS7bFQ8LDM3qHB4iS46brzFjpfuCH73OnePdAmLfKO9QsIjjPCierFGHkc9T
         c4g58znuDlirMSYnddc0DFOxIvfCgN31RUBCZYDVsiFuZJ92LyB0XB0gNU37L5hDBFZO
         +yaA==
X-Gm-Message-State: AGRZ1gLdwliElPhiQf3uXEIDml3P17PiKfwZggGvwyCCn4sBYXdPXWvj
        dSCdCBwwhnp+9eR8UM+btP1a7CoACv0cxIT8HeY=
X-Google-Smtp-Source: AJdET5cwkb4lREhMoAfcfj1debtP1hONk3yaReydOZO+rJyw9R8m8U+Nyi8YcwHo3rCQumW/hIZdPcWvTCbvJCyg54A=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr5967041qkf.107.1542294686850;
 Thu, 15 Nov 2018 07:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
 <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com> <20181115135731.25f60990@bbrezillon>
 <20181115150137.GB4169@kunai>
In-Reply-To: <20181115150137.GB4169@kunai>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Nov 2018 07:11:09 -0800
Message-ID: <CAK8P3a2aem0pFKwRgMq9CUsogJ=MU9d6VHzE0o0+WU0v1UWR4A@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 7:01 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > What we could do though, is expose I3C devices that do not have a
> > driver in kernel space, like spidev does.
>
> ...
>
> > Mark, Wolfram, Arnd, Greg, any opinion?
>
> Is there a benefit for having drivers in userspace? My gut feeling is to
> encourage people to write kernel drivers. If this is, for some reason,
> not possible for some driver, then we have a use case at hand to test
> the then-to-be-developed userspace interface against. Until then, I
> personally wouldn't waste effort on designing it without a user in
> sight.
>
> Dunno if you have that, but a debug interface (exchanging data with
> clients) on the other hand would be super useful most probably. Maybe
> you can start having that in debugfs and already learn from it if you
> ever want to move some interface outside of debugfs?

I think it may depend a little bit on the complexity we require
for a user interface. If it's basically just pread/pwrite, then the
debugfs would not look any different from a stable interface,
and there is little risk of getting it wrong. The more complex
the interface turns out to be, the more cautious we may want
to be about declaring it stable.

Other than that, I agree we should encourage users to write kernel
drivers, but given the precedent of uio, libusb, spidev, i2c-dev,
and vfio, it does seem extremely likely that users will have
requirements for it, and I think it's a good idea to start the design
discussion before users start building their own interfaces to do the
same thing badly.

        Arnd
