Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA61C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F70A24E14
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F70A24E14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeFXHcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:32:06 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:39587 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752049AbeFXHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:32:03 -0400
Received: by mail-it0-f69.google.com with SMTP id o7-v6so5434471itf.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 00:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XuG7l58tUfBa5zGtZ+rNd6NqjC8QpxGqTD1rfkTJ3S8=;
        b=eq1T/7fxZ62D0mKgu8Fer/SbqcDqhrNSllUzdkU5mGLKO0i/laVZg01XsrPExIDYfu
         n15Kv4kDCKDONh4whojsIPYepqA2SG2vy8qGUQUuPZuonzJr04bNndQHkhwbe+26NnP5
         03bO8TwyHIcwiq4mCq4co0WWtO5GJCE4FBTI3ozG+vFTpsbQt2c3lfJ0+slNNcmWV1Ew
         Az6vf80OweLIbAev3rhJXIJTsj8PkUxJxoAKyA43GsLeTQT0YyIrodw/JiDOtH+TPuXM
         a8KmpCzbru07oul9fvlMAQtMfbO2ibQTiIQtL5+7cUi8GTEMfvbiAySE3gNxot9sKLZS
         WR5Q==
X-Gm-Message-State: APt69E0W57hGrntOuNJ6Up4N5hTjsj//ZgfojiSPRNjH6J9iytjBf1f7
        haf7ZnRJn7vkiRhecewmwZ30zi+cB/TUXD3IUGUSKTEhEnDR
X-Google-Smtp-Source: AAOMgpeDETGN+OubEs9DomGzRv+NKocx3ZwI9M6gaZmVnjvuExHu2kmB30Ww3pNQkG9U5QUSYOWGiZkbDBk8hsOJs74nwBsDRtvw
MIME-Version: 1.0
X-Received: by 2002:a6b:dd14:: with SMTP id f20-v6mr3382781ioc.15.1529825522436;
 Sun, 24 Jun 2018 00:32:02 -0700 (PDT)
Date:   Sun, 24 Jun 2018 00:32:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d55131056f5e4285@google.com>
Subject: BUG: unable to handle kernel paging request in bpf_prog_select_runtime
From:   syzbot <syzbot+d866d1925855328eac3b@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5e2204832b20 Merge tag 'powerpc-4.18-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e79814400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=befbcd7305e41bb0
dashboard link: https://syzkaller.appspot.com/bug?extid=d866d1925855328eac3b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d866d1925855328eac3b@syzkaller.appspotmail.com

BUG: unable to handle kernel paging request at ffffc90001952002
PGD 1da947067 P4D 1da947067 PUD 1da948067 PMD 1d3a61067 PTE 800000016ba62161
Oops: 0003 [#1] SMP KASAN
CPU: 0 PID: 17593 Comm: syz-executor3 Not tainted 4.18.0-rc1+ #114
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:bpf_prog_lock_ro include/linux/filter.h:681 [inline]
RIP: 0010:bpf_prog_select_runtime+0xf5/0xa60 kernel/bpf/core.c:1519
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 c1 ea 03 0f b6 14 02 48 89  
c8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 de 08 00 00 <41> 80 66 02 fb  
e8 f1 67 f3 ff 49 8d 7e 20 48 b8 00 00 00 00 00 fc
RSP: 0018:ffff8801b4d6fac8 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 00000000fffffff4 RCX: ffffc90001952002
RDX: 0000000000000000 RSI: ffffffff8188a717 RDI: 0000000000000005
RBP: ffff8801b4d6fb30 R08: ffff8801d778e400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90001952030 R14: ffffc90001952000 R15: ffff8801b4d6fb98
FS:  00007f59edc0c700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001952002 CR3: 00000001d20b4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  bpf_prog_load+0x1194/0x1c60 kernel/bpf/syscall.c:1356
  __do_sys_bpf kernel/bpf/syscall.c:2360 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2322 [inline]
  __x64_sys_bpf+0x36c/0x510 kernel/bpf/syscall.c:2322
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a99
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f59edc0bc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f59edc0c6d4 RCX: 0000000000455a99
RDX: 0000000000000048 RSI: 0000000020000240 RDI: 0000000000000005
RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000015
R13: 00000000004bb7d5 R14: 00000000004c8508 R15: 0000000000000023
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
CR2: ffffc90001952002
---[ end trace f4bd75b0437a2cce ]---
RIP: 0010:bpf_prog_lock_ro include/linux/filter.h:681 [inline]
RIP: 0010:bpf_prog_select_runtime+0xf5/0xa60 kernel/bpf/core.c:1519
Code: 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 c1 ea 03 0f b6 14 02 48 89  
c8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 de 08 00 00 <41> 80 66 02 fb  
e8 f1 67 f3 ff 49 8d 7e 20 48 b8 00 00 00 00 00 fc
RSP: 0018:ffff8801b4d6fac8 EFLAGS: 00010246
RAX: 0000000000000003 RBX: 00000000fffffff4 RCX: ffffc90001952002
RDX: 0000000000000000 RSI: ffffffff8188a717 RDI: 0000000000000005
RBP: ffff8801b4d6fb30 R08: ffff8801d778e400 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc90001952030 R14: ffffc90001952000 R15: ffff8801b4d6fb98
FS:  00007f59edc0c700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001952002 CR3: 00000001d20b4000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
