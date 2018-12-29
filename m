Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330D3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32F12145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 17:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeL2RyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 12:54:05 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35241 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeL2RyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 12:54:04 -0500
Received: by mail-io1-f69.google.com with SMTP id x12so6648101ioj.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 09:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O//1qSPnTkC23AzhlFyYJvC7j5Ac8XZAuFpz6vYFS8s=;
        b=MctbIZfAjtPXBKGWPaODbQepyeB8e9l8xnQLH2bD4F5ccKDvLsUR2NYWjNCa2e78Tl
         jItF87TL3D7wV4JxTduTcNfF9NcxC/wmr869RqJSkS9PemRVDhOCMo2OfQGB9DGX09MR
         Ytyfkh6uaJp8GDER4xvh6pxxgCCxw/WmTw+P88J3SZmi9omuNpFyO3VGTlLoBDpmOucZ
         CYDPNWcUnC20Ch46UYw63qqzfSyw4+jKYqFj62kgca5is6em65LFy31Qk466z6KLF+yp
         fD+3b0CP8vHBsisSQymrRFRT+b4i83HMO5GejQoNIzfDj7HOiAwQBgkL6cVM1DhZYC6+
         syGw==
X-Gm-Message-State: AA+aEWZpDzj8V4IWEEIdDIRtKo1ovfUvR4bHqU90fESU/v4SXjP5Vv8/
        a/xjqWDjwZ0CN7Tdxl87Y97FLeaADsbz/eWIPgqR8fppCNmb
X-Google-Smtp-Source: AFSGD/U9MNpT8aQSyT0Y86xIcpvC2ageiADxLd3UuUCRWVagHt+z4hmNWJOZirNpgU3AojK7fx77hCzqVjTAxTaYK0+RoFwpCZet
MIME-Version: 1.0
X-Received: by 2002:a02:1149:: with SMTP id 70mr24748306jaf.24.1546106043703;
 Sat, 29 Dec 2018 09:54:03 -0800 (PST)
Date:   Sat, 29 Dec 2018 09:54:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000852fcf057e2cdd51@google.com>
Subject: KASAN: use-after-free Read in delete_and_unsubscribe_port
From:   syzbot <syzbot+9917f000776fb73fa40f@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8fe28cb58bcb Linux 4.20
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166859b3400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d581260bae0899a
dashboard link: https://syzkaller.appspot.com/bug?extid=9917f000776fb73fa40f
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9917f000776fb73fa40f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __read_once_size include/linux/compiler.h:191  
[inline]
BUG: KASAN: use-after-free in list_empty include/linux/list.h:226 [inline]
BUG: KASAN: use-after-free in delete_and_unsubscribe_port+0x5d7/0x6d0  
sound/core/seq/seq_ports.c:548
Read of size 8 at addr ffff8881d1c05590 by task syz-executor1/6930

CPU: 0 PID: 6930 Comm: syz-executor1 Not tainted 4.20.0 #167
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d3/0x2c6 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __read_once_size include/linux/compiler.h:191 [inline]
  list_empty include/linux/list.h:226 [inline]
  delete_and_unsubscribe_port+0x5d7/0x6d0 sound/core/seq/seq_ports.c:548
  snd_seq_port_disconnect+0x17b/0x280 sound/core/seq/seq_ports.c:628
  snd_seq_ioctl_unsubscribe_port+0x1d8/0x310  
sound/core/seq/seq_clientmgr.c:1499
  snd_seq_ioctl+0x253/0x440 sound/core/seq/seq_clientmgr.c:2138
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457759
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f36626cac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457759
RDX: 00000000200001c0 RSI: 0000000040505331 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f36626cb6d4
R13: 00000000004ca358 R14: 00000000004d35d0 R15: 00000000ffffffff

Allocated by task 6924:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  kmem_cache_alloc_trace+0x152/0x750 mm/slab.c:3620
  kmalloc include/linux/slab.h:546 [inline]
  kzalloc include/linux/slab.h:741 [inline]
  snd_seq_port_connect+0xe0/0x760 sound/core/seq/seq_ports.c:571
  snd_seq_ioctl_subscribe_port+0x1d8/0x310  
sound/core/seq/seq_clientmgr.c:1458
  snd_seq_ioctl+0x253/0x440 sound/core/seq/seq_clientmgr.c:2138
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6931:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3817
  snd_seq_port_disconnect+0x205/0x280 sound/core/seq/seq_ports.c:632
  snd_seq_ioctl_unsubscribe_port+0x1d8/0x310  
sound/core/seq/seq_clientmgr.c:1499
  snd_seq_ioctl+0x253/0x440 sound/core/seq/seq_clientmgr.c:2138
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
  ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8881d1c05540
  which belongs to the cache kmalloc-128 of size 128
The buggy address is located 80 bytes inside of
  128-byte region [ffff8881d1c05540, ffff8881d1c055c0)
The buggy address belongs to the page:
page:ffffea0007470140 count:1 mapcount:0 mapping:ffff8881da800640  
index:0xffff8881d1c05b40
flags: 0x2fffc0000000200(slab)
raw: 02fffc0000000200 ffffea0006fb09c8 ffffea0006f38908 ffff8881da800640
raw: ffff8881d1c05b40 ffff8881d1c05000 000000010000000e 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d1c05480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d1c05500: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> ffff8881d1c05580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                          ^
  ffff8881d1c05600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d1c05680: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
