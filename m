Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968841AbeE3J0Z convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:26:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46390 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965283AbeE3J0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:26:22 -0400
Date: Wed, 30 May 2018 11:26:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: Introduce atomic_dec_and_lock_irqsave()
Message-ID: <20180530092614.wch377xtjrjgovnl@linutronix.de>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
 <20180523130241.GA12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180523130241.GA12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-23 15:02:41 [+0200], Peter Zijlstra wrote:
> 1,5-6:
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I sucked them into my try tree an noticed this off by one, I applied the
tags to 1,4-5:
*┬─>[PATCH 1/5] spinlock: atomic_dec_and_lock: Add an irqsave variant
 ├─>[PATCH 2/5] mm/backing-dev: Use irqsave variant of atomic_dec_and_lock()
 ├─>[PATCH 3/5] kernel/user: Use irqsave variant of atomic_dec_and_lock()
*├─>[PATCH 4/5] drivers/md/raid5: Use irqsave variant of atomic_dec_and_lock()
*├─>[PATCH 5/5] drivers/md/raid5: Do not disable irq on release_inactive_stripe_list() call

as we talked about it.

Sebastian
