Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82597C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569E42147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfA2NDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:03:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44408 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2NDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:03:12 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1goT2c-0005I3-6Y; Tue, 29 Jan 2019 14:03:02 +0100
Date:   Tue, 29 Jan 2019 14:03:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Stefan Liebler <stli@linux.ibm.com>,
        Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190129103557.GF28485@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190128134410.GA28485@hirez.programming.kicks-ass.net> <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de> <20190129090108.GA26906@osiris> <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de> <20190129102409.GB26906@osiris> <20190129103557.GF28485@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Peter Zijlstra wrote:

> On Tue, Jan 29, 2019 at 11:24:09AM +0100, Heiko Carstens wrote:
> 
> > Yes, sure. However ;) I reproduced the above with v5.0-rc4 + your
> > patch. And now I am trying to reproduce with linux-next 20190129 +
> > your patch and it doesn't trigger. Did I miss a patch which is only in
> > linux-next which could fix this?
> > 
> 
> I'm forever confused on what patch is where; but -ESRCH makes me thing
> maybe you lost this one:
> 
> ---
> 
> commit da791a667536bf8322042e38ca85d55a78d3c273
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Mon Dec 10 14:35:14 2018 +0100

That's in Linus tree already ...
