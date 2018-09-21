Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB821ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538252154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538252154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389870AbeIUSnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:43:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39873 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbeIUSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:43:20 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g3Kx7-0001Zh-44; Fri, 21 Sep 2018 14:54:33 +0200
Date:   Fri, 21 Sep 2018 14:54:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
In-Reply-To: <20180921122058.GB24124@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809211453170.14736@nanos.tec.linutronix.de>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de> <20180921122058.GB24124@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018, Peter Zijlstra wrote:
> On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> > We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> > cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> > cores).
> > 
> > The problem can be triggered with a v4.9-RT kernel by starting
> 
> > Daniel reported that disabling ticket locks on 4.4 makes the problem go
> > away, but he hasn't run a long time test yet and as we saw with 4.14 it can
> > take quite a while.
> 
> On 4.4 and 4.9 ARM64 still uses ticket locks. So I'm very interested to
> know if the ticket locks on x86 really fix or just make it harder.

We can run 4.4. with ticket locks over the weekend.

Thanks,

	tglx

