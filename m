Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeEHXDA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 19:03:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33064 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755529AbeEHXC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 19:02:59 -0400
Date: Tue, 8 May 2018 16:02:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        "Steven J . Hill" <steven.hill@cavium.com>,
        Tejun Heo <htejun@gmail.com>, Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH REPOST] Revert mm/vmstat.c: fix vmstat_update()
 preemption BUG
Message-Id: <20180508160257.6e19707ccf1dabe5ec9e8847@linux-foundation.org>
In-Reply-To: <513014a0-a149-5141-a5a0-9b0a4ce9a8d8@suse.cz>
References: <20180504104451.20278-1-bigeasy@linutronix.de>
        <513014a0-a149-5141-a5a0-9b0a4ce9a8d8@suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2018 09:31:05 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> In any case I agree that the revert should be done immediately even
> before fixing the underlying bug. The preempt_disable/enable doesn't
> prevent the bug, it only prevents the debugging code from actually
> reporting it! Note that it's debugging code (CONFIG_DEBUG_PREEMPT) that
> production kernels most likely don't have enabled, so we are not even
> helping them not crash (while allowing possible data corruption).

Grumble.

I don't see much benefit in emitting warnings into end-users' logs for
bugs which we already know about.

The only thing this buys us is that people will hassle us if we forget
to fix the bug, and how pathetic is that?  I mean, we may as well put

	printk("don't forget to fix the vmstat_update() bug!\n");

into start_kernel().
