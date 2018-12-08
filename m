Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B47CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0F72082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0F72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLHKvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 05:51:04 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:42436 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 05:51:04 -0500
Received: by mail-io1-f72.google.com with SMTP id r13so6405264ioj.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 02:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LAtsQ2cZZxHFcfz3hWZRBH02ArBAR9slj/rdEf6CsQI=;
        b=FXRN4GBx0E4yGnNFXl7l5efQiA8EXfaE19kNVkfwAayQatPgenOav2o4a3z6lwb0YH
         1lUokL6NO4SOGmLzr61wXwhlbGYBZ4zpRf9MKIXasgcPpSmo8sTukBaYqULYpBrubQrj
         boDYGQz9xBTGzAvRhVl/QUNe4ItUvl8SJHDRGOxjWp80qsROYOdudatXI2DJS+qYwld0
         oMcwmTkC7ndblM4Y7QJ5QMOowvuyzQA/NYL6HmHaUIxg96+uIwGtNfnrRdTx9ffla9Rf
         alkH/78Mcyx76ERjNB8W/mrC2aNzVuXUlQYm1a0BRjCgGZu9gB22qNGir9CyvgW/h/TC
         ZrMA==
X-Gm-Message-State: AA+aEWYfRUqKjc8jlP8xHwG5mu83FUF549smks5IJM2I3mhU4bS2PW7m
        ySOfXeQXeuwUvy7RJlf5acS0lNUit3ux0C/pLNACDCo61bMc
X-Google-Smtp-Source: AFSGD/WRnjW34ANtJSbmEcieSE1puS8/RlhCih/8Ub1grD4Oxn9fBvpN6ApGVnrC8mXe3mM8XO/BHRYOBset6hsmp/mYsVQmgW8Q
MIME-Version: 1.0
X-Received: by 2002:a6b:e903:: with SMTP id u3mr4000960iof.37.1544266263175;
 Sat, 08 Dec 2018 02:51:03 -0800 (PST)
Date:   Sat, 08 Dec 2018 02:51:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e2b4e057c80822f@google.com>
Subject: general protection fault in freeary
From:   syzbot <syzbot+9d8b6fa6ee7636f350c1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, dave@stgolabs.net,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, manfred@colorfullife.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    74c4a24df7ca Add linux-next specific files for 20181207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a713d5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e9413388bf37bed
dashboard link: https://syzkaller.appspot.com/bug?extid=9d8b6fa6ee7636f350c1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e19da3400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9d8b6fa6ee7636f350c1@syzkaller.appspotmail.com

dmaengine-unmap-16          0KB          4KB
dmaengine-unmap-2          0KB          3KB
kasan: CONFIG_KASAN_INLINE enabled
skbuff_fclone_cache          5KB          7KB
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 21755 Comm: syz-executor0 Not tainted 4.20.0-rc5-next-20181207+  
#163
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x84/0x100 lib/list_debug.c:51
Code: 0f 84 60 01 00 00 48 b8 00 02 00 00 00 00 ad de 49 39 c4 0f 84 39 01  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75  
5f 49 8b 14 24 48 39 da 0f 85 4e 01 00 00 49 8d 7d
RSP: 0018:ffff8881b5ea6ec0 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffffff87dd7df8 RCX: ffffffff8341d7fe
RDX: 11699ffffec411b1 RSI: ffffffff8341d556 RDI: ffffffff87dd7e00
skbuff_head_cache        539KB       1706KB
RBP: ffff8881b5ea6ed8 R08: ffff8881baf76300 R09: fffff5200198e400
R10: fffff5200198e400 R11: ffffc9000cc72003 R12: 8b4cfffff6208d8b
R13: 48fffff618b58b48 R14: ffff8881b5ea72c0 R15: dffffc0000000000
FS:  000000000279f940(0000) GS:ffff8881dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c000 CR3: 00000001c031f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_del_entry include/linux/list.h:117 [inline]
  list_del include/linux/list.h:125 [inline]
  unlink_queue ipc/sem.c:786 [inline]
  freeary+0xe72/0x1a40 ipc/sem.c:1164
