Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053DE2086E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 20:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Get3TyFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053DE2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeGIUsr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 16:48:47 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37387 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932994AbeGIUsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 16:48:45 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so28298586itc.2;
        Mon, 09 Jul 2018 13:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:from:to:cc:subject:date:message-id:mime-version;
        bh=2tggG76yq1t7r18VRQCh+TnlWLtH3ynK2/hfUyj1llE=;
        b=Get3TyFTPyJbLVhwQNFQj0xcrJ14FBm/lWnEQ6wNSmfnSxgD0ALqojhT6A2Ej2wA1q
         J8gwkmXrdIMwDwtRkkTFSx+2uUOw8YRtNkEIqng9dBM9N2orOdiwBT3XPaSJJyutcjVT
         sdo4mHyn+iU8ZuOXyWjoiQ6Uvd6B1ryu04G/qei3LA0GwrR0xFsnxfGOthzicGfWMydl
         zFEwYIyMWRZiRO0VzEM4tCLg1OJVmThdm/EMfmNuzyTzlYiaC2ay0brxvdLHVd2O7kDg
         Gmy6kFgQRwKwX5Z3VJD82D2fUyW54JX0IzwmUrb+nEKtAAKuTM5wzDXxwhdYLaALQVMi
         168Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
         :mime-version;
        bh=2tggG76yq1t7r18VRQCh+TnlWLtH3ynK2/hfUyj1llE=;
        b=U0t2j/11/M9PwSSYEmzoVwCYpMS1kXNnZckyy0iA8vYH1UNSjlRpL2IZ7TTm4EAHcE
         x5e0Psgx+V6PAet/rj3vCpz8OTewdjCDCSSt4Qp7zdegyidMaFl5Qz9IXx2l+mH3g9hX
         jTMR6w8MrzO8OezufjElrD84CTKcyXNg5/3kYpDSWfUpqs0jBh978atPJn8qhetJ66Oi
         moibty1dDHDJk2WnD59WkBGq5d6xP9yCiBFuUqmzqhj7og29wFu3eAKO9C1zgh31gEwV
         A1/9RZFTNWKRCMbpVjkeqnRIh9138G/qaVjf22GZE7dAIJj4RtgO8pivNNGgvjHbswCK
         fh+g==
X-Gm-Message-State: APt69E0C8f7EXzTwxemnrPQHaP5Z4XBFKHEFXxwTwjg8ajUCyq2p7D8/
        bPSq1usXjia4+0lJff8KLH8eOg==
X-Google-Smtp-Source: AAOMgpc7xMkJmVbr7CXKpiYi6krXpWnQrDw/s6Iu71fYWSFQRcG7lC3neSfdn7tuTuCH6a1A5yQ+zg==
X-Received: by 2002:a02:105:: with SMTP id c5-v6mr17854882jad.139.1531169324454;
        Mon, 09 Jul 2018 13:48:44 -0700 (PDT)
Received: from melon (melon.cs.purdue.edu. [128.10.126.30])
        by smtp.gmail.com with ESMTPSA id 16-v6sm8300256itv.19.2018.07.09.13.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 13:48:43 -0700 (PDT)
User-agent: mu4e 1.1.0; emacs 24.5.1
From:   Byoungyoung Lee <lifeasageek@gmail.com>
To:     netdev@vger.kernel.org, ubraun@linux.ibm.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        Kyungtae Kim <kt0755@gmail.com>,
        Basavesh Ammanaghatta Shivakumar <bammanag@purdue.edu>,
        syzkaller@googlegroups.com
Subject: KASAN: null-ptr-deref Read in smc_ioctl
Date:   Mon, 09 Jul 2018 16:48:42 -0400
Message-ID: <87k1q4nnit.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting the crash: KASAN: null-ptr-deref Read in smc_ioctl

This crash has been found in v4.18-rc3 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report.

Our analysis shows that the race occurs when invoking two syscalls
concurrently, ioctl$sock_inet_tcp_SIOCATMARK() and listen(). More
specifically, two code lines, `if (smc->sk.sk_state == SMC_LISTEN)` in
smc_ioctl() and `sk->sk_state = SMC_LISTEN` in smc_listen() are racing
as switching its execution order results in different execution
behaviors, which in turn raises null-ptr-deref.  More details on the
thread interleaving raising the crash are follows.

Thread interleaving:
CPU0 (smc_ioctl)                                        CPU1 (smc_listen)
=====							=====

// net/smc/af_smc.c#L1524 (v4.18-rc3)
if (smc->sk.sk_state == SMC_LISTEN)

                                                        // net/smc/af_smc.c#L1106 (v4.18-rc3)
                                                        sk->sk_state = SMC_LISTEN;
                                                        // ...
                                                        release_sock(lsk);

if (smc->sk.sk_state == SMC_INIT ||
    smc->sk.sk_state == SMC_CLOSED) {
  // ...
} else {

  // ...
  answ = smc_curs_diff(conn->rmb_desc->len, // null-ptr-deref
                       &cons, &urg) == 1;
}

Note that all the other cases in smc_ioctl() seem to have similar race
issues. For example, running the SIOCOUTQNSD case leads to yet another
crashes, such as "KASAN: null-ptr-deref Read in smc_tx_prepared_sends"
or "general protection fault in smc_tx_prepared_sends". In particular,
"general protection fault in smc_tx_prepared_sends" is recently
spotted by Syzkaller
(https://syzkaller.appspot.com/bug?id=02252298a71214aad90c45a91f86ad3d3c9c3588).

==================================================================
BUG: KASAN: null-ptr-deref in smc_ioctl+0x5c5/0x7a0 net/smc/af_smc.c:1536
Read of size 4 at addr 0000000000000020 by task syz-executor0/5046

CPU: 0 PID: 5046 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x26c lib/dump_stack.c:113
 kasan_report_error mm/kasan/report.c:352 [inline]
 kasan_report.cold.7+0x13b/0x2f5 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 __asan_load4+0x78/0x80 mm/kasan/kasan.c:698
 smc_ioctl+0x5c5/0x7a0 net/smc/af_smc.c:1536
 sock_do_ioctl+0xcc/0x380 net/socket.c:969
 sock_ioctl+0x2bd/0x5a0 net/socket.c:1093
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:500 [inline]
 do_vfs_ioctl+0x188/0xf80 fs/ioctl.c:684
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
 __do_sys_ioctl fs/ioctl.c:708 [inline]
 __se_sys_ioctl fs/ioctl.c:706 [inline]
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:706
 do_syscall_64+0x182/0x540 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44b939
Code: 8d 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6708050b48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000071bee0 RCX: 000000000044b939
RDX: 0000000020000180 RSI: 0000000000008905 RDI: 0000000000000015
RBP: 00000000000066a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f67080516d4
R13: 00000000ffffffff R14: 00000000006f2748 R15: 0000000000000001
==================================================================

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

RaceFuzzer's C repro always pinpoints two racy syscalls. Since C
repro's scheduling synchronization should be performed at the user
space, its reproducibility is limited (reproduction may take from 1
second to 10 minutes (or even more), depending on a bug). This is
because, while RaceFuzzer precisely interleaves the scheduling at the
kernel's instruction level when finding this bug, C repro cannot fully
utilize such a feature. Please disregard all code related to
"should_hypercall" in the C repro, as this is only for our debugging
purposes using our own hypervisor.
