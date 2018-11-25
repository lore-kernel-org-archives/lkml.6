Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D1EC04EBB
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F7D20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F7D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeKYOPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 09:15:25 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37566 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeKYOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 09:15:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id AE1F7224AE;
        Sat, 24 Nov 2018 22:25:17 -0500 (EST)
Date:   Sun, 25 Nov 2018 14:25:25 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 09/14] m68k: hp300: Remove hp300_gettimeoffset()
In-Reply-To: <36b78174-5038-a1ac-4c70-d84a34edd275@gmail.com>
Message-ID: <alpine.LNX.2.21.1811251350500.10@nippy.intranet>
References: <cover.1542589838.git.fthain@telegraphics.com.au> <eb676d37a8e40b88f6c577b372b6512bc19a3394.1542589838.git.fthain@telegraphics.com.au> <CACz-3rh6Qw7YxeFK41KG_ju-bWHRoCaciWvv7JLeURn7wGVAOg@mail.gmail.com> <alpine.LNX.2.21.1811202034350.258@nippy.intranet>
 <CAMuHMdVQPSE7+Pe64OybnugCx-pLVfKmNS6_4DEofF3XZPBLsA@mail.gmail.com> <alpine.LNX.2.21.1811211917270.275@nippy.intranet> <CAMuHMdVexpeYVSBMXFwu5cYt3d=w9U48m_fNTuK5awhBNnsW_A@mail.gmail.com> <alpine.LNX.2.21.1811212032550.275@nippy.intranet>
 <CAMuHMdVzamshSdhDAnxdzq=YiQMvDhrE03UmJxHJLHr6g=u44Q@mail.gmail.com> <alpine.LNX.2.21.1811212129520.275@nippy.intranet> <alpine.LNX.2.21.1811250953120.10@nippy.intranet> <36b78174-5038-a1ac-4c70-d84a34edd275@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018, Michael Schmitz wrote:

> > We can benchmark gettimeofday syscalls on elgar but is that hardware 
> > representative of other relevant models?
> 
> I suppose the CIA is on the main board, so running with the slower clock 
> speed that you'd see with a vanilla Amiga without 060 accelerator board. 
> Ought to be representative enough?
> 

Not really. An accelerated CPU clock exaggerates the slowdown factor, 
given the fixed 0.7 MHz CIA clock.

The "(ticks > jiffy_ticks / 2)" conditional won't make anything worse even 
if interrupt latency is already too high, so I'm inclined towards the more 
prudent option. This patch series is already complicated enough.

In anycase, I'd prefer not to speculate about interrupt priorities or 
latencies when the list probably has people who know the answers.

-- 
