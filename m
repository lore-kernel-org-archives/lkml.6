Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40527C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C49A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfAQQ6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:58:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47471 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbfAQQ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:58:07 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkAzT-00031n-5U; Thu, 17 Jan 2019 17:58:03 +0100
Date:   Thu, 17 Jan 2019 17:57:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Liebler <stli@linux.ibm.com>
Subject: Re: [GIT PULL] timer fix
In-Reply-To: <20190117155859.GE18351@osiris>
Message-ID: <alpine.DEB.2.21.1901171755460.1592@nanos.tec.linutronix.de>
References: <20181221123453.GA102366@gmail.com> <20181223192926.GA3728@osiris> <20190117095102.GA88466@gmail.com> <20190117155859.GE18351@osiris>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019, Heiko Carstens wrote:
> On Thu, Jan 17, 2019 at 10:51:02AM +0100, Ingo Molnar wrote:
> > 
> > * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > 
> > > > -	if (timr->it_requeue_pending == info->si_sys_private) {
> > > > +	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
> > > >  		timr->kclock->timer_rearm(timr);
> > > 
> > > FWIW, with this patch the vanilla glibc 2.28 self tests
> > > rt/tst-cputimer1, rt/tst-cputimer2, and rt/tst-cputimer3
> > > start to fail on s390:
> ...
> > > I haven't looked any further into this, just reporting.. otherwise the
> > > test systems seem to be healthy.
> > 
> > Could you please check whether the top commit in tip:timers/urgent fixes 
> > it:
> >   93ad0fc088c5: posix-cpu-timers: Unbreak timer rearming
> 
> Yes, the test cases don't fail anymore. Thanks!
> 
> A general question: since I reported this already last year, was the
> bug report not usable? I understand that x-mas holidays were in
> between, just wondering if new "glibc test case" fails are worth to be
> reported like I did.

I was on a 3 weeks vacation and I tend to clean out my inbox when I return
as it turned out in the past that playing catch up is hopeless. The
important stuff comes back by itself :)

Thanks,

	tglx
