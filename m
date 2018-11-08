Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1706CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A599320857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="DjjupvJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A599320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeKIB6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:58:18 -0500
Received: from imap.thunk.org ([74.207.234.97]:54842 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbeKIB6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PFLlX9kGzsRha38kaC7YKCB7s91CgNS00CBEVXb1BH4=; b=DjjupvJHz/bm3Hlqh0ZJ8rVXrS
        RUSYxFd5zVKe526nTBqfN+GMErTS7THeSGenU5e26w8YelxItZpUjGrSLA1UNDS1hB2a97UvQ82Ht
        xEld4kHwuum5p2+ivb9ihj3pkoxZrIEfltxAmH4aiW3oLDB3+XSPfEpJK7i19KEUbZKY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKn3m-0007FA-Gs; Thu, 08 Nov 2018 16:21:34 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B1CE07A7D24; Thu,  8 Nov 2018 11:21:33 -0500 (EST)
Date:   Thu, 8 Nov 2018 11:21:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20181108162133.GC1080@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>
References: <20181107171010.421878737@linutronix.de>
 <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net>
 <20181108150517.GV9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108150517.GV9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 04:05:17PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 08, 2018 at 07:49:20AM -0700, Jonathan Corbet wrote:
> > Might it be worth asking Ted for a kernel summit slot to talk about this
> > next week?
> 
> Ah, on that, let me complain :-)
> 
> My plumbers schedule is already 100% booked with MCs and other things.
> There is no kernel-summit schedule details available as of yet, but it
> is already almost certain that I will not have time for anything in that
> track anyway :/
> 

I thought there was a slot already scheduled on the refereed track,
"Towards a Linux Kernel Mainainer Handbook" (Tuesday at 4:45pm) for
this purpose?

A draft kernel summit schedule was released yesterday on the
kernel-summit mailing list.  I haven't populated the web site yet
because I haven't had the time, and it's a lot easier to edit a text
file than to make changes using Indico.  :-)

Please take a look at it and let me know if there are conflicts; there
is still time to make changes, although trying to satisfy all of the
*other* scheduling constraints I know of is going to be tricky, so I
make no promises that I can satisfy any additional scheduling
requests/constraints.

Cheers,

						- Ted

