Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7114DC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F2920671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F2920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeKTT6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:58:15 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57180 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeKTT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:58:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id B576429E17;
        Tue, 20 Nov 2018 04:30:03 -0500 (EST)
Date:   Tue, 20 Nov 2018 20:30:09 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Linus Walleij <linus.walleij@linaro.org>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>, schwab@linux-m68k.org,
        Arnd Bergmann <arnd@arndb.de>, schivers@csc.com.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        schmitzmic@gmail.com, John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
In-Reply-To: <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1811202001390.258@nippy.intranet>
References: <cover.1542589838.git.fthain@telegraphics.com.au> <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au> <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Linus Walleij wrote:

> 
> Yes you already see the same as I see: this chip MK68901 has no less 
> than four timers. I bet the kernel is just using one of them, out of 
> habit.
> 
> By just setting another timer as free-running we get a classic and clean 
> Linux clocksource for the Atari.
> 

These are all 8-bit timers. Whereas the smallest clocksource mask I can 
find with grep is 24-bits.

You can divide the oscillator down to 12288 Hz giving a maximum period of 
20 ms. My concern would be that clocksource counter wrap could still go 
undetected given a little interrupt latency.

> This is however a very good start in untangling the mess (as is the 
> whole patch series).
> 

It should be exciting to see what happens when some of these changes get 
tested 8-) I've only seen results for Mac and Atari so far.

> As with the Amiga, this chip also has an RTC clock that should go to the 
> RTC subsystem, naturally.
> 

I think some Atari's have an MC146818, which is drivers/rtc/rtc-cmos.c,
arch/alpha/kernel/rtc.c etc.

-- 

> Yours,
> Linus Walleij
> 
