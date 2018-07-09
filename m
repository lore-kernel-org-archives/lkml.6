Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF61C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B9F20854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B9F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeGIJEK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:04:10 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43481 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932422AbeGIJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:04:06 -0400
Received: by mail-vk0-f66.google.com with SMTP id d74-v6so10019789vke.10;
        Mon, 09 Jul 2018 02:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCTITmVXvW84PbhpO3L3mubD3aQ9LXR3+QLOSeJe0x0=;
        b=r6UO7lEHon5HE6XRC8K8/Op24n+tV10vZgMxqu6+5aSm+xZIIxTwqrupcZv6/6Y2tL
         cdgpt9FMH8ko54uD27cLvrseCT9hWUnrw4DOEsP5NiftyCGxnEroyBl1vUAjrLFXJsfV
         K4SfZVKKL0iQeT3MaPr0mLn/38e6lGvg+Rzp+31pJpZjr4brfjxaevkvFlg40vd0c64u
         bn7WrgW5qQqljWdyL0rDio9saFh5RVVbGgM/RC6ySCZ2XqRBZqr0xx1bm1KHeO9MyHpX
         E4zX8aM6v6gOy4uNUcuSv2D8Ah20dkrKxQ/9kOAdhBx3OGVs7VLEbChDvkcNc87K/BZs
         k88Q==
X-Gm-Message-State: APt69E3aSIf1w6r/XD+tFOVQb0HenlSL1mAT/XgqSyDa2Ai0SN3C0zeE
        ONJe+TEc0/glp13bKVGnhfzB3rl7UE7KgRceDYI=
X-Google-Smtp-Source: AAOMgpdBCWuslTRej2XFSOqXBLaST5eT/js3RC11XE0m+OM2zv2uULLLoRW3mU6NgZA5XIX1qRzmmRogUWweq2kfYdU=
X-Received: by 2002:a1f:3701:: with SMTP id e1-v6mr10977164vka.50.1531127045158;
 Mon, 09 Jul 2018 02:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180709044444.6397-1-abrodkin@synopsys.com> <20180709054842.GB7618@kroah.com>
 <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
 <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
 <CAMuHMdULgdLsETpZ9+RC6d2ZoARPs72Fn=SRboM-8Xm7t1Qd2g@mail.gmail.com> <cabc2aa35ecf81dc7a47d4ec7bd5dcb1c3d566c3.camel@synopsys.com>
In-Reply-To: <cabc2aa35ecf81dc7a47d4ec7bd5dcb1c3d566c3.camel@synopsys.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jul 2018 11:03:54 +0200
Message-ID: <CAMuHMdXJ7izWV2iRYogYzoufrOtqo43c54X78D2FSH8yd2_oaQ@mail.gmail.com>
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

On Mon, Jul 9, 2018 at 10:37 AM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> On Mon, 2018-07-09 at 09:52 +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 9, 2018 at 9:22 AM Alexey Brodkin
> > <Alexey.Brodkin@synopsys.com> wrote:
> > > On Mon, 2018-07-09 at 09:07 +0200, Geert Uytterhoeven wrote:
> > > > On Mon, Jul 9, 2018 at 7:49 AM Greg KH <greg@kroah.com> wrote:
> > > > > On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > > > > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > > > > might be aligned by either word (32-bits) or double word (64-bits).
> > > >
> > > > Or even 16-bit (on e.g. m68k).
> > >
> > > Indeed, thanks for the note!
> > > Will add this in my v3.
> >
> > Note that in this particular case, the field will probably always be
> > aligned to 4 bytes,
> > as the struct will be allocated using *alloc().
>
> Well I think maybe it worth mentioning only 32-bit and 64-bit alignments in
> this particular case because as it was mentioned initially in the comment there're
> 3 pointers before "data" field and for 32-bit machines I guess we may safely
> assume that a pointer size is 32-bit.
>
> This leaves us only one problematic situation 32-bit instead of 64-bit alignment.
>
> > > For ARC I'd like this fix to be back-ported starting
> > > from v4.8 where we added support of "native" atomic64_t, see commit
> > > ce6365270ecd (" ARCv2: Implement atomic64 based on LLOCKD/SCONDD instructions").
> > >
> > > What about m68k, do you have any preference of earliest kernel version
> > > where this fix might be useful?
> >
> > Given m68k is 32-bit, it will access atomic64_t variables while
> > holding a spinlock,
> > so it should still be safe without this change.
>
> Well ARC and ARMv7 are 32-bit machines as well still both have
> a special instructions to read/write 64-bit data.

Sure.

> > Not to mention no one will try etnaviv on m68k ;-)
>
> See it was just a trigger case but other GPUs that use or will use
> DRM GPU scheduler are good candidates to it that problem and not to
> mention some other users of atomic64_t.
>
> But from you above comment I may deduce that m68k doesn't have
> instructions for 64-bit data; in that case there's no reason to worry
> at least about struct devres_node :)

That's correct: m68k has no instructions for 64-bit data.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
