Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED093C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C3020657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfAONPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:15:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfAONPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:15:25 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gjOYm-0000PM-HV; Tue, 15 Jan 2019 14:15:16 +0100
Date:   Tue, 15 Jan 2019 14:15:16 +0100
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6] x86: load FPU registers on return to userland
Message-ID: <20190115131516.ocyi34ovkgairfiy@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <2e396dbcbb1c4cc191b4208626baed07@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e396dbcbb1c4cc191b4208626baed07@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-15 12:44:53 [+0000], David Laight wrote:
> Once this is done it might be worth while adding a parameter to
> kernel_fpu_begin() to request the registers only when they don't
> need saving.
> This would benefit code paths where the gains are reasonable but not massive.

So if saving + FPU code is a small win why not do this always?

> The return value from kernel_fpu_begin() ought to indicate which
> registers are available - none, SSE, SSE2, AVX, AVX512 etc.
> So code can use an appropriate implementation.
> (I've not looked to see if this is already the case!)

Either everything is saved or nothing. So if SSE registers are saved
then AVX512 are, too.
I would like to see some benefit of this first before adding/adjusting
the API in a way which makes it possible do something to do wrong. That
said, one thing I would like to do is to get rid of irq_fpu_usable() so
code can use FPU registers and needs not to implement a fallback.

> 	David

Sebastian
