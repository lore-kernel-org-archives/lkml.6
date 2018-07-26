Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D586CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeGGXRKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB5D2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeGZHIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:08:42 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38315 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeGZHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:08:42 -0400
Received: by mail-pl0-f67.google.com with SMTP id b1-v6so311031pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 22:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=U6hdG/jj039FZltLgXXw8FTQBHGX3zT6d8phyxSzPFA=;
        b=XeGGXRKPbFHi7oGQODzkiGduYJhFWcPznLRw4fD8lsnOlJbjb2w/nAWbRyHrJuVEwS
         UDycdUltko8H68QSbxgdGK4SqfhA5SaPwnSNxN/IL0UwEgoeqygAKp1fCfRtUjYs0SB/
         XwkBiIJUwlYj2uUe58hN+fjd2WaxXh2YfBS2NFJ88USTIhZjbYkYoHXWHJScvQ++jY9x
         OJBOAZrG7hv7AmbrXlqSEA8GCZt78+b8PsDFVq7f0zqlcHM4OwxWGeSl4NfXK1x90PNl
         2I6gGpgU1n4aA4GxdGX85ZYV8vG7D+9ocp5EoZq/ha87hjq/8PNzOxu2miUgmK/Kj/R5
         Q9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=U6hdG/jj039FZltLgXXw8FTQBHGX3zT6d8phyxSzPFA=;
        b=KPLOygQjdZlDZAZT/MpMKcFOpkAe5TkX/eJ1vd0/P2iOfu58aXOyobaZLuQsFxIovt
         q/Uk2zAOuH8o+kslfI4TQY7rGRK0Oljqkbu4l76pBqKujgjz8qDJeM4nflJCH3BxnX7P
         PJ5Q2vV0t/c3bCf4I/JnYLo1iwtraa3J8kFS/MvHPylMuktQnI/UO5QjY5gkByJExEnp
         IrzDJnuXgQcBhMlhOW7JUaVrUkhaJEwXysd6UxO8+BdBUuNfuOM53OV8qg9i7wjHwJrF
         JNJhZX3uilQ8ZyGQFdFgeLOBFR5+IdeAdSMuyZjs17R4ovTfNQnR50Aq6mtdxJi5Pj5G
         3uIw==
X-Gm-Message-State: AOUpUlFRZnYvWMrTw/iF+l8xQKm2M3/Wy/zj9815f8WYprA2DdzVlh83
        pysH00wlylfv37IXE3YhmNo=
X-Google-Smtp-Source: AAOMgpdM+lOVAgueLso/qeXJmE0GKOYY+6S7V56DP813sqTFDS5a7YnruLeuqCB07v6dqOSFTTOzUQ==
X-Received: by 2002:a17:902:8215:: with SMTP id x21-v6mr603583pln.175.1532584411370;
        Wed, 25 Jul 2018 22:53:31 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id d62-v6sm670163pfc.172.2018.07.25.22.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 22:53:30 -0700 (PDT)
Date:   Thu, 26 Jul 2018 14:53:26 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kt0755@gmail.com, bammanag@purdue.edu, syzkaller@googlegroups.com
Subject: BUG: soft lockup in snd_virmidi_output_trigger
Message-ID: <20180726055326.GA12625@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting the crash: BUG: soft lockup in snd_virmidi_output_trigger

This crash has been found in v4.18-rc3 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report.

Note that this bug is previously reported by Syzkaller a few month ago.
(https://syzkaller.appspot.com/bug?id=642c927972318775e0ea1b4779ccd8624ce9e6f5)
Nonetheless, the crash still can be detected. We guess that the crash has
not fixed yet.
We report the crash log and the attached reproducer with a hope that they are
helpful to diagnose the crash and to fix a bug.

C Reproducer:
https://kiwi.cs.purdue.edu/static/race-fuzzer/repro-dab082.c

Kernel config:
https://kiwi.cs.purdue.edu/static/race-fuzzer/config-dab082

(Please disregard all code related to "should_hypercall" in the C repro,
as this is only for our debugging purposes using our own hypervisor.)


Crash log:
==================================================================
watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [syz-executor0:24261]
Modules linked in:
irq event stamp: 6692
hardirqs last  enabled at (6691): [<ffffffff84eb1f12>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (6691): [<ffffffff84eb1f12>] _raw_spin_unlock_irqrestore+0x62/0x90 kernel/locking/spinlock.c:184
hardirqs last disabled at (6692): [<ffffffff85000905>] interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (1468): [<ffffffff852005ff>] __do_softirq+0x5ff/0x7f4 kernel/softirq.c:314
softirqs last disabled at (1455): [<ffffffff8130de56>] invoke_softirq kernel/softirq.c:368 [inline]
softirqs last disabled at (1455): [<ffffffff8130de56>] irq_exit+0x126/0x130 kernel/softirq.c:408
CPU: 1 PID: 24261 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x7d/0x90 kernel/locking/spinlock.c:184
Code: 0d c8 ce 16 7b 5b 41 5c 5d c3 e8 3e 0f 52 fc 48 c7 c7 68 b0 71 86 e8 62 4c 8d fc 48 83 3d 42 91 86 01 00 74 0e 48 89 df 57 9d <0f> 1f 44 00 00 eb cd 0f 0b 0f 0b 0f 1f 84 00 00 00 00 00 55 48 89 
RSP: 0018:ffff8801b8e4f7e8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000000282 RCX: ffffffff84eb1f1e
RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: 0000000000000282
RBP: ffff8801b8e4f7f8 R08: ffffed002573a06a R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88012b9d0348
R13: ffff8801e6417580 R14: ffff8801b8e4f868 R15: ffff8801e64175a8
FS:  00007f3447a49700(0000) GS:ffff8801f6d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3447a48db8 CR3: 00000001ee58d000 CR4: 00000000000006e0
Call Trace:
 spin_unlock_irqrestore include/linux/spinlock.h:365 [inline]
 snd_virmidi_output_trigger+0x37d/0x420 sound/core/seq/seq_virmidi.c:205
 snd_rawmidi_output_trigger sound/core/rawmidi.c:150 [inline]
 snd_rawmidi_kernel_write1+0x383/0x410 sound/core/rawmidi.c:1288
 snd_rawmidi_write+0x249/0xa50 sound/core/rawmidi.c:1338
 __vfs_write+0xf9/0x5d0 fs/read_write.c:485
 vfs_write+0x195/0x380 fs/read_write.c:549
 ksys_write+0xdb/0x1d0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x43/0x50 fs/read_write.c:607
 do_syscall_64+0x182/0x540 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44b939
Code: 8d 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00 
RSP: 002b:00007f3447a48b48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000071bfa0 RCX: 000000000044b939
RDX: 000000002000010b RSI: 0000000020000100 RDI: 0000000000000013
RBP: 000000000000b7a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3447a496d4
R13: 00000000ffffffff R14: 00000000006f7848 R15: 0000000000000000


= About RaceFuzzer

RaceFuzzer is a customized version of Syzkaller, specifically tailored
to find race condition bugs in the Linux kernel. While we leverage
many different technique, the notable feature of RaceFuzzer is in
leveraging a custom hypervisor (QEMU/KVM) to interleave the
scheduling. In particular, we modified the hypervisor to intentionally
stall a per-core execution, which is similar to supporting per-core
breakpoint functionality. This allows RaceFuzzer to force the kernel
to deterministically trigger racy condition (which may rarely happen
in practice due to randomness in scheduling).
