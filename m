Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F5C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F12E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F12E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeILS1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:27:34 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:42686 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:27:33 -0400
Received: by mail-it0-f72.google.com with SMTP id 20-v6so3355256itb.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=garQHtwIgcq/wy5OsBOzsZScrWqINWEHbMTxY+l8Kmk=;
        b=tWZI3yxH3w+xvGdqnkzi6TZteEnfpN42wDK8+fGTDacr0MSjGQEqeIwtd+xZyDk/b5
         M2Qv3r5kuxTd/D/XtvwbP/D6/VNgrOfbnaB/1GGNtUid9LaLwGsFgmhpGr8c+C89MZiv
         Q80yAC3Bw6OVLSSVMCXgi1L/zShqXJmnQdCc7f8RLsHRRzmsoX8h02zBlaeouKs8sI0x
         R49ALMztp21bgqATw9GU6eHIGDXjU1uTcJAq2RiwSKHl9h6DaV/bGtseyGFF6Nnjd7hR
         gKyzHHdQTLVWWMs5eZN6zNgcHz8rUrDP5lxJ5phX+FrgIsoySn4u+W0LonWpn+aC2fsE
         hmgQ==
X-Gm-Message-State: APzg51Bd8t5IYLnO+RlzboHglVlCVsWiUR7TqyIM5f4LW0O3ddyVLQhc
        /q7C4BdzPz3UVb9OPuhYP9M/T2m5dKvK72q2z4KUAz8pBMTi
X-Google-Smtp-Source: ANB0VdYhYqjRIaTDikLW8S3CQtJ54ZCS3rOUnFAavAON4DmuUIufx8FncoD6pC5Ncq2mMJCg9DlmE2wniCdLZA3/KW7+aRfCRfSd
MIME-Version: 1.0
X-Received: by 2002:a6b:e902:: with SMTP id u2-v6mr1517399iof.105.1536758583104;
 Wed, 12 Sep 2018 06:23:03 -0700 (PDT)
Date:   Wed, 12 Sep 2018 06:23:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000739dd40575ac7d07@google.com>
Subject: general protection fault in lockref_get
From:   syzbot <syzbot+5dc733a19636067b82fd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, dhowells@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c1b097f27bf Add linux-next specific files for 20180912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1333df01400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=5dc733a19636067b82fd
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5dc733a19636067b82fd@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: cc1: uninitialized urandom read (8 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5580 Comm: syz-executor0 Not tainted 4.19.0-rc3-next-20180912+  
#72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__lock_acquire+0x237/0x4ec0 kernel/locking/lockdep.c:3291
Code: 28 00 00 00 0f 85 aa 33 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 6d 35 00 00 49 81 7d 00 20 90 9e 8a 0f 84 54 ff
RSP: 0018:ffff8801d36ff430 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 1ffff1003a6dff03 RCX: 0000000000000000
RDX: 0000000140000014 RSI: 0000000000000000 RDI: ffffffff89722928
RBP: ffff8801d36ff7c0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000a000000a0 R14: ffff8801b9cde100 R15: 0000000000000000
FS:  0000000000db8940(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000482e00 CR3: 00000001b9d4f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3901
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2d/0x40 kernel/locking/spinlock.c:144
  lockref_get+0x15/0x50 include/linux/spinlock.h:329
  dget include/linux/dcache.h:322 [inline]
  mqueue_get_tree+0x101/0x2e0 ipc/mqueue.c:362
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1787
  mq_create_mount+0xe3/0x190 ipc/mqueue.c:415
  mq_init_ns+0x15a/0x210 ipc/mqueue.c:1621
  create_ipc_ns ipc/namespace.c:58 [inline]
  copy_ipcs+0x3d2/0x580 ipc/namespace.c:84
  create_new_namespaces+0x376/0x900 kernel/nsproxy.c:87
  unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:206
  ksys_unshare+0x79c/0x10b0 kernel/fork.c:2535
  __do_sys_unshare kernel/fork.c:2603 [inline]
  __se_sys_unshare kernel/fork.c:2601 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2601
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459d87
Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 3d 8a fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 1d 8a fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcccf0eee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459d87
RDX: 0000000000000000 RSI: 00007ffcccf0eef0 RDI: 0000000008000000
RBP: 0000000000930b28 R08: 0000000000000000 R09: 0000000000000018
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000010
R13: 0000000000412cc0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 404378fbbfe9896c ]---
RIP: 0010:__lock_acquire+0x237/0x4ec0 kernel/locking/lockdep.c:3291
Code: 28 00 00 00 0f 85 aa 33 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f  
5d c3 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f  
85 6d 35 00 00 49 81 7d 00 20 90 9e 8a 0f 84 54 ff
RSP: 0018:ffff8801d36ff430 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 1ffff1003a6dff03 RCX: 0000000000000000
RDX: 0000000140000014 RSI: 0000000000000000 RDI: ffffffff89722928
RBP: ffff8801d36ff7c0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000a000000a0 R14: ffff8801b9cde100 R15: 0000000000000000
FS:  0000000000db8940(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000482e00 CR3: 00000001b9d4f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
