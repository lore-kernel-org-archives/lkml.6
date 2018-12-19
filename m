Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47CCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B21620643
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbeLSPab convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:30:31 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbeLSPab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:30:31 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gZdni-0006lA-Jj; Wed, 19 Dec 2018 16:30:22 +0100
Date:   Wed, 19 Dec 2018 16:30:22 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     He Zhe <zhe.he@windriver.com>, tglx@linutronix.de,
        rostedt@goodmis.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181219153022.w5le6nf7meiogh72@linutronix.de>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
 <40a63aa5-edb6-4673-b4cc-1bc10e7b3953@windriver.com>
 <20181130181956.eewrlaabtceekzyu@linutronix.de>
 <e7795912-7d93-8f4e-b997-67c4ac1f3549@windriver.com>
 <20181205191400.qrhim3m3ak5hcsuh@linutronix.de>
 <16ac893a-a080-18a5-e636-7b7668d978b0@windriver.com>
 <20181218150744.GB20197@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181218150744.GB20197@arrakis.emea.arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-18 15:07:45 [+0000], Catalin Marinas wrote:
…
> It may be worth running some performance/latency tests during kmemleak
> scanning (echo scan > /sys/kernel/debug/kmemleak) but at a quick look,
> I don't think we'd see any difference with a raw_spin_lock_t.
> 
> With a bit more thinking (though I'll be off until the new year), we
> could probably get rid of the kmemleak_lock entirely in scan_block() and
> make lookup_object() and the related rbtree code in kmemleak RCU-safe.

Okay. So let me apply that patch into my RT tree with your ack (from the
other email). And then I hope that it either shows up upstream or gets
replaced with RCU in the ende :)

Thanks.

Sebastian
