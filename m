Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFF9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6D20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpmMYT5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE6D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757146AbeFSLrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:47:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35126 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756546AbeFSLro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:47:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so10844018plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bgpS6SV9YxrOR8LnFTWPghf1XeNg/Oy2XfAF/4XfDUw=;
        b=EpmMYT5/UcOJ2PXfNFo4pjiwdj0j5IXJ+3smZPe21BZdNYkPxaBK3xJ5MpNTMNc/OF
         75rWB/GSjpJoNF82Ia9p+1/euwM9M3u6v67+S+jqKUB7Y+EVCvqchFzPpDoKJ1o7SRak
         b9FupjLQH+NEqqqv92lSvownkp7+3g9MMChG0QatbqoSSpdqlwdIFptnImcmMNnn+eyB
         5LVdGZLTM48LNrGXnzuxqdotfXCXWGwCPXuQy7PvWOCoUHZpb3BwG4l7P2CkFOGw4fgH
         HCZSnaPkYs+lzwWMc6/PY2VFlpTTAyPAUhfwAhok+SOz7vnHDnPrTRAL84105g/oEqkS
         N26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bgpS6SV9YxrOR8LnFTWPghf1XeNg/Oy2XfAF/4XfDUw=;
        b=nAoOHX6IdwFcI2sNsEUnRpi4oCRlk1G457ifnmdBA/lYgXqkX+5XJCn0bJNB8QUfRe
         4ZVIX6RBK7wJc8wz2e8LjYoy0GeG7iMkp9ml5toVDxfuPPtxe7CVqhEaBuXgjeTqBfgs
         FM5zKg8ayqxlHJvARcZ6RyK9W7LA6h2KKEw6MWibTsV8EshCuHXZhmf5lshhe+kg6w0u
         Ox62zTZb7IhgA3iexdeqbDkiwWvFv6MJ+VVffdjpCW1YmYrznzBmoN/3MyEe7v9c7xr0
         QPgBo5gLHydydqRUG3XmJIXSkK8Pxyh3vJghRvCg/ivdSTzEHYony3MwWQNIsIcf3pZg
         ZeBQ==
X-Gm-Message-State: APt69E1QBY63tZVQnrI5Wgcu8hcK7on/iTM9umgQKSfboh8532hMHEVe
        jXaYV2yUYQ6Ths4XYIVriCzvfCL713PfPQ0bKWDwCA==
X-Google-Smtp-Source: ADUXVKL++fnTke/ME38MdGgbGkBKDubQkpPt8mMZUxktmJow/eBrEy1n+nEb61mjz1sTaOFPWd3duO5ZFpTJU9mYFkI=
X-Received: by 2002:a17:902:8491:: with SMTP id c17-v6mr18333038plo.97.1529408863207;
 Tue, 19 Jun 2018 04:47:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 19 Jun 2018 04:47:22
 -0700 (PDT)
In-Reply-To: <f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp>
References: <000000000000283c37056b4a81a5@google.com> <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
 <20180611073038.GK12217@hirez.programming.kicks-ass.net> <CACT4Y+Zyf2e_K0oRJ5oRj3WYWpf-t=V=RKHYcdqujF3s9PJL_w@mail.gmail.com>
 <b1b876d9-94e8-fdee-ae12-e05a7467ce5b@i-love.sakura.ne.jp>
 <CACT4Y+ZaUanRCWtq4nFhFVxfDCX=2e6JCW-qkX7vp++QvijWBw@mail.gmail.com>
 <dd849e4f-a30f-e508-d4e9-0f3c6d11c89a@i-love.sakura.ne.jp> <f91e1c82-9693-cca3-4ab7-ecd9d9881fb4@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Jun 2018 13:47:22 +0200
