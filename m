Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeC0UYI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:24:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38055 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbeC0UX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:23:59 -0400
X-Google-Smtp-Source: AIpwx49orK2tQVzX8cQCs7UmUtD3xJPtmqvMQtUT2XcHKSMfTucbqx8RCd6DLEteD0CTmICaIvu0BQ==
Date: Tue, 27 Mar 2018 13:23:57 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc: peterz@infradead.org, mhocko@suse.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, bp@suse.de,
        tglx@linutronix.de
Subject: Re: [PATCH v2] lockdep: Show address of "struct lockdep_map" at
 print_lock().
In-Reply-To: <201803271941.GBE57310.tVSOJLQOFFOHFM@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.20.1803271323130.5082@chino.kir.corp.google.com>
References: <1522059513-5461-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <20180326160549.GL4043@hirez.programming.kicks-ass.net> <201803270558.HCA41032.tVFJOFOMOFLHSQ@I-love.SAKURA.ne.jp> <201803271941.GBE57310.tVSOJLQOFFOHFM@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Tetsuo Handa wrote:

> Since "struct lockdep_map" is embedded into lock objects, we can know
> which instance of a lock object is acquired using hlock->instance field.
> This will help finding which threads are causing a lock contention.
> 
> Currently, print_lock() is printing hlock->acquire_ip field in both
> "[<%px>]" and "%pS" format. But "[<%px>]" is little useful nowadays, for
> we use scripts/faddr2line which receives "%pS" for finding the location
> in the source code. And I want to reduce amount of output, for
> debug_show_all_locks() might print a lot.
> 
> Therefore, this patch replaces "[<%px>]" for printing hlock->acquire_ip
> field with "%p" for printing hlock->instance field.
> 
> [  251.305475] 3 locks held by a.out/31106:
> [  251.308949]  #0: 00000000b0f753ba (&mm->mmap_sem){++++}, at: copy_process.part.41+0x10d5/0x1fe0
> [  251.314283]  #1: 00000000ef64d539 (&mm->mmap_sem/1){+.+.}, at: copy_process.part.41+0x10fe/0x1fe0
> [  251.319618]  #2: 00000000b41a282e (&mapping->i_mmap_rwsem){++++}, at: copy_process.part.41+0x12f2/0x1fe0
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Michal Hocko <mhocko@suse.com>

Acked-by: David Rientjes <rientjes@google.com>
