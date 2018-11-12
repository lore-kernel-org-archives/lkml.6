Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0E0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADB922504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADB922504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbeKMG2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:28:55 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:53993 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeKMG2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:28:54 -0500
Received: by mail-it1-f198.google.com with SMTP id l200-v6so13741130ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+TM5yEBMyjgsHt1bxDZ5vvjRCaDoPpFeOTyNTRc4j4o=;
        b=c24fIsZ7S+i+M353LlQ6HBlV3orDAlWmkrTFlAdU+mzfZu/iUmkc2r2lmK5ZC9wfYP
         KBNRQJm4iNq6dqXHsDITHNEdV/4BKkHcJeQhzZhV6v4hBmPg02pkhlVd6020W36or70I
         3gLoXMvSVI8kNbDlxtk4KysSaU6HcROSq7C+EAOs4gw8BmFoEvyHbsfdMiaJLL2inVwU
         Ej5nm7Hgi+6urExkrVwxUMPBY02kIwBiKKuJeBVp53qe15DQpGn+OHzP3WUUH4khBEOb
         oIqSbNnPRmtKdrIciVH95Vu3uHtLY0ptL9t700qfn9gikSwG0zRuy75EkECxBsOMthM2
         yQAg==
X-Gm-Message-State: AGRZ1gLPtHjSMXp3ozTVNRMdSS4L54yqNnUW5Hv33XHN8R4Klr9WExcO
        eD6D2T7Ac352daLCtCxpbaI5LdaJC10FyZD1LcgEivDjcxRT
X-Google-Smtp-Source: AJdET5eHwRfh2xMIoDwfihshP2rxczjYagLgLQIG56wBLMGpHbR/UKQx4wtfD1Ma0Gckne3eeNSrqOKTFeB12aa1pjbklqyRIcfO
MIME-Version: 1.0
X-Received: by 2002:a24:5f84:: with SMTP id r126-v6mr252540itb.39.1542054842867;
 Mon, 12 Nov 2018 12:34:02 -0800 (PST)
Date:   Mon, 12 Nov 2018 12:34:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000222b58057a7d9f39@google.com>
Subject: KASAN: use-after-free Read in locks_delete_block
From:   syzbot <syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=115dbad5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=a4a3d526b4157113ec6a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a4a3d526b4157113ec6a@syzkaller.appspotmail.com

device loop0 blocksize: 4096
__find_get_block_slow() failed. block=1, b_blocknr=8
b_state=0x00000029, b_size=512
device loop0 blocksize: 4096
==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xf1/0x100  
lib/list_debug.c:51
Read of size 8 at addr ffff88017eb47b70 by task syz-executor3/13461

CPU: 0 PID: 13461 Comm: syz-executor3 Not tainted 4.20.0-rc1-next-20181109+  
#110
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_address_description.cold.7+0x9/0x1ff mm/kasan/report.c:256
  kasan_report_error mm/kasan/report.c:354 [inline]
  kasan_report.cold.8+0x242/0x309 mm/kasan/report.c:412
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
  __list_del_entry_valid+0xf1/0x100 lib/list_debug.c:51
  __list_del_entry include/linux/list.h:117 [inline]
  list_del_init include/linux/list.h:159 [inline]
  __locks_delete_block fs/locks.c:683 [inline]
  locks_delete_block+0xce/0x3d0 fs/locks.c:716
  locks_mandatory_area+0x48b/0x6a0 fs/locks.c:1398
  rw_verify_area+0x2f2/0x360 fs/read_write.c:386
  vfs_write+0x149/0x560 fs/read_write.c:544
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff2e8194c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000010 RSI: 0000000020000180 RDI: 0000000000000006
RBP: 000000000072c0e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff2e81956d4
R13: 00000000004c571f R14: 00000000004d9360 R15: 00000000ffffffff

The buggy address belongs to the page:
page:ffffea0005fad1c0 count:0 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0x2fffc0000000000()
raw: 02fffc0000000000 0000000000000000 ffffea0005fad1c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88017eb47a00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff88017eb47a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff88017eb47b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                              ^
  ffff88017eb47b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff88017eb47c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
