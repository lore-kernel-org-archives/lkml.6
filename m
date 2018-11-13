Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD43FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA5F223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 22:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA5F223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeKNIL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 03:11:27 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39714 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbeKNIL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 03:11:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 204AC29EE7;
        Tue, 13 Nov 2018 17:11:13 -0500 (EST)
Date:   Wed, 14 Nov 2018 09:11:41 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Michael Schmitz <schmitzmic@gmail.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
In-Reply-To: <0054c37f-ef34-e892-ff1d-02968ab529fa@gmail.com>
Message-ID: <alpine.LNX.2.21.1811140905440.371@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au> <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com> <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com> <alpine.LNX.2.21.1811131413210.362@nippy.intranet> <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com> <alpine.LNX.2.21.1811131700010.366@nippy.intranet> <0054c37f-ef34-e892-ff1d-02968ab529fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, Michael Schmitz wrote:

> 
> Running a recent kernel under ARAnyM shows 40 ns resolution so the Atari 
> hardware emulation is a little more complete.
> 

You mean, 40 us resolution, right?

> Using that for initial tests, I can confirm that timer resolution is 
> reduced to 10ms after patch 6, and gets restored to 40ns after applying 
> the full series

Thanks for testing!

> (once clocksource_init runs, that is - the first part of the boot is at 
> 10ms resolution only, a regression compared to with use of 
> arch_gettimeoffset).
> 

Sounds like a theoretical regression (?)

Is there any need for more precise timers (I mean, better than 40 us) 
before clocksource_init runs?

> Unfortunately, I can't log in at the console with all patches applied. I 
> immediately get the 'login timeout exceeded' message. Weird...
> 

I didn't see that in my tests... Was this aranym or real hardware or both?

Can you also test tree fbf8405cd982 please?

-- 

> Cheers,
> 
> 	Michael
> 
> 
