Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeC0Kuv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:50:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:54661 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbeC0Kuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:50:50 -0400
Date: Tue, 27 Mar 2018 12:50:48 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bp@suse.de, rientjes@google.com,
        tglx@linutronix.de
Subject: Re: [PATCH v2] lockdep: Show address of "struct lockdep_map" at
 print_lock().
Message-ID: <20180327105048.GE5652@dhcp22.suse.cz>
References: <1522059513-5461-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180326160549.GL4043@hirez.programming.kicks-ass.net>
 <201803270558.HCA41032.tVFJOFOMOFLHSQ@I-love.SAKURA.ne.jp>
 <201803271941.GBE57310.tVSOJLQOFFOHFM@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803271941.GBE57310.tVSOJLQOFFOHFM@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-03-18 19:41:41, Tetsuo Handa wrote:
> >From 91c081c4c5f6a99402542951e7de661c38f928ab Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 27 Mar 2018 19:38:33 +0900
> Subject: [PATCH v2] lockdep: Show address of "struct lockdep_map" at print_lock().
> 
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

Looks good to me. Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
