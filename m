Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +LSaN1xkGVvedwAAmS7hNA
	; Thu, 07 Jun 2018 16:59:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B77EC607E7; Thu,  7 Jun 2018 16:59:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5SJw5GA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BFD6F606DD;
	Thu,  7 Jun 2018 16:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFD6F606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934367AbeFGQ65 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:58:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46307 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932728AbeFGQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:58:54 -0400
Received: by mail-pf0-f195.google.com with SMTP id q1-v6so5194951pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uiGJKXY14qE7ItnVb1RpQJrrBTMrFPHK/i6p4ZTKLiw=;
        b=c5SJw5GASrDIYcHj9CXY4Mj0R7T9hvPSSTj3CZti+kwH0MynOIqEuXtbooma9aAxoT
         923pIytS6na1F0u8SH0wSHhpqhBZjy/xNDJOCER/HffmnGn/pYbkFVXM/uFGMyXX/Xk6
         5OdpkgOEtLTWcVex0ksVK8Y8FhKmfS5xJwJIJPGqERmgdzEvapuMy0MDTBlmgUFduzry
         4EZpmBdCbADxCltQLIDqkfOeTqIXopoTAh8KstySlG0xIR/DJVmeDiaDzYGiIIGGOzt2
         QYLolqfFi6NYQ3ERgh3cLYLqrOyAbJTwslm4Gih3VWybfBeiV8UiBn9wQYyPHQqCMTXV
         O3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uiGJKXY14qE7ItnVb1RpQJrrBTMrFPHK/i6p4ZTKLiw=;
        b=WLTbkIxSJaIP3HDxo2SfnyjAIsnpwRbG7w1qnXbY+Bk3gVu6wCY5/xUvSHhshmkkV/
         nJpiiylxLQJMyEWzDt++66Ip8Cl3a/j7dop3ZaAMRCH5d0QroEAhFdeRJptZXzR6w4HO
         PBrW3vbJvO3ZvEupoDGIUbDoL6nS5AgkmlQB4lSngxRKF/IBC50jJzTwqlvtt6iwaXAr
         luuMcqvlC2HfZd8Osoyq4HR1Bps/54skvVHlQBJhF4ngKljcGG/PVifPbIxsE820Qorx
         HEF36w8Fiu0eoC/jIFTfed+di/hBFBiO071VB1c07Wfxi7r0hN45udhCHDhyLIYpIm6s
         d58A==
X-Gm-Message-State: APt69E0Uh9RYZmpkXn/qZtpWlvxjn9LfR8GsPr/VfNBSgTCUb40ujqhP
        PHB5H3MYIMxySlyWteze77iMvVWAigXKmderb2yuSA==
X-Google-Smtp-Source: ADUXVKJwS7l/Mdh2jEEAsdxPZBEdY6aOIFEVuxl6nq5bLu33geFEvW1mOUpR4DEpH51EAZ0I16iMSqIp9yH5jpH/LpE=
X-Received: by 2002:a62:a38d:: with SMTP id q13-v6mr2515291pfl.49.1528390733443;
 Thu, 07 Jun 2018 09:58:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 09:58:32
 -0700 (PDT)
In-Reply-To: <ca3eff64-adb0-6110-38ca-2e07b6ecc3d6@iogearbox.net>
References: <000000000000cb4149056d3587f5@google.com> <ca3eff64-adb0-6110-38ca-2e07b6ecc3d6@iogearbox.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 18:58:32 +0200
Message-ID: <CACT4Y+YqCF3mcjkJSZaJSpBHazQsucdZWdgksg=Cdi7AFQuEqQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in bpf_tcp_close
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: syzbot <syzbot+31025a5f3f7650081204@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 12:15 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> [ +John ]
>
> On 05/27/2018 10:06 PM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    ff4fb475cea8 Merge branch 'btf-uapi-cleanups'
>> git tree:       bpf-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12b3d577800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b632d8e2c2ab2c1
>> dashboard link: https://syzkaller.appspot.com/bug?extid=31025a5f3f7650081204
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=109a2f37800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171a727b800000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+31025a5f3f7650081204@syzkaller.appspotmail.com
>
> Should be fixed by: https://patchwork.ozlabs.org/patch/920695/

#syz fix: bpf: sockhash fix race with bpf_tcp_close and map delete

