Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D817C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F79920846
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F79920846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754411AbeGIHxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:53:10 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37641 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeGIHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:53:08 -0400
Received: by mail-ua0-f193.google.com with SMTP id u8-v6so11141891uao.4;
        Mon, 09 Jul 2018 00:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6xlBOiZlZt4cYKIuADLBCJ3aLGZA73399Vj10Xsk1A=;
        b=a1RuHABcjzzKKcO1Z5pPSnYuY8GzCl7V5ZWb1AJ0k0u7PbWkt+NKroTqf+KVwn7wYs
         oi5J259Gxo0Nwc0jYF5aBn3hQiN6g2jgA29riTc6ZMRRCS4wFt56wuWIjjkpJjcRhU6M
         y3yVIjc2vM2UjnSwq7LxhV+SENlXqeLLscNhMPFbc+vcVtUU3ydkHu8YDxBIgcSta2kh
         HpNUib1lKnkYmx7KpXGTVjCCV5UEiTxQX3lMq26OMpwy3EiJVGCjiKmsQaw4Iqe3Tf1H
         hv9OwLNKmysOADNgY5y5K5Te+UoC3bY+RjHLaHt2acvsxBX9mz7cpEsPkUc7MCjPuvnk
         dwTg==
X-Gm-Message-State: APt69E2id04Y5VT2iPAtXefQAwneR+sAQb/hPCuyyRgns+kuG16tK/K7
        zwnpq7HPgf3GoOw+wPrH1mzV2rFJLK5/nZARgXBkMw==
X-Google-Smtp-Source: AAOMgpcMqExBpOO/417TGyYmLKPzfOqli5MY2mwzI4bBBy7poZ/t58CxskMj9EzQGlWQK+XlIEmCRnoCLoPntVL8V0A=
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr12116679uae.72.1531122787788;
 Mon, 09 Jul 2018 00:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180709044444.6397-1-abrodkin@synopsys.com> <20180709054842.GB7618@kroah.com>
 <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com> <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
In-Reply-To: <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jul 2018 09:52:56 +0200
Message-ID: <CAMuHMdULgdLsETpZ9+RC6d2ZoARPs72Fn=SRboM-8Xm7t1Qd2g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Greg KH <greg@kroah.com>,
        arcml <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On Mon, Jul 9, 2018 at 9:22 AM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> On Mon, 2018-07-09 at 09:07 +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 9, 2018 at 7:49 AM Greg KH <greg@kroah.com> wrote:
> > > On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > > might be aligned by either word (32-bits) or double word (64-bits).
> >
> > Or even 16-bit (on e.g. m68k).
>
> Indeed, thanks for the note!
> Will add this in my v3.

Note that in this particular case, the field will probably always be
aligned to 4 bytes,
as the struct will be allocated using *alloc().

> For ARC I'd like this fix to be back-ported starting
> from v4.8 where we added support of "native" atomic64_t, see commit
> ce6365270ecd (" ARCv2: Implement atomic64 based on LLOCKD/SCONDD instructions").
>
> What about m68k, do you have any preference of earliest kernel version
> where this fix might be useful?

Given m68k is 32-bit, it will access atomic64_t variables while
holding a spinlock,
so it should still be safe without this change.

Not to mention no one will try etnaviv on m68k ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
