Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217A3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B615720874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR3G6PqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B615720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbeGXFEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:04:23 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39232 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbeGXFEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:04:23 -0400
Received: by mail-it0-f66.google.com with SMTP id g141-v6so1822903ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IUGGxQilNeGNgpfoBRbox7MyyQLxsHcAMFGoo7I0Bfc=;
        b=iR3G6PqIck/PllatVPdatLppazKqsWH9hypLTfm3cPPxyqyihW9nnNUix0gnVfYgak
         rkCeFzBv6S8f3Upi/DXC19RhQTR5NfU/yZQvUV2UTTGsXKUJzzJAUfbdN7O/T5tvHsJZ
         Hx2aiAJFAFgEO1IHm+N6MwbVhjrshtI4zVXNjEzPDnbP6FRxA/WUTilwWfvp+L8MoWUG
         8Z4vzWHQN26hGeN1XBgO2b2Y3XoNVeDLdi9WJNeJgbtGSKL95eD4KSh+7BKdOk1HXVAT
         u6NQ//J3ubqO+h7vy23BMRk8eG0slbx9sj90vzCmRrOCMznZhyYVtJiKMX9FxKwdIaiU
         QyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IUGGxQilNeGNgpfoBRbox7MyyQLxsHcAMFGoo7I0Bfc=;
        b=gg2MVqcZ46Ixb11uqAkuF1+p9P2/Yyd7QjoP+gt+y7gKc0GBRtZdM1EZuNiE4aDjQu
         C/J6OQ45Y4SzqGq7QSeT0kYgC6Oc0OFY5tgTCVeMm+9U55EMSafvlrOJw3jQ0emowx5h
         F4g/iupCJsd1O82LeHXRFobey0a/blaSVJsAf2z3jC8TFUn85nm5A4QAdnSCSmBB0Rdc
         8aDLSvSJoo4OkMXZdQxx5g7iaGcF71XHfbf0GMGa/W61VWtDChCIKoZ1Tuqo1KI2heOV
         3fARcH6qZv4Q580LhRgLj/X3eGvTdtyY9iwz93u0f+JU+xBC0boPaClmjiOF4CceQhRZ
         vq6Q==
X-Gm-Message-State: AOUpUlELMfUGaKNU0pV+lV2VfALfpukj7SRtFgYC/AuD+Y2uPYLOZ2vo
        1OmshHP+vqh1FkbpHEm6vnnFXqRXuLP75DbrsPs=
X-Google-Smtp-Source: AAOMgpd03o0shcgVlX3GygOJk7+VZUdQgPlOcGA5a1UTybuZnLxpqgYL3bFWYEXb7z5xjUT/3gHqpiIpyyq3+zsbV+o=
X-Received: by 2002:a24:d41:: with SMTP id 62-v6mr1374875itx.14.1532404797137;
 Mon, 23 Jul 2018 20:59:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9f0a:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 20:59:56
 -0700 (PDT)
In-Reply-To: <20180724033608.GA17607@dragonet>
References: <20180724033608.GA17607@dragonet>
From:   DaeRyong Jeong <threeearcat@gmail.com>
Date:   Tue, 24 Jul 2018 12:59:56 +0900
Message-ID: <CACsK=jdZ5W8AHtjZinwh=9-e5jUo_Lo1mNesvDygdJhPRpPMvw@mail.gmail.com>
Subject: Re: WARNING in port_delete
To:     perex@perex.cz, tiwai@suse.com,
        Colin King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        Kyungtae Kim <kt0755@gmail.com>, bammanag@purdue.edu,
        syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just realized that the crash has been spotted by Syzkaller a few days before.
