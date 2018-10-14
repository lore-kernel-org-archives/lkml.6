Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA751C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DB520835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 17:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DB520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeJOAxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 20:53:46 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:42571 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeJOAxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 20:53:45 -0400
Received: by mail-it1-f199.google.com with SMTP id v125-v6so19847250ita.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 10:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=057knKzo42j2WmuM7Mf2uD2nZ70LoQWG8EzLBaYLkWo=;
        b=oQUnZ+scOpbcA6Fsopf6F9eJRvnk99VOXv030NOVR2PdOTccEGK5WhxJEEYg8YhO9r
         leaPWeQ8JyRxcpHzJvBgBzsWQdVzjMjrWKbSutwgeDWdBz1mCVactDTgSVwjPf0Deuf1
         bgMg+HUsRqpGJHtfYi6PWzyNS9FpAIbg3rgcsk0jXBU3hFyw/TsbS7YWrSi7xXBKWpFH
         T2q/8TY0qgxVAAx1i9dRoCajhgadn+PjwtNQA/x5JrBJrmjnvcauYnnmsBEhUWkO3Te8
         tzCu8ABRPhJc9vFuqqTJUuX/0CHzlDU40qu7vT9nNCe6m2kB5M+EA5omhCJFrKA4XWn4
         1DfQ==
X-Gm-Message-State: ABuFfogoRk/BHGJEJ6K+xz0eMU030yMW0lG4EVODMvAiCfcPpxtNS+SF
        BanZwunfFdEZaty17GsNopVsNxeEmk+ytw/RQDW/VvSYj94/
X-Google-Smtp-Source: ACcGV61Pw0TFZzXQX9UQJl4ua4DJxoeuyfH1/5d2pOLAzOExAG8LI0BTHBI/ixSI4/roNvkOrMnasKdSSAL+GcjVlDCA2FUnvC62
MIME-Version: 1.0
X-Received: by 2002:a24:9416:: with SMTP id j22-v6mr10375578ite.8.1539537123854;
 Sun, 14 Oct 2018 10:12:03 -0700 (PDT)
Date:   Sun, 14 Oct 2018 10:12:03 -0700
In-Reply-To: <000000000000b3d5610577b9e12c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062cff50578336b0c@google.com>
Subject: Re: WARNING in __put_task_struct (2)
From:   syzbot <syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dledford@redhat.com, dvyukov@google.com,
        ebiederm@xmission.com, guro@fb.com, jgg@ziepe.ca,
        keescook@chromium.org, kirill.shutemov@linux.intel.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, luto@amacapital.net,
        marcos.souza.org@gmail.com, markb@mellanox.com, mhocko@kernel.org,
        riel@surriel.com, swise@opengridcomputing.com,
        syzkaller-bugs@googlegroups.com, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    774ea0551a29 Add linux-next specific files for 20181012
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f71735400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=273e86a7f336b114
dashboard link: https://syzkaller.appspot.com/bug?extid=1ed9dfaa984c88cf0ef8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1735d391400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1296a3a1400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1ed9dfaa984c88cf0ef8@syzkaller.appspotmail.com

audit: type=1800 audit(1539536806.030:30): pid=5454 uid=0 auid=4294967295  
ses=4294967295 subj==unconfined op=collect_data cause=failed(directio)  
comm="startpar" name="rmnologin" dev="sda1" ino=2423 res=0
IPVS: ftp: loaded support on port[0] = 21
WARNING: CPU: 1 PID: 5614 at kernel/fork.c:718  
__put_task_struct+0x3ef/0x620 kernel/fork.c:718
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 5614 Comm: syz-executor338 Not tainted  
4.19.0-rc7-next-20181012+ #93
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x3ab lib/dump_stack.c:113
  panic+0x238/0x4e7 kernel/panic.c:184
  __warn.cold.8+0x163/0x1ba kernel/panic.c:536
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:__put_task_struct+0x3ef/0x620 kernel/fork.c:718
Code: 4c 89 ee e8 c3 a3 7b 00 e9 a1 fe ff ff e8 69 55 37 00 0f 0b e9 7c fd  
ff ff e8 5d 55 37 00 0f 0b e9 87 fd ff ff e8 51 55 37 00 <0f> 0b e9 d0 fc  
ff ff e8 45 55 37 00 49 8d 87 90 05 00 00 31 f6 48
RSP: 0018:ffff8801d7fcee48 EFLAGS: 00010293
RAX: ffff8801d7ffe5c0 RBX: ffff8801d82be540 RCX: ffffffff814711cd
RDX: 0000000000000000 RSI: ffffffff814714ff RDI: 0000000000000005
RBP: ffff8801d7fcef28 R08: ffff8801d7ffe5c0 R09: ffffed003b057cac
R10: ffffed003b057cac R11: ffff8801d82be563 R12: 1ffff1003aff9dcc
R13: 0000000000000000 R14: ffff8801d7fcef00 R15: ffff8801d7f7a9c0
  put_task_struct include/linux/sched/task.h:96 [inline]
  rdma_restrack_del+0x2e0/0x3b0 drivers/infiniband/core/restrack.c:243
  rdma_destroy_id+0x126/0xcc0 drivers/infiniband/core/cma.c:1820
  ucma_close+0x114/0x310 drivers/infiniband/core/ucma.c:1767
  __fput+0x3bc/0xa70 fs/file_table.c:279
  ____fput+0x15/0x20 fs/file_table.c:312
  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x1ad2/0x2610 kernel/exit.c:867
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8a8/0x1970 kernel/signal.c:2517
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4460a9
Code: Bad RIP value.
RSP: 002b:00007f0e9c1a9da8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006dbc48 RCX: 00000000004460a9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc48
RBP: 00000000006dbc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc4c
R13: 666e692f7665642f R14: 0100000000000000 R15: 0000000000000003
Kernel Offset: disabled
Rebooting in 86400 seconds..

