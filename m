Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB30C20878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FneWqSZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfAKWnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:43:51 -0500
Received: from sonic311-20.consmr.mail.bf2.yahoo.com ([74.6.131.194]:43963
        "EHLO sonic311-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbfAKWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547246629; bh=y1wrN/bq0usYFLtvCdyBRqnB6xvJbPhDLYtTLXxr1ks=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=FneWqSZPPBRX+Pi0IMFs7qboxIe8GJhXPl/tETsSUVdqN7lsF72vhC4tO82QRt1jbQCOoAJ/AxjoEzMOhGU7MilLLLqYbN6pbaUMPhpdPjVpeFb5fv9dhpmYR9kFH7oTCf7XzZX4yaoKNaRjENWWfTIRKbvGJBUWFf6k8KqLDN3xk2Dmt6KNYOjvDZju6+ou9yql9SvNqQFEdtdRSNF+cBBNEGM/YifxCRp/R4HrWzYSsT30yROv3iiMc1Ql9qarBU1O51ihcv+SMwyZkeN+vK4/aPh1Y0GRlusmL3T8zD35V/eDbhloV2ABuTfpc3si5jiGznWE3Xjc+CKS9d4H5Q==
X-YMail-OSG: fFdeJ5sVM1nVLR.iMNPhfhnIurNNItxcDUY_Fz_f3xXGImDrKo9H_4RVxp028z6
 Vc5peg93KPS7KURbggWVQsHlujG0HYrphME3kRi2tcE0tzRPfH9Uc8ZbISDwuCKwTrhc3XAUSTyq
 .ucSaq.Sn4wHSfF53mT5Ao0BOUdg3GBwIJ7VoKoomDhgzyJLQ.H4iBXS.dy9C9XXsH6IYeJye7Je
 JNCVpI2lwws0nDxQUPIGZ9Tpf2ks03R7atZ0AVtvCrBOvwcYGvzLXDpNekS9tHy070pl0BKCM2f9
 7mIMLYvThkuwKytLBCm0mxOdCG9F7V0rtV61N_iMZgfev7uajEWdfOnEn0F3dTOxlQHp8m7OBUur
 6XKM2H.YskhKQMmITmwVkt2q3Oplz2Wj5RNbzOlOsKldSv.iqGDl5GRf8EZ45NmBSw1srRD6SsQI
 Kg4ELFlRdnhSc4HsRc1MnHyUT9mu0V2vPo_yqJP2hzKBAGUNVWCs2nUbAN1CKTGRpktMjQ5AOAx4
 414XUdfP_a4InzWHCpRW6OV.hP6HdbYgB8QRPRtpZexoo3kyjUr65wMDRX0GK1klCcTi.V6eXwP6
 kinzZcQpLlz5yms564dsMaOGWx0Zb.bzhagHsbhOzwSW1E6whsZ7SePGqy67c.q3Kbz7LN0TyYPG
 NVp0I9lMLRGol7H6sL.13p7KF5qdhx_aFUC_Z1eQT9DZb7CsjeiczMoigwpEAWbjEbxdSkNr3EXj
 ILEizIeFVlh0lYXpdP5ej9AGBNJZZDqh42gIYhbNRI3bqlnbNrxeKNM3D03BBxCmbZmse1.RPVbT
 3V9TyPAqEunJg3N5nbyC0z0LoawmCDOzbrjhf4ZAtfk.A4FZq0dr_fLf4p2d4wSBJ4RjsyQe5HoI
 EQ.VtpwukKhZSA5a.u0qz9BS5UmDdx.TbO19U22DOP9rLOmWrphHl.cq6foUVkjfJze8eb04DHdz
 LY5LFt2oC5pbEx6iyF3gKzZJzvELu8Lgsq5UuENpm9YXjTsjjjByu1P5E3TQriKnnEI1_u9RyICQ
 MKyKw.ugr.s0ybGLovr.rpx1M_RYweoVy2sdg5WOIfOZxnrTBN9fj_NPkO0tu1b_UW9AmLeHyZoT
 QYrg9.s1PuWN46qIgI0hTDM8F0XT7Ljb3xL2FB3OJvZAk2w0PkTeSc1lL8qs90lYt
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Jan 2019 22:43:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 504d55a3c0e03b417b3871cadabc724a;
          Fri, 11 Jan 2019 22:43:47 +0000 (UTC)
Subject: Re: WARNING in apparmor_cred_free
To:     John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
References: <0000000000007f604f057f2b8509@google.com>
 <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com>
 <b0d2811e-87e4-21d4-c33a-2d2012a906cc@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <2ccf6281-3f4b-a94a-ed71-31905e583fa6@schaufler-ca.com>
Date:   Fri, 11 Jan 2019 14:43:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <b0d2811e-87e4-21d4-c33a-2d2012a906cc@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2019 2:30 PM, John Johansen wrote:
> On 1/11/19 2:11 PM, Casey Schaufler wrote:
>> On 1/11/2019 1:43 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    b808822a75a3 Add linux-next specific files for 20190111
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=179c22f7400000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c052ead0aed5001b
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=69ca07954461f189e808
>>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162d947f400000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139f6c37400000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+69ca07954461f189e808@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> AppArmor WARN cred_label: ((!blob)):
>>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 cred_label security/apparmor/include/cred.h:30 [inline]
>>> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
>>> Kernel panic - not syncing: panic_on_warn set ...
>>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc1-next-20190111 #10
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>>> Call Trace:
>>>  <IRQ>
>>>  __dump_stack lib/dump_stack.c:77 [inline]
>>>  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>>>  panic+0x2cb/0x65c kernel/panic.c:214
>>>  __warn.cold+0x20/0x48 kernel/panic.c:571
>>>  report_bug+0x263/0x2b0 lib/bug.c:186
>>>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>>>  fixup_bug arch/x86/kernel/traps.c:173 [inline]
>>>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>>>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
>>>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
>>> RIP: 0010:cred_label security/apparmor/include/cred.h:30 [inline]
>>> RIP: 0010:apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
>>> Code: 7c 88 48 c7 c7 00 d0 7c 88 e8 fd 70 f2 fd 0f 0b eb a9 e8 54 3f 29 fe 48 c7 c6 c0 df 7c 88 48 c7 c7 00 d0 7c 88 e8 e1 70 f2 fd <0f> 0b 48 b8 00 00 00 00 00 fc ff df 80 38 00 75 4a 4c 8b 2c 25 00
>>> RSP: 0018:ffff8880ae6079f8 EFLAGS: 00010286
>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>> RDX: 0000000000000100 RSI: ffffffff81687fa6 RDI: 0000000000000006
>>> RBP: ffff8880ae607a18 R08: ffffffff8987dec0 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a86b3100
>>> R13: ffff8880a86b3100 R14: ffff8880a86b3188 R15: dffffc0000000000
>>>  security_cred_free+0x4b/0xf0 security/security.c:1490
>> The obvious thing to do is put a check in security_cred_free
>> for a NULL cred->security, in which case the LSM hooks
>> wouldn't get called.
> Right, but the question is should we? To my thinking we shouldn't
> ever have a cred without cred->security, unless the cred was
> allocated but a later step in its construction, say allocating
> ->security failed.

If allocating ->security fails in security_cred_alloc_blank()
or security_prepare_creds() you don't have to do anything but
fail because the LSM hooks are not called before the allocation.

> In which case I'd rather see the cred directly freed and not
> call into security_cred_free() as I like being able to detect
> corrupt creds.

I think we need to look for some bit of code that's setting
cred->security to NULL inappropriately.

> We certainly can still do the check for security on only live creds
> but I would like to understand this particular failure better first
>
>> It's not clear to me how we got a cred
>> that doesn't have an allocated security blob.
> I have been trying to figure that one out as well.
>
>
>>>  put_cred_rcu+0x21f/0x6e0 kernel/cred.c:118
>>>  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
>>>  rcu_do_batch kernel/rcu/tree.c:2486 [inline]
>>>  invoke_rcu_callbacks kernel/rcu/tree.c:2799 [inline]
>>>  rcu_core+0xc4a/0x1680 kernel/rcu/tree.c:2780
>>>  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
>>>  invoke_softirq kernel/softirq.c:373 [inline]
>>>  irq_exit+0x180/0x1d0 kernel/softirq.c:413
>>>  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>>>  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
>>>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>>>  </IRQ>
>>> RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
>>> Code: ff ff ff 48 89 c7 48 89 45 d8 e8 79 6f d0 f9 48 8b 45 d8 e9 ce fe ff ff 48 89 df e8 68 6f d0 f9 eb 82 90 90 90 90 90 90 fb f4 <c3> 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
>>> RSP: 0018:ffffffff89807c60 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
>>> RAX: 1ffffffff1325061 RBX: 1ffffffff1300f8f RCX: 0000000000000000
>>> RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffffffff8987e73c
>>> RBP: ffffffff89807d20 R08: ffffffff8987dec0 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>> R13: ffffffff89807cf8 R14: 0000000000000000 R15: ffffffff899282f8
>>>  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:555
>>>  default_idle_call+0x36/0x90 kernel/sched/idle.c:93
>>>  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
>>>  do_idle+0x386/0x5d0 kernel/sched/idle.c:262
>>>  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
>>>  rest_init+0x245/0x37b init/main.c:442
>>>  arch_call_rest_init+0xe/0x1b
>>>  start_kernel+0x882/0x8bd init/main.c:742
>>>  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
>>>  x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
>>>  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
>>> Kernel Offset: disabled
>>> Rebooting in 86400 seconds..
>>>
>>>
>>> ---
>>> This bug is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this bug report. See:
>>> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
>>> syzbot can test patches for this bug, for details see:
>>> https://goo.gl/tpsmEJ#testing-patches
>>>
>
