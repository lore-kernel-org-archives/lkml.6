Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B5FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C1B208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uk9iJdyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C1B208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeH1Aq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:46:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38891 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1Aq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:46:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id e2-v6so138562pgv.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cdA+KykNtZjgZ69yEgl4YYnf8HfunyAzMu7VEiax7eM=;
        b=uk9iJdyOQ8ppCGtinHn08MPdlnd+NeDnSpu/2EheFYIWorAU1T2qv9WrevTdK1RbH6
         bj8EkpRCb0zH8vJ8zCyn6WTeb/USuejQuZ71ttlwvfn7vOlco41vU1I7MwkBp+7hTO1I
         O3nvVZq3EddGCYquo1sODj9sPSVPbDwtiHKFwGBBbCCASvA3iuMrbql/OMDQ5MFj1G35
         gJUfxDCzndCBZwbxmyg8wBzDbXkpaXMbzJ/SuOfbyTJSUo1SplezhQfpX06OeqZucKkR
         toM5i1RZAw0CghvlDEW3XAAbLyPQNvymRuKsf+MjbZPVzQfygjwR8hwSjJYOnzfHPVqa
         AFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cdA+KykNtZjgZ69yEgl4YYnf8HfunyAzMu7VEiax7eM=;
        b=CLTGR1IhW/1CApB++3NYMXDj5oy6v0A02CQorPcrS9lS71ZqcHrd2X4ExzSmgokFoT
         rTn1mz6GPqWGJ8r+9mYAaXGOZgDIufjobRxuj+lWiCYYfemVUBCkdm3lM+KyhX6kawDw
         e/4/18lWqLM+lSTyK4JC4lzCnI/6tK7BDJF43ozDT1Rm2JyaWnqJ9hZegwQ/UFxx+8xD
         w1L4ttNJLsKsxhdg2hVzzJVG/CkBrJxsvV7hNPQW/oYXkHqCDCMUZvhgO7IvOT1n4cXF
         SDkYBc+IqQvw3SB6tIthdE4XLkQzMSEbkY8R6rfAGlYIzwFzMMRWo+TXh8XIzxZqn7Af
         niqw==
X-Gm-Message-State: APzg51Dg1znWFqCaTSn5reDzK0kqTY0fYE4Q7svvr52I9kMJF7wFQvGJ
        5psNOm1EdhCMp+ohV8PylZT1fs7Uotu6wyHpj6c2fw==
X-Google-Smtp-Source: ANB0VdZi423Rb77OHPq90Vg575KGtxWdHFbXXMo2kNw2o6itkwxm81W3V95N81oaQu/pJ22Bomhq310mj9Rhy3wtisA=
X-Received: by 2002:a63:6501:: with SMTP id z1-v6mr13503483pgb.419.1535403490909;
 Mon, 27 Aug 2018 13:58:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Mon, 27 Aug 2018 13:57:50
 -0700 (PDT)
In-Reply-To: <CAGXu5jLcuE-h9V04fTtoSfz9mZdVeH1zfJOpRncK2NZkv2gsnQ@mail.gmail.com>
References: <001a113f711ae2110c055f45acb8@google.com> <20171212220647.GJ185376@gmail.com>
 <CAGXu5jLcuE-h9V04fTtoSfz9mZdVeH1zfJOpRncK2NZkv2gsnQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Aug 2018 13:57:50 -0700
Message-ID: <CACT4Y+aeSz05wDyStT75OFFi_aTyxbfzz7Z6jJ6FJsLNN3Pdtg@mail.gmail.com>
Subject: Re: possible deadlock in seq_read
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        syzbot 
        <bot+e93a80c1bb7c5c56e522461c149f8bf55eab1b2b@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:20 AM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Dec 12, 2017 at 2:06 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
