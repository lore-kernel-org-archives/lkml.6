Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E168CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902C72077C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902C72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeKOOSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:18:34 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47272 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeKOOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 09:18:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id A03BE23F07;
        Wed, 14 Nov 2018 23:12:18 -0500 (EST)
Date:   Thu, 15 Nov 2018 15:12:17 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
cc:     Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in
 arch_gettimeoffset
In-Reply-To: <20181114141632.GT30658@n2100.armlinux.org.uk>
Message-ID: <alpine.LNX.2.21.1811151427210.19@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au> <20181112083422.GA19695@infradead.org> <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk> <alpine.LNX.2.21.1811140854280.371@nippy.intranet> <20181113234336.GP30658@n2100.armlinux.org.uk> <alpine.LNX.2.21.1811141142490.8@nippy.intranet> <20181114141632.GT30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Russell King - ARM Linux wrote:

> However, I now see (having searched mailing lists) what you are trying 
> to do - you have _not_ copied me or the mailing lists I'm on with your 
> cover message, so I'm *totally* lacking in the context of your patch 
> series, particularly where you are converting m68k to use clocksources 
> without needing the gettimeoffset() stuff.
> 

True. I should have included all interested parties in the recipients of 
the cover letter. My bad.

> You have failed to explain that in this thread - probably assuming that 
> I've read your cover message.

I offered to write a patch to add a clocksource to replace the 
arch_gettimeoffset functionality for RPC and EBSA110.

You even replied to that offer.

I did not propose degrading functionality while there is someone able to 
test modernization patches (assuming there is...).

Would you consider merging untested modernization patches for the 
arch_gettimeoffset API?

> I haven't until now, because you never sent it to me or the 
> linux-arm-kernel mailing list.
> 
> I have found this thread _very_ frustrating, and frankly a waste of my 
> time discussing the finer points because of this lack of context.

Sorry for any frustration I've caused you.

The thread went way off-topic when Christoph took the opportunity to 
suggest the removal of RPC and EBSA110. That doesn't interest me.

My interest remains API modernization. The actual patches I've sent are 
intended to modernize the clock API *without* degrading any functionality.

> Please ensure that if you're going to be sending a patch series, that 
> the cover message at least finds its way to the intended audience of 
> your patches, so that everyone has the context they need when looking at 
> (eg) the single patch they may receive.
> 

OK. I'll have to improve my patch submission scripts.

-- 

> Alternatively, if someone raises a problem with the patch, and you 
> _know_ you haven't done that, then please consider informing them where 
> they can get more context, eg, by providing a link to your archived 
> cover message.  It would help avoid misunderstandings.
> 
> Thanks.
> 
> 
