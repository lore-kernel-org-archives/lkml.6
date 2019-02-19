Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A522177E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbfBSDFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:05:04 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:53965 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfBSDFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:05:04 -0500
Received: by mail-it1-f200.google.com with SMTP id i65so2189782ite.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M+mkyJ/hGQngn7YX1uDc8pbk4lHG23PAGDCXhbQHtUU=;
        b=nMinO+40XN3sPxVCGTMKUXqKxOyKRoV6K5YYnJyZb4CiFYm0Amw2bLPmuG3ltxIFW6
         QiYqqM4LEMtDqKzBJ73xEO3+YGjvaU0Lf8lJVIy1LmNTK6899A8Et5vY/bFSCKEphNoP
         iCGQBAF6lNeK3IZnoTeoeEn0dkji1lJjab5qaQG1tGtSueVZcUf9fYh1rbV/sDf+i5b8
         MQFYLO29I/nJPniMJ+5GuwtfDySLws5o0Eccrxk2Z/vFesHzKGsvCuC83jKm3jdrWbJN
         3ja1vTjbszDKrR1JKYrJ2B960GsDfiYa7acHXzSIwFsmvPcOctmd0smEo4ApFdEQzIGd
         Zitw==
X-Gm-Message-State: AHQUAubtmiBSjWNo5ZsvGQodX8cE5CuvWrK+69IOd04wPQwOaA4n8xgH
        hOkbi7abjZkF5P5F27IQoY3tb8q6x40J8Y811nYaUpnEaZbx
X-Google-Smtp-Source: AHgI3IZ5Enc6Ujqe+3v1CWhH6vAIeRrXSVIB4QEfJGeGVNJx+YG5lnvzyNaUveaL6JeUIMj69NiB3zmhHurXOTkWFd23QC4aOkTx
MIME-Version: 1.0
X-Received: by 2002:a24:4d8e:: with SMTP id l136mr1215448itb.5.1550545503344;
 Mon, 18 Feb 2019 19:05:03 -0800 (PST)
Date:   Mon, 18 Feb 2019 19:05:03 -0800
In-Reply-To: <000000000000c5745b0573d62311@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef6010058236812f@google.com>
Subject: Re: WARNING in xfrm_policy_fini
From:   syzbot <syzbot+9bce6db6c82f06b85d8b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    a3b22b9f11d9 Linux 5.0-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e3d4d0c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=9bce6db6c82f06b85d8b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177317a8c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bce6db6c82f06b85d8b@syzkaller.appspotmail.com

bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
cgroup: fork rejected by pids controller in /syz3
cgroup: fork rejected by pids controller in /syz2
WARNING: CPU: 1 PID: 31 at net/xfrm/xfrm_policy.c:3871  
xfrm_policy_fini+0x30c/0x3a0 net/xfrm/xfrm_policy.c:3871
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 31 Comm: kworker/u4:2 Not tainted 5.0.0-rc7 #77
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
kobject: 'loop1' (00000000fd200829): kobject_uevent_env
RIP: 0010:xfrm_policy_fini+0x30c/0x3a0 net/xfrm/xfrm_policy.c:3871
Code: c3 e8 b8 e9 72 fb 0f 0b e9 49 fe ff ff e8 ac e9 72 fb 0f 0b e9 cd fd  
ff ff e8 a0 e9 72 fb 0f 0b e9 00 ff ff ff e8 94 e9 72 fb <0f> 0b e9 62 fd  
ff ff e8 98 e8 a9 fb e9 7d fe ff ff 4c 89 ff e8 ab
kobject: 'loop1' (00000000fd200829): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RSP: 0018:ffff8880a9a8fbb0 EFLAGS: 00010293
RAX: ffff8880a9a82100 RBX: ffff88808e30dbf0 RCX: 1ffff1101535053e
RDX: 0000000000000000 RSI: ffffffff85fcf7ec RDI: ffff8880a9a8297c
RBP: ffff8880a9a8fbf0 R08: ffff8880a9a82100 R09: ffff8880a9a829f0
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88808e30c080
R13: ffff8880a9a8fcc8 R14: ffffffff893d5eb8 R15: dffffc0000000000
  xfrm_net_exit+0x1d/0x70 net/xfrm/xfrm_policy.c:3931
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x3fb/0x960 net/core/net_namespace.c:551
kobject: 'loop1' (00000000fd200829): kobject_uevent_env
kobject: 'loop1' (00000000fd200829): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
cgroup: fork rejected by pids controller in /syz1
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..