>> ==================================================================
>> BUG: KASAN: use-after-free in cmpxchg_size include/asm-generic/atomic-instrumented.h:355 [inline]
>> BUG: KASAN: use-after-free in bpf_tcp_close+0x6f5/0xf80 kernel/bpf/sockmap.c:265
>> Write of size 8 at addr ffff8801ca277680 by task syz-executor749/9723
>>
>> CPU: 0 PID: 9723 Comm: syz-executor749 Not tainted 4.17.0-rc4+ #19
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
>>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>>  kasan_report_error mm/kasan/report.c:354 [inline]
>>  kasan_report.cold.7+0x242/0x2fe mm/kasan/report.c:412
>>  check_memory_region_inline mm/kasan/kasan.c:260 [inline]
>>  check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
>>  kasan_check_write+0x14/0x20 mm/kasan/kasan.c:278
>>  cmpxchg_size include/asm-generic/atomic-instrumented.h:355 [inline]
>>  bpf_tcp_close+0x6f5/0xf80 kernel/bpf/sockmap.c:265
>>  inet_release+0x104/0x1f0 net/ipv4/af_inet.c:427
>>  inet6_release+0x50/0x70 net/ipv6/af_inet6.c:459
>>  sock_release+0x96/0x1b0 net/socket.c:594
>>  sock_close+0x16/0x20 net/socket.c:1149
>>  __fput+0x34d/0x890 fs/file_table.c:209
>>  ____fput+0x15/0x20 fs/file_table.c:243
>>  task_work_run+0x1e4/0x290 kernel/task_work.c:113
>>  exit_task_work include/linux/task_work.h:22 [inline]
>>  do_exit+0x1aee/0x2730 kernel/exit.c:865
>>  do_group_exit+0x16f/0x430 kernel/exit.c:968
>>  __do_sys_exit_group kernel/exit.c:979 [inline]
>>  __se_sys_exit_group kernel/exit.c:977 [inline]
>>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:977
>>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x440a59
>> RSP: 002b:00007ffdadf92488 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440a59
>> RDX: 0000000000440a59 RSI: 0000000000000020 RDI: 0000000000000000
>> RBP: 0000000000000000 R08: 00000000004002c8 R09: 0000000000401ea0
>> R10: 00000000004002c8 R11: 0000000000000206 R12: 000000000001b5ac
>> R13: 0000000000401ea0 R14: 0000000000000000 R15: 0000000000000000
>>
>> Allocated by task 9723:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>>  __do_kmalloc_node mm/slab.c:3682 [inline]
>>  __kmalloc_node+0x47/0x70 mm/slab.c:3689
>>  kmalloc_node include/linux/slab.h:554 [inline]
>>  bpf_map_area_alloc+0x3f/0x90 kernel/bpf/syscall.c:144
>>  sock_map_alloc+0x376/0x410 kernel/bpf/sockmap.c:1555
>>  find_and_alloc_map kernel/bpf/syscall.c:126 [inline]
>>  map_create+0x393/0x1010 kernel/bpf/syscall.c:448
>>  __do_sys_bpf kernel/bpf/syscall.c:2128 [inline]
>>  __se_sys_bpf kernel/bpf/syscall.c:2105 [inline]
>>  __x64_sys_bpf+0x300/0x4f0 kernel/bpf/syscall.c:2105
>>  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Freed by task 4521:
>>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>>  set_track mm/kasan/kasan.c:460 [inline]
>>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>>  __cache_free mm/slab.c:3498 [inline]
>>  kfree+0xd9/0x260 mm/slab.c:3813
>>  kvfree+0x61/0x70 mm/util.c:440
>>  bpf_map_area_free+0x15/0x20 kernel/bpf/syscall.c:155
>>  sock_map_remove_complete kernel/bpf/sockmap.c:1443 [inline]
>>  sock_map_free+0x408/0x540 kernel/bpf/sockmap.c:1619
>>  bpf_map_free_deferred+0xba/0xf0 kernel/bpf/syscall.c:259
>>  process_one_work+0xc1e/0x1b50 kernel/workqueue.c:2145
>>  worker_thread+0x1cc/0x1440 kernel/workqueue.c:2279
>>  kthread+0x345/0x410 kernel/kthread.c:238
>>  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
>>
>> The buggy address belongs to the object at ffff8801ca277680
>>  which belongs to the cache kmalloc-1024 of size 1024
>> The buggy address is located 0 bytes inside of
>>  1024-byte region [ffff8801ca277680, ffff8801ca277a80)
>> The buggy address belongs to the page:
>> page:ffffea0007289d80 count:1 mapcount:0 mapping:ffff8801ca276000 index:0x0 compound_mapcount: 0
>> flags: 0x2fffc0000008100(slab|head)
>> raw: 02fffc0000008100 ffff8801ca276000 0000000000000000 0000000100000007
>> raw: ffffea0006d12b20 ffffea000763bba0 ffff8801da800ac0 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>  ffff8801ca277580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>  ffff8801ca277600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> ffff8801ca277680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                    ^
>>  ffff8801ca277700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>  ffff8801ca277780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>> syzbot can test patches for this bug, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/ca3eff64-adb0-6110-38ca-2e07b6ecc3d6%40iogearbox.net.
> For more options, visit https://groups.google.com/d/optout.