configfs_dir_cache          0KB          4KB
file_lock_cache            0KB          3KB
file_lock_ctx              0KB          3KB
fsnotify_mark_connector         43KB         55KB
  free_ipcs+0x9f/0x1c0 ipc/namespace.c:112
  sem_exit_ns+0x20/0x40 ipc/sem.c:237
  free_ipc_ns ipc/namespace.c:120 [inline]
  put_ipc_ns+0x66/0x180 ipc/namespace.c:152
net_namespace             52KB         52KB
  free_nsproxy+0xcf/0x220 kernel/nsproxy.c:180
  switch_task_namespaces+0xb3/0xd0 kernel/nsproxy.c:229
  exit_task_namespaces+0x17/0x20 kernel/nsproxy.c:234
  do_exit+0x1a48/0x2620 kernel/exit.c:866
shmem_inode_cache       5754KB       6042KB
task_delay_info          112KB        484KB
taskstats                152KB        163KB
proc_dir_entry           578KB        581KB
  do_group_exit+0x177/0x440 kernel/exit.c:970
  get_signal+0x8b0/0x1980 kernel/signal.c:2515
pde_opener                 0KB          3KB
  do_signal+0x9c/0x21c0 arch/x86/kernel/signal.c:816
seq_file                 282KB        342KB
sigqueue                  39KB        208KB
kernfs_node_cache      11484KB      11489KB
mnt_cache               5951KB       6436KB
  exit_to_usermode_loop+0x2e5/0x380 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
filp                    3938KB       6761KB
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
names_cache            99560KB      99598KB
RIP: 0033:0x459f39
Code: ff 48 85 f6 0f 84 27 8a fb ff 48 83 ee 10 48 89 4e 08 48 89 3e 48 89  
d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0f 05 <48> 85 c0 0f 8c  
fe 89 fb ff 74 01 c3 31 ed 48 f7 c7 00 00 01 00 75
RSP: 002b:00007ffd923f9ef8 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
RAX: fffffffffffffff4 RBX: 00007f99b9efc700 RCX: 0000000000459f39
RDX: 00007f99b9efc9d0 RSI: 00007f99b9efbdb0 RDI: 00000000003d0f00
iint_cache                87KB         91KB
RBP: 00007ffd923fa100 R08: 00007f99b9efc700 R09: 00007f99b9efc700
R10: 00007f99b9efc9d0 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffd923f9faf R14: 00007f99b9efc9c0 R15: 0000000000000001
Modules linked in:
---[ end trace 984887003f1a69a9 ]---
RIP: 0010:__list_del_entry_valid+0x84/0x100 lib/list_debug.c:51
key_jar                    3KB          7KB
Code: 0f 84 60 01 00 00 48 b8 00 02 00 00 00 00 ad de 49 39 c4 0f 84 39 01  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75  
5f 49 8b 14 24 48 39 da 0f 85 4e 01 00 00 49 8d 7d
RSP: 0018:ffff8881b5ea6ec0 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffffff87dd7df8 RCX: ffffffff8341d7fe
RDX: 11699ffffec411b1 RSI: ffffffff8341d556 RDI: ffffffff87dd7e00
RBP: ffff8881b5ea6ed8 R08: ffff8881baf76300 R09: fffff5200198e400
uts_namespace              2KB          7KB
R10: fffff5200198e400 R11: ffffc9000cc72003 R12: 8b4cfffff6208d8b
R13: 48fffff618b58b48 R14: ffff8881b5ea72c0 R15: dffffc0000000000
FS:  000000000279f940(0000) GS:ffff8881dad00000(0000) knlGS:0000000000000000
nsproxy                   63KB         75KB
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000072c000 CR3: 00000001c031f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
