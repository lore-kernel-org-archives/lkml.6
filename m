Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id F59YNSlkGVubdgAAmS7hNA
	; Thu, 07 Jun 2018 16:58:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6F857605A2; Thu,  7 Jun 2018 16:58:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wS0ofeuP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 97977606DD;
	Thu,  7 Jun 2018 16:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97977606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933634AbeFGQ6i (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:58:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39535 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932712AbeFGQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:58:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id w12-v6so5040662pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I3GluQff4OmBCDTH6hsyn5D3zGOD7XzJJry0Bu2rmxQ=;
        b=wS0ofeuPNZpKpPFTwFIGiwrdhy6Rnt7FIi4ds0aDlwrteRxD0TShVfDJf2J7YrKCC1
         xVPp6k42aQnyHWFNMi3RRWKEQH0wdwZj41ys8o/v1EME+0SU86dwCBez1tmAwcJiJS6q
         2bxTA+9pqXOri8/D2cPaAuxXokRIh1sJDQVp6NofqhDjXPGeaVqqIGGA15CZnAdV9STi
         6CM5KMR7AQfwxCWXCtGMpiDmwU+uN72Z1YRjYgpi38XaEbNc6QGYtPPSORYLG5sEmnwA
         Db0+f9HO8Wz0G6ELP6/41tmc4RyvhgGUJ+1SIOQ2x3nYZpnvm2nEdWUn2+F4LPkQo2V8
         hI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I3GluQff4OmBCDTH6hsyn5D3zGOD7XzJJry0Bu2rmxQ=;
        b=kvR5OWs2kNgJYp3D7kAbmisJE5a3W+07kdyD+J9XcuBiQaZxiqRehfQyFIKbbqQaFa
         MPBfVZICg3BesNj3ukiaV8Cn/DSDX4ILcvv07wfWuAQnHqdEYU987y2lwkSPiOEPKS5O
         CkL7r62qqvALPlrqXJarmUZxSZn8BhWvJzpVEMfr2hj02TdG88crhHswnI+NDnLWE1ED
         8eMSCgKn2HwzZVoM5Dm+EWXsZMxboV+kWiaaDBkNKDnZahEIU1C8z3O4FO+6FzyzQWIF
         broOmaw55NuzvzmRnK2Vumtnz34+QivARwTXNmKHesnhssD4ccAyqxIRaYds9LVpR62y
         JW0w==
X-Gm-Message-State: APt69E1INCy9t5aCc0u1TjtfUCFOuOM0DqstQ6eqtf4sbMqx1SeyWH0h
        XdWySjs64wQjVEC2Vfg0Tz9HmJTqEnp50g+7YLeY8w==
X-Google-Smtp-Source: ADUXVKI9hQihEipPC7DkegTpfg0GBholC3sWez9EDIaRyltf4UPzy7FJg6c6iZ4BeND0UWYjB8LfsteOYhsyeXhXWVM=
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr2494025pff.199.1528390715883;
 Thu, 07 Jun 2018 09:58:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 09:58:15
 -0700 (PDT)
In-Reply-To: <7257c52b-7632-e313-6e80-a4bc1f8a6bf0@iogearbox.net>
References: <00000000000098e65b056d184a11@google.com> <7257c52b-7632-e313-6e80-a4bc1f8a6bf0@iogearbox.net>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 18:58:15 +0200
Message-ID: <CACT4Y+bN1jHcqovkBu5szmUqNHe3WRS1doOi9v3N6VnxZS7z4g@mail.gmail.com>
Subject: Re: general protection fault in bpf_tcp_close
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: syzbot <syzbot+0ce137753c78f7b6acc1@syzkaller.appspotmail.com>,
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
> On 05/26/2018 11:13 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    fd0bfa8d6e04 Merge branch 'bpf-af-xdp-cleanups'
>> git tree:       bpf-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11da9427800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b632d8e2c2ab2c1
>> dashboard link: https://syzkaller.appspot.com/bug?extid=0ce137753c78f7b6acc1
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+0ce137753c78f7b6acc1@syzkaller.appspotmail.com
>
> Should be fixed by: https://patchwork.ozlabs.org/patch/920695/

#syz fix: bpf: sockhash fix race with bpf_tcp_close and map delete


>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] SMP KASAN
>> Dumping ftrace buffer:
>>    (ftrace buffer empty)
>> Modules linked in:
>> CPU: 0 PID: 12139 Comm: syz-executor2 Not tainted 4.17.0-rc4+ #17
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:__hlist_del include/linux/list.h:649 [inline]
>> RIP: 0010:hlist_del_rcu include/linux/rculist.h:427 [inline]
>> RIP: 0010:bpf_tcp_close+0x7d2/0xf80 kernel/bpf/sockmap.c:271
>> RSP: 0018:ffff8801a8f8ef70 EFLAGS: 00010a02
>> RAX: ffffed00351f1dfd RBX: dffffc0000000000 RCX: dead000000000200
>> RDX: 0000000000000000 RSI: 1bd5a00000000040 RDI: ffff8801cb710910
>> RBP: ffff8801a8f8f110 R08: ffffed003350ac9d R09: ffffed003350ac9c
>> R10: ffffed003350ac9c R11: ffff88019a8564e3 R12: ffff8801cb710380
>> R13: ffff8801b17ea6e0 R14: ffff8801cb710398 R15: ffff8801cb710900
>> FS:  00007f9890c43700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fde1a668000 CR3: 000000019dca2000 CR4: 00000000001406f0
>> DR0: 00000000200001c0 DR1: 00000000200001c0 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
>> Call Trace:
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
>>  get_signal+0x886/0x1960 kernel/signal.c:2469
>>  do_signal+0x98/0x2040 arch/x86/kernel/signal.c:810
>>  exit_to_usermode_loop+0x28a/0x310 arch/x86/entry/common.c:162
>>  prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
>>  syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
>>  do_syscall_64+0x6ac/0x800 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x455a09
>> RSP: 002b:00007f9890c42ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
>> RAX: fffffffffffffe00 RBX: 000000000072bec8 RCX: 0000000000455a09
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000072bec8
>> RBP: 000000000072bec8 R08: 0000000000000000 R09: 000000000072bea0
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> R13: 00007ffcb48ac3ff R14: 00007f9890c439c0 R15: 0000000000000000
>> Code: ff 48 c1 e9 03 80 3c 19 00 0f 85 a9 05 00 00 49 8b 4f 18 48 8b 85 98 fe ff ff 48 89 ce c6 00 00 48 c1 ee 03 48 89 95 d8 fe ff ff <80> 3c 1e 00 0f 85 c6 05 00 00 48 8b 85 98 fe ff ff 48 85 d2 48
>> RIP: __hlist_del include/linux/list.h:649 [inline] RSP: ffff8801a8f8ef70
>> RIP: hlist_del_rcu include/linux/rculist.h:427 [inline] RSP: ffff8801a8f8ef70
>> RIP: bpf_tcp_close+0x7d2/0xf80 kernel/bpf/sockmap.c:271 RSP: ffff8801a8f8ef70
>> ---[ end trace e81227e93c7e7b75 ]---
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/7257c52b-7632-e313-6e80-a4bc1f8a6bf0%40iogearbox.net.
> For more options, visit https://groups.google.com/d/optout.
