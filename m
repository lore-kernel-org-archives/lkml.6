Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C16EC71134
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9103204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9103204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeJPAvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:51:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36290 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeJPAvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:51:10 -0400
Received: by mail-io1-f70.google.com with SMTP id z15-v6so19389558iob.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=THqZRNF6jd+nvhb9hZDss4NTvMVc4wboEHyX52l9GM0=;
        b=Wggj4F0F8Oi5AxQtbB/EzgcZ0CSOKCd1okxukTo28rUqidvAyPG2vfuXKOwWHDUmqc
         u1irhhXKgKuUTxgoFxo2gsbQkJr4jHqNFDdL5sVQ5GABc2sNyqOzh8mxDcgNESraO4/6
         wyGnBVebPPJ3fWzRLnP6UEIR+uriVc5iF9wq76dobZbGbLf3SwR/ZCYLriplz+a6zkmc
         zFF6uvEmvkBORl906fZ/3vbi93j9D+c8ySuj9BGfvfNYkw6JvUKzKcxID61kq7WznzTp
         It7hGYNLeTrTzpLrS0SRnqlkD/EbZRlHo7sc0umKzYdXz2xetPWKVFg+xc77VZEC+fB7
         zz6A==
X-Gm-Message-State: ABuFfohDUnAWzY+Hepu7MVfuahkXI9/eri01e1Z1QAtkMb5t/2T0gIWH
        rqw5h5QWFAHmQS7VgGM3osKjQRqniB+p+gbwxxbwI3Im8ayG
X-Google-Smtp-Source: ACcGV63/SmkPl/lKa/c7YhddSH0sKmoOMCiiqv1iunQfgnMEykOlyFuFl/KSK6hHiWyM0vQ8R7hH4BolG0b88JWqA6fPPF6edmIO
MIME-Version: 1.0
X-Received: by 2002:a24:a048:: with SMTP id o69-v6mr14641429ite.39.1539623103947;
 Mon, 15 Oct 2018 10:05:03 -0700 (PDT)
Date:   Mon, 15 Oct 2018 10:05:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003302870578477029@google.com>
Subject: possible deadlock in process_measurement
From:   syzbot <syzbot+5ab61747675a87ea359d@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bab5c80b2110 Merge tag 'armsoc-fixes-4.19' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138e5f76400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=5ab61747675a87ea359d
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5ab61747675a87ea359d@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready

======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc7+ #60 Not tainted
------------------------------------------------------
syz-executor4/22440 is trying to acquire lock:
000000008e8e5998 (&ovl_i_mutex_key[depth]){+.+.}, at: inode_lock  
include/linux/fs.h:738 [inline]
000000008e8e5998 (&ovl_i_mutex_key[depth]){+.+.}, at:  
process_measurement+0xc3e/0x1bf0 security/integrity/ima/ima_main.c:205

but task is already holding lock:
00000000fd816d85 (&sig->cred_guard_mutex){+.+.}, at:  
prepare_bprm_creds+0x53/0x120 fs/exec.c:1404

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sig->cred_guard_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1102
        lock_trace+0x4c/0xe0 fs/proc/base.c:384
        proc_pid_syscall+0xad/0x520 fs/proc/base.c:617
        proc_single_show+0x101/0x190 fs/proc/base.c:737
IPv6: ADDRCONF(NETDEV_UP): wlan11: link is not ready
        seq_read+0x4af/0x1150 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:700 [inline]
        do_iter_read+0x4a3/0x650 fs/read_write.c:924
        vfs_readv+0x175/0x1c0 fs/read_write.c:986
        do_preadv+0x1cc/0x280 fs/read_write.c:1070
        __do_sys_preadv fs/read_write.c:1120 [inline]
        __se_sys_preadv fs/read_write.c:1115 [inline]
        __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1115
IPv6: ADDRCONF(NETDEV_UP): wlan12: link is not ready
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&p->lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
        __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
IPv6: ADDRCONF(NETDEV_UP): wlan13: link is not ready
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
        seq_read+0x71/0x1150 fs/seq_file.c:161
        do_loop_readv_writev fs/read_write.c:700 [inline]
        do_iter_read+0x4a3/0x650 fs/read_write.c:924
        vfs_readv+0x175/0x1c0 fs/read_write.c:986
        kernel_readv fs/splice.c:362 [inline]
        default_file_splice_read+0x53c/0xb20 fs/splice.c:417
        do_splice_to+0x12e/0x190 fs/splice.c:881
        splice_direct_to_actor+0x270/0x8f0 fs/splice.c:953
        do_splice_direct+0x2d4/0x420 fs/splice.c:1062
        do_sendfile+0x62a/0xe20 fs/read_write.c:1440
        __do_sys_sendfile64 fs/read_write.c:1495 [inline]
        __se_sys_sendfile64 fs/read_write.c:1487 [inline]
        __x64_sys_sendfile64+0x15d/0x250 fs/read_write.c:1487
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (sb_writers#4){.+.+}:
        percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36  
[inline]
        percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
        __sb_start_write+0x214/0x370 fs/super.c:1387
        sb_start_write include/linux/fs.h:1566 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:360
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
        ovl_do_remove+0x174/0xfd0 fs/overlayfs/dir.c:823
        ovl_unlink+0x17/0x20 fs/overlayfs/dir.c:868
        vfs_unlink+0x2db/0x510 fs/namei.c:4000
        do_unlinkat+0x6cc/0xa30 fs/namei.c:4063
        __do_sys_unlink fs/namei.c:4110 [inline]
        __se_sys_unlink fs/namei.c:4108 [inline]
        __x64_sys_unlink+0x42/0x50 fs/namei.c:4108
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&ovl_i_mutex_key[depth]){+.+.}:
        lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
        down_write+0x8a/0x130 kernel/locking/rwsem.c:70
        inode_lock include/linux/fs.h:738 [inline]
        process_measurement+0xc3e/0x1bf0  
security/integrity/ima/ima_main.c:205
        ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
        do_last fs/namei.c:3422 [inline]
        path_openat+0x134d/0x5160 fs/namei.c:3534
        do_filp_open+0x255/0x380 fs/namei.c:3564
        do_open_execat+0x221/0x8e0 fs/exec.c:853
        __do_execve_file.isra.33+0x173f/0x2540 fs/exec.c:1755
        do_execveat_common fs/exec.c:1866 [inline]
        do_execve fs/exec.c:1883 [inline]
        __do_sys_execve fs/exec.c:1964 [inline]
        __se_sys_execve fs/exec.c:1959 [inline]
        __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &ovl_i_mutex_key[depth] --> &p->lock --> &sig->cred_guard_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&sig->cred_guard_mutex);
                                lock(&p->lock);
                                lock(&sig->cred_guard_mutex);
   lock(&ovl_i_mutex_key[depth]);

  *** DEADLOCK ***

