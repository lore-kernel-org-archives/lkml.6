Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1385C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC5C214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC5C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbeKVCtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:49:10 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:42703 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbeKVCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:49:10 -0500
Received: by mail-it1-f200.google.com with SMTP id z195-v6so7358858itb.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=E+FRStBRBsgHWXsZzDcUwponmKLlsFCL/cwDIB32Ujs=;
        b=EZNCvB4B9UPnQyOd0jSGFHte5G/jbqBwXK2Xj9/0YXPh+a4vHsUp6ianDM4EHLr0Lf
         n9JUYDCgMX5oLjhdxXZfvdQhFKnJVKSeY2B9PWQP7tFYrbfAdgv+7ePbEwZvIZU0xEDa
         l33/GvvGAWTMvPcbfA68EWbW2plbir1XvbvcJ0ungrVb4tGXY4aPouvVsxPNfUG84kTw
         q67AcqKsXEHtjal4ji/AcxAwWM8DFuVqpk5vS4i6lprElu9H+ETTSnqgLyyvstpPaZZV
         EMvRdUNugqSGv4HPvid6t+ar6sm2Ugc+ygMu6PTvV2BJ/7obXxx/7UXuhEBeaFRnwDNA
         TscA==
X-Gm-Message-State: AGRZ1gJUh1erNkU4Lb0qA791KzjQ5VLNQCvtO25mJZMMxJUSewAkhgZX
        J2Dr5DUfnEte6xw/LNG5kO28q1tqaRVaob0LM4m4ptW0CKdi
X-Google-Smtp-Source: AJdET5c1BUN7ToYisHE2fYdW+A/BLC4HBJrbtMMpD3leGFmgXE2HIVSpw7L7U0lzj68Oz2QmEBXnnVviZiNKLJZRrcNaGVGzsMIS
MIME-Version: 1.0
X-Received: by 2002:a24:2793:: with SMTP id g141-v6mr4733823ita.39.1542816844498;
 Wed, 21 Nov 2018 08:14:04 -0800 (PST)
Date:   Wed, 21 Nov 2018 08:14:04 -0800
In-Reply-To: <000000000000d03eea0571adfe83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f85223057b2f0994@google.com>
Subject: Re: possible deadlock in mnt_want_write
From:   syzbot <syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    c8ce94b8fe53 Merge tag 'mips_fixes_4.20_3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a16ed5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73e2bc0cb6463446
dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d8ac5d400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0

======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc3+ #122 Not tainted
------------------------------------------------------
syz-executor0/6225 is trying to acquire lock:
000000001881f73a (sb_writers#3){.+.+}, at: sb_start_write  
include/linux/fs.h:1597 [inline]
000000001881f73a (sb_writers#3){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:360

but task is already holding lock:
00000000c37872d6 (&iint->mutex){+.+.}, at: process_measurement+0x438/0x1bf0  
security/integrity/ima/ima_main.c:224

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&iint->mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        process_measurement+0x438/0x1bf0  
security/integrity/ima/ima_main.c:224
        ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
        do_last fs/namei.c:3422 [inline]
        path_openat+0x134a/0x5150 fs/namei.c:3534
        do_filp_open+0x255/0x380 fs/namei.c:3564
        do_sys_open+0x568/0x700 fs/open.c:1063
        __do_sys_open fs/open.c:1081 [inline]
        __se_sys_open fs/open.c:1076 [inline]
        __x64_sys_open+0x7e/0xc0 fs/open.c:1076
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (sb_writers#3){.+.+}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36  
[inline]
        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
        __sb_start_write+0x214/0x370 fs/super.c:1387
        sb_start_write include/linux/fs.h:1597 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:360
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
        ovl_open_maybe_copy_up+0x12c/0x190 fs/overlayfs/copy_up.c:888
        ovl_open+0xb3/0x260 fs/overlayfs/file.c:123
        do_dentry_open+0x499/0x1250 fs/open.c:771
        vfs_open fs/open.c:880 [inline]
        dentry_open+0x143/0x1d0 fs/open.c:896
        ima_calc_file_hash+0x324/0x570  
security/integrity/ima/ima_crypto.c:427
        ima_collect_measurement+0x619/0x730  
security/integrity/ima/ima_api.c:232
        process_measurement+0x11fd/0x1bf0  
security/integrity/ima/ima_main.c:284
        ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
        do_last fs/namei.c:3422 [inline]
        path_openat+0x134a/0x5150 fs/namei.c:3534
        do_filp_open+0x255/0x380 fs/namei.c:3564
        do_sys_open+0x568/0x700 fs/open.c:1063
        __do_sys_open fs/open.c:1081 [inline]
        __se_sys_open fs/open.c:1076 [inline]
        __x64_sys_open+0x7e/0xc0 fs/open.c:1076
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&iint->mutex);
                                lock(sb_writers#3);
                                lock(&iint->mutex);
   lock(sb_writers#3);

  *** DEADLOCK ***

1 lock held by syz-executor0/6225:
  #0: 00000000c37872d6 (&iint->mutex){+.+.}, at:  
process_measurement+0x438/0x1bf0 security/integrity/ima/ima_main.c:224

stack backtrace:
CPU: 0 PID: 6225 Comm: syz-executor0 Not tainted 4.20.0-rc3+ #122
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  __sb_start_write+0x214/0x370 fs/super.c:1387
  sb_start_write include/linux/fs.h:1597 [inline]
  mnt_want_write+0x3f/0xc0 fs/namespace.c:360
  ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
  ovl_open_maybe_copy_up+0x12c/0x190 fs/overlayfs/copy_up.c:888
  ovl_open+0xb3/0x260 fs/overlayfs/file.c:123
  do_dentry_open+0x499/0x1250 fs/open.c:771
  vfs_open fs/open.c:880 [inline]
  dentry_open+0x143/0x1d0 fs/open.c:896
  ima_calc_file_hash+0x324/0x570 security/integrity/ima/ima_crypto.c:427
  ima_collect_measurement+0x619/0x730 security/integrity/ima/ima_api.c:232
  process_measurement+0x11fd/0x1bf0 security/integrity/ima/ima_main.c:284
  ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
  do_last fs/namei.c:3422 [inline]
  path_openat+0x134a/0x5150 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_sys_open+0x568/0x700 fs/open.c:1063
  __do_sys_open fs/open.c:1081 [inline]
  __se_sys_open fs/open.c:1076 [inline]
  __x64_sys_open+0x7e/0xc0 fs/open.c:1076
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd93abed08 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000040 RSI: 0000000000000003 RDI: 0000000020000780
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000

