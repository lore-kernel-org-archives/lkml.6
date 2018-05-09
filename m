Return-Path: <ebiggers3@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525852521; cv=none;
        d=google.com; s=arc-20160816;
        b=L6b1englz1Jv3WEUlurPnJAAYq6KQr2fHwq3ob0q2BTkdqTTRE1jqpdCAr93IWbkbT
         oGj0D56q8n1sYCb+Smxldsg6JK1SVXxUER0jR8usTfv2H+YXezT0ba2G7OxS7P2y/lVd
         FGDXRa7LlhmUjKf5EE9/u59LSA4B2nhmQJgfpqM3NJu2KXqyLWLGmhJKQW2XhAWKxH7a
         Eim4vptFvAkjd7Viz4Tnb5RUZud0cRmeJkD6mej363mkZx+73LT0z09h4DaAEt3KU4hB
         PWNA1RYC0DFxafxlDE3Z4uW/zVKkqd6DHabibs2fg6NE/m261kFetCSZn0l0Pin08kGM
         2NJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ASCjAZJ571fxhI4LwxWV+OG7JiyXJTm0PwNDyyGaUoY=;
        b=dnJ/e/1u8VnSrESt+aJ2ZZtKxih1ygF+TYQC3QpTAgrOFxf2ug/ecqDHG19Ejn+5JR
         SpjYspcb/QGOoywYebl1WunERnT2Ip67eEgJ9pM0u4h8sB0LuyNfG1RCS+8FmEL4cGHN
         Cax/v4UDJ9eELya3a/Yvity0Q6553CNk1ug80+6p584PV9jcx6yrN1ekeTkpZOAFr/Wu
         sbGe4FM9CFRn26/NBjbV1cJa0/9q33sY9o8iMNUHj9DfENRJ/vPhPhbGZZzJn7uhK8Zt
         RsOwVwnWltvejqpQvzJOG+QAEDN0uFnI8gOocsMqhAlf2w7ULVZRbS3QmdBpY9ISohTl
         D9sA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Vv07ZvmO;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Vv07ZvmO;
       spf=pass (google.com: domain of ebiggers3@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=ebiggers3@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqF0oXmWy58D16uQqLneIGE7KCxMAmBuWK+6m82YHnvE2SUgL2lUYZDRSa3kDGi7809DWFqSQ==
Date: Wed, 9 May 2018 00:57:15 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	devel@driverdev.osuosl.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com>
Subject: Re: possible deadlock in vfs_fallocate
Message-ID: <20180509075715.GH711@sol.localdomain>
References: <000000000000194520056affab14@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000194520056affab14@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599972333084763095?=
X-GMAIL-MSGID: =?utf-8?q?1599972333084763095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[+ashmem maintainers]

On Sun, Apr 29, 2018 at 10:00:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot hit the following crash on upstream commit
> cdface5209349930ae1b51338763c8e029971b97 (Sun Apr 29 03:07:21 2018 +0000)
> Merge tag 'for_linus_stable' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
> syzbot dashboard link:
> https://syzkaller.appspot.com/bug?extid=148c2885d71194f18d28
> 
> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5054004375584768
> syzkaller reproducer:
> https://syzkaller.appspot.com/x/repro.syz?id=6438048191479808
> Raw console output:
> https://syzkaller.appspot.com/x/log.txt?id=5404215203594240
> Kernel config:
> https://syzkaller.appspot.com/x/.config?id=7043958930931867332
> compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+148c2885d71194f18d28@syzkaller.appspotmail.com
> It will help syzbot understand when the bug is fixed. See footer for
> details.
> If you forward the report, please keep this part and the footer.
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 4.17.0-rc2+ #23 Not tainted
> ------------------------------------------------------
> syz-executor715/4492 is trying to acquire lock:
>         (ptrval) (sb_writers#6){.+.+}, at: file_start_write
> include/linux/fs.h:2718 [inline]
>         (ptrval) (sb_writers#6){.+.+}, at: vfs_fallocate+0x5be/0x8d0
> fs/open.c:318
> 
> but task is already holding lock:
>         (ptrval) (ashmem_mutex){+.+.}, at: ashmem_shrink_scan+0xac/0x560
> drivers/staging/android/ashmem.c:440
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (ashmem_mutex){+.+.}:
>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>        __mutex_lock+0x16d/0x17f0 kernel/locking/mutex.c:893
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>        ashmem_mmap+0x53/0x460 drivers/staging/android/ashmem.c:361
>        call_mmap include/linux/fs.h:1789 [inline]
>        mmap_region+0xd13/0x1820 mm/mmap.c:1723
>        do_mmap+0xc79/0x11d0 mm/mmap.c:1494
>        do_mmap_pgoff include/linux/mm.h:2237 [inline]
>        vm_mmap_pgoff+0x1fb/0x2a0 mm/util.c:357
>        ksys_mmap_pgoff+0x4c9/0x640 mm/mmap.c:1544
>        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
>        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
>        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
>        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #2 (&mm->mmap_sem){++++}:
>        __might_fault+0x155/0x1e0 mm/memory.c:4555
>        _copy_to_user+0x30/0x110 lib/usercopy.c:25
>        copy_to_user include/linux/uaccess.h:155 [inline]
>        filldir+0x1ea/0x3a0 fs/readdir.c:196
>        dir_emit_dot include/linux/fs.h:3378 [inline]
>        dir_emit_dots include/linux/fs.h:3389 [inline]
>        dcache_readdir+0x13a/0x620 fs/libfs.c:192
>        iterate_dir+0x4b0/0x5d0 fs/readdir.c:51
>        __do_sys_getdents fs/readdir.c:231 [inline]
>        __se_sys_getdents fs/readdir.c:212 [inline]
>        __x64_sys_getdents+0x293/0x4e0 fs/readdir.c:212
>        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #1 (&sb->s_type->i_mutex_key#11){++++}:
>        down_write+0x87/0x120 kernel/locking/rwsem.c:70
>        inode_lock include/linux/fs.h:713 [inline]
>        do_last fs/namei.c:3274 [inline]
>        path_openat+0x123b/0x4e20 fs/namei.c:3501
>        do_filp_open+0x249/0x350 fs/namei.c:3535
>        do_sys_open+0x56f/0x740 fs/open.c:1093
>        __do_sys_open fs/open.c:1111 [inline]
>        __se_sys_open fs/open.c:1106 [inline]
>        __x64_sys_open+0x7e/0xc0 fs/open.c:1106
>        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #0 (sb_writers#6){.+.+}:
>        lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36
> [inline]
>        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
>        __sb_start_write+0x1e9/0x300 fs/super.c:1385
>        file_start_write include/linux/fs.h:2718 [inline]
>        vfs_fallocate+0x5be/0x8d0 fs/open.c:318
>        ashmem_shrink_scan+0x1f1/0x560 drivers/staging/android/ashmem.c:447
>        ashmem_ioctl+0x3bf/0x13a0 drivers/staging/android/ashmem.c:789
>        vfs_ioctl fs/ioctl.c:46 [inline]
>        file_ioctl fs/ioctl.c:500 [inline]
>        do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>        __do_sys_ioctl fs/ioctl.c:708 [inline]
>        __se_sys_ioctl fs/ioctl.c:706 [inline]
>        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>        do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   sb_writers#6 --> &mm->mmap_sem --> ashmem_mutex
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(ashmem_mutex);
>                                lock(&mm->mmap_sem);
>                                lock(ashmem_mutex);
>   lock(sb_writers#6);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by syz-executor715/4492:
>  #0:         (ptrval) (ashmem_mutex){+.+.}, at:
> ashmem_shrink_scan+0xac/0x560 drivers/staging/android/ashmem.c:440
> 
> stack backtrace:
> CPU: 1 PID: 4492 Comm: syz-executor715 Not tainted 4.17.0-rc2+ #23
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>  print_circular_bug.isra.36.cold.54+0x1bd/0x27d
> kernel/locking/lockdep.c:1223
>  check_prev_add kernel/locking/lockdep.c:1863 [inline]
>  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
>  validate_chain kernel/locking/lockdep.c:2417 [inline]
>  __lock_acquire+0x343e/0x5140 kernel/locking/lockdep.c:3431
>  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
>  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
>  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
>  __sb_start_write+0x1e9/0x300 fs/super.c:1385
>  file_start_write include/linux/fs.h:2718 [inline]
>  vfs_fallocate+0x5be/0x8d0 fs/open.c:318
>  ashmem_shrink_scan+0x1f1/0x560 drivers/staging/android/ashmem.c:447
>  ashmem_ioctl+0x3bf/0x13a0 drivers/staging/android/ashmem.c:789
>  vfs_ioctl fs/ioctl.c:46 [inline]
>  file_ioctl fs/ioctl.c:500 [inline]
>  do_vfs_ioctl+0x1cf/0x16a0 fs/ioctl.c:684
>  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
>  __do_sys_ioctl fs/ioctl.c:708 [inline]
>  __se_sys_ioctl fs/ioctl.c:706 [inline]
>  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:706
>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440179
> RSP: 002b:00007ffc165d4a28 EFLAGS: 00000217 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 6873612f7665642f RCX: 0000000000440179
> RDX: 0000000000000000 RSI: 000000000000770a RDI: 0000000000000004
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000004 R11: 0000000000000217 R12: 00000000004016a0
> R13: 0000000000401730 R14: 0000000000000000 R15: 0000000000000000
> random: crng init done
> 
> 
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report.
> If you forgot to add the Reported-by tag, once the fix for this bug is
> merged
> into any tree, please reply to this email with:
> #syz fix: exact-commit-title
> If you want to test a patch for this bug, please reply with:
> #syz test: git://repo/address.git branch
> and provide the patch inline or as an attachment.
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
> Note: all commands must start from beginning of the line in the email body.

Looks like yet another locking bug in ashmem.  ashmem_mutex normally ranks below
mmap_sem, but ashmem_shrink_scan() inverts that order, via the
file_start_write() in vfs_fallocate().

- Eric
