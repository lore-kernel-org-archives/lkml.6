Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E9C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BA721783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nqBc0vw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfAKWL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:11:56 -0500
Received: from sonic302-10.consmr.mail.bf2.yahoo.com ([74.6.135.49]:37441 "EHLO
        sonic302-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbfAKWL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1547244714; bh=T+syzB2I6JcLyyhffGrks0lAauTditeSDgv6uDBu6lE=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=nqBc0vw5Elku5hDDo8xLKm8m+erJ7RKrC0lq9fAM/NUq1wMrp0exR9+mK2FEN7QscEDc5Yae82X4LBZzUGH3WSgWkWDfSvI7uvowW3k0EKCiHWvaHJVXsylV2i/LCIKlocjSJp5idNTyFQ3tFKlJP2MmuoRuZMFDFHRnId83YC+8xgwYVyTVUTqM33C/DyEt17408sTYNZEzlpzGWODp2a/03/d8vqxtGLKHG/qm9mxtZmeMyNNp6Scl1wOwqzpxoMbGR8D724Q4JP0v8qCZmzkKXkvOVqzXtZhw0eCsscrY+SzMojJnRy1+YaJsDUoW2PFOrC+igYIM2Tj7A+QaXw==
X-YMail-OSG: QqxStRcVM1khDpEyJWBZH82lFEdOfglGOxBHnlRkQAHY706jzqg30pjtQlW27uG
 WyF8qatFZg1faIRNNwwx69TphVQlCOAgAZ2u40W4sMISjEY0GoKxLzbcQPEFaFBSlN.u4uqF5zh.
 ZVDn2sEdx5PWZfJuIAvKjISJA5YuB3Sy4a2IN6gbWyZZO25ftaaQcPwJIULwC6ykcIFWiSKlbO74
 Zx9OLFY5pda6j0ZlC6tOsQ.h08w7tHHYEoU1sCiK0njhs3zwUoMSZWdQpv1UPWOQDR5baiT4zZFP
 A9Odp_w0A6QWe5V1H7Y0ktEe4foHx6NyPmBRa8ND1vOd2BlukHYFSHXp_s0FYCVcwaHU2jAHSHL3
 46twt5q0GMB6g2_h6H0UBgXG8Iv2IpaJXg73mRgX2BoUnbrPD7s_2s0ry.LSzhft2KBGZkEL7tuR
 nsvo56mH9Mfuk507Qo_OYRczSVB5QQXUf6ytgdhYvNdHrg3OeM6l_SYaCq1atxh_4tgGOlpYIwbM
 dfjK3V7rdp.v1Z6.pFgkzAXx2To1kuu1QWijbPtyW9wdyldBWUXxPOmetiY7hXCeGbTplKduGr1w
 olKQD9NeMGQi5fLujW_a49lyJGqDshE69p8UlXyALwQvJrbHYDxAUY29zYbvNg4OWtFZeiMih6qp
 4jOiRIPNnlAOgvwPHAWiIUJnCJcIlNqTdEPX0Hy7P6MXKSSbURAXxAHvfm7GWl_PYRDeJBtj8Ga_
 m6PI2v.I7GIG5COV4UvvgE23Zix7MBzweYljouEbRMo.R49EoLOs5VOo.Oy6p3hh8C1hCtzmywOT
 X2oE90fP3kR54Xw_s9ATgvEv1A0Iff4PrL.bxgaFSL.XBKyUgb.yUY5XOxOd1fK.Rtk4EOiTZ5T_
 t4IDdcRCClaFCiZxeNUHVD8voWck3_wKjpDGSit9cyoVi8aBpdaimbhcVGnZj12C6NJ_GAB1dK3V
 L6NZO_la9o7kNlhRtI8f1672DuU1ufybv96lNUpN1NfBw99sfxUxMWDYoOIdUhmSn779XYuxx6m0
 WaXPY99r55Gi3YTnImNysjaTJsmoZQQuygf9yBzpxTm2tb57jZ2jy6pWsurmj3texe0D1n5OTIx5
 EFBitm6WNuy0aCTamNLnB7mcAgfIl3z9nCJke1PVh4dsHSumUq78kImtEPVrhtv_StFITo8fV
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Jan 2019 22:11:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5db66def429044df9e0283d87eaa48f4;
          Fri, 11 Jan 2019 22:11:52 +0000 (UTC)
Subject: Re: WARNING in apparmor_cred_free
To:     jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
References: <0000000000007f604f057f2b8509@google.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6213e783-4377-489d-cdfb-1a83f4497076@schaufler-ca.com>
Date:   Fri, 11 Jan 2019 14:11:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <0000000000007f604f057f2b8509@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/2019 1:43 AM, syzbot wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b808822a75a3 Add linux-next specific files for 20190111
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=179c22f7400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c052ead0aed5001b
> dashboard link: https://syzkaller.appspot.com/bug?extid=69ca07954461f189e808
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162d947f400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139f6c37400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+69ca07954461f189e808@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> AppArmor WARN cred_label: ((!blob)):
> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 cred_label security/apparmor/include/cred.h:30 [inline]
> WARNING: CPU: 0 PID: 0 at security/apparmor/include/cred.h:30 apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc1-next-20190111 #10
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1db/0x2d0 lib/dump_stack.c:113
>  panic+0x2cb/0x65c kernel/panic.c:214
>  __warn.cold+0x20/0x48 kernel/panic.c:571
>  report_bug+0x263/0x2b0 lib/bug.c:186
>  fixup_bug arch/x86/kernel/traps.c:178 [inline]
>  fixup_bug arch/x86/kernel/traps.c:173 [inline]
>  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
>  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
> RIP: 0010:cred_label security/apparmor/include/cred.h:30 [inline]
> RIP: 0010:apparmor_cred_free+0x12f/0x1a0 security/apparmor/lsm.c:62
> Code: 7c 88 48 c7 c7 00 d0 7c 88 e8 fd 70 f2 fd 0f 0b eb a9 e8 54 3f 29 fe 48 c7 c6 c0 df 7c 88 48 c7 c7 00 d0 7c 88 e8 e1 70 f2 fd <0f> 0b 48 b8 00 00 00 00 00 fc ff df 80 38 00 75 4a 4c 8b 2c 25 00
> RSP: 0018:ffff8880ae6079f8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000100 RSI: ffffffff81687fa6 RDI: 0000000000000006
> RBP: ffff8880ae607a18 R08: ffffffff8987dec0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a86b3100
> R13: ffff8880a86b3100 R14: ffff8880a86b3188 R15: dffffc0000000000
>  security_cred_free+0x4b/0xf0 security/security.c:1490

The obvious thing to do is put a check in security_cred_free
for a NULL cred->security, in which case the LSM hooks
wouldn't get called. It's not clear to me how we got a cred
that doesn't have an allocated security blob.

>  put_cred_rcu+0x21f/0x6e0 kernel/cred.c:118
>  __rcu_reclaim kernel/rcu/rcu.h:240 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2486 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:2799 [inline]
>  rcu_core+0xc4a/0x1680 kernel/rcu/tree.c:2780
>  __do_softirq+0x30b/0xb11 kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0x180/0x1d0 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>  smp_apic_timer_interrupt+0x1b7/0x760 arch/x86/kernel/apic/apic.c:1062
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
>  </IRQ>
> RIP: 0010:native_safe_halt+0x2/0x10 arch/x86/include/asm/irqflags.h:58
> Code: ff ff ff 48 89 c7 48 89 45 d8 e8 79 6f d0 f9 48 8b 45 d8 e9 ce fe ff ff 48 89 df e8 68 6f d0 f9 eb 82 90 90 90 90 90 90 fb f4 <c3> 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f4 c3 90 90 90 90 90 90
> RSP: 0018:ffffffff89807c60 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
> RAX: 1ffffffff1325061 RBX: 1ffffffff1300f8f RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffffffff8987e73c
> RBP: ffffffff89807d20 R08: ffffffff8987dec0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ffffffff89807cf8 R14: 0000000000000000 R15: ffffffff899282f8
>  arch_cpu_idle+0x10/0x20 arch/x86/kernel/process.c:555
>  default_idle_call+0x36/0x90 kernel/sched/idle.c:93
>  cpuidle_idle_call kernel/sched/idle.c:153 [inline]
>  do_idle+0x386/0x5d0 kernel/sched/idle.c:262
>  cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:353
>  rest_init+0x245/0x37b init/main.c:442
>  arch_call_rest_init+0xe/0x1b
>  start_kernel+0x882/0x8bd init/main.c:742
>  x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:470
>  x86_64_start_kernel+0x77/0x7b arch/x86/kernel/head64.c:451
>  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
