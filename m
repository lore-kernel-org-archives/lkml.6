Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeEDPzB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:55:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58958 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeEDPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:54:55 -0400
Date: Fri, 4 May 2018 17:54:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org
Subject: Re: Introduce atomic_dec_and_lock_irqsave()
Message-ID: <20180504155446.GP12217@hirez.programming.kicks-ass.net>
References: <20180504154533.8833-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504154533.8833-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:45:28PM +0200, Sebastian Andrzej Siewior wrote:
> This series introduces atomic_dec_and_lock_irqsave() and converts a few
> users to use it. They were using local_irq_save() +
> atomic_dec_and_lock() before that series.

Should not all these users be converted to refcount_t, and thus, should
we not introduce refcount_dec_and_lock_irqsave() instead?
