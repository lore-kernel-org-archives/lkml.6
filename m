Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED830C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4212088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8N2RXeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4212088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbeG0DCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:02:07 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46770 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbeG0DCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:02:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id t17-v6so1589787ply.13;
        Thu, 26 Jul 2018 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2czCNij/z30y1ZYNCEwQnExLgbI/YMT7ZFPRyKeVeg0=;
        b=F8N2RXeSubMAOtrHVBuQkhCPdpmJSjSO/FycIv818S85gavfAP8qmDt2Qy3qxLywQx
         bja2oOmqzSea8lTiXuRTuaagEQ4r2etNjASXhjpPaB+svBAZVrjIUUk1dCGuA5kzifYY
         vbZbNQ53fTTJ+k5tk8ZieXVqoJb6QCdkXpzasbykAXJyfMV7gU/Eqwccp7RC8Dx/RKX6
         XOf+7/6h9ch50bjiRJ6YNg8TZdm4jhuWt1Op+CqvEk4eoBs6CXTj/nT6hqhaW0YB3bKV
         JNblaQ/Kp6vNq4rHDr4xylGSExN+HOUc7MXvWS97v7euqsmrOs+amFp9Of4ETcP623uW
         eysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2czCNij/z30y1ZYNCEwQnExLgbI/YMT7ZFPRyKeVeg0=;
        b=UQ4h5+v6PoVrYbSI1Nm7XR147RuPeVvUtsRrU8wvA/VvKy9KInbVQaUpR3jN4hl29r
         bxH2LDEYhW5ersirBnikM+FaqVeoewM3SY3pbub9k2k6v1Us/guvNH1CuYzEQqqRXpu0
         cPKVWXZpIzyERRjbrZvB0J87Eaea++ulQDBVxmzPuXPsKRWnoPY8ZJ/TzbqSBjOodFEa
         Ntj6u/OvuUYQQ+A0/A3ofhNh/hl+Vp3UrZGnSt6svE2vUfSuDHj3rdjnb7k8tr6NQFgb
         IxOUaZ/gSYQ1vwzOy1+F+H11udCn8WL+C/wHZ16zP3yXVBxWE8FNt6N2mjwBrgQlv97Z
         W0tg==
X-Gm-Message-State: AOUpUlEhri8opy0yl5KWNJVFN5qduLyu8Lqlhk58LvIdr/UDpBq9g1yz
        58h8QDfehG55Ru3rbe94ej6TFOuxmIk=
X-Google-Smtp-Source: AAOMgpekGq/CCrY++Y6j56j9pWHRN2ruvT6v2WmY6wH43OqhO8s7WmV1UQw/ganNH/pQAhFVSmiXpw==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr4078712plp.143.1532655760418;
        Thu, 26 Jul 2018 18:42:40 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id t69-v6sm7915404pfj.7.2018.07.26.18.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 18:42:39 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:42:35 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     jikos@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        lifeasageek@gmail.com, kt0755@gmail.com
Subject: WARNING in schedule_bh
Message-ID: <20180727014235.GA2483@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting the crash: WARNING in schedule_bh

This crash has been found in v4.18-rc4 using a modified version of
Syzkaller, which focus on exploring hard-to-reach coverages.

C repro code:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/repro-98b14a.c
Kernel config:
https://kiwi.cs.purdue.edu/static/alexkkid-fuzzer/config-98b14a

