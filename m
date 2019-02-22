Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80720700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfBVRKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:10:06 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:43545 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:10:05 -0500
Received: by mail-it1-f200.google.com with SMTP id i186so2352821ite.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=V3seM8LJAokEaSEkGcL06BwSPKoHq6EDcTbNNxNfo6c=;
        b=Yb0CdAV7vwMB6nhRZI+qGwBZBjMJyMTlhRXivLdVqxCsWhKNa+1O1BJV2GvBJlSMqs
         dVdD1ucDFHCbYHh7CYdTbI2Ep5ecQ2bjv7cSFzqSelJ4LEKnn5iOb/slYPTPAk4t6ygI
         Qp3GBhY/aTBMhf9n72fLnuoGXd3EhPxRKUzVF7RYw8NacRbclGG6vRaGgaVknlre9uqD
         Gf7JSioBOdlsdAci+uBgd3CzktyR6tON1rdMDT4mjOimW4HN8fL1Owjzu8APnUJRremL
         lIFP44jjgZGfInGIbJH0gq2d8VH+0gIIYzIteMP/499ebDjs0ljL6kGdTcRIEVcOgyIz
         ip6A==
X-Gm-Message-State: AHQUAuZvH6Inl1kvMDl7yuTaQ0MPbbETeA7WvHD60I//FevUCYuVc/kP
        yeE/ysEPhCL+lXhOaLDzfyJCSjhKtRXJNjTawcuc2F3eRMJ/
X-Google-Smtp-Source: AHgI3IYIOdIU+i97w3f8QBXJsGzVBEP305Uu9SZ5Q++3b8YmMhx141YCBS4+AazOVXXbZ5uBnqRmzjuMFH9cY+mlen0ujEGyE4yw
MIME-Version: 1.0
X-Received: by 2002:a24:2f15:: with SMTP id j21mr3025275itj.4.1550855404622;
 Fri, 22 Feb 2019 09:10:04 -0800 (PST)
Date:   Fri, 22 Feb 2019 09:10:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007da94e05827ea99a@google.com>
Subject: WARNING in rcu_check_gp_start_stall
From:   syzbot <syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com>
To:     bp@alien8.de, douly.fnst@cn.fujitsu.com, hpa@zytor.com,
        konrad.wilk@oracle.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, puwen@hygon.cn,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wang.yi59@zte.com.cn, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8a61716ff2ab Merge tag 'ceph-for-5.0-rc8' of git://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1531dd3f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7132344728e7ec3f
dashboard link: https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d4966cc00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c492d0c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+111bc509cd9740d7e4aa@syzkaller.appspotmail.com

hrtimer: interrupt took 25959 ns
rcu: rcu_check_gp_start_stall: g4348->4352 gar:15680 ga:15694 f0x1 gs:1  
rcu_preempt->state:0x0
WARNING: CPU: 0 PID: 7398 at kernel/rcu/tree.c:2666  
rcu_check_gp_start_stall kernel/rcu/tree.c:2660 [inline]
WARNING: CPU: 0 PID: 7398 at kernel/rcu/tree.c:2666  
rcu_check_gp_start_stall.cold+0x7f/0xb1 kernel/rcu/tree.c:2619
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7398 Comm: syz-executor615 Not tainted 5.0.0-rc7+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
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
RIP: 0010:rcu_check_gp_start_stall kernel/rcu/tree.c:2666 [inline]
RIP: 0010:rcu_check_gp_start_stall.cold+0x7f/0xb1 kernel/rcu/tree.c:2619
Code: 48 8b 0d 93 ae 3b 07 4c 2b 0d 1c c4 3b 07 50 0f bf 05 a4 c1 3b 07 48  
8b 15 45 c1 3b 07 4c 2b 05 0e c4 3b 07 50 e8 a4 c5 fb ff <0f> 0b 48 83 c4  
20 49 81 fc 00 69 9a 88 74 0c 48 c7 c7 00 69 9a 88
RSP: 0018:ffff8880ae807dc0 EFLAGS: 00010086
RAX: 000000000000005e RBX: ffff8880aa25e280 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815a92c6 RDI: ffffed1015d00faa
RBP: ffff8880ae807e00 R08: 000000000000005e R09: ffffed1015d05021
R10: ffffed1015d05020 R11: ffff8880ae828107 R12: ffffffff889a6900
R13: 0000000100014001 R14: 0000000000000286 R15: dffffc0000000000
  rcu_process_callbacks+0x3ba/0x1390 kernel/rcu/tree.c:2750
  __do_softirq+0x266/0x95a kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x14a/0x570 arch/x86/kernel/apic/apic.c:1062
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:807
  </IRQ>
RIP: 0010:__sanitizer_cov_trace_pc+0x26/0x50 kernel/kcov.c:101
Code: 90 90 90 90 55 48 89 e5 48 8b 75 08 65 48 8b 04 25 40 ee 01 00 65 8b  
15 38 0c 92 7e 81 e2 00 01 1f 00 75 2b 8b 90 d8 12 00 00 <83> fa 02 75 20  
48 8b 88 e0 12 00 00 8b 80 dc 12 00 00 48 8b 11 48
RSP: 0018:ffff8880a9bcf590 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffff888086a48500 RBX: ffff8880a9bcf688 RCX: ffffffff8700203f
RDX: 0000000000000000 RSI: ffffffff87002051 RDI: 0000000000000001
RBP: ffff8880a9bcf590 R08: ffff888086a48500 R09: ffffed1015d05bd0
R10: ffffed1015d05bcf R11: ffff8880ae82de7b R12: ffff88809e40d742
R13: ffff8880a9bcf6a0 R14: ffff88808474e778 R15: ffff88809e40d742
  xa_head include/linux/xarray.h:988 [inline]
  xas_start+0x1a1/0x560 lib/xarray.c:182
  xas_load+0x21/0x150 lib/xarray.c:227
  find_get_entry+0x13d/0x8d0 mm/filemap.c:1476
  pagecache_get_page+0x4a/0x740 mm/filemap.c:1579
  find_get_page include/linux/pagemap.h:272 [inline]
  generic_file_buffered_read mm/filemap.c:2076 [inline]
  generic_file_read_iter+0x716/0x2870 mm/filemap.c:2350
  ext4_file_read_iter+0x180/0x3c0 fs/ext4/file.c:77
  call_read_iter include/linux/fs.h:1857 [inline]
  generic_file_splice_read+0x4b2/0x800 fs/splice.c:308
  do_splice_to+0x12a/0x190 fs/splice.c:880
  splice_direct_to_actor+0x2d2/0x970 fs/splice.c:957
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1066
  do_sendfile+0x597/0xd00 fs/read_write.c:1436
  __do_sys_sendfile64 fs/read_write.c:1491 [inline]
  __se_sys_sendfile64 fs/read_write.c:1483 [inline]
  __x64_sys_sendfile64+0x15a/0x220 fs/read_write.c:1483
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a59
Code: e8 dc e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f032c353db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006dcc28 RCX: 0000000000446a59
RDX: 0000000020000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00000000006dcc20 R08: 0000000000000000 R09: 0000000000000000
R10: 00008080fffffffe R11: 0000000000000246 R12: 00000000006dcc2c
R13: 00007fff7d4161cf R14: 00007f032c3549c0 R15: 20c49ba5e353f7cf
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
