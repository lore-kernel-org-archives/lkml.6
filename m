Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242C0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17AD20865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 17:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17AD20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeKYE27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 23:28:59 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:55247 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeKYE27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 23:28:59 -0500
Received: by mail-io1-f69.google.com with SMTP id f24so14135144ioh.21
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 09:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XrEutnY5Vj/QyRcAYMGIeSlHjp5B9L+bHpCgLhSQHXs=;
        b=t4GLUvGePR/v+4znL3jFLYckG1SiBVaPMqjsFkwl/8qzjuD1y5AELDve9lnOrQMjMy
         wEb33Hmypp9HEfZrtU8CcQe2xS5YZocujdiBq33nZh//wMTjXXduVxJdUj6BiEYRJEf7
         1AiwSinPmdW9WnLqxtaovaYxwrEk9/xRDiw4m1oxSCExga3pVVqxljXfqiauFt1mnObu
         +EO+CxDE5ko6Osrh9I1+hXlLH7Gv6M4sOG7CHcPaVDOzkgg/0kKoN2pMJ+hgS/u/JJss
         5P66j28Rzvip7EZmpFK/82Pr+jryTeNnyjl1E6vV4dLOd8l83Kc7unfc+YS0NUfvmUcs
         3hJg==
X-Gm-Message-State: AGRZ1gJVNWOU+V3YZ/h98Rj1t/VWKE8XzWwylX/Sbz1MUeEeU8ZFaWRU
        Yi3ZxlOO6hfrIGJ7mhWh+dCsZdZw5p0jWd0xZfChhX04zaCw
X-Google-Smtp-Source: AJdET5cNDV13tXNLvv2AU57GveLiYL2xoGT5sSWeeoyUDnBMuDAwcdN9MiYwIiwWubdizRq+sxdXHXC4Iyl/eNKX8TphgJpN1hBj
MIME-Version: 1.0
X-Received: by 2002:a24:3653:: with SMTP id l80mr13928023itl.3.1543081204530;
 Sat, 24 Nov 2018 09:40:04 -0800 (PST)
Date:   Sat, 24 Nov 2018 09:40:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e4a41057b6c9792@google.com>
Subject: WARNING: syz-executor still has locks held!
From:   syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c98a4261827 Merge tag 'ceph-for-4.20-rc4' of https://gith..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d81015400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=b70f2aabc707c69c9239
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c9e26d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e1234d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com

audit: type=1400 audit(1543059836.603:35): avc:  denied  { map } for   
pid=6203 comm="bash" path="/bin/bash" dev="sda1" ino=1457  
scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
audit: type=1400 audit(1543059843.273:36): avc:  denied  { map } for   
pid=6217 comm="syz-executor552" path="/root/syz-executor552394561"  
dev="sda1" ino=16483 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1

====================================
WARNING: syz-executor552/6218 still has locks held!
4.20.0-rc3+ #127 Not tainted
------------------------------------
1 lock held by syz-executor552/6218:
  #0: 000000004754a9eb (&sig->cred_guard_mutex){+.+.}, at:  
prepare_bprm_creds+0x53/0x120 fs/exec.c:1405

stack backtrace:
CPU: 0 PID: 6218 Comm: syz-executor552 Not tainted 4.20.0-rc3+ #127
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_held_locks_bug kernel/locking/lockdep.c:4362 [inline]
  debug_check_no_locks_held.cold.49+0x93/0x9f kernel/locking/lockdep.c:4368
  try_to_freeze include/linux/freezer.h:66 [inline]
  freezer_count include/linux/freezer.h:128 [inline]
  freezable_schedule include/linux/freezer.h:173 [inline]
  de_thread fs/exec.c:1115 [inline]
  flush_old_exec+0x1ea2/0x2480 fs/exec.c:1262
  load_elf_binary+0xa39/0x5620 fs/binfmt_elf.c:869
  search_binary_handler+0x17d/0x570 fs/exec.c:1654
  exec_binprm fs/exec.c:1696 [inline]
  __do_execve_file.isra.33+0x1661/0x25d0 fs/exec.c:1820
  do_execveat_common fs/exec.c:1867 [inline]
  do_execveat fs/exec.c:1895 [inline]
  __do_sys_execveat fs/exec.c:1976 [inline]
  __se_sys_execveat fs/exec.c:1968 [inline]
  __x64_sys_execveat+0xed/0x130 fs/exec.c:1968
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x445639
Code: e8 ec b8 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5efaee7d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 00000000006dac28 RCX: 0000000000445639
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000006dac20 R08: 0000000000001000 R09: 65732f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5efaee7d20
R13: 00000000006dac2c R14: 0000000020000280 R15: 00000000006dad2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
