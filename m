Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B8C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CC22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CC22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeGSMvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:51:54 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:34006 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeGSMvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:51:53 -0400
Received: by mail-io0-f197.google.com with SMTP id f9-v6so5697011ioh.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 05:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KAHSHIi6ftWCMp6Q/gXGW4Vi3ATYtKuhra/Yctil4+c=;
        b=e/VH5gEmTjPoMLDhY0F15tr1BILg/Gk7hLjlR6WNl+w7JliGtjp1gTaIQoDFHMStcV
         pd/MPJNXVdNXQW8xLbgACrcFx/ZRJuCIW8v6z4xaOXoQdlfFIK1eg+ShbdNCea+vov5n
         I9sAGGPxQxUtmp6spHo/+Wg5KA63ARn1+XlRMoJjoH1H/bZZfFz4AO0yQj/xo5XyLYTn
         GkzhyIAhcRxWoKa1XTaOapBcu+OYfmxBH9T+Yj60oyBhOT+tpmDCIZx3bSapdACimPBU
         48oYGIrN1L65Is2UzLTL5aJWnZL78nfrk18JcQ93y1CJBTjFCMv+oKo9XjLv8lWti04F
         q/8w==
X-Gm-Message-State: AOUpUlG05lZ3wHXddZEGei3YuQP+FBixzqWZ17kR8VbO7Pp9M7Wc0+rj
        bXGu7Jhj6SOuZJdsAjGQRlsBOiscnyeQ9OGdjtcc8qjeNo0M
X-Google-Smtp-Source: AAOMgpewAErVUDzDBJj2G6BCN0AHSYynVOoLiBsoKpnrpU4WhGHIa/sH5xW/04gwXUfQclmlY/nUesTiu3A1dECrj+Q4m8wsj5Bn
MIME-Version: 1.0
X-Received: by 2002:a24:160f:: with SMTP id a15-v6mr2770834ita.7.1532002142021;
 Thu, 19 Jul 2018 05:09:02 -0700 (PDT)
Date:   Thu, 19 Jul 2018 05:09:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007870ef0571590bb2@google.com>
Subject: general protection fault in p9_client_prepare_req
From:   syzbot <syzbot+77a28a63a0ece0fbba97@syzkaller.appspotmail.com>
To:     davem@davemloft.net, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1c34981993da Add linux-next specific files for 20180719
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=160ec658400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7002497517b09aec
dashboard link: https://syzkaller.appspot.com/bug?extid=77a28a63a0ece0fbba97
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=17317a58400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1135e1c2400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+77a28a63a0ece0fbba97@syzkaller.appspotmail.com

RBP: 0000000000000000 R08: 0000000020000840 R09: 0000000000003831
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc432a9cd0
R13: 0030656c69662f2e R14: 64663d736e617274 R15: 0000000000000006
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 4386 Comm: syz-executor227 Not tainted  
4.18.0-rc5-next-20180719+ #11
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:p9_client_prepare_req.part.8+0x392/0xa00 net/9p/client.c:645
Code: ff 0f 87 6a 02 00 00 e8 bc 39 0c fa 0f be 85 f4 fe ff ff 4c 89 f2 48  
c1 ea 03 89 85 f4 fe ff ff 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 0f  
85 89 05 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
RSP: 0018:ffff8801bd8c7250 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000600040
RDX: 000000000000000a RSI: ffffffff87706d04 RDI: ffff8801b9efa378
RBP: ffff8801bd8c7380 R08: ffff8801b9f24080 R09: ffffed0037b18de4
R10: ffffed0037b18de4 R11: 0000000000000003 R12: ffff8801b9efa340
R13: 0000000000002000 R14: 0000000000000050 R15: ffff8801b9efa37c
FS:  0000000001ba1880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 00000001b994e000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  p9_client_prepare_req net/9p/client.c:675 [inline]
  p9_client_rpc+0x242/0x1330 net/9p/client.c:675
  p9_client_version net/9p/client.c:890 [inline]
  p9_client_create+0xca4/0x1537 net/9p/client.c:974
  v9fs_session_init+0x21a/0x1a80 fs/9p/v9fs.c:400
  v9fs_mount+0x7c/0x900 fs/9p/vfs_super.c:135
  legacy_get_tree+0x131/0x460 fs/fs_context.c:674
  vfs_get_tree+0x1cb/0x5c0 fs/super.c:1743
  do_new_mount fs/namespace.c:2603 [inline]
  do_mount+0x6f2/0x1e20 fs/namespace.c:2927
  ksys_mount+0x12d/0x140 fs/namespace.c:3143
  __do_sys_mount fs/namespace.c:3157 [inline]
  __se_sys_mount fs/namespace.c:3154 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3154
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440719
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc432a9cc8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 0000000000440719
RDX: 0000000020000900 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000020000840 R09: 0000000000003831
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc432a9cd0
R13: 0030656c69662f2e R14: 64663d736e617274 R15: 0000000000000006
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace bae3d5802518770f ]---
RIP: 0010:p9_client_prepare_req.part.8+0x392/0xa00 net/9p/client.c:645
Code: ff 0f 87 6a 02 00 00 e8 bc 39 0c fa 0f be 85 f4 fe ff ff 4c 89 f2 48  
c1 ea 03 89 85 f4 fe ff ff 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 0f  
85 89 05 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b
RSP: 0018:ffff8801bd8c7250 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000600040
RDX: 000000000000000a RSI: ffffffff87706d04 RDI: ffff8801b9efa378
RBP: ffff8801bd8c7380 R08: ffff8801b9f24080 R09: ffffed0037b18de4
R10: ffffed0037b18de4 R11: 0000000000000003 R12: ffff8801b9efa340
R13: 0000000000002000 R14: 0000000000000050 R15: ffff8801b9efa37c
FS:  0000000001ba1880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 00000001b994e000 CR4: 00000000001406e0
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
