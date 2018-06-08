Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lzNAJdvLGlt+ZAAAmS7hNA
	; Fri, 08 Jun 2018 18:33:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2C10E607DC; Fri,  8 Jun 2018 18:33:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdJVfglS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 59718605A2;
	Fri,  8 Jun 2018 18:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 59718605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753006AbeFHSdZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:33:25 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34953 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeFHSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:33:23 -0400
Received: by mail-lf0-f49.google.com with SMTP id i15-v6so11150457lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IRtTWZkEX29bLFEo8coqaf3jwvXAtrwmaZnu2gp+UFY=;
        b=VdJVfglSf+HGtGiKJ7JqQW2EhpF70fMnduw1jBTMEnO+8PttLlzNQ4C+/mFf6kU/lz
         NBbg5Bs1VS0UrN7JAi8FMtOHLRIEW382wBfS5ywtumf5kzSvoicit/VgzpAmhWpECi8Y
         kJcOMkJftlHqy7OIlb2dptr+xsc4ZsJBl1ybA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IRtTWZkEX29bLFEo8coqaf3jwvXAtrwmaZnu2gp+UFY=;
        b=i2mUUkixqcOArskFwta6Sn8mmyBakmiFsIm3HQmadfYPtDyIvuM2RCvzdnAEpSzDY5
         9hFlZsBTpGhjD5Kk/UfuDRLWVb8DJ3nDw7m2QwKMaaKxSxv0s+GRTi0ue+1cJ491lmFA
         TVH6ZvngXO+H/Kg360/mj7goKYai59tHLsr/7ouIm0T/qnbVEyna510UqxJ89vfdYs7w
         NxzKd6pEhaW0DIxHyg0YjLJ+bMRWbJUJdDXQVNtH4kFg50oVY4xTvmrP1fMpIWyfQyIC
         wraAMyB5phGjCmgYrSCmJnap2XXSDHMMqdkQd4Vvbcuy3t4a4tJY/QVpAJeCTLFhpjBj
         hm0g==
X-Gm-Message-State: APt69E1jMGQwz2dAgz+rGgjxEhlnGKTnUuscGv6/kxoO0IgPYlN9KNGL
        H+a2tn7aguppuq53ct7uhRLgp7PvpD0cszSzYhdT2TORmY0=
X-Google-Smtp-Source: ADUXVKJZII2UZR4tEZ0gEHvwTrQ6cHn+oo+8ZQDr+X+EYD6XRKLv3w9GRffkKEWb8yy1dM4WnxMI5drgsU1ePj3JKFE=
X-Received: by 2002:a2e:4442:: with SMTP id r63-v6mr5531335lja.89.1528482801693;
 Fri, 08 Jun 2018 11:33:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:5619:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 11:33:20 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 9 Jun 2018 00:03:20 +0530
Message-ID: <CA+G9fYuDfeOwPuPnuVCT4PUPvoAwW-PMP5bExEz+H7hQ5P10Lg@mail.gmail.com>
Subject: mainline: x86_64: kernel panic: RIP: 0010:__xfrm_policy_check+0xcb/0x690
To: open list <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel panic on x86_64 machine running mainline kernel while testing
selftests bpf tests caused this kernel crash.
I have noticed same kernel crash on 4.17.0-next-20180608 on
qemu_x86_64 while running selftests intel_pstate.

