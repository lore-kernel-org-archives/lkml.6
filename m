Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC8AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD4820868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547559746;
	bh=SHeeUncfxptRYnseh9h7VQhZA8am4zrDd/dEbGnU0Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x8kcCLZCqTDqt2t9rY77T3yUmZRBWHZsrbjexg+KjaAXfKIPrwfhrCUhi1AOmgJPH
	 nbz2iTRL4nIQpgevAUPC5P9lr69hQyShWGCGMW3YKMOXgSVjGmvWcBJ5fJR546zoKs
	 EeWFGnxya22slIyJDPjlfKo50/mpKpEZ/dP7qn1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfAONmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbfAONmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:42:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD5720651;
        Tue, 15 Jan 2019 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547559743;
        bh=SHeeUncfxptRYnseh9h7VQhZA8am4zrDd/dEbGnU0Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFoK2uWDJeCJ/EDOFaJPsOpzpoPMXNg8VwA+n4iCifXbwbLRbcQ+bHLdgUYhqefC1
         0qvjPCDAp9RQFvEI21j6CDGeVBN9BwC/tYd0BwZUhP9nlrtAuUO9GNTnZXggdQ5TG5
         jD27GRQCnD4RsWdbQLprfQJMmAXwaj5onv8fQMcM=
Date:   Tue, 15 Jan 2019 14:42:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rene Schickbauer <cavac@cavac.at>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Hutter, Tony" <hutter2@llnl.gov>,
        Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190115134221.GB30742@kroah.com>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <20190110131132.GC20217@kroah.com>
 <ba74ed88-06d0-5063-799f-c9c6ddbc7da0@llnl.gov>
 <20190110180752.f4cnunadzzkev24m@linutronix.de>
 <20190110182413.GA6932@kroah.com>
 <46a97264-9586-ef67-73a0-9af1c4d34f25@cavac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a97264-9586-ef67-73a0-9af1c4d34f25@cavac.at>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 02:01:48PM +0100, Rene Schickbauer wrote:
> To be frank, your argument, which boils down to "GPL is the only correct
> open source license", makes me ashamed to have been advocating people
> switching to Linux. This is exactly the kind of argument that made me switch
> away from closed source operating systems like Windows, only then it was
> Steve Ballmer using it against open source.

What?

No, my argument is, "If you want to interact directly with Linux kernel
code in kernel-space, then you have to abide by it's license, which is
GPLv2".  That's it.  If you wish to use open source code by another
license, wonderful, I'm not telling you what you can, and can not do,
but please, do not violate the license of the code I contributed under
GPLv2.

ZFS could be the best filesystem ever to grace this planet, that's
fantastic, but given that the creators of that code placed it under a
license that was specifically designed to not be compatible with Linux
to prevent it from ever being used on Linux, well, you can see why I
really don't care about it.  Why would I?

Those copyright owners (well license owner at this point in time) could
fix this all tomorrow if they wanted to.  But they do not, so _THEY_ are
the people you should be upset at.  Not at the Linux kernel developers
who are giving you a kernel on which to use on your systems, for free,
under the GPLv2.  Our position has always been very clear and upfront.
And really, so has the ZFS license creators.  So why is anyone upset
about all of this?  Nothing new has changed here with the license of
anything.

best of luck!

greg k-h
