Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B3DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7D82173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qFgRx0zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7D82173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbeHNRJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:09:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43007 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeHNRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:09:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so9161084pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=roOtXB+o1QXbekjrzYsbNRJv1BfE7idv1Sy5AbMHiZU=;
        b=qFgRx0zmSmDImbfg62WwOAFJZ7m3Syuu7vx63ATL68+7KbnlgKpyT0oYC6T1oJiZyz
         wOm7yvUU8ye85sRHx11XCdMQJSk2xmIg3etNybF+EOAWrCEHmzGIL53nOYzzkDXaiRUV
         Vcp5VtMnwEa9iEgONVXj7sv5Emq5I6hEXYpyjTeGxEsb5p+ZLX+Ic4bUcKhmeH7k6Lgq
         OdpP1tn0eTCGpathzMEIOTbJtNvIanm1WqqD7JR4IXVQp0oBmPjNE+kYAfHwMB0EITU1
         qRk/hJX6rA98o7ftYDzPyLDvfL/pLpkprvcV8zXA+nB5miBVDZgfMYWcPuLWvtRj3Xgb
         408A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=roOtXB+o1QXbekjrzYsbNRJv1BfE7idv1Sy5AbMHiZU=;
        b=fYDu+EcaFHBuh95espS0xMOZxBKB65ddCcKknX9NFJt9lrfDNtIo1xIIcyfr9XaA0I
         gEIMVwBWt/6wJ2AE4TDqPFIFVQzmbnkpiOTCOBrsxX7fd+r1DXU9obcXDszxa8DSGyU/
         Ljdlcw5/Dos+2RiFqsJgFyKSiOwJ7hCI7BShY8N+0e4WF30kfTbHU0jmcPhtkFSQPD3p
         FVqmp6xb/Cc0dKPfgIaeC/RkOxOq4jbxQuG5X7sRj9ZTv/5KCMYeANZ2G1bcCofFail/
         3l2y/WjL8em+mOZ+Vkdu9saHW/ubsEHKGsrMreYze2F5ADwb06A6HM3F6z562hG3i3fk
         fBzw==
X-Gm-Message-State: AOUpUlHxrDY5as8puVIZfgBPgIYi0ybPrusGND72rWXPBg3jBZbCpcuA
        bRzA3LtR5RQtVAbzVG/w8U32YcLpRZ2a08HnZp19Kg==
X-Google-Smtp-Source: AA+uWPz5qXUvuZfwsJD8Fc303O5X6r+uwUzj7hwQE4pqVnVNKZgvlmrz2dXoHuSvOV7ykvJrKqTspnNh3VZ6P87kfGQ=
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr6225612pgu.96.1534256517344;
 Tue, 14 Aug 2018 07:21:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 14 Aug 2018 07:21:36
 -0700 (PDT)
In-Reply-To: <f6904a2a-5c4e-854b-8fa0-4ad184fed9d6@virtuozzo.com>
References: <0000000000008bc6660570637414@google.com> <f6904a2a-5c4e-854b-8fa0-4ad184fed9d6@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Aug 2018 07:21:36 -0700
Message-ID: <CACT4Y+Yre+9bO2uR9mddjdw4aLVN+kwA53q_OkHZHQiTgSZJ2g@mail.gmail.com>
Subject: Re: general protection fault in cgroup_reconfigure
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     syzbot <syzbot+d4eb75e353a836d57809@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>, guro@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 6:34 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> JFI: Fixed by https://lkml.org/lkml/2018/8/3/351

Thanks!

This is linux-next and the fix was squashed and no Reported-by tag...
so, I don't know, let's do:

#syz fix: kernfs, sysfs, cgroup, intel_rdt: Support fs_context


> On 07.07.2018 10:09, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    526674536360 Add linux-next specific files for 20180706
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=14b51a2c400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d4eb75e353a836d57809
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10ce2cc2400000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149cec58400000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+d4eb75e353a836d57809@syzkaller.appspotmail.com
>>
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> random: sshd: uninitialized urandom read (32 bytes read)
>> kasan: CONFIG_KASAN_INLINE enabled
>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>> general protection fault: 0000 [#1] SMP KASAN
>> CPU: 1 PID: 4415 Comm: syz-executor204 Not tainted 4.18.0-rc3-next-20180706+ #1
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> RIP: 0010:cgroup_reconfigure+0x25/0x80 kernel/cgroup/cgroup.c:1781
>> Code: 00 00 00 00 00 55 48 89 e5 53 48 89 f3 e8 f3 e9 08 00 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 45 48 8b 9b 90 00 00 00 48 b8 00 00 00 00 00 fc ff
>> RSP: 0018:ffff8801acc1f9f8 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c5edb2
>> RDX: 0000000000000012 RSI: ffffffff8173906d RDI: 0000000000000090
>> RBP: ffff8801acc1fa00 R08: ffff8801ad2e45c0 R09: fffffbfff11c24e5
>> R10: fffffbfff11c24e5 R11: ffffffff88e1272b R12: ffff8801d9a14940
>> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
>> FS:  00000000016f3880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020000000 CR3: 00000001b24ea000 CR4: 00000000001406e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  kernfs_sop_reconfigure+0xba/0x100 fs/kernfs/mount.c:31
>>  do_remount_sb+0x34f/0x850 fs/super.c:991
>>  do_umount fs/namespace.c:1467 [inline]
>>  ksys_umount+0xfa7/0x12f0 fs/namespace.c:1585
>>  __do_sys_umount fs/namespace.c:1596 [inline]
>>  __se_sys_umount fs/namespace.c:1594 [inline]
>>  __x64_sys_umount+0x54/0x80 fs/namespace.c:1594
>>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x440059
>> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>> RSP: 002b:00007ffe8d0cd578 EFLAGS: 00000217 ORIG_RAX: 00000000000000a6
>> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440059
>> RDX: 0000000000440059 RSI: 0000000000000000 RDI: 0000000020000040
>> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
>> R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004018e0
>> R13: 0000000000401970 R14: 0000000000000000 R15: 0000000000000000
>> Modules linked in:
>> Dumping ftrace buffer:
>>    (ftrace buffer empty)
>> ---[ end trace 2c2a1923aa2ae1cb ]---
>> RIP: 0010:cgroup_reconfigure+0x25/0x80 kernel/cgroup/cgroup.c:1781
>> Code: 00 00 00 00 00 55 48 89 e5 53 48 89 f3 e8 f3 e9 08 00 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 45 48 8b 9b 90 00 00 00 48 b8 00 00 00 00 00 fc ff
>> RSP: 0018:ffff8801acc1f9f8 EFLAGS: 00010206
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c5edb2
>> RDX: 0000000000000012 RSI: ffffffff8173906d RDI: 0000000000000090
>> RBP: ffff8801acc1fa00 R08: ffff8801ad2e45c0 R09: fffffbfff11c24e5
>> R10: fffffbfff11c24e5 R11: ffffffff88e1272b R12: ffff8801d9a14940
>> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
>> FS:  00000000016f3880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020000000 CR3: 00000001b24ea000 CR4: 00000000001406e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/f6904a2a-5c4e-854b-8fa0-4ad184fed9d6%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
