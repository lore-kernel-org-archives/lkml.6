Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C12C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB3A20684
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB3A20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbeKUUgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:36:16 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35574 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeKUUgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:36:16 -0500
Received: by mail-vs1-f68.google.com with SMTP id e7so2902633vsc.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 02:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y12dPRT0FgIiV1LBI8Bf3+h/yCRZUDj82GOHtCzcJGs=;
        b=OJyj5groDVVMsS3kvx/IroFnj1zqlT1bCJ8a3wTVfK20CnsCiK0yOpNJegBzc6XZb2
         SEPz1v3tx2ofXNBHu40AtdB53Ltw8h3hM2lXyKnOkEck0cAj/X1TcrqRAl96bZ4PqqK+
         aq+SDxDDKjuD817SVtDQb0Yac4lGHBrDqZ1DP2kv1gxp0Fsozgn0rzRapJvXktf92UfQ
         xf+BAKL9fzRq6uKYSW7rArSB1B+wtbJasN5J1itJBfyJdanmOqZUWsabfq27E5Eo51It
         0PAlHsYORdfsjHBQCipfxqj34pN9VVsP6iypa1i3WrU06sTI/qirX6a4sfnVKn+ZIqD3
         Iipg==
X-Gm-Message-State: AGRZ1gIczFGLcQicU9PQcrif2iCIPJJyGZqF8D0om/CRUKNPXBg5kikm
        5HNp8R+DvewXq6sdXMQE/5o1po3Oha2LlUujPe8=
X-Google-Smtp-Source: AJdET5e86A1o4NOKDIcHqMWmQyB93vxJlVByW4jL/9cQtIZiLx4roU3bxO69kAa4SpA/xYQoLtEqReU0rWLM0Zd7WNc=
X-Received: by 2002:a67:f43:: with SMTP id 64mr2481901vsp.166.1542794548022;
 Wed, 21 Nov 2018 02:02:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au>
 <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com>
 <alpine.LNX.2.21.1811202034350.258@nippy.intranet> <CAMuHMdVQPSE7+Pe64OybnugCx-pLVfKmNS6_4DEofF3XZPBLsA@mail.gmail.com>
 <alpine.LNX.2.21.1811211917270.275@nippy.intranet> <CAMuHMdVexpeYVSBMXFwu5cYt3d=w9U48m_fNTuK5awhBNnsW_A@mail.gmail.com>
 <alpine.LNX.2.21.1811212032550.275@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1811212032550.275@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Nov 2018 11:02:14 +0100
Message-ID: <CAMuHMdVzamshSdhDAnxdzq=YiQMvDhrE03UmJxHJLHr6g=u44Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Wed, Nov 21, 2018 at 10:47 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 21 Nov 2018, Geert Uytterhoeven wrote:
> > The 8520 CIA is almost identical to the 6526 CIA, as used in the C64...
>
> The 6526 CIA datasheet says, "In continuous mode, the timer will count
> from the latched value to zero, generate and interrupt, reload the latched
> value and repeat the procedure continuously."

I stand corrected...

> This suggests that either 0 or N (the latched value) would result from a
> read from the counter immediately following an interrupt. Who can say
> which? Just have to try it. The answer should allow us to avoid the risk
> of a clocksource that jumps forwards and backwards.

The code in amiga_gettimeoffset() does:

        ticks = hi << 8 | lo;

        if (ticks > jiffy_ticks / 2)
                /* check for pending interrupt */
                if (cia_set_irq(&ciab_base, 0) & CIA_ICR_TA)
                        offset = 10000;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
