Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5DD2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 06:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5DD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeJANeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:34:18 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44583 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeJANeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:34:18 -0400
Received: by mail-io1-f69.google.com with SMTP id s15-v6so12334492iob.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 23:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VFYP8u3DyIhKMXbo398ETEhORskOY/radS41nMVViGo=;
        b=BnKp7JYX0w2IgfmT8rpb9JDNkCLx/Qv1sktBdWPGyWn8RJvtMA4MRS1ZRB+HR3+jOj
         5PuGieouQMCe4A1k8Qo41hWpkDBqeLT0rc1jp2SXh4MG3ZYfCMKVo2KnHPC4ETNq1Tk/
         zErPXpT/9NW1zbdkAndih3Hx/K95hCpbQ3dIPsDwLNLnjNv2GQ1a/Oc1Yp70ScOMpmjA
         IiUQC2fWKwWFdMbVjosnkN3Jr6Ky9Un/mi5DVCBolTHk34ZA2/Vk26x9TxEyhYYkUS9W
         QtMvP8dIBir8P73Q35yuGOd0n5xRyLc2cRsyowFoM9kQL9gy+237q1i2d9zgEYWvMZO9
         nQgA==
X-Gm-Message-State: ABuFfoiH673Qx6gVUp/sXuTW10fQqfcbRZHcC/XqNAwWRlLdBz3m7KAA
        PpCIuvn8qYUuKRhmPW9hl7S9MR/KvY0+VTMZZ6DSGLU3fC1R
X-Google-Smtp-Source: ACcGV63B+700JlkyeIGO74VuudYdouAkTlFB1xBl6VcZvK94XsBsGH29KUXnymlMNrn3c7mIMiyWkDPP77301YSCN1bysv6d0EVR
MIME-Version: 1.0
X-Received: by 2002:a24:b947:: with SMTP id k7-v6mr9731604iti.21.1538377083002;
 Sun, 30 Sep 2018 23:58:03 -0700 (PDT)
Date:   Sun, 30 Sep 2018 23:58:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000902cb10577255369@google.com>
Subject: KASAN: use-after-free Read in seq_escape
From:   syzbot <syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    17b57b1883c1 Linux 4.19-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1672d711400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=a2872d6feea6918008a9
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a2872d6feea6918008a9@syzkaller.appspotmail.com

(unnamed net_device) (uninitialized): option active_slave: mode dependency  
failed, not supported in mode balance-rr(0)
IPVS: ftp: loaded support on port[0] = 21
EXT4-fs (sda1): journaled quota format not specified
==================================================================
BUG: KASAN: use-after-free in strlen+0x83/0xa0 lib/string.c:482
Read of size 1 at addr ffff8801ce9a9540 by task syz-executor2/486

CPU: 1 PID: 486 Comm: syz-executor2 Not tainted 4.19.0-rc6+ #39
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
(unnamed net_device) (uninitialized): option active_slave: mode dependency  
failed, not supported in mode balance-rr(0)
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
  strlen+0x83/0xa0 lib/string.c:482
  strlen include/linux/string.h:267 [inline]
  string_escape_str include/linux/string_helpers.h:66 [inline]
  seq_escape+0xd5/0x240 fs/seq_file.c:381
  seq_show_option include/linux/seq_file.h:185 [inline]
  ext4_show_quota_options fs/ext4/super.c:2051 [inline]
  _ext4_show_options+0xcef/0x18f0 fs/ext4/super.c:2151
  ext4_show_options+0x41/0x50 fs/ext4/super.c:2157
  show_mountinfo+0x674/0x9b0 fs/proc_namespace.c:187
  m_show+0x65/0x80 fs/namespace.c:1280
  seq_read+0x4af/0x1150 fs/seq_file.c:229
  do_loop_readv_writev fs/read_write.c:700 [inline]
  do_iter_read+0x4a3/0x650 fs/read_write.c:924
  vfs_readv+0x175/0x1c0 fs/read_write.c:986
  do_preadv+0x1cc/0x280 fs/read_write.c:1070
  __do_sys_preadv fs/read_write.c:1120 [inline]
  __se_sys_preadv fs/read_write.c:1115 [inline]
  __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1115
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457579
Code: 1d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8a6dc50c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000457579
RDX: 1000000000000181 RSI: 0000000020000480 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8a6dc516d4
R13: 00000000004c309c R14: 00000000004d4a40 R15: 00000000ffffffff

Allocated by task 493:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  kasan_kmalloc+0xc7/0xe0 mm/kasan/kasan.c:553
  __do_kmalloc mm/slab.c:3718 [inline]
  __kmalloc+0x14e/0x760 mm/slab.c:3727
  kmalloc include/linux/slab.h:518 [inline]
  match_strdup+0x5e/0xa0 lib/parser.c:331
  set_qf_name+0x14b/0x3e0 fs/ext4/super.c:1548
  handle_mount_opt fs/ext4/super.c:1718 [inline]
  parse_options+0xd3e/0x29c0 fs/ext4/super.c:1979
  ext4_remount+0x693/0x2640 fs/ext4/super.c:5139
  do_remount_sb+0x350/0x7b0 fs/super.c:888
  do_remount fs/namespace.c:2278 [inline]
  do_mount+0x1513/0x31f0 fs/namespace.c:2778
  ksys_mount+0x12d/0x140 fs/namespace.c:3003
  __do_sys_mount fs/namespace.c:3017 [inline]
  __se_sys_mount fs/namespace.c:3014 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3014
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 493:
  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
  set_track mm/kasan/kasan.c:460 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/kasan.c:521
  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
  __cache_free mm/slab.c:3498 [inline]
  kfree+0xcf/0x230 mm/slab.c:3813
  ext4_remount+0x11ec/0x2640 fs/ext4/super.c:5355
  do_remount_sb+0x350/0x7b0 fs/super.c:888
  do_remount fs/namespace.c:2278 [inline]
  do_mount+0x1513/0x31f0 fs/namespace.c:2778
  ksys_mount+0x12d/0x140 fs/namespace.c:3003
  __do_sys_mount fs/namespace.c:3017 [inline]
  __se_sys_mount fs/namespace.c:3014 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3014
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8801ce9a9540
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff8801ce9a9540, ffff8801ce9a9560)
The buggy address belongs to the page:
page:ffffea00073a6a40 count:1 mapcount:0 mapping:ffff8801da8001c0  
index:0xffff8801ce9a9fc1
flags: 0x2fffc0000000100(slab)
raw: 02fffc0000000100 ffffea000749ea48 ffffea00074b5e08 ffff8801da8001c0
raw: ffff8801ce9a9fc1 ffff8801ce9a9000 000000010000003e 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8801ce9a9400: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801ce9a9480: fb fb fb fb fc fc fc fc 06 fc fc fc fc fc fc fc
> ffff8801ce9a9500: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                                            ^
  ffff8801ce9a9580: 00 00 00 fc fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8801ce9a9600: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================
(unnamed net_device) (uninitialized): option active_slave: mode dependency  
failed, not supported in mode balance-rr(0)


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
