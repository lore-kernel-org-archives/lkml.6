Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2146920827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2146920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeKJGps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:45:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34602 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeKJGps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:45:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so4092641qkg.1;
        Fri, 09 Nov 2018 13:03:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoIf/x7u1sm6xzv64OQZepUoudpT+9X/87qTrGsSHR0=;
        b=Ayf7EVBPzwuLnvVXoNBN5cfAK+rWRq0jCOaDZgtsCVGTsD7Dd5ToIpq18X74HaD3gg
         3TiEJwMOhb+BeNKtRPRc4SJjzHFfjfBjgxiJGy/1OuiKTKbd4JMZBCu/aTlkc7U+9JsF
         V9ErDd0aN1q34EI16apN37AlWOtyJefZ7VFvRe6yy+2lukxRDR7LC6qJ/rr6yiDRGrRX
         Kz2RTkfIrSmleDsmLAeVrOaY8OX1ikP90lvwfWl9h4HD2Nd/cyRn0NOvt98IeiAxMhWr
         ejjiqS/EJ+e6wjpVb0OJJSDUEvN7XyuiBXo7mLD+YKnJrsqYZsG/OWCnYswnUN661CUf
         e0lw==
X-Gm-Message-State: AGRZ1gLMtVg2r9PiU6T7mFRLXRnOPbv8yia4laufPIwmcfC2LO6u3vIj
        fAr06YW6nHs24tA6D1YXtk4zv1zdyA9vjOiVljc=
X-Google-Smtp-Source: AJdET5eZ/Ni9rSYUHTpjTDAqZOoEqDO3Rit1FlhMvVYD7Yua+BTOOhSA1P4z5jmOgHNdOlG+nW/M5B2rBQ5bd1aAE64=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr10040803qtr.319.1541797409160;
 Fri, 09 Nov 2018 13:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-5-TheSven73@googlemail.com> <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
 <CAGngYiWxhSbLLsPaRZ90wEMhhF7e1jt06ZhhRcuhjM53-RYRwg@mail.gmail.com>
In-Reply-To: <CAGngYiWxhSbLLsPaRZ90wEMhhF7e1jt06ZhhRcuhjM53-RYRwg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Nov 2018 22:03:12 +0100
Message-ID: <CAK8P3a3=2PUy4Zv9r7oN3Jrp6+vf5iZ+3wi2VNee61mmnFsXNA@mail.gmail.com>
Subject: Re: [PATCH anybus v3 4/6] bus: support HMS Anybus-S bus
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, noralf@tronnes.org,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 5:25 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> On Thu, Nov 8, 2018 at 9:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > +struct anybus_mbox_hdr {
> > > +       u16 id;
> > > +       u16 info;
> > > +       u16 cmd_num;
> > > +       u16 data_size;
> > > +       u16 frame_count;
> > > +       u16 frame_num;
> > > +       u16 offset_high;
> > > +       u16 offset_low;
> > > +       u16 extended[8];
> > > +} __packed;
> >
> > I don't think you want this to be __packed, it won't change the layout
> > but instead force byte accesses on architectures that don't have
> > fast unaligned load/store instructions.
> >
> > Instead of the __packed, it's almost always better to ensure that
> > the structure itself is aligned to a 16-bit address.
> >
>
> A general question about __packed.
>
> My current understanding is this:
> (please tell me if it's incorrect or incomplete)
>
> + without __packed, the compiler is free to pad the struct in whatever
> way it feels is best.
> + with __packed, the fields have to be laid out EXACTLY as specified.

It's not up to the compiler but the ELF ABI. The rules are largely consisten
among the architectures we support, but there are a couple of notable
exceptions:

- ARM OABI requires 32-bit alignment for structures
- x86-32 aligns 64-bit members to 32-bit rather than 64-bit
- m68k has some oddities, I think they can pack certain
  members (don't remember the details)

> Is it possible that someone will compile this on an architecture that 'likes'
> 16-bit ints to be 32-bit aligned? If such an architecture does not currently
> exist, could it appear in the future?

I'm fairly sure Linux would not be portable to an architecture like this
without a major development effort.

> If the compiler changes the padding in the struct, the driver will
> break, as the struct layout is tightly defined by the anybus spec.
>
> Would it be better to stay safe, and keep __packed in case of such
> tightly defined structures?

Generally I think it does more harm than good. If you require
__packed attributes for correct structure layout,
then only apply it to those members that are not naturally
aligned, and mark the structure itself as __aligned(n) with
the alignment you expect if that makes a difference.

        Arnd
