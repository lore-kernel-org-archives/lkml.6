Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF76C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D3A2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZdOQ/6Cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D3A2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeLAFQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:16:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:32909 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeLAFQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:16:57 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so2555967itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cTTfnc6ZFkVy3xYW9a8zadLxxBYQrHWlaeJu7Ih89iM=;
        b=ZdOQ/6ClKJJw0qRdkw80GWBDAEgybySCm3HgP25+YaLnUUr2nc9Ufvq7A8LdNsoVnf
         V8Ow6p7uOsI7+ZH/BMFt+41kdeCBkfjANcdO8M9s2xPMWb8eCH7ZXZu4d1SW2qL/soKA
         xTDo6J+xvqpt2lF1FB/1JveL5QoIm6Mf8P6/3rM7uo7RmTobg7x8VlCrnx59lGJz4cT5
         RX+9YDuVvSlD+ZKj/XOGoKlYmEIO2hnC5VAlinT7NTFKIOrqyG2QFGNuIATVZWkMuveq
         ZpSva3EgCcZYLMBeSBZyKt7uTl0wPtFhxbRPTAGa/mNhNYYHCK+Kw+CVkUE7QTMuCyRV
         fGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cTTfnc6ZFkVy3xYW9a8zadLxxBYQrHWlaeJu7Ih89iM=;
        b=CmTPaMPkJqQNMVbdSchld7oE4zBcJl1/bTDedKmIdVWMGwDgR6aNL6Nsr9G3tiJjJ5
         46Fqk+aphD1VW5PXAIwcA9+Rjg8BNQ5Zty4ujC53ps+OGERq8oPqsCgoZl2GjfdHk5LX
         RgWHQ9iPgPMDKfg3h9s1nvYomoG6o5GL5etSot0gKRJvWz+L5gTCW0SjKVivKhaVHeyd
         sY8oEVXDjwcG3xVztnJPzHMXeeJsmaQRouu6RuZdxT4RgYtMuTVlHzoFB9x4P7DI0FZp
         p5kRxend4azlxLxzT1W+wzL+maZiYyvXgeiAurdA5qr6ZPAMa4ASTI8X4GHnQTRmxGbA
         5/oA==
X-Gm-Message-State: AA+aEWZr7Nzir4/R3fEYiCTWJehs2RXa+Fy1Lagi5mYONfTcg3PiHCWH
        7/Uhy8xWTsYzzVd6Tu+xPhFFyKnXs4xCHsIWP/rr1A==
X-Google-Smtp-Source: AFSGD/WypECx4RAdC6BVOnHhQ3C/kEKBxJ89NTBzKp4OGDZS1zhshGMLgGPX8nnaFWij6NWQTRk+iFbGC0xvOSzORmg=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr5628864iti.166.1543601210702;
 Fri, 30 Nov 2018 10:06:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Fri, 30 Nov 2018 10:06:30
 -0800 (PST)
In-Reply-To: <CACT4Y+ZStCdg6NhyYAtUZS07NWR=oJzdTZxpD+uyr=3SAVSmVw@mail.gmail.com>
References: <0000000000004eade9057ba76eae@google.com> <621f7c52-de52-eb35-bf61-e839adee7ec9@colorfullife.com>
 <CACT4Y+ZStCdg6NhyYAtUZS07NWR=oJzdTZxpD+uyr=3SAVSmVw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 30 Nov 2018 18:06:30 +0000
