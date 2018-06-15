Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85F60C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDA3208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RC0kfHco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDA3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756139AbeFOJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:19:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36578 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755804AbeFOJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:19:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so4602351pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BJD15BLTXamiHiLHFinnbEYzok+zv/NkzUfDcrnEROw=;
        b=RC0kfHcoohYivnsgNllptgH8WW1wf0wg4JEMWJmkIgV1HRhj22Vlk/n+Q9lxO27Oip
         PSJBYgs5GVB5y5euEq719iwcM3MR/4M9WUTUhZ7f/jRVvmaE3wHEOpw8et/jAy40XRjr
         do+CYiDUbPOHMQWaM7PJV9ee6cmkcyIBX3kKoFlCT7pYGuigCsLsHEePSM8NxxLiF9DQ
         P/rpySD4gHPoOGxq7BWvt5hBVta/n+zCKjYdhDk5ehxxjv80+dxAIWY5XDvrBxp/JZwN
         y4Z/g5IJxcvozY1axkoZYPVIUuHxJHnhuGGBuwfNzwR16u0dMPTeY2XFlhfJ3RBziqRS
         SbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BJD15BLTXamiHiLHFinnbEYzok+zv/NkzUfDcrnEROw=;
        b=lh1oIJXugm7+Oqe4wsMIQX5lDGYpQfLaxkZjt6tTpciQZESZCeNuhW1KJw3nyXUsLf
         lehjoEJa2dbs9skGKEDRRjL+rAr4OPkJn4OTiOsCtQ+G234oeTvF13WX7oWa4BN8rjkP
         RpIf+AjZi0hKrGOfA2HgWe+qwsBT1zRicwaMIJYIk/mZhi8mPleAhDd/RPqH1AjFFNnc
         vkWyhiK4DtlArzsR9XeHefRrnGdR6UjDMkZCba2TjZsiHpFSc/iFFf8PS7KxKiRp9uMV
         bL4PfIrVQcvsKxGXK6dT2XJjGlz3npYv43DwGGi3TebTzhPIJPk+A0/ci1aTvtiXPpVH
         QrcQ==
X-Gm-Message-State: APt69E2wUPAvfuIWlPg3Eq0Fgz3sSufTJv3c8BIypEurKJikj5hus3nN
        vquaPuPsylaTs1mrpvGjNFXt92s0JFvQTxNWH4MFpQ==
X-Google-Smtp-Source: ADUXVKLHVcrGXdbwUKMyfBl7QmknTJVaC7NlUl6c7ujW4v1S7LSG4dNvqn2EyVS3Qkl/9kdCwlm8gOhueic2hKT8/Jo=
X-Received: by 2002:aa7:8311:: with SMTP id t17-v6mr1012717pfm.45.1529054377881;
 Fri, 15 Jun 2018 02:19:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Fri, 15 Jun 2018 02:19:17
 -0700 (PDT)
In-Reply-To: <b1b876d9-94e8-fdee-ae12-e05a7467ce5b@i-love.sakura.ne.jp>
References: <000000000000283c37056b4a81a5@google.com> <ee29ad1e-8bd0-3eef-f49e-793bfadcbea7@I-love.SAKURA.ne.jp>
 <20180611073038.GK12217@hirez.programming.kicks-ass.net> <CACT4Y+Zyf2e_K0oRJ5oRj3WYWpf-t=V=RKHYcdqujF3s9PJL_w@mail.gmail.com>
 <b1b876d9-94e8-fdee-ae12-e05a7467ce5b@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 15 Jun 2018 11:19:17 +0200
Message-ID: <CACT4Y+ZaUanRCWtq4nFhFVxfDCX=2e6JCW-qkX7vp++QvijWBw@mail.gmail.com>
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