(https://syzkaller.appspot.com/bug?id=3490860a465e6b39227c6906f0ef2d40ad4d5bb1)

I'm CC'ing Syzkaller's mailing list.


Best regards,
DaeRyong Jeong


On Tue, Jul 24, 2018 at 12:36 PM, Dae R. Jeong <threeearcat@gmail.com> wrote:
> Reporting the crash: WARNING in port_delete
>
> This crash has been found in v4.18-rc3 using RaceFuzzer (a modified
> version of Syzkaller), which we descrbie more at the end of this
> report. Our analysis shows that the race occurs when invoking two close
> syscalls concurrently.
>
>
> The executed program is as follows:
> r0 = open("/dev/snd/seq", 0x0, 0x0)
> ioctl(r0, SNDRV_SEQ_IOCTL_CREATE_PORT, {{0x80}, "706f72943000000000000000000000000000000000000000000000000000000000233f770800000000000000000000000000000000000000001000", 0xffffffffffffffff, 0xfffffffffffffbff})
> r1 = openat(AT_FDCWD, "/dev/sequencer2", 0x8402, 0x0)
> close(r0)
> close(r1)
>
> and two threads executed the program as follows:
> Thread0                                     Thread1
> open("/dev/snd/seq")
> ioctl(r0, SNDRV_SEQ_IOCTL_CREATE_PORT)
> openat("/dev/sequencer2")
> close(r0)                                   close(r1)
>
> (Note that two close() syscalls were exeuted after openat() syscall, and
> two close() syscalls were executed concurrently.)
>
>
> Crash log:
> ==================================================================
> WARNING: CPU: 1 PID: 32519 at /home/daeryong/workspace/race-fuzzer/kernels_repo/kernel_v4.18-rc3/sound/core/seq/seq_ports.c:275 port_delete+0xde/0xf0 sound/core/seq/seq_ports.c:275
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 32519 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x16e/0x22c lib/dump_stack.c:113
>  panic+0x1a8/0x3a7 kernel/panic.c:184
>  __warn+0x191/0x1a0 kernel/panic.c:536
>  report_bug+0x132/0x1b0 lib/bug.c:186
>  fixup_bug.part.10+0x28/0x50 arch/x86/kernel/traps.c:178
>  fixup_bug arch/x86/kernel/traps.c:247 [inline]
>  do_error_trap+0x284/0x2c0 arch/x86/kernel/traps.c:296
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
>  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
> RIP: 0010:port_delete+0xde/0xf0 sound/core/seq/seq_ports.c:275
> Code: 00 00 e8 b5 68 d2 fd 8b 83 58 01 00 00 85 c0 75 1d e8 86 5c ae fd 48 89 df e8 3e 52 d2 fd 31 c0 5b 41 5c 5d c3 e8 72 5c ae fd <0f> 0b eb c8 e8 69 5c ae fd 0f 0b eb da 0f 1f 44 00 00 55 48 89 e5
> RSP: 0018:ffff8801d635f900 EFLAGS: 00010216
> RAX: 0000000000040000 RBX: ffff8801da196900 RCX: ffffffff839b86ee
> RDX: 0000000000005e94 RSI: ffffc90002640000 RDI: ffff8801da196978
> RBP: ffff8801d635f910 R08: 0000000000000098 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff839ba820
> R13: ffff8801da196950 R14: ffff8801ed5bc080 R15: ffff8801da196958
>  snd_seq_delete_port+0x2b0/0x2d0 sound/core/seq/seq_ports.c:303
>  snd_seq_ioctl_delete_port+0x5b/0xa0 sound/core/seq/seq_clientmgr.c:1325
>  snd_seq_kernel_client_ctl+0xd4/0xf0 sound/core/seq/seq_clientmgr.c:2361
>  snd_seq_event_port_detach+0xcb/0x120 sound/core/seq/seq_ports.c:705
>  delete_port+0x3a/0x70 sound/core/seq/oss/seq_oss_init.c:354
>  snd_seq_oss_release+0x7c/0x90 sound/core/seq/oss/seq_oss_init.c:433
>  odev_release+0x40/0x60 sound/core/seq/oss/seq_oss.c:153
>  __fput+0x234/0x470 fs/file_table.c:209
>  ____fput+0x15/0x20 fs/file_table.c:243
>  task_work_run+0x15a/0x1c0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
>  exit_to_usermode_loop+0x2a3/0x2b0 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x485/0x4b0 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x456469
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fe9a8936b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 000000000072bfa0 RCX: 0000000000456469
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000014
> RBP: 0000000000000054 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe9a89376d4
> R13: 00000000ffffffff R14: 00000000006f5880 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> = About RaceFuzzer
>
> RaceFuzzer is a customized version of Syzkaller, specifically tailored
> to find race condition bugs in the Linux kernel. While we leverage
> many different technique, the notable feature of RaceFuzzer is in
> leveraging a custom hypervisor (QEMU/KVM) to interleave the
> scheduling. In particular, we modified the hypervisor to intentionally
> stall a per-core execution, which is similar to supporting per-core
> breakpoint functionality. This allows RaceFuzzer to force the kernel
> to deterministically trigger racy condition (which may rarely happen
> in practice due to randomness in scheduling).
>
> RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
> repro's scheduling synchronization should be performed at the user
> space, its reproducibility is limited (reproduction may take from 1
> second to 10 minutes (or even more), depending on a bug). This is
> because, while RaceFuzzer precisely interleaves the scheduling at the
> kernel's instruction level when finding this bug, C repro cannot fully
> utilize such a feature. Please disregard all code related to
> "should_hypercall" in the C repro, as this is only for our debugging
> purposes using our own hypervisor.
