Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512A322419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512A322419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbeKMQLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:11:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50418 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbeKMQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:11:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 11E092929F;
        Tue, 13 Nov 2018 01:14:36 -0500 (EST)
Date:   Tue, 13 Nov 2018 17:15:02 +1100 (AEDT)
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
In-Reply-To: <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com>
Message-ID: <alpine.LNX.2.21.1811131700010.366@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au> <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com> <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com> <alpine.LNX.2.21.1811131413210.362@nippy.intranet> <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018, Michael Schmitz wrote:

> 
> > (It appears that a QEMU-emulated Mac does not benefit from having a 
> > clocksource that's more accurate than the 'jiffies' clocksource, in 
> > spite of "clocksource: Switched to clocksource via1".)
> 
> With the current code, kernel log timestamps have 10 ms resolution on 
> Atari. Time resolution of times reported by initcall_debug is roughly 40 
> us. I'd expect that changes with falling back to jiffies only. Might be 
> worth a try on QEMU Mac.

The initcall debug output shows the same precision as my earlier tests 
with userland. The VIA timer only gets updated when QEMU wants to update 
it, which seems to be about every 9765 us. Hence, using the 'jiffies' 
clocksource would be effectively no regression for a virtual Mac.

-- 
