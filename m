Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB6DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8474920882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8474920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeILSNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:13:30 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46715 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:13:30 -0400
Received: by mail-io1-f71.google.com with SMTP id f4-v6so117679ioh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gq7XUPTtTTVntpHRzK/cjoxEU4nVosXxAERTmhVHZD0=;
        b=rZMv0COItYlVQnW15tL8GqVZBdCwLnqtk8jKiVz2iLqSdm5SU06OFAncINeYnA6wsK
         uE2vHAAA80WpXh0XAAY1of69nes7yWnqk+u+pu7fCtQrx4mrxej0hFnmYyTLB9x/5UHZ
         Wl2mO+qCLmPLYfeG3qKCGVfrizFP1oK8//s9x4viFH7Ljgcb1EG+8xSkAie5bvG81kZD
         ouPEl9on1RCq41Qama5J8WZ4N1YdLUI4LsUKXJEqB0S4UitD3bdcIDd5v65d2ZKPFYtZ
         nOHD9qzb//Vjw1WypZRqOAD0L351LqXzCyrtsH6UZ/RWKWQSXaDWk7z4fqp0v1BHxl3/
         XkVQ==
X-Gm-Message-State: APzg51BmtbfLIF+a4MkaKWXN7oOPk7yd9HeYFEp9ra5dwWPSek7zz4Dn
        pY1iu2SvdfIoZq/406oK9DK5Lf17tFuwySZ8bETL0C9yoi+X
X-Google-Smtp-Source: ANB0VdZVaCf5fkKwr0AkN5demB/Zo6BinK2dm1uZG/cVJJ3swsIoSFTkFRxo2KnXU9jHB6dNg0uzdh233MGryHjnSfOLIeqhI3Qf
MIME-Version: 1.0
X-Received: by 2002:a5e:c30b:: with SMTP id a11-v6mr1426183iok.38.1536757742836;
 Wed, 12 Sep 2018 06:09:02 -0700 (PDT)
Date:   Wed, 12 Sep 2018 06:09:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e25bd0575ac4bb1@google.com>
Subject: general protection fault in mqueue_get_tree
From:   syzbot <syzbot+885a82aa44fba12672b3@syzkaller.appspotmail.com>
To:     arnd@arndb.de, dhowells@redhat.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1667ea56400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5980033172920ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=885a82aa44fba12672b3
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12129aae400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11473121400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+885a82aa44fba12672b3@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5559 Comm: syz-executor976 Not tainted  
4.19.0-rc3-next-20180912+ #72
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:mqueue_get_tree+0xba/0x2e0 ipc/mqueue.c:362
Code: 4c 8d b3 98 00 00 00 4d 85 ed 0f 84 d1 00 00 00 e8 6b 44 3f fe 49 8d  
7d 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 e3 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff8801bbaf7928 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8801cc909b40 RCX: ffffffff8160aca1
RDX: 0000000000018006 RSI: ffffffff833deb15 RDI: 00000000000c0032
RBP: ffff8801bbaf7948 R08: fffffbfff13555fd R09: fffffbfff13555fc
R10: fffffbfff13555fc R11: ffffffff89aaafe3 R12: ffff8801d7ac00c0
R13: 00000000000c002a R14: ffff8801cc909bd8 R15: ffff8801cc909bd8
FS:  0000000001816880(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004776a0 CR3: 00000001d8e4b000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
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
RIP: 0033:0x44e717
Code: 00 00 00 b8 63 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 bd 9a fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9d 9a fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdc5a0a4e8 EFLAGS: 00000217 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007ffdc5a0a660 RCX: 000000000044e717
RDX: 0000000000000000 RSI: 00007ffdc5a0a500 RDI: 0000000008000000
RBP: 585858582e72656c R08: 0000000000000000 R09: 0000000000000018
R10: 0000000000000000 R11: 0000000000000217 R12: 6c616b7a79732f2e
R13: 00000000004086d0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 45e54bf7dc140f15 ]---
RIP: 0010:mqueue_get_tree+0xba/0x2e0 ipc/mqueue.c:362
Code: 4c 8d b3 98 00 00 00 4d 85 ed 0f 84 d1 00 00 00 e8 6b 44 3f fe 49 8d  
7d 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 e3 01 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff8801bbaf7928 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8801cc909b40 RCX: ffffffff8160aca1
RDX: 0000000000018006 RSI: ffffffff833deb15 RDI: 00000000000c0032
RBP: ffff8801bbaf7948 R08: fffffbfff13555fd R09: fffffbfff13555fc
R10: fffffbfff13555fc R11: ffffffff89aaafe3 R12: ffff8801d7ac00c0
R13: 00000000000c002a R14: ffff8801cc909bd8 R15: ffff8801cc909bd8
FS:  0000000001816880(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004776a0 CR3: 00000001d8e4b000 CR4: 00000000001406e0
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
