Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 768D2606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeFFLVs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:21:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49768 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeFFLVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:21:46 -0400
Date: Wed, 6 Jun 2018 13:21:39 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 0.5/5] alpha: remove custom dec_and_lock() implementation
Message-ID: <20180606112139.5ykw277zt72ye3ka@linutronix.de>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
 <20180504154533.8833-2-bigeasy@linutronix.de>
 <20180604102559.2ynbassthjzva62l@linutronix.de>
 <20180604102757.h46feymcfdydl4nz@linutronix.de>
 <20180604114852.GQ12217@hirez.programming.kicks-ass.net>
 <20180606111849.4vr2ap2w4mlyqm23@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606111849.4vr2ap2w4mlyqm23@linutronix.de>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-06 13:18:50 [+0200], To Peter Zijlstra wrote:
> I suggest to remove the custom alpha implementation of dec_and_lock()
> and if it is an issue (performance wise) we could still inline the fast
> path of dec_and_lock().

For everyone who lost track, we are now down to this:
|577cd5e894ec alpha: remove custom dec_and_lock() implementation
|831923bd9fd3 spinlock: atomic_dec_and_lock: Add an irqsave variant
|f452abc5a3c1 drivers/md/raid5: Use irqsave variant of atomic_dec_and_lock()
|8e609dcd8b0d drivers/md/raid5: Do not disable irq on release_inactive_stripe_list() call
|fdf84cf5bee4 bdi: use refcount_t for reference counting instead atomic_t
|c3fce80b4112 userns: use refcount_t for reference counting instead atomic_t
|a9595ca33f5b locking/refcount: implement refcount_dec_and_lock_irqsave()
|32ded25a41a9 bdi: Use irqsave variant of refcount_dec_and_lock()
|6a63e34ed625 userns: Use irqsave variant of refcount_dec_and_lock()

for reference at
  https://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git/log/?h=refcount_t_irqsave

Sebastian
