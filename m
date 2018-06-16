Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CD0C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D5220874
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D5220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeFPGrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 02:47:04 -0400
Received: from mail-io0-f198.google.com ([209.85.223.198]:39168 "EHLO
        mail-io0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753907AbeFPGrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 02:47:03 -0400
Received: by mail-io0-f198.google.com with SMTP id x14-v6so8951964ioa.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 23:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=orIz5q4a7NYnzTsTtWAizkLMItUSy9B3mkZjaSro8k0=;
        b=V75rSmcsBvHssgM2ht2k/zAsd3H18p/zNPdLDWLxYR+Z//JoWZYIthUpIcOogFlMXS
         mLC5TICoOUmwBEGG/Ppilw6x/BXtBEfAMd5FGHFLNQYzBJvgbYzzd6kXvJOtzFhyLKfO
         kCe7NLLlzO0Tlfi8c0mQPngl4zNtuRP7qJ+G3HkpeoFzixu7g1rVqKFwI1UlLjU06+P3
         XAS7bO/eNv514SMbNeUMiIU9pzHw3kxP4HkIHirDqS989IMxSIorA/sPfMWkJArOcv5v
         dQrkNHAC+8akQ9T2qq7/Ghf49iDdSormGw/rqc7NLFz1MV6tKCUZ3/tb4qHVVR9TkcjY
         Ef1g==
X-Gm-Message-State: APt69E39C/uXcBn4vEXA6WRMKvWs2YmlqF/QZyefPMFclsNIbhkYeIuD
        jWm2dwyLJZavsTIvbWnDhpslcTa43mcn25Az1NSu2HGN1+Rj
X-Google-Smtp-Source: ADUXVKIwY756tdnwA2kUnzKwtQ8XtvhFvb5EFlvqRUxC7Dw1tXtA3BCri2zjcANDK1jq1TniKjTZG6SAS5giZQuXBhCTbL7FB65x
MIME-Version: 1.0
X-Received: by 2002:a24:d944:: with SMTP id p65-v6mr1681994itg.24.1529131622418;
 Fri, 15 Jun 2018 23:47:02 -0700 (PDT)
Date:   Fri, 15 Jun 2018 23:47:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b532a056ebcb3eb@google.com>
Subject: WARNING: suspicious RCU usage in pid_task
From:   syzbot <syzbot+c2d4c3ae3fd90bbaf059@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, gs051095@gmail.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        pasha.tatashin@oracle.com, riel@redhat.com,
        rppt@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=124b698f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9c20c48788d1c1
dashboard link: https://syzkaller.appspot.com/bug?extid=c2d4c3ae3fd90bbaf059
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c2d4c3ae3fd90bbaf059@syzkaller.appspotmail.com

bpfilter: read fail -512

=============================
WARNING: suspicious RCU usage
4.17.0+ #84 Not tainted
-----------------------------
kernel/pid.c:323 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor7/29997:
device lo entered promiscuous mode
  #0: 000000001e4dec85 (bpfilter_lock){+.+.}, at:  
__bpfilter_process_sockopt+0x1bd/0x384 net/bpfilter/bpfilter_kern.c:67

stack backtrace:
CPU: 1 PID: 29997 Comm: syz-executor7 Not tainted 4.17.0+ #84
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
IPVS: ftp: loaded support on port[0] = 21
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x14a/0x153 kernel/locking/lockdep.c:4562
  pid_task+0x1b9/0x1e0 kernel/pid.c:322
  shutdown_umh.constprop.0+0x33/0x7c net/bpfilter/bpfilter_kern.c:29
  __stop_umh net/bpfilter/bpfilter_kern.c:41 [inline]
  __bpfilter_process_sockopt.cold.1+0x9b/0xa0 net/bpfilter/bpfilter_kern.c:81
  bpfilter_mbox_request+0x4d/0xb0 net/ipv4/bpfilter/sockopt.c:25
  bpfilter_ip_get_sockopt+0x6b/0x90 net/ipv4/bpfilter/sockopt.c:42
  ip_getsockopt+0x238/0x2a0 net/ipv4/ip_sockglue.c:1563
  tcp_getsockopt+0x93/0xe0 net/ipv4/tcp.c:3534
  sock_common_getsockopt+0x9a/0xe0 net/core/sock.c:3012
  smc_getsockopt+0xc7/0x120 net/smc/af_smc.c:1473
  __sys_getsockopt+0x1a5/0x370 net/socket.c:1984
  __do_sys_getsockopt net/socket.c:1995 [inline]
  __se_sys_getsockopt net/socket.c:1992 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:1992
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455b29
Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0391bdbc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007f0391bdc6d4 RCX: 0000000000455b29
RDX: 0000000000000043 RSI: 0000000000000000 RDI: 0000000000000016
RBP: 000000000072bea0 R08: 0000000020000040 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000004c3808 R14: 00000000004c8f78 R15: 0000000000000000
netlink: 220 bytes leftover after parsing attributes in process  
`syz-executor2'.


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
