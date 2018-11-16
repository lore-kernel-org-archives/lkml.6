Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40340C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0079F20883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0079F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeKQJEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:04:05 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:40520 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:04:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E399328CDA;
        Fri, 16 Nov 2018 17:49:45 -0500 (EST)
Date:   Sat, 17 Nov 2018 09:49:48 +1100 (AEDT)
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
In-Reply-To: <20181116174705.GY30658@n2100.armlinux.org.uk>
Message-ID: <alpine.LNX.2.21.1811170934300.45@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au> <20181112083422.GA19695@infradead.org> <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk> <alpine.LNX.2.21.1811140854280.371@nippy.intranet> <20181113234336.GP30658@n2100.armlinux.org.uk> <alpine.LNX.2.21.1811141142490.8@nippy.intranet> <20181114141632.GT30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811151427210.19@nippy.intranet> <20181116174705.GY30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Russell King - ARM Linux wrote:

> 
> The EBSA110 is probably in a similar boat - I don't remember whether it 
> had 16MB or 32MB as the maximal amount of memory, but memory was getting 
> tight with some kernels even running a minimalist userspace.
> 
> So, it's probably time to say goodbyte to the kernel support for these 
> platforms.
> 

Your call.

Note that removing code from mainline won't help users obtain older, 
smaller, -stable kernel releases, free from the bug we were discussing. 
(The bug appeared in Linux v2.6.32.)

BTW, if you did want to boot Linux on a 16 MB system, you do have some 
options.

https://lwn.net/Articles/741494/
https://lwn.net/Articles/608945/
https://tiny.wiki.kernel.org/

Contributing to this kind of effort probably has value for IoT 
deployments. I suspect it also cuts a small amount of bloat from a large 
number of other Linux systems.

-- 
