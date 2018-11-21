Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD2FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D713A21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D713A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbeKVC7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:59:12 -0500
Received: from mail-it1-f197.google.com ([209.85.166.197]:60121 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbeKVC7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:59:11 -0500
Received: by mail-it1-f197.google.com with SMTP id 66-v6so7509217itz.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Qrhq8boVGqRP3kxHMSbUuOMXq1cWYffgOCH+HyNAAt0=;
        b=ZiCK7nzcHpWDGeVDGxGN/lM18nSy31HawuQ2mnX4aXFuGcYfHKnXMdL+V1sOG3ZPgl
         s6Dsm48ohoJkW2cCHWkdoDfufRdBbmPzZSNV/oDdcobe8/LXHQ8RyTrNQWpgNYn8GqWt
         P6WAp0mde0qcf9HTabLWocJAkTtsfwv/QUNfIjTdPCARO42r+DsU0pNtf/U+TevnjG0C
         TKowiSqVgtOAHQtDBJEUm8YGPKyYrg/xh39MzmGQI4vNs/lEs6AaWphFMHFQFyvNG3hS
         6I/MaWYAGzunI267O/jufOVmsYG21rhE41PZH5OHY7GZISalweyFJSdmoJs1s4Tw70Nj
         tPJA==
X-Gm-Message-State: AA+aEWYRI+katQes2QMXwhJIp0mDHfKZl1Ffdxf0hNWj7MRkw40rLEh0
        1qR30QsrY6FzQlqRlR7TAsOOmBwZecV7ENofPTw/oldgicNv
X-Google-Smtp-Source: AJdET5dzNi4PpLee+Iv7faZ4RurL5IXLZxE4v3Lfm2KpywJY78hZ/NVc528pcg+zgtT9HO2jo/TapwvBAPk+GJZ88kdqP11oS8Cx
MIME-Version: 1.0
X-Received: by 2002:a02:8ca9:: with SMTP id f38mr4797233jak.14.1542817443272;
 Wed, 21 Nov 2018 08:24:03 -0800 (PST)
Date:   Wed, 21 Nov 2018 08:24:03 -0800
In-Reply-To: <000000000000d03eea0571adfe83@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8e163057b2f2ddf@google.com>
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

HEAD commit:    442b8cea2477 Add linux-next specific files for 20181109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a1426d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f72bdb11df9fbe8
dashboard link: https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1632326d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a16ed5400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0

======================================================
WARNING: possible circular locking dependency detected
4.20.0-rc1-next-20181109+ #110 Not tainted
------------------------------------------------------
syz-executor599/5968 is trying to acquire lock:
00000000e42cbf00 (sb_writers#3){.+.+}, at: sb_start_write  
include/linux/fs.h:1607 [inline]
00000000e42cbf00 (sb_writers#3){.+.+}, at: mnt_want_write+0x3f/0xc0  
fs/namespace.c:359

but task is already holding lock:
00000000166f985a (&iint->mutex){+.+.}, at: process_measurement+0x438/0x1bf0  
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
        __sb_start_write+0x214/0x370 fs/super.c:1564
        sb_start_write include/linux/fs.h:1607 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:359
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

1 lock held by syz-executor599/5968:
  #0: 00000000166f985a (&iint->mutex){+.+.}, at:  
process_measurement+0x438/0x1bf0 security/integrity/ima/ima_main.c:224

stack backtrace:
CPU: 0 PID: 5968 Comm: syz-executor599 Not tainted  
4.20.0-rc1-next-20181109+ #110
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  print_circular_bug.isra.35.cold.56+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1863 [inline]
  check_prevs_add kernel/locking/lockdep.c:1976 [inline]
  validate_chain kernel/locking/lockdep.c:2347 [inline]
  __lock_acquire+0x3399/0x4c20 kernel/locking/lockdep.c:3341
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
  percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
  percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
  __sb_start_write+0x214/0x370 fs/super.c:1564
  sb_start_write include/linux/fs.h:1607 [inline]
  mnt_want_write+0x3f/0xc0 fs/namespace.c:359
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
RIP: 0033:0x441af9
Code: 23 02 00 85 c0 b8 00 00 00 00 48 0f 44 c3 5b c3 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffce8c93d48 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000441af9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000020000040
RBP: 0000000000000000 R08: 0000000000402850 R09: 0000000000402850
R10: 0000000000402850 R11: 0000000000000246 R12: 0000000000402850
R13: 00000000004028e0 R14: 0000000000000000 R15: 0000000000000000
kobject: 'rx-0' (000000008bf42b56): kobject_cleanup, parent 00000000f75c8bd3
kobject: 'rx-0' (000000008bf42b56): auto cleanup 'remove' event
kobject: 'rx-0' (000000008bf42b56): kobject_uevent_env
kobject: 'rx-0' (000000008bf42b56): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/rx-0'
kobject: 'rx-0' (000000008bf42b56): auto cleanup kobject_del
kobject: 'rx-0' (000000008bf42b56): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (00000000bbdcdbed): kobject_cleanup, parent 00000000f75c8bd3
kobject: 'tx-0' (00000000bbdcdbed): auto cleanup 'remove' event
kobject: 'tx-0' (00000000bbdcdbed): kobject_uevent_env
kobject: 'tx-0' (00000000bbdcdbed): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun/queues/tx-0'
kobject: 'tx-0' (00000000bbdcdbed): auto cleanup kobject_del
kobject: 'tx-0' (00000000bbdcdbed): calling ktype release
kobject: 'tx-0': free name
kobject: 'queues' (00000000f75c8bd3): kobject_cleanup, parent            
(null)
kobject: 'queues' (00000000f75c8bd3): calling ktype release
kobject: 'queues' (00000000f75c8bd3): kset_release
kobject: 'queues': free name
kobject: 'syz_tun' (00000000ad4d7dba): kobject_uevent_env
kobject: 'syz_tun' (00000000ad4d7dba): fill_kobj_path: path  
= '/devices/virtual/net/syz_tun'
kobject: 'syz_tun' (00000000ad4d7dba): kobject_cleanup, parent            
(null)
kobject: 'syz_tun' (00000000ad4d7dba): calling ktype release
kobject: 'syz_tun': free name
kobject: 'rx-0' (0000000017c19f65): kobject_cleanup, parent 000000003ca64aec
kobject: 'rx-0' (0000000017c19f65): auto cleanup 'remove' event
kobject: 'rx-0' (0000000017c19f65): kobject_uevent_env
kobject: 'rx-0' (0000000017c19f65): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'rx-0' (0000000017c19f65): auto cleanup kobject_del
kobject: 'rx-0' (0000000017c19f65): calling ktype release
kobject: 'rx-0': free name
kobject: 'tx-0' (000000003e77b572): kobject_cleanup, parent 000000003ca64aec
kobject: 'tx-0' (000000003e77b572): auto cleanup 'remove' event
kobject: 'tx-0' (000000003e77b572): kobject_uevent_env
kobject: 'tx-0' (000000003e77b572): kobject_uevent_env: uevent_suppress  
caused the event to drop!
kobject: 'tx-0' (000000003e77b572): auto cleanup kobject_del
kobject: 'tx-0' (000000003e77b572): calling ktype release
kobject: 'tx-0': free name

