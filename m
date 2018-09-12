Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C5EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5370020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeILOrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:47:51 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43930 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:47:51 -0400
Received: by mail-ua1-f65.google.com with SMTP id f4-v6so1159646uao.10;
        Wed, 12 Sep 2018 02:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsVr4sMc5u1H6qyUpWjEGx4ml2cK+pL3vf4B6HBhpHo=;
        b=lgGYruThmR1HFaxUlbTnMt9/UMvW+9Ep7NE6zIirK6Biv7wxfRZc7j2G1JyP8eGNTQ
         yQFVqwy3Cj9URAM7SbnZ9H5PNTgA/rODE4SUQTvVF4QRHMmQsaR5SzUTIFkQZ9gqnpPM
         I01UtwgPNZ6Im3GFdcp8w3cSseGGG+37Gg4SxNfxr2pzPf0k1h5B9FF+DZbvQVdBADBm
         WyGmk8/SOKr6BSbKQyHf2NfV7qivryUkv84Ez3RJN/Bvxd3Zw72JE/lbBpQAD55Pg2Hg
         Oe7faa2jPfgK3VGj8Wuqi/0TvxW/GQkxgbMlGDU+ZzcA/mkqPtAShFbM/NLTL48BtGk9
         yYtA==
X-Gm-Message-State: APzg51DYcRJfSKTWzzdj4zicfh/h6NVTCy3wLfIG5I+5cvrdio3YCJBq
        jWXQItheqsKmIuWc1k0IAj2+8bG5dxjoX7njyFM=
X-Google-Smtp-Source: ANB0VdYlbZaTaOjzsRYbXEVPVyFRq+DtYoTQ69n0q9szlPsi5DTRvjXsYxKrOQBLg2UvSBxm0RQUuBq3ekM9OmS5sbM=
X-Received: by 2002:ab0:51ac:: with SMTP id g41-v6mr414037uaa.155.1536745445441;
 Wed, 12 Sep 2018 02:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180911093356.GE4185@dell> <20180911093917.GL2494@piout.net>
 <CAMuHMdXH8gNjKGOHGFc+K03U2zsVCSN7G_Q4wtepQr859nRQKg@mail.gmail.com>
 <20180911153621.GP2494@piout.net> <CAMuHMdV+=EgAYogwNHbY=RExkGox_+YSeHV6pJtQb6g6PzD-CQ@mail.gmail.com>
 <20180911181838.GI4185@dell> <20180911185839.GA25212@piout.net>
 <20180911224418.GK4185@dell> <20180911225440.GL4185@dell> <20180912073355.GB2557@piout.net>
 <20180912084143.GN4185@dell>
In-Reply-To: <20180912084143.GN4185@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Sep 2018 11:43:53 +0200
Message-ID: <CAMuHMdWefU0pw=c9TKOa+wGHchpg8JRfE0OnC4+wKDt-qrbH1A@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        radu_nicolae.pirea@upb.ro, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Wed, Sep 12, 2018 at 10:41 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 12 Sep 2018, Alexandre Belloni wrote:
> > On 11/09/2018 23:54:40+0100, Lee Jones wrote:
> > > > > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6438-32-bit-ARM926-Embedded-Microprocessor-SAM9G45_Datasheet.pdf
> > > > >
> > > > > USART doc starting p572, registers p621.
> > >
> > > After looking at the datasheet, I don't see any reason why one of the
> > > two drivers can't be selected using different compatible strings.
> >
> > Because there is only one IP and we don't use the device tree to selecet
> > linux specific drivers.
>
> We do it all the time.  There are loads of MFDs (def: same IP, with
> different functions) which have separate compatibles for their various
> functions.  If you wish this IP to operate as an SPI controller, it
> should have an SPI compatible, if you wish it to operate as a U(S)ART,
> then it should have a UART compatible.  It's what we do for most of
> the other MFDs in the kernel.

There is a big difference: MFD functions are(more or less) independent
functions, which can be used at the same time. It makes perfect sense for a
single IP block that has both SPI and UART interfaces, that can be used at
the same time.

In this case, there is a single piece of hardware that can perform
different functions, but not at the same time. Performing a different
function means configuring the hardware for that function, hence using a
different driver (from a different subsystem).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
