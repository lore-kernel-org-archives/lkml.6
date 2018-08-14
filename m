Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9291C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702862171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhQDbax3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702862171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbeHNXa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:30:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37722 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeHNXa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:30:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so9772356pfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 13:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/hQdDTnKvR7srihALThA/rUYJX00xO0FWE5TU2TR9Bs=;
        b=dhQDbax3tF6qK6T3cZzl0APKBVCVdbErAAsWxK/Pd+YXTNn2jveP2t9ImcXR87Lgjz
         RntMzfaE5XVftc3Io3YPm9C0rWam7sK85OoY8SWutlR24SJiLmHtbfml49u8v7feEPrx
         FrsXlGz51LRa47HEGNOL3hiAhgRlMZldmHoJyfomra/xlxLCh+Y+grQmvmFs+AKb1kac
         L3fHFG2kUDBbY/r8JzipRTBkJ/mTW3DZwFsKalr3povAEf7GgI205qYeGR5BtyFmbtCs
         3eheB4NjZYlcTSgLTsQJ1mBPsvfgG0RART50kG49BHln+fSClAKH86JQivX3OCg+5noa
         4F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/hQdDTnKvR7srihALThA/rUYJX00xO0FWE5TU2TR9Bs=;
        b=gOK7qpnlASYMoPEcLL769oHr/bY4oV/EL951llFzRP9qzzdOOZxvXRZj+O3dg5jTxW
         B0xs2dVBRMeo+uFsTt5IPiP4MGx3A5YxEdB2qMcLZo1CHdHsojIGVUJPFDHBOu+M1/kT
         lVZwjI4yG0uxFOUvaxxf0B1Xbwpwj9+vd37vA4jzmaEQ23c7T2D/L9HGCAcQyBe3h6lj
         kpiMv02M2y1umoI262KU74DWw3vs0PBONf0Apjjz9XiD8RWyz6E0/UzGhFy45rDUrA5I
         v11skz/ZNFcznUeTCizzDGH/G8nJ0r8rwWJ1Y1shl2MqwBgPXkVWfJdF3Q1N5Jf4yRhk
         /gjQ==
X-Gm-Message-State: AOUpUlFU5lcy8VylM6iyveaqtAi6+QoNTTENJyM37G30Ap5lCuIct5pk
        qpiRmIbddj37JA38rUhH0H1u+26jhwgfR+305lzuMw==
X-Google-Smtp-Source: AA+uWPz+AdV7/2nTWb1yxGvMf1hlI70+n9s8PnRSG/yY2qpsUb/BbeaV3jQiWRJiujQnvMSVveTe0MickBC5wKXOA5I=
X-Received: by 2002:a63:c046:: with SMTP id z6-v6mr22460221pgi.114.1534279293424;
 Tue, 14 Aug 2018 13:41:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:41:12
 -0700 (PDT)
In-Reply-To: <c8298b92-aa7e-6894-7a9a-f4eb2293a5b3@redhat.com>
References: <000000000000b239d705736497a3@google.com> <c8298b92-aa7e-6894-7a9a-f4eb2293a5b3@redhat.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Aug 2018 13:41:12 -0700
Message-ID: <CACT4Y+aA8SzNeYu3YmWLoKbx6J-O_drbV_okX4WoOWzyoxem6Q@mail.gmail.com>
Subject: Re: WARNING in free_loaded_vmcs (2)
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     syzbot <syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 10:16 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Is there anything that was changed in syzkaller and is causing it to
> find all these bugs?

Nothing has changed on syzkaller side as far as I can tell.


> On 14/08/2018 14:46, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    112cbae26d18 Merge branch 'linus' of
>> git://git.kernel.org/..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=161d8a3c400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
>> dashboard link:
>> https://syzkaller.appspot.com/bug?extid=01bc9e7a8a3f138b71cf
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+01bc9e7a8a3f138b71cf@syzkaller.appspotmail.com
>>
>> WARNING: CPU: 1 PID: 5195 at arch/x86/kvm/vmx.c:4431
>> free_loaded_vmcs+0x160/0x1b0 arch/x86/kvm/vmx.c:4431
>> Kernel panic - not syncing: panic_on_warn set ...
>>
>> CPU: 1 PID: 5195 Comm: syz-executor3 Not tainted 4.18.0-rc8+ #182
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>  __dump_stack lib/dump_stack.c:77 [inline]
>>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>>  panic+0x238/0x4e7 kernel/panic.c:184
>>  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
>>  report_bug+0x252/0x2d0 lib/bug.c:186
>>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>  do_error_trap+0x1fc/0x4d0 arch/x86/kernel/traps.c:296
>>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
>> RIP: 0010:free_loaded_vmcs+0x160/0x1b0 arch/x86/kvm/vmx.c:4431
>> Code: 81 e8 64 25 53 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea
>> 03 80 3c 02 00 75 49 4c 8b 23 e9 22 ff ff ff e8 50 5f 5f 00 <0f> 0b eb
>> b0 e8 77 3b 9d 00 e9 f4 fe ff ff 48 89 df e8 8a 3b 9d 00
>> RSP: 0018:ffff8801947bf780 EFLAGS: 00010293
>> RAX: ffff88018fe4a680 RBX: ffff88018f95e3e8 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffffffff811cb900 RDI: ffff88018f95e3f0
>> RBP: ffff8801947bf798 R08: ffffea0007544608 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8801d5118000
>> R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000000001
>>  vmx_free_vcpu+0x204/0x300 arch/x86/kvm/vmx.c:10299
>>  kvm_arch_vcpu_free arch/x86/kvm/x86.c:8314 [inline]
>>  kvm_free_vcpus arch/x86/kvm/x86.c:8763 [inline]
>>  kvm_arch_destroy_vm+0x365/0x7c0 arch/x86/kvm/x86.c:8860
>>  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:746 [inline]
>>  kvm_put_kvm+0x73f/0x1060 arch/x86/kvm/../../../virt/kvm/kvm_main.c:767
>>  kvm_vcpu_release+0x7b/0xa0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2397
>>  __fput+0x355/0x8b0 fs/file_table.c:209
>>  ____fput+0x15/0x20 fs/file_table.c:243
>>  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>>  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
>>  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
>>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> RIP: 0033:0x410c41
>> Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 19 00 00 c3
>> 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c
>> 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
>> RSP: 002b:0000000000a3fdc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
>> RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000410c41
>> RDX: 0000000000000000 RSI: 0000000000731000 RDI: 0000000000000006
>> RBP: 0000000000000000 R08: ffffffffffffffff R09: ffffffffffffffff
>> R10: 0000000000a3fcf0 R11: 0000000000000293 R12: 0000000000000007
>> R13: 000000000008c6e7 R14: 0000000000000398 R15: badc0ffeebadface
>> Dumping ftrace buffer:
>>    (ftrace buffer empty)
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..
>>
>>
>> ---
>> This bug is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this bug report. See:
>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
>> syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/c8298b92-aa7e-6894-7a9a-f4eb2293a5b3%40redhat.com.
> For more options, visit https://groups.google.com/d/optout.