On Thu, Jun 14, 2018 at 12:33 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/06/11 16:39, Dmitry Vyukov wrote:
>> On Mon, Jun 11, 2018 at 9:30 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> On Sun, Jun 10, 2018 at 11:47:56PM +0900, Tetsuo Handa wrote:
>>>
>>>> This looks quite strange that nobody is holding percpu_rw_semaphore for
>>>> write but everybody is stuck trying to hold it for read. (Since there
>>>> is no "X locks held by ..." line without followup "#0:" line, there is
>>>> no possibility that somebody is in TASK_RUNNING state while holding
>>>> percpu_rw_semaphore for write.)
>>>>
>>>> I feel that either API has a bug or API usage is wrong.
>>>> Any idea for debugging this?
>>>
>>> Look at percpu_rwsem_release() and usage. The whole fs freezer thing is
>>> magic.
>>
>> Do you mean that we froze fs? We tried to never-ever issue
>> ioctl(FIFREEZE) during fuzzing. Are there other ways to do this?
>>
>
> Dmitry, can you try this patch? If you can get
>
> [   48.080875] ================================================
> [   48.083648] WARNING: lock held when returning to user space!
> [   48.086384] 4.17.0+ #588 Tainted: G                T
> [   48.088890] ------------------------------------------------
> [   48.091447] a.out/1243 is leaving the kernel with locks still held!
> [   48.093487] 3 locks held by a.out/1243:
> [   48.094964]  #0: 00000000148ae74c (sb_writers#8){++++}, at: percpu_down_write+0x1d/0x110
> [   48.097622]  #1: 000000001c9e7d4d (sb_pagefaults){++++}, at: percpu_down_write+0x1d/0x110
> [   48.100432]  #2: 000000003c3d2e71 (sb_internal){++++}, at: percpu_down_write+0x1d/0x110
>
> with this patch, there is a way to return to userspace with locks held.
> If you got possible deadlock warning messages, it will be great.
>
> If you cannot reproduce with this patch, I think we need a git tree to try
> this patch. But linux-next.git is not yet re-added to the list of trees to
> test and linux.git is not suitable for temporary debug patch...
>
>
>
> From 5ba3a5bc6401a937d30a9e3421ac2a29ee99588f Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Thu, 14 Jun 2018 16:14:55 +0900
> Subject: [PATCH] locking/lockdep: Add config option to allow lockdep splat
>  upon ioctl(FIFREEZE) request
>
> syzbot is hitting hung task problems at __sb_start_write() [1]. While hung
> tasks at __sb_start_write() suggest that filesystem was frozen, syzbot is
> not doing ioctl(FIFREEZE) requests. Therefore, the root cause of hung tasks
> is currently unknown. If there are other paths to freeze filesystem and
> return to userspace without thawing, syzbot needs to avoid testing such
> paths. Therefore, this patch adds a kernel config option which allows
> lockdep to splat if syzbot found such paths.
>
> [1] https://syzkaller.appspot.com/bug?id=287aa8708bc940d0ca1645223c53dd4c2d203be6
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  fs/super.c        |  4 ++++
>  lib/Kconfig.debug | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/fs/super.c b/fs/super.c
> index 50728d9..eb51268 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1428,10 +1428,12 @@ static void sb_wait_write(struct super_block *sb, int level)
>   */
>  static void lockdep_sb_freeze_release(struct super_block *sb)
>  {
> +#ifndef CONFIG_LOCKDEP_REPORT_FSFREEZE_FROM_USERSPACE
>         int level;
>
>         for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
>                 percpu_rwsem_release(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
> +#endif
>  }
>
>  /*
> @@ -1439,10 +1441,12 @@ static void lockdep_sb_freeze_release(struct super_block *sb)
>   */
>  static void lockdep_sb_freeze_acquire(struct super_block *sb)
>  {
> +#ifndef CONFIG_LOCKDEP_REPORT_FSFREEZE_FROM_USERSPACE
>         int level;
>
>         for (level = 0; level < SB_FREEZE_LEVELS; ++level)
>                 percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
> +#endif
>  }
>
>  static void sb_freeze_unlock(struct super_block *sb)
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d543c65..e119d19 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1170,6 +1170,19 @@ config DEBUG_LOCK_ALLOC
>          spin_lock_init()/mutex_init()/etc., or whether there is any lock
>          held during task exit.
>
> +config LOCKDEP_REPORT_FSFREEZE_FROM_USERSPACE
> +       bool "Allow lockdep splat upon ioctl(FIFREEZE) request"
> +       depends on PROVE_LOCKING
> +       default n
> +       help
> +        Freezing filesystems and not thawing shortly will kill the system with
> +        hung tasks. Since ioctl(FIFREEZE) request returns to userspace with
> +        locks held, in order to suppress lockdep splat messages, information
> +        of held locks is cleared without actually releasing locks held. But
> +        doing so might hide possible deadlock bugs. Thus, this option allows
> +        lockdep splat if ioctl(FIFREEZE) is requested, in order to help
> +        finding possible deadlock bugs.
> +
>  config LOCKDEP
>         bool
>         depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
> --
> 1.8.3.1


I've tried replying 5 logs with this patch, but I don't see that we
return to user-space with locks held, nor deadlock reports.

What I've noticed is that all these logs contain lots of error
messages around block subsystem. Perhaps if we can identify the common
denominator across error messages in different logs, we can find the
one responsible for hangs.

[  443.933790] FAT-fs (loop3): Directory bread(block 137) failed
[  444.077580] attempt to access beyond end of device
[  444.082571] loop3: rw=2049, want=310, limit=128
[  444.087278] buffer_io_error: 238 callbacks suppressed
[  444.087291] Buffer I/O error on dev loop3, logical block 309, lost
async page write
[  444.100466] attempt to access beyond end of device
[  444.105465] loop3: rw=2049, want=311, limit=128
[  444.110160] Buffer I/O error on dev loop3, logical block 310, lost
async page write
[  444.118684] attempt to access beyond end of device
[  444.123660] loop3: rw=2049, want=312, limit=128
[  444.225240] attempt to access beyond end of device
[  444.230192] loop3: rw=2049, want=2153, limit=128
[  444.244874] attempt to access beyond end of device
[  444.250144] loop3: rw=0, want=310, limit=128

[  199.713659] print_req_error: I/O error, dev loop0, sector 0
[  199.714970] Buffer I/O error on dev loop0, logical block 0, lost
async page write
