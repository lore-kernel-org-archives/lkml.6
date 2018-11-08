Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4691CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0CE20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="To0lUuBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0CE20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeKIAlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:41:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37822 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeKIAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lgSTuEa61Oqtfz2CR6+/SDFybHQoETSixUNperywsaI=; b=To0lUuBf+kM1M5bwZ5Y9i9Rxu
        d2dfewzU3oZsUeo03QXA2HHgKFjEx4BXXbOxtu0AqjHjKtejtx4tqhX8EvmY31D5+ut5FQy/CzUku
        lteNtVHh9BhBKkevwqrA+MYzMoX/IsQnzkz8TDLZQkndBTjb3CvSqOtbq9XePYAcka+fQiZFZcjRw
        ihyMlNXflfQzeKYXyVR7uPygDuWRIgUcCm5c4mQU396JO22qWqdODkBUtkmDyR1d3Siwz3+y9o4Iz
        xnN44+TAUE7s6equebb5hsluSjnyhQcXkDowrLSJ1uhf7JcoXOseQ53uFiDDVfuy4gNMsYV/QmqOy
        ysSxFIihQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKlrz-0002b4-2h; Thu, 08 Nov 2018 15:05:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E4CF20284F96; Thu,  8 Nov 2018 16:05:17 +0100 (CET)
Date:   Thu, 8 Nov 2018 16:05:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20181108150517.GV9761@hirez.programming.kicks-ass.net>
References: <20181107171010.421878737@linutronix.de>
 <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108074920.4c601ee3@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:49:20AM -0700, Jonathan Corbet wrote:
> Might it be worth asking Ted for a kernel summit slot to talk about this
> next week?

Ah, on that, let me complain :-)

My plumbers schedule is already 100% booked with MCs and other things.
There is no kernel-summit schedule details available as of yet, but it
is already almost certain that I will not have time for anything in that
track anyway :/

And I'm fairly sure I'm not the only one in that boat.
