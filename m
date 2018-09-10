Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7976AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF9F2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF9F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeIJNU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:20:56 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:58874 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeIJNUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:20:55 -0400
Received: by mail-it0-f72.google.com with SMTP id x15-v6so40034448ite.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qVW29j9XC52gbV0QnW6opKeiufgsE+VCt7yiYaqpuzc=;
        b=YEuLI31b48ZmwRmgBuswlc5qEbx8HN5zzFAtR+ftj3WdVTD3WvnB2ffrbxNOR6VfEG
         4/P06sELLoMkS6ZUqr9eOdjTeKMSxAQggFdKsDoKG3tC2ODy+aOa7RIW1anJVyHX+3vs
         58wneLTGIP1fn8kkGuHIAg3oY70+tnCCkKwLJxS0oZb3EOwF59Es+GRW9PhXa4puUfkp
         CEoYexwlWYrJTC6PAXJR6lob5Th81et1OOCM420peTtgEz5hNMQhFKU6DyjyoD1jtztB
         1JD67W0LsQRuF186zHMXVZNdXQ7FSa/rPcoiownx1SHwh/vLRoI9gvUsYE/t4nvzkvd3
         n8dA==
X-Gm-Message-State: APzg51ARi0Z4KqaZ797CQ4SX24vtdv24Jai8r/zNAxJlW9dHag4ljTkC
        EoMZeE7cCr+dXCkA8wZPFJMagzAMC0rEvZe3Dq7eBIgLMxnj
X-Google-Smtp-Source: ANB0VdbCGRzMln49v72XNwMCLW+rXteIDhKnF9PPmjwVGR31yfMoFpWSy74JKhkdHtCpMiiCVYB9YIX7uEmenHzU2hRGpHCde6KL
MIME-Version: 1.0
X-Received: by 2002:a6b:9346:: with SMTP id v67-v6mr15925551iod.111.1536568082725;
 Mon, 10 Sep 2018 01:28:02 -0700 (PDT)
Date:   Mon, 10 Sep 2018 01:28:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be864405758022a2@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in __do_page_cache_readahead
From:   syzbot <syzbot+d47b586c9bc26763ffce@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk,
        darrick.wong@oracle.com, dchinner@redhat.com, jbacik@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@dominikbrodowski.net, mawilcox@microsoft.com,
        stockhausen@collogia.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3d0e7a9e00fd Merge tag 'md/4.19-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1654ac21400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=d47b586c9bc26763ffce
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d47b586c9bc26763ffce@syzkaller.appspotmail.com

EXT4-fs (sda1): warning: refusing change of dax flag with busy inodes while  
remounting
EXT4-fs (sda1): re-mounted. Opts: dax,,errors=continue
EXT4-fs (sda1): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
EXT4-fs (sda1): warning: refusing change of dax flag with busy inodes while  
remounting
EXT4-fs (sda1): re-mounted. Opts: dax,,errors=continue
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
PGD 1cf0bc067 P4D 1cf0bc067 PUD 1c8d95067 PMD 0
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9112 Comm: syz-executor2 Not tainted 4.19.0-rc2+ #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff880184436a28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffc900062fe000
RDX: 1ffffffff1036431 RSI: ffffea000602f280 RDI: ffff8801c86ce780
RBP: ffff880184436c08 R08: ffff8801bf28a0c0 R09: fffff94000c05e56
R10: fffff94000c05e56 R11: ffffea000602f2b7 R12: ffffea000602f288
R13: ffffea000602f280 R14: 0000000000000000 R15: ffffed0030886d74
FS:  00007f9fe8e5f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000018aff0000 CR4: 00000000001406e0
Call Trace:
  __do_page_cache_readahead+0x56d/0x980 mm/readahead.c:210
  ra_submit mm/internal.h:66 [inline]
  do_sync_mmap_readahead mm/filemap.c:2444 [inline]
  filemap_fault+0xf4d/0x25f0 mm/filemap.c:2520
  ext4_filemap_fault+0x82/0xad fs/ext4/inode.c:6257
  __do_fault+0x100/0x6b0 mm/memory.c:3240
  do_read_fault mm/memory.c:3652 [inline]
  do_fault mm/memory.c:3752 [inline]
  handle_pte_fault mm/memory.c:3983 [inline]
  __handle_mm_fault+0x3709/0x53e0 mm/memory.c:4107
  handle_mm_fault+0x54f/0xc70 mm/memory.c:4144
  faultin_page mm/gup.c:518 [inline]
  __get_user_pages+0x806/0x1b30 mm/gup.c:718
  populate_vma_page_range+0x2db/0x3d0 mm/gup.c:1222
  __mm_populate+0x286/0x4d0 mm/gup.c:1270
  mm_populate include/linux/mm.h:2307 [inline]
  vm_mmap_pgoff+0x27f/0x2c0 mm/util.c:362
  ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
  __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457099
Code: fd b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9fe8e5ec78 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f9fe8e5f6d4 RCX: 0000000000457099
RDX: 00000000007ffffe RSI: 0000000000600000 RDI: 0000000020000000
RBP: 0000000000930140 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000004002011 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004d3168 R14: 00000000004c8161 R15: 0000000000000001
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace e3fb6a18760358f2 ]---
RIP: 0010:          (null)
Code: Bad RIP value.
RSP: 0018:ffff880184436a28 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffc900062fe000
RDX: 1ffffffff1036431 RSI: ffffea000602f280 RDI: ffff8801c86ce780
RBP: ffff880184436c08 R08: ffff8801bf28a0c0 R09: fffff94000c05e56
R10: fffff94000c05e56 R11: ffffea000602f2b7 R12: ffffea000602f288
R13: ffffea000602f280 R14: 0000000000000000 R15: ffffed0030886d74
FS:  00007f9fe8e5f700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
kobject: 'loop3' (0000000092ea2d98): kobject_uevent_env
kobject: 'loop3' (0000000092ea2d98): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop7' (00000000102bc430): kobject_uevent_env
CR2: 00000000004d3d08 CR3: 000000018aff0000 CR4: 00000000001406f0
kobject: 'loop7' (00000000102bc430): fill_kobj_path: path  
= '/devices/virtual/block/loop7'
kobject: 'loop1' (00000000bbec18b6): kobject_uevent_env
kobject: 'loop5' (000000006bdd6403): kobject_uevent_env
kobject: 'loop5' (000000006bdd6403): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop1' (00000000bbec18b6): fill_kobj_path: path  
= '/devices/virtual/block/loop1'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
