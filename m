Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2529C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3B920883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 10:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3B920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeKJUk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 15:40:29 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42349 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbeKJUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 15:40:28 -0500
Received: by mail-vk1-f194.google.com with SMTP id y14so990324vky.9;
        Sat, 10 Nov 2018 02:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3Lw9mptkH/xmEHc5fbQRscurNikL9pqmqhaWt5KsIg=;
        b=bbtXWL5zqpK8NT9lW+u/dfeZ3LoxyiDOf+7tYAd4aeqGiFDLHKliYsl9OInv3qyng9
         O4rxlbu9yv79wyX2StF6v5dReqkjjlpmuV8I39zQ9d40bq0OtnYEiOEsH0kRDb++eRqc
         gcajbOQ7OjSiqyrgt0WEad9RwbjymBS3nS+fucqyVjU/V4daK2qzUnkYx6b8tGsvFfab
         gFPmE3R6CKJ9tukAMnyt01VsVxsU7NHwon5/zbubWccOpOnKl1u1n3vL5my1kf0AhohF
         bdR/nA1GHrJIpH++yaEqdQtM73VXSEmNlXxB+fbTwqCBdRGbeQpVHJGgRwjd6xL/mCTf
         /HCw==
X-Gm-Message-State: AGRZ1gK9nYvO7G3dT5xkLTFjtjBu6ObHrTKYAMenYu7n68JVNXl3x8bP
        GD27HE9h8V4sZkNjrwgd7WahgZoRH1enbbw7nWY=
X-Google-Smtp-Source: AJdET5cC9aR4Q6fNxjE8qMrZEW17/gIXL8qYxgOX3nFgyTRQ4dD6YdBMQgUeGHWmgRhYz56uWvFOWGouxSrdsWoQYlI=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr5486449vkd.74.1541847354493;
 Sat, 10 Nov 2018 02:55:54 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-5-TheSven73@googlemail.com> <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
 <CAGngYiWxhSbLLsPaRZ90wEMhhF7e1jt06ZhhRcuhjM53-RYRwg@mail.gmail.com> <CAK8P3a3=2PUy4Zv9r7oN3Jrp6+vf5iZ+3wi2VNee61mmnFsXNA@mail.gmail.com>
In-Reply-To: <CAK8P3a3=2PUy4Zv9r7oN3Jrp6+vf5iZ+3wi2VNee61mmnFsXNA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 10 Nov 2018 11:55:42 +0100
Message-ID: <CAMuHMdVgEQzf_CR79R0dtWVDTtQUj-YUbYPSqg2XkzxQoDz0Lw@mail.gmail.com>
Subject: Re: [PATCH anybus v3 4/6] bus: support HMS Anybus-S bus
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     thesven73@gmail.com, svendev@arcx.com,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Greg KH <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 10:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Nov 9, 2018 at 5:25 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> > On Thu, Nov 8, 2018 at 9:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > +struct anybus_mbox_hdr {
> > > > +       u16 id;
> > > > +       u16 info;
> > > > +       u16 cmd_num;
> > > > +       u16 data_size;
> > > > +       u16 frame_count;
> > > > +       u16 frame_num;
> > > > +       u16 offset_high;
> > > > +       u16 offset_low;
> > > > +       u16 extended[8];
> > > > +} __packed;
> > >
> > > I don't think you want this to be __packed, it won't change the layout
> > > but instead force byte accesses on architectures that don't have
> > > fast unaligned load/store instructions.
> > >
> > > Instead of the __packed, it's almost always better to ensure that
> > > the structure itself is aligned to a 16-bit address.
> > >
> >
> > A general question about __packed.
> >
> > My current understanding is this:
> > (please tell me if it's incorrect or incomplete)
> >
> > + without __packed, the compiler is free to pad the struct in whatever
> > way it feels is best.
> > + with __packed, the fields have to be laid out EXACTLY as specified.
>
> It's not up to the compiler but the ELF ABI. The rules are largely consisten
> among the architectures we support, but there are a couple of notable
> exceptions:
>
> - ARM OABI requires 32-bit alignment for structures
> - x86-32 aligns 64-bit members to 32-bit rather than 64-bit
> - m68k has some oddities, I think they can pack certain
>   members (don't remember the details)

M68k aligns 16-bit and larger members to 16-bit.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