>> On Fri, Dec 01, 2017 at 03:29:01AM -0800, syzbot wrote:
>>> Hello,
>>>
>>> syzkaller hit the following crash on
>>> df8ba95c572a187ed2aa7403e97a7a7f58c01f00
>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>>> compiler: gcc (GCC) 7.1.1 20170620
>>> .config is attached
>>> Raw console output is attached.
>>>
>>> Unfortunately, I don't have any reproducer for this bug yet.
>>>
>>>
>>>
>>> ======================================================
>>> WARNING: possible circular locking dependency detected
>>> 4.15.0-rc1+ #202 Not tainted
>>> ------------------------------------------------------
>>> syz-executor4/26476 is trying to acquire lock:
>>>  (&p->lock){+.+.}, at: [<0000000040185b66>] seq_read+0xd5/0x13d0
>>> fs/seq_file.c:165
>>>
>>> but task is already holding lock:
>>>  (&pipe->mutex/1){+.+.}, at: [<00000000c644bcdc>] pipe_lock_nested
>>> fs/pipe.c:67 [inline]
>>>  (&pipe->mutex/1){+.+.}, at: [<00000000c644bcdc>]
>>> pipe_lock+0x56/0x70 fs/pipe.c:75
>>>
>>> which lock already depends on the new lock.
>>>
>>>
>>> the existing dependency chain (in reverse order) is:
>>>
>>> -> #2 (&pipe->mutex/1){+.+.}:
>>>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>>>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>>>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>>>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:908
>>>        __pipe_lock fs/pipe.c:88 [inline]
>>>        fifo_open+0x15c/0xa40 fs/pipe.c:916
>>>        do_dentry_open+0x682/0xd70 fs/open.c:752
>>>        vfs_open+0x107/0x230 fs/open.c:866
>>>        do_last fs/namei.c:3379 [inline]
>>>        path_openat+0x1157/0x3530 fs/namei.c:3519
>>>        do_filp_open+0x25b/0x3b0 fs/namei.c:3554
>>>        do_open_execat+0x1b9/0x5c0 fs/exec.c:849
>>>        do_execveat_common.isra.30+0x90c/0x23c0 fs/exec.c:1741
>>>        do_execveat fs/exec.c:1859 [inline]
>>>        SYSC_execveat fs/exec.c:1940 [inline]
>>>        SyS_execveat+0x4f/0x60 fs/exec.c:1932
>>>        do_syscall_64+0x26c/0x920 arch/x86/entry/common.c:285
>>>        return_from_SYSCALL_64+0x0/0x75
>>>
>>> -> #1 (&sig->cred_guard_mutex){+.+.}:
>>>        lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4004
>>>        __mutex_lock_common kernel/locking/mutex.c:756 [inline]
>>>        __mutex_lock+0x16f/0x1a80 kernel/locking/mutex.c:893
>>>        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:923
>>>        do_io_accounting+0x1c2/0xf50 fs/proc/base.c:2682
>>>        proc_tid_io_accounting+0x1f/0x30 fs/proc/base.c:2725
>>>        proc_single_show+0xf8/0x170 fs/proc/base.c:744
>>>        seq_read+0x385/0x13d0 fs/seq_file.c:234
>>>        __vfs_read+0xef/0xa00 fs/read_write.c:411
>>>        vfs_read+0x124/0x360 fs/read_write.c:447
>>>        SYSC_read fs/read_write.c:573 [inline]
>>>        SyS_read+0xef/0x220 fs/read_write.c:566
>>>        entry_SYSCALL_64_fastpath+0x1f/0x96
>>>
>>
>> So the problem with all these deadlocks involving pipe->mutex and
>> sig->cred_guard_mutex is that execve() ranks pipe->mutex below
>> sig->cred_guard_mutex when it tries to open a fifo, whereas reading or writing
>> some of the /proc files result in ->cred_guard_mutex being taken which may be
>> underneath pipe->mutex from splice().  Here's a program which causes an actual
>> deadlock using this bug (in addition to reproducing the lockdep report):
>>
>>         #define _GNU_SOURCE
>>         #include <fcntl.h>
>>         #include <pthread.h>
>>         #include <sys/stat.h>
>>         #include <unistd.h>
>>
>>         static void *exec_thread(void *_arg)
>>         {
>>                 for (;;)
>>                         execl("fifo", "fifo", NULL);
>>         }
>>
>>         int main()
>>         {
>>                 int readend, writeend;
>>                 int syscallfd;
>>                 pthread_t t;
>>
>>                 mknod("fifo", 0777|S_IFIFO, 0);
>>                 readend = open("fifo", O_RDONLY|O_NONBLOCK);
>>                 writeend = open("fifo", O_WRONLY);
>>                 syscallfd = open("/proc/self/syscall", O_RDONLY);
>>
>>                 pthread_create(&t, NULL, exec_thread, NULL);
>>
>>                 for (;;) {
>>                         char buffer[16];
>>                         loff_t off_in = 0;
>>                         splice(syscallfd, &off_in, writeend, NULL, 16, 0);
>>                         read(readend, buffer, 16);
>>                 }
>>         }
>>
>> I'm not sure what the fix will be.  Maybe the proc handlers should take a
>> different lock instead of cred_guard_mutex.  Or perhaps execve should check that
>> the file is a regular file before it attempts to open it.
>
> This cleaner reproducer still generates the lockdep warning (but I can
> ctrl-C out of it without leaving behind a zombie), but I see that
> syzbot isn't seeing this any more. Why did it stop? (And can we feed a
> reproducer in to syzbot?)
>
> Was this creating an uninterruptible deadlock before? (Perhaps
> something did change here?)


Hi,

This never was an uninterruptible deadlock. This is a lockdep
"potential deadlock". For the deadlock to actually happen you need
very precise thread interleaving when 2 threads lock 2 different locks
first and then try to lock them the other way around.
