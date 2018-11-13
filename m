Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9748BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F76223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F76223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbeKMNKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:10:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47226 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeKMNKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:10:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id D910429C98;
        Mon, 12 Nov 2018 22:14:13 -0500 (EST)
Date:   Tue, 13 Nov 2018 14:14:31 +1100 (AEDT)
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
In-Reply-To: <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com>
Message-ID: <alpine.LNX.2.21.1811131413210.362@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au> <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com> <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, Michael Schmitz wrote:

> Hi Finn,
> 
> Am 12.11.2018 um 22:06 schrieb Finn Thain:
> > On Mon, 12 Nov 2018, Geert Uytterhoeven wrote:
> > 
> > > Hi Finn,
> > > 
> > > Thanks for your patch!
> > > 
> > > On Mon, Nov 12, 2018 at 5:46 AM Finn Thain <fthain@telegraphics.com.au>
> > > wrote:
> > > > The functions that implement arch_gettimeoffset are re-used by
> > > > new clocksource drivers in subsequent patches.
> > > 
> > > Disabling this first affects functionality during bisection, right?
> > > 
> > 
> > It means that all platforms have to use the 'jiffies' clocksource.
> 
> So all that happens is timer granularity drops to 10ms, then gets restored by
> the later patches?
> 

Yes, that was the plan, but I can't confirm that it worked out as I don't 
have any physical 68k hardware in front of me right now. If you can 
confirm this on your Atari Falcon, that would be great.

(It appears that a QEMU-emulated Mac does not benefit from having a 
clocksource that's more accurate than the 'jiffies' clocksource, in spite 
of "clocksource: Switched to clocksource via1".)

The latest patches can be found at
https://github.com/fthain/linux/commits/mac68k-queue/

-- 

> I doubt that would be a large enough regression to matter for bisection, but
> the way you reuse the arch_gettimeoffset() code for the new read_clock()
> functions makes reordering of this patch to the end of the series impossible.
> 
> Best you can don, under the circumstances.
> 
> Cheers,
> 
> 	Michael
> 
> 