1 lock held by syz-executor4/22440:
  #0: 00000000fd816d85 (&sig->cred_guard_mutex){+.+.}, at:  
prepare_bprm_creds+0x53/0x120 fs/exec.c:1404

stack backtrace:
CPU: 1 PID: 22440 Comm: syz-executor4 Not tainted 4.19.0-rc7+ #60
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
  print_circular_bug.isra.33.cold.54+0x1bd/0x27d  
kernel/locking/lockdep.c:1221
  check_prev_add kernel/locking/lockdep.c:1861 [inline]
  check_prevs_add kernel/locking/lockdep.c:1974 [inline]
  validate_chain kernel/locking/lockdep.c:2415 [inline]
  __lock_acquire+0x33e4/0x4ec0 kernel/locking/lockdep.c:3411
  lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
  down_write+0x8a/0x130 kernel/locking/rwsem.c:70
  inode_lock include/linux/fs.h:738 [inline]
  process_measurement+0xc3e/0x1bf0 security/integrity/ima/ima_main.c:205
  ima_file_check+0xe5/0x130 security/integrity/ima/ima_main.c:391
  do_last fs/namei.c:3422 [inline]
  path_openat+0x134d/0x5160 fs/namei.c:3534
  do_filp_open+0x255/0x380 fs/namei.c:3564
  do_open_execat+0x221/0x8e0 fs/exec.c:853
  __do_execve_file.isra.33+0x173f/0x2540 fs/exec.c:1755
  do_execveat_common fs/exec.c:1866 [inline]
  do_execve fs/exec.c:1883 [inline]
  __do_sys_execve fs/exec.c:1964 [inline]
  __se_sys_execve fs/exec.c:1959 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fceac5acc78 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000020000880 RSI: 0000000020000640 RDI: 0000000020000480
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fceac5ad6d4
R13: 00000000004bdbd4 R14: 00000000004cc7d8 R15: 00000000ffffffff
ip6_tunnel: ip6gre2 xmit: Local address not yet configured!
ip6_tunnel: ip6gre1 xmit: Local address not yet configured!
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
ip6_tunnel: ip6gre2 xmit: Local address not yet configured!
ip6_tunnel: ip6gre1 xmit: Local address not yet configured!
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
ip6_tunnel: ip6gre1 xmit: Local address not yet configured!
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
ip6_tunnel: ip6gre1 xmit: Local address not yet configured!
ip6_tunnel: ip6gre2 xmit: Local address not yet configured!
ip6_tunnel: ip6gre2 xmit: Local address not yet configured!
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
ip6_tunnel: ip6gre1 xmit: Local address not yet configured!
ip6_tunnel: ip6gre2 xmit: Local address not yet configured!
IPv6: ADDRCONF(NETDEV_CHANGE): vcan0: link becomes ready
ip6_tunnel: ip6gre1 xmit: Local address not yet configured!
ip6_tunnel: ip6gre1 xmit: Local address not yet configured!
ip6_tunnel: ip6gre2 xmit: Local address not yet configured!
kobject: 'hwsim80' (00000000884015b0): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim80' (00000000884015b0): kobject_uevent_env
kobject: 'hwsim80' (00000000884015b0): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80'
ip6_tunnel: ip6gre1 xmit: Local address not yet configured!
kobject: 'hwsim80' (00000000884015b0): kobject_uevent_env
kobject: 'hwsim80' (00000000884015b0): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80'
kobject: 'ieee80211' (0000000069570b8a): kobject_add_internal:  
parent: 'hwsim80', set: '(null)'
kobject: 'phy80' (000000006685243f): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy80' (000000006685243f): kobject_uevent_env
kobject: 'phy80' (000000006685243f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80/ieee80211/phy80'
kobject: 'rfkill83' (000000003b96fa77): kobject_add_internal:  
parent: 'phy80', set: 'devices'
kobject: 'rfkill83' (000000003b96fa77): kobject_uevent_env
kobject: 'rfkill83' (000000003b96fa77): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80/ieee80211/phy80/rfkill83'
ieee80211 phy80: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000b389e3e0): kobject_add_internal: parent: 'hwsim80',  
set: '(null)'
kobject: 'wlan19' (00000000173b10e2): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan19' (00000000173b10e2): kobject_uevent_env
kobject: 'wlan19' (00000000173b10e2): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80/net/wlan19'
kobject: 'queues' (00000000eb14d180): kobject_add_internal:  
parent: 'wlan19', set: '<NULL>'
kobject: 'queues' (00000000eb14d180): kobject_uevent_env
kobject: 'queues' (00000000eb14d180): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000002be07406): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000002be07406): kobject_uevent_env
kobject: 'rx-0' (000000002be07406): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80/net/wlan19/queues/rx-0'
kobject: 'tx-0' (00000000c4e796bf): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000c4e796bf): kobject_uevent_env
kobject: 'tx-0' (00000000c4e796bf): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80/net/wlan19/queues/tx-0'
kobject: 'tx-1' (00000000515931b5): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000515931b5): kobject_uevent_env
kobject: 'tx-1' (00000000515931b5): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80/net/wlan19/queues/tx-1'
kobject: 'tx-2' (00000000c773be1e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000c773be1e): kobject_uevent_env
kobject: 'tx-2' (00000000c773be1e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80/net/wlan19/queues/tx-2'
kobject: 'tx-3' (00000000ff0aef0a): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000ff0aef0a): kobject_uevent_env
kobject: 'tx-3' (00000000ff0aef0a): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim80/net/wlan19/queues/tx-3'
kobject: 'hwsim81' (00000000a47a145e): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim81' (00000000a47a145e): kobject_uevent_env
kobject: 'hwsim81' (00000000a47a145e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81'
kobject: 'hwsim81' (00000000a47a145e): kobject_uevent_env
kobject: 'hwsim81' (00000000a47a145e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81'
kobject: 'ieee80211' (000000006e880dda): kobject_add_internal:  
parent: 'hwsim81', set: '(null)'
kobject: 'phy81' (00000000c3e0e1bc): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy81' (00000000c3e0e1bc): kobject_uevent_env
ip6_tunnel: ip6gre2 xmit: Local address not yet configured!
kobject: 'phy81' (00000000c3e0e1bc): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81/ieee80211/phy81'
kobject: 'rfkill84' (000000005f89f9ac): kobject_add_internal:  
parent: 'phy81', set: 'devices'
kobject: 'rfkill84' (000000005f89f9ac): kobject_uevent_env
kobject: 'rfkill84' (000000005f89f9ac): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81/ieee80211/phy81/rfkill84'
ieee80211 phy81: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000de2128e7): kobject_add_internal: parent: 'hwsim81',  
set: '(null)'
kobject: 'wlan20' (00000000c07ac1a0): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan20' (00000000c07ac1a0): kobject_uevent_env
kobject: 'wlan20' (00000000c07ac1a0): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81/net/wlan20'
kobject: 'queues' (0000000049357ad5): kobject_add_internal:  
parent: 'wlan20', set: '<NULL>'
kobject: 'queues' (0000000049357ad5): kobject_uevent_env
kobject: 'queues' (0000000049357ad5): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000068f4a1ce): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000068f4a1ce): kobject_uevent_env
kobject: 'rx-0' (0000000068f4a1ce): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81/net/wlan20/queues/rx-0'
kobject: 'tx-0' (0000000072d99b10): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000072d99b10): kobject_uevent_env
kobject: 'tx-0' (0000000072d99b10): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81/net/wlan20/queues/tx-0'
kobject: 'tx-1' (0000000026a3b255): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (0000000026a3b255): kobject_uevent_env
kobject: 'tx-1' (0000000026a3b255): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81/net/wlan20/queues/tx-1'
kobject: 'tx-2' (0000000060652f84): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (0000000060652f84): kobject_uevent_env
kobject: 'tx-2' (0000000060652f84): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81/net/wlan20/queues/tx-2'
kobject: 'tx-3' (0000000018485de5): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (0000000018485de5): kobject_uevent_env
kobject: 'tx-3' (0000000018485de5): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim81/net/wlan20/queues/tx-3'
kobject: 'hwsim82' (00000000a720814e): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim82' (00000000a720814e): kobject_uevent_env
kobject: 'hwsim82' (00000000a720814e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82'
kobject: 'hwsim82' (00000000a720814e): kobject_uevent_env
kobject: 'hwsim82' (00000000a720814e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82'
kobject: 'ieee80211' (000000006c9e46c3): kobject_add_internal:  
parent: 'hwsim82', set: '(null)'
kobject: 'phy82' (000000001c68df7b): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy82' (000000001c68df7b): kobject_uevent_env
kobject: 'phy82' (000000001c68df7b): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82/ieee80211/phy82'
kobject: 'rfkill85' (000000001d4ac63b): kobject_add_internal:  
parent: 'phy82', set: 'devices'
kobject: 'rfkill85' (000000001d4ac63b): kobject_uevent_env
kobject: 'rfkill85' (000000001d4ac63b): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82/ieee80211/phy82/rfkill85'
ieee80211 phy82: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000a46ff1d7): kobject_add_internal: parent: 'hwsim82',  
set: '(null)'
kobject: 'wlan16' (00000000a5fd7536): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan16' (00000000a5fd7536): kobject_uevent_env
kobject: 'wlan16' (00000000a5fd7536): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82/net/wlan16'
kobject: 'queues' (0000000092ddde0c): kobject_add_internal:  
parent: 'wlan16', set: '<NULL>'
kobject: 'queues' (0000000092ddde0c): kobject_uevent_env
kobject: 'queues' (0000000092ddde0c): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000306b3dff): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000306b3dff): kobject_uevent_env
kobject: 'rx-0' (00000000306b3dff): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82/net/wlan16/queues/rx-0'
kobject: 'tx-0' (00000000d34ca135): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000d34ca135): kobject_uevent_env
kobject: 'tx-0' (00000000d34ca135): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82/net/wlan16/queues/tx-0'
kobject: 'tx-1' (00000000a57bad07): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000a57bad07): kobject_uevent_env
kobject: 'tx-1' (00000000a57bad07): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82/net/wlan16/queues/tx-1'
kobject: 'tx-2' (00000000fd969aad): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000fd969aad): kobject_uevent_env
kobject: 'tx-2' (00000000fd969aad): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82/net/wlan16/queues/tx-2'
kobject: 'tx-3' (000000004872947e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (000000004872947e): kobject_uevent_env
kobject: 'tx-3' (000000004872947e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim82/net/wlan16/queues/tx-3'
kobject: 'hwsim83' (00000000881659f1): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim83' (00000000881659f1): kobject_uevent_env
kobject: 'hwsim83' (00000000881659f1): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83'
kobject: 'hwsim83' (00000000881659f1): kobject_uevent_env
kobject: 'hwsim83' (00000000881659f1): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83'
kobject: 'ieee80211' (00000000f53c9ba0): kobject_add_internal:  
parent: 'hwsim83', set: '(null)'
kobject: 'phy83' (00000000b2972636): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy83' (00000000b2972636): kobject_uevent_env
kobject: 'phy83' (00000000b2972636): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83/ieee80211/phy83'
kobject: 'rfkill86' (00000000f92fb2ab): kobject_add_internal:  
parent: 'phy83', set: 'devices'
kobject: 'rfkill86' (00000000f92fb2ab): kobject_uevent_env
kobject: 'rfkill86' (00000000f92fb2ab): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83/ieee80211/phy83/rfkill86'
ieee80211 phy83: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000a098d82d): kobject_add_internal: parent: 'hwsim83',  
set: '(null)'
kobject: 'wlan21' (000000009b89d44e): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan21' (000000009b89d44e): kobject_uevent_env
kobject: 'wlan21' (000000009b89d44e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83/net/wlan21'
kobject: 'queues' (000000002228c10e): kobject_add_internal:  
parent: 'wlan21', set: '<NULL>'
kobject: 'queues' (000000002228c10e): kobject_uevent_env
kobject: 'queues' (000000002228c10e): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000a6bc8dd1): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000a6bc8dd1): kobject_uevent_env
kobject: 'rx-0' (00000000a6bc8dd1): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83/net/wlan21/queues/rx-0'
kobject: 'tx-0' (0000000052a35051): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000052a35051): kobject_uevent_env
kobject: 'tx-0' (0000000052a35051): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83/net/wlan21/queues/tx-0'
kobject: 'tx-1' (0000000060511977): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (0000000060511977): kobject_uevent_env
kobject: 'tx-1' (0000000060511977): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83/net/wlan21/queues/tx-1'
kobject: 'tx-2' (000000003943709e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (000000003943709e): kobject_uevent_env
kobject: 'tx-2' (000000003943709e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83/net/wlan21/queues/tx-2'
kobject: 'tx-3' (00000000f1f070e6): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000f1f070e6): kobject_uevent_env
kobject: 'tx-3' (00000000f1f070e6): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim83/net/wlan21/queues/tx-3'
kobject: 'hwsim84' (00000000fb1e279c): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim84' (00000000fb1e279c): kobject_uevent_env
kobject: 'hwsim84' (00000000fb1e279c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84'
kobject: 'hwsim84' (00000000fb1e279c): kobject_uevent_env
kobject: 'hwsim84' (00000000fb1e279c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84'
kobject: 'ieee80211' (00000000b15ae302): kobject_add_internal:  
parent: 'hwsim84', set: '(null)'
kobject: 'phy84' (00000000d11108d8): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy84' (00000000d11108d8): kobject_uevent_env
kobject: 'phy84' (00000000d11108d8): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84/ieee80211/phy84'
kobject: 'rfkill87' (00000000cb4ad89c): kobject_add_internal:  
parent: 'phy84', set: 'devices'
kobject: 'rfkill87' (00000000cb4ad89c): kobject_uevent_env
kobject: 'rfkill87' (00000000cb4ad89c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84/ieee80211/phy84/rfkill87'
ieee80211 phy84: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000444aa2f8): kobject_add_internal: parent: 'hwsim84',  
set: '(null)'
kobject: 'wlan14' (00000000dd31fe74): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan14' (00000000dd31fe74): kobject_uevent_env
kobject: 'wlan14' (00000000dd31fe74): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84/net/wlan14'
kobject: 'queues' (0000000059450f67): kobject_add_internal:  
parent: 'wlan14', set: '<NULL>'
kobject: 'queues' (0000000059450f67): kobject_uevent_env
kobject: 'queues' (0000000059450f67): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000002ce67750): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000002ce67750): kobject_uevent_env
kobject: 'rx-0' (000000002ce67750): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84/net/wlan14/queues/rx-0'
kobject: 'tx-0' (00000000e2b9d39c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000e2b9d39c): kobject_uevent_env
kobject: 'tx-0' (00000000e2b9d39c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84/net/wlan14/queues/tx-0'
kobject: 'tx-1' (000000009fe1f8d1): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (000000009fe1f8d1): kobject_uevent_env
kobject: 'tx-1' (000000009fe1f8d1): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84/net/wlan14/queues/tx-1'
kobject: 'tx-2' (000000007013ffb9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (000000007013ffb9): kobject_uevent_env
kobject: 'tx-2' (000000007013ffb9): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84/net/wlan14/queues/tx-2'
kobject: 'tx-3' (0000000096a346f6): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (0000000096a346f6): kobject_uevent_env
kobject: 'tx-3' (0000000096a346f6): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim84/net/wlan14/queues/tx-3'
kobject: 'hwsim85' (00000000ca276466): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim85' (00000000ca276466): kobject_uevent_env
kobject: 'hwsim85' (00000000ca276466): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85'
kobject: 'hwsim85' (00000000ca276466): kobject_uevent_env
kobject: 'hwsim85' (00000000ca276466): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85'
kobject: 'ieee80211' (00000000813be1c0): kobject_add_internal:  
parent: 'hwsim85', set: '(null)'
kobject: 'phy85' (0000000057e14462): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy85' (0000000057e14462): kobject_uevent_env
kobject: 'phy85' (0000000057e14462): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85/ieee80211/phy85'
kobject: 'rfkill88' (000000005d9adf92): kobject_add_internal:  
parent: 'phy85', set: 'devices'
kobject: 'rfkill88' (000000005d9adf92): kobject_uevent_env
kobject: 'rfkill88' (000000005d9adf92): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85/ieee80211/phy85/rfkill88'
ieee80211 phy85: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (000000004c0cdeb3): kobject_add_internal: parent: 'hwsim85',  
set: '(null)'
kobject: 'wlan3' (000000003748a3f2): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan3' (000000003748a3f2): kobject_uevent_env
kobject: 'wlan3' (000000003748a3f2): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85/net/wlan3'
kobject: 'queues' (0000000063c4b00b): kobject_add_internal:  
parent: 'wlan3', set: '<NULL>'
kobject: 'queues' (0000000063c4b00b): kobject_uevent_env
kobject: 'queues' (0000000063c4b00b): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000002108f327): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000002108f327): kobject_uevent_env
kobject: 'rx-0' (000000002108f327): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85/net/wlan3/queues/rx-0'
kobject: 'tx-0' (0000000095fea208): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000095fea208): kobject_uevent_env
kobject: 'tx-0' (0000000095fea208): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85/net/wlan3/queues/tx-0'
kobject: 'tx-1' (00000000988dd3d0): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000988dd3d0): kobject_uevent_env
kobject: 'tx-1' (00000000988dd3d0): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85/net/wlan3/queues/tx-1'
kobject: 'tx-2' (000000004e2e650c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (000000004e2e650c): kobject_uevent_env
kobject: 'tx-2' (000000004e2e650c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85/net/wlan3/queues/tx-2'
kobject: 'tx-3' (00000000b2fce9b9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000b2fce9b9): kobject_uevent_env
kobject: 'tx-3' (00000000b2fce9b9): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim85/net/wlan3/queues/tx-3'
kobject: 'hwsim86' (000000005a17f2b6): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim86' (000000005a17f2b6): kobject_uevent_env
kobject: 'hwsim86' (000000005a17f2b6): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86'
kobject: 'hwsim86' (000000005a17f2b6): kobject_uevent_env
kobject: 'hwsim86' (000000005a17f2b6): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86'
kobject: 'ieee80211' (000000003f089935): kobject_add_internal:  
parent: 'hwsim86', set: '(null)'
kobject: 'phy86' (00000000d05a807f): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy86' (00000000d05a807f): kobject_uevent_env
kobject: 'phy86' (00000000d05a807f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86/ieee80211/phy86'
kobject: 'rfkill89' (000000008e9ce379): kobject_add_internal:  
parent: 'phy86', set: 'devices'
kobject: 'rfkill89' (000000008e9ce379): kobject_uevent_env
kobject: 'rfkill89' (000000008e9ce379): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86/ieee80211/phy86/rfkill89'
ieee80211 phy86: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000da109402): kobject_add_internal: parent: 'hwsim86',  
set: '(null)'
kobject: 'wlan17' (0000000047f34b4f): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan17' (0000000047f34b4f): kobject_uevent_env
kobject: 'wlan17' (0000000047f34b4f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86/net/wlan17'
kobject: 'queues' (00000000962d7811): kobject_add_internal:  
parent: 'wlan17', set: '<NULL>'
kobject: 'queues' (00000000962d7811): kobject_uevent_env
kobject: 'queues' (00000000962d7811): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000fecaa945): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000fecaa945): kobject_uevent_env
kobject: 'rx-0' (00000000fecaa945): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86/net/wlan17/queues/rx-0'
kobject: 'tx-0' (00000000f7c024bf): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000f7c024bf): kobject_uevent_env
kobject: 'tx-0' (00000000f7c024bf): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86/net/wlan17/queues/tx-0'
kobject: 'tx-1' (0000000032f6a1ff): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (0000000032f6a1ff): kobject_uevent_env
kobject: 'tx-1' (0000000032f6a1ff): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86/net/wlan17/queues/tx-1'
kobject: 'tx-2' (000000009bda8057): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (000000009bda8057): kobject_uevent_env
kobject: 'tx-2' (000000009bda8057): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86/net/wlan17/queues/tx-2'
kobject: 'tx-3' (0000000077260d50): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (0000000077260d50): kobject_uevent_env
kobject: 'tx-3' (0000000077260d50): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim86/net/wlan17/queues/tx-3'
kobject: 'hwsim87' (0000000028d66ed8): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim87' (0000000028d66ed8): kobject_uevent_env
kobject: 'hwsim87' (0000000028d66ed8): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87'
kobject: 'hwsim87' (0000000028d66ed8): kobject_uevent_env
kobject: 'hwsim87' (0000000028d66ed8): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87'
kobject: 'ieee80211' (00000000dc1f4203): kobject_add_internal:  
parent: 'hwsim87', set: '(null)'
kobject: 'phy87' (000000002fd93634): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy87' (000000002fd93634): kobject_uevent_env
kobject: 'phy87' (000000002fd93634): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87/ieee80211/phy87'
kobject: 'rfkill90' (000000009ffdd768): kobject_add_internal:  
parent: 'phy87', set: 'devices'
kobject: 'rfkill90' (000000009ffdd768): kobject_uevent_env
kobject: 'rfkill90' (000000009ffdd768): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87/ieee80211/phy87/rfkill90'
ieee80211 phy87: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (0000000014812229): kobject_add_internal: parent: 'hwsim87',  
set: '(null)'
kobject: 'wlan22' (0000000043bf12bd): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan22' (0000000043bf12bd): kobject_uevent_env
kobject: 'wlan22' (0000000043bf12bd): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87/net/wlan22'
kobject: 'queues' (00000000401a3d31): kobject_add_internal:  
parent: 'wlan22', set: '<NULL>'
kobject: 'queues' (00000000401a3d31): kobject_uevent_env
kobject: 'queues' (00000000401a3d31): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000053997825): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000053997825): kobject_uevent_env
kobject: 'rx-0' (0000000053997825): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87/net/wlan22/queues/rx-0'
kobject: 'tx-0' (00000000f42adf47): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000f42adf47): kobject_uevent_env
kobject: 'tx-0' (00000000f42adf47): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87/net/wlan22/queues/tx-0'
kobject: 'tx-1' (00000000c516022f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000c516022f): kobject_uevent_env
kobject: 'tx-1' (00000000c516022f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87/net/wlan22/queues/tx-1'
kobject: 'tx-2' (00000000b157f675): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000b157f675): kobject_uevent_env
kobject: 'tx-2' (00000000b157f675): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87/net/wlan22/queues/tx-2'
kobject: 'tx-3' (000000000340e65d): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (000000000340e65d): kobject_uevent_env
kobject: 'tx-3' (000000000340e65d): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim87/net/wlan22/queues/tx-3'
kobject: 'hwsim88' (0000000036879902): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim88' (0000000036879902): kobject_uevent_env
kobject: 'hwsim88' (0000000036879902): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88'
kobject: 'hwsim88' (0000000036879902): kobject_uevent_env
kobject: 'hwsim88' (0000000036879902): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88'
kobject: 'ieee80211' (00000000dab03b0b): kobject_add_internal:  
parent: 'hwsim88', set: '(null)'
kobject: 'phy88' (00000000bb5a1939): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy88' (00000000bb5a1939): kobject_uevent_env
kobject: 'phy88' (00000000bb5a1939): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88/ieee80211/phy88'
kobject: 'rfkill91' (00000000558373f1): kobject_add_internal:  
parent: 'phy88', set: 'devices'
kobject: 'rfkill91' (00000000558373f1): kobject_uevent_env
kobject: 'rfkill91' (00000000558373f1): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88/ieee80211/phy88/rfkill91'
ieee80211 phy88: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (000000003c0ae0b8): kobject_add_internal: parent: 'hwsim88',  
set: '(null)'
kobject: 'wlan15' (00000000f4e97ee9): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan15' (00000000f4e97ee9): kobject_uevent_env
kobject: 'wlan15' (00000000f4e97ee9): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88/net/wlan15'
kobject: 'queues' (000000009cc561b2): kobject_add_internal:  
parent: 'wlan15', set: '<NULL>'
kobject: 'queues' (000000009cc561b2): kobject_uevent_env
kobject: 'queues' (000000009cc561b2): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000feccf1bb): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000feccf1bb): kobject_uevent_env
kobject: 'rx-0' (00000000feccf1bb): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88/net/wlan15/queues/rx-0'
kobject: 'tx-0' (0000000002ee4f6e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000002ee4f6e): kobject_uevent_env
kobject: 'tx-0' (0000000002ee4f6e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88/net/wlan15/queues/tx-0'
kobject: 'tx-1' (0000000042bb09e7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (0000000042bb09e7): kobject_uevent_env
kobject: 'tx-1' (0000000042bb09e7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88/net/wlan15/queues/tx-1'
kobject: 'tx-2' (00000000d29a8b7e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000d29a8b7e): kobject_uevent_env
kobject: 'tx-2' (00000000d29a8b7e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88/net/wlan15/queues/tx-2'
kobject: 'tx-3' (0000000004695c2a): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (0000000004695c2a): kobject_uevent_env
kobject: 'tx-3' (0000000004695c2a): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim88/net/wlan15/queues/tx-3'
kobject: 'hwsim89' (0000000048be5c39): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim89' (0000000048be5c39): kobject_uevent_env
kobject: 'hwsim89' (0000000048be5c39): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89'
kobject: 'hwsim89' (0000000048be5c39): kobject_uevent_env
kobject: 'hwsim89' (0000000048be5c39): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89'
kobject: 'ieee80211' (0000000012e6b5cf): kobject_add_internal:  
parent: 'hwsim89', set: '(null)'
kobject: 'phy89' (00000000216c9593): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy89' (00000000216c9593): kobject_uevent_env
kobject: 'phy89' (00000000216c9593): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89/ieee80211/phy89'
kobject: 'rfkill92' (000000008a7644aa): kobject_add_internal:  
parent: 'phy89', set: 'devices'
kobject: 'rfkill92' (000000008a7644aa): kobject_uevent_env
kobject: 'rfkill92' (000000008a7644aa): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89/ieee80211/phy89/rfkill92'
ieee80211 phy89: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (000000007c0a68dd): kobject_add_internal: parent: 'hwsim89',  
set: '(null)'
kobject: 'wlan4' (00000000cf356619): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan4' (00000000cf356619): kobject_uevent_env
kobject: 'wlan4' (00000000cf356619): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89/net/wlan4'
kobject: 'queues' (000000001e120007): kobject_add_internal:  
parent: 'wlan4', set: '<NULL>'
kobject: 'queues' (000000001e120007): kobject_uevent_env
kobject: 'queues' (000000001e120007): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (0000000070a2af1b): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (0000000070a2af1b): kobject_uevent_env
kobject: 'rx-0' (0000000070a2af1b): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89/net/wlan4/queues/rx-0'
kobject: 'tx-0' (00000000c685c753): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000c685c753): kobject_uevent_env
kobject: 'tx-0' (00000000c685c753): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89/net/wlan4/queues/tx-0'
kobject: 'tx-1' (0000000042e053ff): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (0000000042e053ff): kobject_uevent_env
kobject: 'tx-1' (0000000042e053ff): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89/net/wlan4/queues/tx-1'
kobject: 'tx-2' (00000000297a3fac): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000297a3fac): kobject_uevent_env
kobject: 'tx-2' (00000000297a3fac): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89/net/wlan4/queues/tx-2'
kobject: 'tx-3' (00000000c294bf30): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000c294bf30): kobject_uevent_env
kobject: 'tx-3' (00000000c294bf30): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim89/net/wlan4/queues/tx-3'
kobject: 'hwsim90' (00000000e4aaef1b): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim90' (00000000e4aaef1b): kobject_uevent_env
kobject: 'hwsim90' (00000000e4aaef1b): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90'
kobject: 'hwsim90' (00000000e4aaef1b): kobject_uevent_env
kobject: 'hwsim90' (00000000e4aaef1b): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90'
kobject: 'ieee80211' (00000000d3c4f44a): kobject_add_internal:  
parent: 'hwsim90', set: '(null)'
kobject: 'phy90' (00000000d6d46f6a): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy90' (00000000d6d46f6a): kobject_uevent_env
kobject: 'phy90' (00000000d6d46f6a): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90/ieee80211/phy90'
kobject: 'rfkill93' (00000000a26f0a8a): kobject_add_internal:  
parent: 'phy90', set: 'devices'
kobject: 'rfkill93' (00000000a26f0a8a): kobject_uevent_env
kobject: 'rfkill93' (00000000a26f0a8a): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90/ieee80211/phy90/rfkill93'
ieee80211 phy90: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (0000000020850f67): kobject_add_internal: parent: 'hwsim90',  
set: '(null)'
kobject: 'wlan18' (000000003c48910b): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan18' (000000003c48910b): kobject_uevent_env
kobject: 'wlan18' (000000003c48910b): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90/net/wlan18'
kobject: 'queues' (00000000b51d60c2): kobject_add_internal:  
parent: 'wlan18', set: '<NULL>'
kobject: 'queues' (00000000b51d60c2): kobject_uevent_env
kobject: 'queues' (00000000b51d60c2): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000003ddde05e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000003ddde05e): kobject_uevent_env
kobject: 'rx-0' (000000003ddde05e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90/net/wlan18/queues/rx-0'
kobject: 'tx-0' (00000000654529cf): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000654529cf): kobject_uevent_env
kobject: 'tx-0' (00000000654529cf): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90/net/wlan18/queues/tx-0'
kobject: 'tx-1' (00000000678451d7): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000678451d7): kobject_uevent_env
kobject: 'tx-1' (00000000678451d7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90/net/wlan18/queues/tx-1'
kobject: 'tx-2' (000000005d2d8de2): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (000000005d2d8de2): kobject_uevent_env
kobject: 'tx-2' (000000005d2d8de2): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90/net/wlan18/queues/tx-2'
kobject: 'tx-3' (00000000a070d2ca): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000a070d2ca): kobject_uevent_env
kobject: 'tx-3' (00000000a070d2ca): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim90/net/wlan18/queues/tx-3'
kobject: 'hwsim91' (000000005a135c9c): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim91' (000000005a135c9c): kobject_uevent_env
kobject: 'hwsim91' (000000005a135c9c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91'
kobject: 'hwsim91' (000000005a135c9c): kobject_uevent_env
kobject: 'hwsim91' (000000005a135c9c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91'
kobject: 'ieee80211' (0000000054041e44): kobject_add_internal:  
parent: 'hwsim91', set: '(null)'
kobject: 'phy91' (000000002254a539): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy91' (000000002254a539): kobject_uevent_env
kobject: 'phy91' (000000002254a539): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91/ieee80211/phy91'
kobject: 'rfkill94' (00000000628caf66): kobject_add_internal:  
parent: 'phy91', set: 'devices'
kobject: 'rfkill94' (00000000628caf66): kobject_uevent_env
kobject: 'rfkill94' (00000000628caf66): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91/ieee80211/phy91/rfkill94'
ieee80211 phy91: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (000000009f73ce44): kobject_add_internal: parent: 'hwsim91',  
set: '(null)'
kobject: 'wlan23' (000000000e928207): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan23' (000000000e928207): kobject_uevent_env
kobject: 'wlan23' (000000000e928207): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91/net/wlan23'
kobject: 'queues' (000000008b69631c): kobject_add_internal:  
parent: 'wlan23', set: '<NULL>'
kobject: 'queues' (000000008b69631c): kobject_uevent_env
kobject: 'queues' (000000008b69631c): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000e654d2c4): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000e654d2c4): kobject_uevent_env
kobject: 'rx-0' (00000000e654d2c4): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91/net/wlan23/queues/rx-0'
kobject: 'tx-0' (000000003f8728ae): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000003f8728ae): kobject_uevent_env
kobject: 'tx-0' (000000003f8728ae): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91/net/wlan23/queues/tx-0'
kobject: 'tx-1' (00000000b821fdf5): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000b821fdf5): kobject_uevent_env
kobject: 'tx-1' (00000000b821fdf5): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91/net/wlan23/queues/tx-1'
kobject: 'tx-2' (00000000c8b4dddc): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000c8b4dddc): kobject_uevent_env
kobject: 'tx-2' (00000000c8b4dddc): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91/net/wlan23/queues/tx-2'
kobject: 'tx-3' (000000003e6262f9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (000000003e6262f9): kobject_uevent_env
kobject: 'tx-3' (000000003e6262f9): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim91/net/wlan23/queues/tx-3'
kobject: 'hwsim92' (0000000024d7cbbc): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim92' (0000000024d7cbbc): kobject_uevent_env
kobject: 'hwsim92' (0000000024d7cbbc): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92'
kobject: 'hwsim92' (0000000024d7cbbc): kobject_uevent_env
kobject: 'hwsim92' (0000000024d7cbbc): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92'
kobject: 'ieee80211' (00000000183a19a0): kobject_add_internal:  
parent: 'hwsim92', set: '(null)'
kobject: 'phy92' (000000001c8e3ce5): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy92' (000000001c8e3ce5): kobject_uevent_env
kobject: 'phy92' (000000001c8e3ce5): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92/ieee80211/phy92'
kobject: 'rfkill95' (00000000d89ee6c7): kobject_add_internal:  
parent: 'phy92', set: 'devices'
kobject: 'rfkill95' (00000000d89ee6c7): kobject_uevent_env
kobject: 'rfkill95' (00000000d89ee6c7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92/ieee80211/phy92/rfkill95'
ieee80211 phy92: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (0000000039fba66e): kobject_add_internal: parent: 'hwsim92',  
set: '(null)'
kobject: 'wlan14' (00000000dfbfb5c2): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan14' (00000000dfbfb5c2): kobject_uevent_env
kobject: 'wlan14' (00000000dfbfb5c2): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92/net/wlan14'
kobject: 'queues' (00000000f14c857a): kobject_add_internal:  
parent: 'wlan14', set: '<NULL>'
kobject: 'queues' (00000000f14c857a): kobject_uevent_env
kobject: 'queues' (00000000f14c857a): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000007c5dc2e9): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000007c5dc2e9): kobject_uevent_env
kobject: 'rx-0' (000000007c5dc2e9): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92/net/wlan14/queues/rx-0'
kobject: 'tx-0' (000000008b83fa7f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000008b83fa7f): kobject_uevent_env
kobject: 'tx-0' (000000008b83fa7f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92/net/wlan14/queues/tx-0'
kobject: 'tx-1' (00000000459e57ae): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000459e57ae): kobject_uevent_env
kobject: 'tx-1' (00000000459e57ae): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92/net/wlan14/queues/tx-1'
kobject: 'tx-2' (00000000f19def83): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000f19def83): kobject_uevent_env
kobject: 'tx-2' (00000000f19def83): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92/net/wlan14/queues/tx-2'
kobject: 'tx-3' (00000000a80bc710): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000a80bc710): kobject_uevent_env
kobject: 'tx-3' (00000000a80bc710): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim92/net/wlan14/queues/tx-3'
kobject: 'hwsim93' (000000003bd6e3bf): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim93' (000000003bd6e3bf): kobject_uevent_env
kobject: 'hwsim93' (000000003bd6e3bf): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93'
kobject: 'hwsim93' (000000003bd6e3bf): kobject_uevent_env
kobject: 'hwsim93' (000000003bd6e3bf): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93'
kobject: 'ieee80211' (00000000b175abe2): kobject_add_internal:  
parent: 'hwsim93', set: '(null)'
kobject: 'phy93' (0000000082c908e3): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy93' (0000000082c908e3): kobject_uevent_env
kobject: 'phy93' (0000000082c908e3): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93/ieee80211/phy93'
kobject: 'rfkill96' (00000000e4a0ed65): kobject_add_internal:  
parent: 'phy93', set: 'devices'
kobject: 'rfkill96' (00000000e4a0ed65): kobject_uevent_env
kobject: 'rfkill96' (00000000e4a0ed65): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93/ieee80211/phy93/rfkill96'
ieee80211 phy93: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000055121ad): kobject_add_internal: parent: 'hwsim93',  
set: '(null)'
kobject: 'wlan16' (000000008480f961): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan16' (000000008480f961): kobject_uevent_env
kobject: 'wlan16' (000000008480f961): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93/net/wlan16'
kobject: 'queues' (00000000ba252046): kobject_add_internal:  
parent: 'wlan16', set: '<NULL>'
kobject: 'queues' (00000000ba252046): kobject_uevent_env
kobject: 'queues' (00000000ba252046): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000008d4cb5ab): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000008d4cb5ab): kobject_uevent_env
kobject: 'rx-0' (000000008d4cb5ab): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93/net/wlan16/queues/rx-0'
kobject: 'tx-0' (000000009ac86e34): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000009ac86e34): kobject_uevent_env
kobject: 'tx-0' (000000009ac86e34): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93/net/wlan16/queues/tx-0'
kobject: 'tx-1' (0000000071122038): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (0000000071122038): kobject_uevent_env
kobject: 'tx-1' (0000000071122038): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93/net/wlan16/queues/tx-1'
kobject: 'tx-2' (0000000033f1741e): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (0000000033f1741e): kobject_uevent_env
kobject: 'tx-2' (0000000033f1741e): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93/net/wlan16/queues/tx-2'
kobject: 'tx-3' (00000000f492392c): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (00000000f492392c): kobject_uevent_env
kobject: 'tx-3' (00000000f492392c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim93/net/wlan16/queues/tx-3'
kobject: 'hwsim94' (00000000e0e4b420): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim94' (00000000e0e4b420): kobject_uevent_env
kobject: 'hwsim94' (00000000e0e4b420): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94'
kobject: 'hwsim94' (00000000e0e4b420): kobject_uevent_env
kobject: 'hwsim94' (00000000e0e4b420): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94'
kobject: 'ieee80211' (00000000bc9d5dca): kobject_add_internal:  
parent: 'hwsim94', set: '(null)'
kobject: 'phy94' (00000000a8ce111c): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy94' (00000000a8ce111c): kobject_uevent_env
kobject: 'phy94' (00000000a8ce111c): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94/ieee80211/phy94'
kobject: 'rfkill97' (00000000ad96308b): kobject_add_internal:  
parent: 'phy94', set: 'devices'
kobject: 'rfkill97' (00000000ad96308b): kobject_uevent_env
kobject: 'rfkill97' (00000000ad96308b): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94/ieee80211/phy94/rfkill97'
ieee80211 phy94: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (0000000010586ede): kobject_add_internal: parent: 'hwsim94',  
set: '(null)'
kobject: 'wlan5' (00000000b5b39e90): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan5' (00000000b5b39e90): kobject_uevent_env
kobject: 'wlan5' (00000000b5b39e90): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94/net/wlan5'
kobject: 'queues' (00000000024ee17e): kobject_add_internal:  
parent: 'wlan5', set: '<NULL>'
kobject: 'queues' (00000000024ee17e): kobject_uevent_env
kobject: 'queues' (00000000024ee17e): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000cb9d4cbc): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000cb9d4cbc): kobject_uevent_env
kobject: 'rx-0' (00000000cb9d4cbc): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94/net/wlan5/queues/rx-0'
kobject: 'tx-0' (00000000ef7295ee): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (00000000ef7295ee): kobject_uevent_env
kobject: 'tx-0' (00000000ef7295ee): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94/net/wlan5/queues/tx-0'
kobject: 'tx-1' (00000000397f2ba6): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000397f2ba6): kobject_uevent_env
kobject: 'tx-1' (00000000397f2ba6): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94/net/wlan5/queues/tx-1'
kobject: 'tx-2' (000000004b87c704): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (000000004b87c704): kobject_uevent_env
kobject: 'tx-2' (000000004b87c704): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94/net/wlan5/queues/tx-2'
kobject: 'tx-3' (0000000009d3b43a): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (0000000009d3b43a): kobject_uevent_env
kobject: 'tx-3' (0000000009d3b43a): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim94/net/wlan5/queues/tx-3'
kobject: 'hwsim95' (00000000204f62ce): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim95' (00000000204f62ce): kobject_uevent_env
kobject: 'hwsim95' (00000000204f62ce): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95'
kobject: 'hwsim95' (00000000204f62ce): kobject_uevent_env
kobject: 'hwsim95' (00000000204f62ce): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95'
kobject: 'ieee80211' (000000003d62f0a3): kobject_add_internal:  
parent: 'hwsim95', set: '(null)'
kobject: 'phy95' (000000007ae639b2): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy95' (000000007ae639b2): kobject_uevent_env
kobject: 'phy95' (000000007ae639b2): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95/ieee80211/phy95'
kobject: 'rfkill98' (0000000007396b53): kobject_add_internal:  
parent: 'phy95', set: 'devices'
kobject: 'rfkill98' (0000000007396b53): kobject_uevent_env
kobject: 'rfkill98' (0000000007396b53): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95/ieee80211/phy95/rfkill98'
ieee80211 phy95: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000359626e4): kobject_add_internal: parent: 'hwsim95',  
set: '(null)'
kobject: 'wlan19' (000000003d92ba52): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan19' (000000003d92ba52): kobject_uevent_env
kobject: 'wlan19' (000000003d92ba52): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95/net/wlan19'
kobject: 'queues' (000000000bbf135a): kobject_add_internal:  
parent: 'wlan19', set: '<NULL>'
kobject: 'queues' (000000000bbf135a): kobject_uevent_env
kobject: 'queues' (000000000bbf135a): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (000000007176b48b): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (000000007176b48b): kobject_uevent_env
kobject: 'rx-0' (000000007176b48b): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95/net/wlan19/queues/rx-0'
kobject: 'tx-0' (000000009266b49f): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (000000009266b49f): kobject_uevent_env
kobject: 'tx-0' (000000009266b49f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95/net/wlan19/queues/tx-0'
kobject: 'tx-1' (0000000088406718): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (0000000088406718): kobject_uevent_env
kobject: 'tx-1' (0000000088406718): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95/net/wlan19/queues/tx-1'
kobject: 'tx-2' (00000000b24911ce): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-2' (00000000b24911ce): kobject_uevent_env
kobject: 'tx-2' (00000000b24911ce): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95/net/wlan19/queues/tx-2'
kobject: 'tx-3' (000000006f6296ef): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-3' (000000006f6296ef): kobject_uevent_env
kobject: 'tx-3' (000000006f6296ef): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim95/net/wlan19/queues/tx-3'
kobject: 'hwsim96' (0000000057df9ca7): kobject_add_internal:  
parent: 'mac80211_hwsim', set: 'devices'
kobject: 'hwsim96' (0000000057df9ca7): kobject_uevent_env
kobject: 'hwsim96' (0000000057df9ca7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim96'
kobject: 'hwsim96' (0000000057df9ca7): kobject_uevent_env
kobject: 'hwsim96' (0000000057df9ca7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim96'
kobject: 'ieee80211' (00000000ef33bf4a): kobject_add_internal:  
parent: 'hwsim96', set: '(null)'
kobject: 'phy96' (00000000001afe4a): kobject_add_internal:  
parent: 'ieee80211', set: 'devices'
kobject: 'phy96' (00000000001afe4a): kobject_uevent_env
kobject: 'phy96' (00000000001afe4a): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim96/ieee80211/phy96'
kobject: 'rfkill99' (0000000025b801a7): kobject_add_internal:  
parent: 'phy96', set: 'devices'
kobject: 'rfkill99' (0000000025b801a7): kobject_uevent_env
kobject: 'rfkill99' (0000000025b801a7): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim96/ieee80211/phy96/rfkill99'
ieee80211 phy96: Selected rate control algorithm 'minstrel_ht'
kobject: 'net' (00000000a53e19e8): kobject_add_internal: parent: 'hwsim96',  
set: '(null)'
kobject: 'wlan15' (000000007ec1f036): kobject_add_internal: parent: 'net',  
set: 'devices'
kobject: 'wlan15' (000000007ec1f036): kobject_uevent_env
kobject: 'wlan15' (000000007ec1f036): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim96/net/wlan15'
kobject: 'queues' (00000000fee80fbf): kobject_add_internal:  
parent: 'wlan15', set: '<NULL>'
kobject: 'queues' (00000000fee80fbf): kobject_uevent_env
kobject: 'queues' (00000000fee80fbf): kobject_uevent_env: filter function  
caused the event to drop!
kobject: 'rx-0' (00000000adc72d32): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'rx-0' (00000000adc72d32): kobject_uevent_env
kobject: 'rx-0' (00000000adc72d32): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim96/net/wlan15/queues/rx-0'
kobject: 'tx-0' (0000000052436407): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-0' (0000000052436407): kobject_uevent_env
kobject: 'tx-0' (0000000052436407): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim96/net/wlan15/queues/tx-0'
kobject: 'tx-1' (00000000fe1a1c40): kobject_add_internal: parent: 'queues',  
set: 'queues'
kobject: 'tx-1' (00000000fe1a1c40): kobject_uevent_env
kobject: 'tx-1' (00000000fe1a1c40): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim96/net/wlan15/queues/tx-1'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
