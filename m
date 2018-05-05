Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeEEDv5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 23:51:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbeEEDv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 23:51:56 -0400
Date: Fri, 4 May 2018 20:51:54 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Nicholas Bellinger <nab@linux-iscsi.org>, Shaohua Li <shli@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] percpu_ida: Use _irqsave() instead of local_irq_save() +
 spin_lock
Message-ID: <20180505035154.GB20495@bombadil.infradead.org>
References: <20180504153218.7301-1-bigeasy@linutronix.de>
 <20180504162216.ae91654b68eddafe38df7d7f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504162216.ae91654b68eddafe38df7d7f@linux-foundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 04:22:16PM -0700, Andrew Morton wrote:
> I'm feeling a bit hostile toward lib/percpu_ida.c in general ;) It has
> very few users and seems rather complicated (what's with that
> schedule() in percpu_ida_alloc?).  I'm suspecting and hoping that if
> someone can figure out what the requirements were, this could all be
> zapped and reimplemented using something else which we already have.

Note that I have no code in percpu_ida ... it's quite different from
the regular IDA.  But I have noticed the stunning similarity between the
percpu_ida and the code in lib/sbitmap.c.  I have no idea which one is
better, but they're essentially doing the same thing.