Crash log:
WARNING: CPU: 0 PID: 6107 at drivers/block/floppy.c:984 schedule_bh+0x4d/0x60 drivers/block/floppy.c:984
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 6107 Comm: kworker/u4:6 Not tainted 4.18.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: floppy floppy_work_workfn
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x122/0x198 lib/dump_stack.c:113
 panic+0x27d/0x489 kernel/panic.c:184
 __warn+0x291/0x2d0 kernel/panic.c:536
 report_bug+0x243/0x300 lib/bug.c:186
 fixup_bug.part.9+0x42/0x1a0 arch/x86/kernel/traps.c:178
 fixup_bug arch/x86/kernel/traps.c:248 [inline]
 do_error_trap+0x278/0x2c0 arch/x86/kernel/traps.c:296
 do_invalid_op+0x20/0x30 arch/x86/kernel/traps.c:316
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:992
RIP: 0010:schedule_bh+0x4d/0x60 drivers/block/floppy.c:984
Code: c2 29 fe 48 8b 35 43 ee 88 07 48 c7 c2 40 f4 ac 88 bf 40 00 00 00 48 89 1d 50 e9 88 07 e8 cb 77 03 fe 5b 5d c3 e8 63 c2 29 fe <0f> 0b eb d0 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 
RSP: 0018:ffff88011a607d38 EFLAGS: 00010006
RAX: 0000000000010000 RBX: ffffffff83350970 RCX: ffffffff8333e1bd
RDX: ffff880110404440 RSI: ffffffff8abcd070 RDI: ffffffff83350970
RBP: ffff88011a607d40 R08: fffffbfff10e6995 R09: fffffbfff10e6995
R10: ffffffff88734ca3 R11: fffffbfff10e6994 R12: ffffffff83350970
R13: ffffffff8abcd070 R14: 0000000000000000 R15: ffffffff8abce960
 floppy_interrupt+0x1f6/0x390 drivers/block/floppy.c:1734
 floppy_hardint+0x25c/0x330 arch/x86/include/asm/floppy.h:66
 __handle_irq_event_percpu+0x10e/0xa30 kernel/irq/handle.c:149
 handle_irq_event_percpu+0x71/0x160 kernel/irq/handle.c:189
 handle_irq_event+0xca/0x170 kernel/irq/handle.c:206
 handle_edge_irq+0x2b0/0x960 kernel/irq/chip.c:791
 generic_handle_irq_desc include/linux/irqdesc.h:154 [inline]
 handle_irq+0x2dc/0x480 arch/x86/kernel/irq_64.c:77
 do_IRQ+0x15b/0x3c0 arch/x86/kernel/irq.c:245
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:642
 </IRQ>
RIP: 0010:outb arch/x86/include/asm/io.h:333 [inline]
RIP: 0010:outb_p arch/x86/include/asm/io.h:333 [inline]
RIP: 0010:output_byte+0x133/0x3d0 drivers/block/floppy.c:1128
Code: 03 48 01 d0 80 38 00 0f 85 ab 02 00 00 4a 8d 14 b5 00 00 00 00 44 89 e8 49 01 d6 49 c1 e6 03 49 8b 96 70 d0 bc 8a 83 c2 05 ee <49> c7 c4 30 e1 6b 88 48 ba 00 00 00 00 00 fc ff df 4c 89 e0 48 c1 
RSP: 0018:ffff8800b998fcb8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffffdc
RAX: 00000000ffffff8f RBX: 0000000000000090 RCX: ffffffff833438e3
RDX: 00000000000003f5 RSI: ffffffff8abcd070 RDI: ffffffff8abcd070
RBP: ffff8800b998fce0 R08: ffffffff8abcd070 R09: ffffffff8abcd060
R10: 0000000000000000 R11: ffffffff8abcd070 R12: 0000000000000000
R13: 00000000ffffff8f R14: 0000000000000000 R15: 0000000000000000
 seek_floppy drivers/block/floppy.c:1616 [inline]
 floppy_ready+0xac4/0x18f0 drivers/block/floppy.c:1920
 seek_interrupt+0x2c2/0x540 drivers/block/floppy.c:1540
 floppy_work_workfn+0x1a/0x20 drivers/block/floppy.c:977
 process_one_work+0x98d/0x1a30 kernel/workqueue.c:2153
 worker_thread+0x8f/0xcf0 kernel/workqueue.c:2296
 kthread+0x3d5/0x4b0 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..