Message-ID: <CACT4Y+bvd+z3F4H5Y_W03Txi09UzU6CJqR1Ymid94quj5nELhA@mail.gmail.com>
Subject: Re: INFO: task hung in __sb_start_write
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        syzbot <syzbot+7b2866454055e43c21e5@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 1:10 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/06/16 4:40, Tetsuo Handa wrote:
>> Hmm, there might be other locations calling percpu_rwsem_release() ?
>
> There are other locations calling percpu_rwsem_release(), but quite few.
>
> include/linux/fs.h:1494:#define __sb_writers_release(sb, lev)   \
> include/linux/fs.h-1495-        percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
>
> fs/btrfs/transaction.c:1821:            __sb_writers_release(fs_info->sb, SB_FREEZE_FS);
> fs/aio.c:1566:                  __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> fs/xfs/xfs_aops.c:211:  __sb_writers_release(ioend->io_inode->i_sb, SB_FREEZE_FS);
>
>
>
> I'd like to check what atomic_long_read(&sem->rw_sem.count) says
> when hung task is reported.
>
> Dmitry, if you succeed to reproduce khungtaskd messages, can you try this patch?
>
> ---
>  include/linux/sched.h         |  1 +
>  kernel/hung_task.c            | 25 +++++++++++++++++++++++++
>  kernel/locking/percpu-rwsem.c |  2 ++
>  3 files changed, 28 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 87bf02d..af95251 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1179,6 +1179,7 @@ struct task_struct {
>         /* Used by LSM modules for access restriction: */
>         void                            *security;
>  #endif
> +       struct percpu_rw_semaphore      *pcpu_rwsem_read_waiting;
>
>         /*
>          * New fields for task_struct should be added above here, so that
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 32b4794..409cc82 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -18,6 +18,7 @@
>  #include <linux/utsname.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/debug.h>
> +#include <linux/percpu-rwsem.h>
>
>  #include <trace/events/sched.h>
>
> @@ -77,6 +78,29 @@ static int __init hung_task_panic_setup(char *str)
>         .notifier_call = hung_task_panic,
>  };
>
> +static void dump_percpu_rwsem_state(struct percpu_rw_semaphore *sem)
> +{
> +       unsigned int sum = 0;
> +       int cpu;
> +
> +       if (!sem)
> +               return;
> +       pr_info("percpu_rw_semaphore(%p)\n", sem);
> +       pr_info("  ->rw_sem.count=0x%lx\n",
> +               atomic_long_read(&sem->rw_sem.count));
> +       pr_info("  ->rss.gp_state=%d\n", sem->rss.gp_state);
> +       pr_info("  ->rss.gp_count=%d\n", sem->rss.gp_count);
> +       pr_info("  ->rss.cb_state=%d\n", sem->rss.cb_state);
> +       pr_info("  ->rss.gp_type=%d\n", sem->rss.gp_type);
> +       pr_info("  ->readers_block=%d\n", sem->readers_block);
> +       for_each_possible_cpu(cpu)
> +               sum += per_cpu(*sem->read_count, cpu);
> +       pr_info("  ->read_count=%d\n", sum);
> +       pr_info("  ->list_empty(rw_sem.wait_list)=%d\n",
> +              list_empty(&sem->rw_sem.wait_list));
> +       pr_info("  ->writer.task=%p\n", sem->writer.task);
> +}
> +
>  static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  {
>         unsigned long switch_count = t->nvcsw + t->nivcsw;
> @@ -122,6 +146,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>                 pr_err("\"echo 0 > /proc/sys/kernel/hung_task_timeout_secs\""
>                         " disables this message.\n");
>                 sched_show_task(t);
> +               dump_percpu_rwsem_state(t->pcpu_rwsem_read_waiting);
>                 hung_task_show_lock = true;
>         }
>
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 883cf1b..b3654ab 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -82,7 +82,9 @@ int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
>         /*
>          * Avoid lockdep for the down/up_read() we already have them.
>          */
> +       current->pcpu_rwsem_read_waiting = sem;
>         __down_read(&sem->rw_sem);
> +       current->pcpu_rwsem_read_waiting = NULL;
>         this_cpu_inc(*sem->read_count);
>         __up_read(&sem->rw_sem);
>
> --
> 1.8.3.1



I wasn't able to reproduce this locally yet.

> If no, we would want a git tree for testing under syzbot.

Thinking of this, we could setup a sandbox instance that won't report
anything over email at all, but crashes will be available on the web.
We could point this instance to a custom git tree, where additional
patches can be applied as necessary.  The main question is: who and
how will manage this tree? The tree needs to be rebased periodically,
patches applied, old patches taken out.