[  167.779461] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000008
[  167.779468] PGD 0 P4D 0
[  167.779476] Oops: 0000 [#1] SMP PTI
[  167.779481] CPU: 2 PID: 39 Comm: kauditd Not tainted 4.17.0 #1
[  167.779483] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[  167.779492] RIP: 0010:__xfrm_policy_check+0xcb/0x690
[  167.779493] Code: 80 3d 65 0e f2 00 00 0f 84 c1 02 00 00 4c 8b 25
0b e4 f4 00 e8 36 e2 6a ff 85 c0 74 0d 80 3d 46 0e f2 00 00 0f 84 d5
02 00 00 <49> 8b 44 24 08 48 85 c0 74 0c 48 8d b5 78 ff ff ff 4c 89 ff
ff d0
[  167.779580] RSP: 0018:ffff97392fd03a58 EFLAGS: 00010202
[  167.779584] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 000000000000000f
[  167.779587] RDX: 00000000ffffffff RSI: 00000000ffffffff RDI: ffffffffbb261a80
[  167.779589] RBP: ffff97392fd03b28 R08: ffffffffba43ac00 R09: 0000000000000000
[  167.779591] R10: ffff97392fd039e0 R11: 0000000000000000 R12: 0000000000000000
[  167.779593] R13: ffff97391b27204e R14: ffff97391a869500 R15: ffff9739177a2900
[  167.779597] FS:  0000000000000000(0000) GS:ffff97392fd00000(0000)
knlGS:0000000000000000
[  167.779599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  167.779602] CR2: 0000000000000008 CR3: 000000032841e002 CR4: 00000000003606e0
[  167.779604] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  167.779606] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  167.779608] Call Trace:
[  167.779611]  <IRQ>
[  167.779626]  ? ipt_do_table+0x2eb/0x420
[  167.779630]  ? trace_hardirqs_on+0xd/0x10
[  167.779639]  __xfrm_policy_check2.constprop.36+0x6c/0xc0
[  167.779645]  tcp_v4_rcv+0x9ef/0xbd0
[  167.779656]  ip_local_deliver_finish+0xc1/0x340
[  167.779662]  ip_local_deliver+0x74/0x220
[  167.779667]  ? inet_del_offload+0x40/0x40
[  167.779674]  ip_rcv_finish+0x1f0/0x550
[  167.779679]  ip_rcv+0x282/0x480
[  167.779685]  ? ip_local_deliver_finish+0x340/0x340
[  167.779692]  __netif_receive_skb_core+0x3b2/0xd30
[  167.779700]  ? lock_acquire+0xd5/0x1c0
[  167.779707]  __netif_receive_skb+0x18/0x60
[  167.779711]  ? __netif_receive_skb+0x18/0x60
[  167.779717]  netif_receive_skb_internal+0x79/0x370
[  167.779724]  napi_gro_receive+0x138/0x1b0
[  167.779732]  igb_poll+0x610/0xe70
[  167.779736]  ? mark_held_locks+0x6f/0xa0
[  167.779745]  net_rx_action+0x246/0x4b0
[  167.779758]  __do_softirq+0xbf/0x493
[  167.779769]  irq_exit+0xc3/0xd0
[  167.779774]  smp_apic_timer_interrupt+0x93/0x2a0
[  167.779780]  apic_timer_interrupt+0xf/0x20
[  167.779783]  </IRQ>
[  167.779787] RIP: 0010:console_unlock+0x4e8/0x620
[  167.779788] Code: 4d 66 02 89 05 29 4d 66 02 e9 ed fb ff ff e8 df
ca fe ff 41 55 9d e9 68 fe ff ff 01 d0 e9 97 fc ff ff e8 cb ca fe ff
41 55 9d <e9> 05 ff ff ff 44 89 e2 4c 89 f6 48 89 df ff d1 e9 0c fd ff
ff 48
[  167.779875] RSP: 0018:ffffac6581a2bd18 EFLAGS: 00000247 ORIG_RAX:
ffffffffffffff13
[  167.779879] RAX: ffff97391d0c1700 RBX: 0000000000000000 RCX: 0000000000000006
[  167.779881] RDX: 0000000000000014 RSI: ffff97391d0c1f28 RDI: ffff97391d0c1700
[  167.779883] RBP: ffffac6581a2bd50 R08: 0000000000000001 R09: 0000000000000000
[  167.779885] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000093
[  167.779887] R13: 0000000000000247 R14: ffffffffbc0fc960 R15: 0000000000000000
[  167.779905]  vprintk_emit+0x254/0x430
[  167.779913]  ? audit_log_lost+0xc0/0xc0
[  167.779917]  vprintk_default+0x1f/0x30
[  167.779922]  vprintk_func+0x27/0x60
[  167.779926]  printk+0x52/0x6e
[  167.779931]  ? ___ratelimit+0xb1/0x100
[  167.779938]  kauditd_hold_skb+0x90/0xa0
[  167.779942]  ? audit_send_reply_thread+0x1c0/0x1c0
[  167.779947]  kauditd_send_queue+0xd0/0x110
[  167.779955]  kauditd_thread+0x3b3/0x530
[  167.779960]  ? wait_woken+0xa0/0xa0
[  167.779968]  kthread+0x10d/0x140
[  167.779972]  ? auditd_reset+0xf0/0xf0
[  167.779976]  ? kthread_create_worker_on_cpu+0x70/0x70
[  167.779982]  ret_from_fork+0x3a/0x50
[  167.779993] Modules linked in: xt_mark cls_bpf algif_hash af_alg
x86_pkg_temp_thermal fuse
[  167.780009] CR2: 0000000000000008
[  167.780017] ---[ end trace a70c418202e0491e ]---
[  167.780022] RIP: 0010:__xfrm_policy_check+0xcb/0x690
[  167.780023] Code: 80 3d 65 0e f2 00 00 0f 84 c1 02 00 00 4c 8b 25
0b e4 f4 00 e8 36 e2 6a ff 85 c0 74 0d 80 3d 46 0e f2 00 00 0f 84 d5
02 00 00 <49> 8b 44 24 08 48 85 c0 74 0c 48 8d b5 78 ff ff ff 4c 89 ff
ff d0
[  167.780110] RSP: 0018:ffff97392fd03a58 EFLAGS: 00010202
[  167.780113] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 000000000000000f
[  167.780116] RDX: 00000000ffffffff RSI: 00000000ffffffff RDI: ffffffffbb261a80
[  167.780118] RBP: ffff97392fd03b28 R08: ffffffffba43ac00 R09: 0000000000000000
[  167.780120] R10: ffff97392fd039e0 R11: 0000000000000000 R12: 0000000000000000
[  167.780122] R13: ffff97391b27204e R14: ffff97391a869500 R15: ffff9739177a2900
[  167.780125] FS:  0000000000000000(0000) GS:ffff97392fd00000(0000)
knlGS:0000000000000000
[  167.780128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  167.780130] CR2: 0000000000000008 CR3: 000000032841e002 CR4: 00000000003606e0
[  167.780132] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  167.780135] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  167.780137] Kernel panic - not syncing: Fatal exception in interrupt
[  167.780205] Kernel Offset: 0x38a00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  168.263068] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---


Full log link,
https://lkft.validation.linaro.org/scheduler/job/262004#L2710
https://lkft.validation.linaro.org/scheduler/job/262327#L4451

Best regards
Naresh Kamboju