Message-ID: <CACT4Y+ZLAoZCFMYVB+JiAYo1a8o5KwkQXH8QWaUPdLg2c2wzmg@mail.gmail.com>
Subject: Re: BUG: corrupted list in freeary
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     syzbot <syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:58 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Nov 29, 2018 at 9:13 AM, Manfred Spraul
> <manfred@colorfullife.com> wrote:
>> Hello together,
>>
>> On 11/27/18 4:52 PM, syzbot wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    e195ca6cb6f2 Merge branch 'for-linus' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10d3e6a3400000
>>
>> From the console output:
>>
>> 20:36:14 executing program 4:
>> semget$private(0x12000000, 0x39d0, 0x0)
>>
>>
>> I don't understand the 0x12000000.
>>
>> What does that mean? What is the actual syscall?
>
> Hi Manfred,
>
> The syscall is semget with the first argument 0x12000000.
>
>
>>
>> Is 0x39d0 the number of semaphores in the array, i.e. create ~13.000
>> semaphores?
>
> If the second argument of 0x39d0 relates to creation of 0x39d0
> semaphores, then yes.
>
>
>
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c92d3646e35bc5d1a909
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com
>>
>> input: syz1 as /devices/virtual/input/input670
>> input: syz1 as /devices/virtual/input/input671
>> list_del corruption. prev->next should be ffff8881dae2cdb8, but was
>> 0000000000100000
>> ------------[ cut here ]------------
>> kernel BUG at lib/list_debug.c:53!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 6194 Comm: syz-executor5 Not tainted 4.20.0-rc3+ #348
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> RIP: 0010:__list_del_entry_valid.cold.1+0x48/0x4a lib/list_debug.c:51
>> Code: d0 60 88 e8 b2 31 d2 fd 0f 0b 48 89 de 48 c7 c7 00 d2 60 88 e8 a1 31
>> d2 fd 0f 0b 48 89 de 48 c7 c7 a0 d1 60 88 e8 90 31 d2 fd <0f> 0b 48 89 d9 48
>> c7 c7 60 d2 60 88 e8 7f 31 d2 fd 0f 0b 48 89 f1
>> RSP: 0018:ffff8881848fee80 EFLAGS: 00010286
>> RAX: 0000000000000054 RBX: ffff8881dae2cdb8 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff8165eaf5 RDI: 0000000000000005
>> RBP: ffff8881848fee98 R08: ffff8881848f26c0 R09: 0000000000000006
>> R10: 0000000000000000 R11: ffff8881848f26c0 R12: ffff8881c3173a00
>> R13: ffff8881be118118 R14: ffff8881848ff280 R15: dffffc0000000000
>> FS:  00000000020b2940(0000) GS:ffff8881dae00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000625208 CR3: 00000001c10d3000 CR4: 00000000001406f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  __list_del_entry include/linux/list.h:117 [inline]
>>  list_del include/linux/list.h:125 [inline]
>>  unlink_queue ipc/sem.c:786 [inline]
>>
>> Unlink_queue means transfer all waiting threads to the wake-q.
>>
>> There are 2*(1+<semaphores in the array>) linked lists in an array.
>>
>> And this fails, because one linked list contains 0x100000 instead of a real
>> pointer.
>>
>> I could not find any semop() in the log --> all lists must be empty.
>>
>> Actually, the lists were initialized in newary(), and then never touched.
>>
>>  freeary+0xbd1/0x1a40 ipc/sem.c:1160
>>
>> Free a semaphore array
>>
>>  free_ipcs+0x9f/0x1c0 ipc/namespace.c:112
>>  sem_exit_ns+0x20/0x40 ipc/sem.c:237
>>  free_ipc_ns ipc/namespace.c:120 [inline]
>>
>> Free all ipc ids in the name space
>>
>>  put_ipc_ns+0x66/0x180 ipc/namespace.c:152
>>  free_nsproxy+0xcf/0x220 kernel/nsproxy.c:180
>>
>> Free the name space
>>
>>  switch_task_namespaces+0xb3/0xd0 kernel/nsproxy.c:229
>>  exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
>>  do_exit+0x1ad1/0x26d0 kernel/exit.c:866
>>  do_group_exit+0x177/0x440 kernel/exit.c:970
>>  get_signal+0x8b0/0x1980 kernel/signal.c:2517
>>  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
>>  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
>>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x410fa0
>>
>> This is time code 604.599748 in the console output:
>>
>> [  604.599748] RIP: 0033:0x410fa0
>>
>>
>> Questions:
>>
>> 1) What is this?
>>
>> [  600.924691]  entry_SYSCALL_64_after_hwframe+0x49/0xbe^M
>> [  600.929872] RIP: 0033:0x7f3e597d0120^M
>> [  600.933576] Code: Bad RIP value.^M
>> [  600.936920] RSP: 002b:00007ffc2d83e008 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000002^M
>> [  600.944608] RAX: ffffffffffffffda RBX: 000055ca2995b436 RCX:
>> 00007f3e597d0120^M
>> [  600.951856] RDX: 00007ffc2d83e244 RSI: 0000000000080000 RDI:
>> 00007ffc2d83e220^M
>> [  600.959107] RBP: 000055ca2995b1e0 R08: 0000000000000000 R09:
>> 000055ca2995b099^M
>> [  600.966355] R10: 0000000000000000 R11: 0000000000000246 R12:
>> 0000000000000001^M
>> [  600.973628] R13: 000055ca2995b090 R14: 000055ca2995b190 R15:
>> 00007ffc2d83e220^M
>>
>> Isn't this a kernel stack overrun?
>>
>> RSP: 0x..83e008. Assuming 8 kB kernel stack, and 8 kB alignment, we have
>> used up everything.
>
> I don't exact answer, that's just the kernel output that we captured
> from console.
>
> FWIW with KASAN stacks are 16K:
> https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/page_64_types.h#L10
>
>
> But it looks like the OOM may have been caused by a page fault, so the
> IP/SP are legitimately in user-space, e.g. in the same log:
>
> [  443.339635]  __do_page_fault+0x5e8/0xe60
> [  443.343683]  ? trace_hardirqs_off+0xb8/0x310
> [  443.348079]  do_page_fault+0xf2/0x7e0
> [  443.351867]  ? vmalloc_sync_all+0x30/0x30
> [  443.356002]  ? error_entry+0x70/0xd0
> [  443.359702]  ? trace_hardirqs_off_caller+0xbb/0x310
> [  443.364702]  ? trace_hardirqs_on_caller+0xc0/0x310
> [  443.369620]  ? syscall_return_slowpath+0x5e0/0x5e0
> [  443.374537]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [  443.379390]  ? trace_hardirqs_on_caller+0x310/0x310
> [  443.384397]  ? __bpf_trace_preemptirq_template+0x30/0x30
> [  443.389837]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20
> [  443.395366]  ? prepare_exit_to_usermode+0x291/0x3b0
> [  443.400374]  ? page_fault+0x8/0x30
> [  443.403901]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [  443.408729]  ? page_fault+0x8/0x30
> [  443.412255]  page_fault+0x1e/0x30
> [  443.415693] RIP: 0033:0x43d8e8
> [  443.418884] Code: Bad RIP value.
> [  443.422229] RSP: 002b:000000c43a053490 EFLAGS: 00010206
>
>
>
>
>> - How/where are namespaces used by the bot?
>>
>> I.e. what triggered the namespace exit?
>
> It creates whole set of namespaces per test process:
> https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L1523
>
> but then each test can also execute unshare as well.
>
> Namespace exits usually happen when process terminates.
> In the reported stack it seems to be the case:
>
>  exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
>  do_exit+0x1ad1/0x26d0 kernel/exit.c:866
>  do_group_exit+0x177/0x440 kernel/exit.c:970
>  get_signal+0x8b0/0x1980 kernel/signal.c:2517
>  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
>  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
>
>
>> - There are ~370 calls to semget(), most with large (>10.000) semaphores in
>> the arrays.
>>
>> Starting from [442.544635], the OOM killer starts to kill processes.
>>
>> Is this as intended?
>
> Well, generally everything except for kernel crashes is expected.
>
> We actually sandbox it with memcg quite aggressively:
> https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L2159
> But it seems to manage to either break the limits, or cause some
> massive memory leaks. The nature of that is yet unknown.
>
>
>> - Which stress tests are enabled? By chance, I found:
>>
>> [  433.304586] FAULT_INJECTION: forcing a failure.^M
>> [  433.304586] name fail_page_alloc, interval 1, probability 0, space 0,
>> times 0^M
>> [  433.316471] CPU: 1 PID: 19653 Comm: syz-executor4 Not tainted 4.20.0-rc3+
>> #348^M
>> [  433.323841] Hardware name: Google Google Compute Engine/Google Compute
>> Engine, BIOS Google 01/01/2011^M
>>
>> I need some more background, then I can review the code.
>
> What exactly do you mean by "Which stress tests"?
> Fault injection is enabled. Also random workload from userspace.
>
>
>> Right now, I would put it into my "unknown syzcaller finding" folder.


Since it happened only once, it can well be a previous silent memory
corruption. But we also seen hundreds of subtle data races that ever
fired few times or just once, but turned out to be very real bugs.
Hard to say.
