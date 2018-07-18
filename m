Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47ECECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B4F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B4F2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbeGRLOS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:14:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58204 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGRLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:14:18 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffjpJ-0004aI-H3; Wed, 18 Jul 2018 12:36:57 +0200
Date:   Wed, 18 Jul 2018 12:36:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180718103657.zyqinxambp5n3tv6@linutronix.de>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <1531519424.23898.68.camel@gmx.de>
 <20180718092741.pah2lubzo2a7tkmu@linutronix.de>
 <1531909728.6904.84.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1531909728.6904.84.camel@gmx.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-18 12:28:48 [+0200], Mike Galbraith wrote:
> > Okay, so you did not test this because you can't compile.
> 
> Nope, the running kernel, the one that is doing the segfaulting etc,
> has the patches applied.
> 
> It is exhibiting that symptom because those patches do not cure this
> symptom, one which I verified to be present in virgin 4.14-rt as well. 
> The pseudo-patch I sent, disabling preemption where it is assumed to be
> disabled instead, does cure it.  With preemption so disabled, I can
> beat on affected kernels (>=4.14-rt) as long as I like.

ah. so gcc shows the problem instead gcc explodes with the patch
applied. Okay. Let me stare at this a little more…

> This particular 48 core Cavium is very slow, maybe that makes it easier
> to reproduce, dunno.  According to pipe-test, the thing is essentially
> a dozen RPi super-glued together.  pipe-test pinned to a single core
> can only context switch at ~40KHz with PREEMPT_RT, or ~90 with
> NOPREEMPT, comparable to measurement done in real deal RPi.
> 
> 	-Mike

Sebastian
