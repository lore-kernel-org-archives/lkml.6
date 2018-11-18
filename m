Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F64C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125CB20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125CB20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeKSDsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:48:54 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:49790 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeKSDsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:48:53 -0500
Received: by mail-io1-f69.google.com with SMTP id s10so8584813iop.16
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+gG2GsqxPiHWn1qQP9mdgcaTp834uqBcVYElfGn++4Q=;
        b=YR32TKHp051fcKNi4C6autlWqqHcFQ1YrOxjmVdj21G3XYvfSGya4GFQtIFYQhCXl9
         iFNBHUMg6RqB01KrcKmnv9UWHTr7W/ztN7hSk7TTY6feIqHJbiRJdfsS/ZWn48CLVaZ4
         oyLdsexouVq4XNI96L9WHN6SefTLom4k8lmwcDxeYRHCEWaEXAg7LB3oCCCGVyUJYBwd
         hDk534iTZJadcB09JeLgI7/LwqcNPZgATCgkcGw4aCzs93HY/olWh3UWrWZNuq0YPIuB
         W2l5b2YG9yHfMCGQvNlih9gQq+EDpe1M70aPnocFZjodDclvXTCwlxAOjAZtwuiaBWGg
         qRkg==
X-Gm-Message-State: AA+aEWbHHhj7TgB33jpISZkW/E3zIIZBz+PA6khXZRdO78Tntj9iXPz+
        Z9uI9euGdwD07WBy43B/yeWcDpYyx/uHsr6JfZ4sK1Ta8Qs2
X-Google-Smtp-Source: AFSGD/W6fM1hCOFUiMnK8D8YlPSEOVkXIXZSHDB3/qnXdD+4nYIajnelHPBVAaQfOkZ6KNRxGfpdfGE+TSpcCSckLvgEZHxdGcuA
MIME-Version: 1.0
X-Received: by 2002:a5e:db04:: with SMTP id q4mr4248584iop.30.1542562083160;
 Sun, 18 Nov 2018 09:28:03 -0800 (PST)
Date:   Sun, 18 Nov 2018 09:28:03 -0800
In-Reply-To: <000000000000ebd44005758029c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002c9d3057af3b9fb@google.com>
Subject: Re: KASAN: use-after-free Read in bpf_prog_kallsyms_add
From:   syzbot <syzbot+ac0311cfc9e80cd2e0e8@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    1ce80e0fe98e Merge tag 'fsnotify_for_v4.20-rc3' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11752783400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=ac0311cfc9e80cd2e0e8
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16abd093400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ac0311cfc9e80cd2e0e8@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x8f/0xac lib/list_debug.c:26
Read of size 8 at addr ffff8881b97b8560 by task syz-executor3/12896

CPU: 1 PID: 12896 Comm: syz-executor3 Not tainted 4.20.0-rc2+ #117
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_add_valid+0x8f/0xac lib/list_debug.c:26
  __list_add_rcu include/linux/rculist.h:52 [inline]
  list_add_tail_rcu include/linux/rculist.h:101 [inline]
  bpf_prog_ksym_node_add kernel/bpf/core.c:460 [inline]
  bpf_prog_kallsyms_add+0x200/0x9b0 kernel/bpf/core.c:491
  jit_subprogs kernel/bpf/verifier.c:5973 [inline]
  fixup_call_args kernel/bpf/verifier.c:6023 [inline]
  bpf_check+0x4fcb/0x6310 kernel/bpf/verifier.c:6404
  bpf_prog_load+0x113d/0x1cc0 kernel/bpf/syscall.c:1528
  __do_sys_bpf kernel/bpf/syscall.c:2504 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2466 [inline]
  __x64_sys_bpf+0x36c/0x520 kernel/bpf/syscall.c:2466
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6de3718c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000048 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6de37196d4
R13: 00000000004bd97c R14: 00000000004cc688 R15: 00000000ffffffff

Allocated by task 12883:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  bpf_prog_alloc+0x16b/0x3e0 kernel/bpf/core.c:89
  bpf_prog_load+0x435/0x1cc0 kernel/bpf/syscall.c:1482
  __do_sys_bpf kernel/bpf/syscall.c:2504 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2466 [inline]
  __x64_sys_bpf+0x36c/0x520 kernel/bpf/syscall.c:2466
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 17:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  __bpf_prog_free kernel/bpf/core.c:146 [inline]
  bpf_prog_unlock_free include/linux/filter.h:743 [inline]
  bpf_prog_free_deferred+0x2a4/0x420 kernel/bpf/core.c:1781
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8881b97b8500
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 96 bytes inside of
  512-byte region [ffff8881b97b8500, ffff8881b97b8700)
The buggy address belongs to the page:
page:ffffea0006e5ee00 count:1 mapcount:0 mapping:ffff8881da800940  
index:0xffff8881b97b8a00
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0006ede848 ffffea0006e6b508 ffff8881da800940
raw: ffff8881b97b8a00 ffff8881b97b8000 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881b97b8400: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881b97b8480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff8881b97b8500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8881b97b8580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881b97b8600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

