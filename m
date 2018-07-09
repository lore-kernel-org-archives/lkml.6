Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55720C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA53208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA53208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeGIGQG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:16:06 -0400
Received: from mail-io0-f197.google.com ([209.85.223.197]:45940 "EHLO
        mail-io0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeGIGQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:16:03 -0400
Received: by mail-io0-f197.google.com with SMTP id i18-v6so15442647iog.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 23:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=H6rlXjG4+Wql6tcnbDpNN4EB1h6Rjfsmxnn1wRjSPyw=;
        b=OFB0c0MDhiiZ4oO3pt8O46vsit/cwiviNq0X1LqwCmOPlKtPO3lizGJfpn9/by722I
         pPHel5yYMzDp+GghgmeCHgreYgjzGETe20+rLmzlAUsmWiDmpQx8KmV7aJLUmC/y0RCy
         cuwmNzQkrPZIVAMQQpmH150kV1wJe3lPaMiBqAa78s+LB0zDOhLHRoabcIMsGOQFlj8c
         wdkBBo4HhJCcM8qqsIYawbKciynQW31vqJLt7JsimXkKMHR714vjnUE2L6s+y2MxtnVH
         IkjJyU3owPj5b8480N4sQ2x0CbJQQbek23GQodUL8FntC3u5L5BSQE7uru5MQYK866hj
         6ujw==
X-Gm-Message-State: APt69E3o44ZxW/5XPEBiVnSCRtJfrU2I1araqaWBLGxXqpRjLh1E4CEH
        rHNVE1K/18dggB9deXgK1xy1bYO0Q/erxp1Fp+JtV2yJcFET
X-Google-Smtp-Source: AAOMgpc47GEI2qURsYZCDXqT9KCFJX7SkN8r9F72jYRagood4/ZqUV91z9KJAxNSkdDDnW2pOPyhPOk3Dm0aIEaR6tuQZltjvHaK
MIME-Version: 1.0
X-Received: by 2002:a02:9a11:: with SMTP id b17-v6mr8865486jal.38.1531116962946;
 Sun, 08 Jul 2018 23:16:02 -0700 (PDT)
Date:   Sun, 08 Jul 2018 23:16:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afa87d05708af289@google.com>
Subject: kernel BUG at mm/slab.c:LINE! (2)
From:   syzbot <syzbot+885bda95271928dc24eb@syzkaller.appspotmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d90c936fb318 Merge branch 'bpf-nfp-mul-div-support'
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15cf4f48400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a501a01deaf0fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=885bda95271928dc24eb
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=15c87748400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1459050c400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+885bda95271928dc24eb@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
------------[ cut here ]------------
kernel BUG at mm/slab.c:4421!
invalid opcode: 0000 [#1] SMP KASAN
CPU: 0 PID: 4467 Comm: syz-executor607 Not tainted 4.18.0-rc3+ #48
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4446
Code: 48 c7 c7 90 73 c0 88 e8 87 7a 08 00 5d c3 41 8b 91 04 01 00 00 48 29  
c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7  
90 73 c0 88 e8 6d 81 08 00 44 89 e1 4c 8d 45 c4 48
RSP: 0018:ffff8801ab117a10 EFLAGS: 00010246
RAX: 0000000000000006 RBX: 1ffff10035622f49 RCX: 0000000000000009
RDX: ffff8801c27ff000 RSI: 00000000000003d2 RDI: ffff8801c27ffff2
RBP: ffff8801ab117a10 R08: ffff8801ab37a680 R09: ffff8801da800940
R10: 0000000000000991 R11: 0000000000000001 R12: ffff8801c27ffff2
R13: 00000000000003d2 R14: 0000000000000001 R15: ffffea000709ffc0
FS:  0000000000763880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 00000001b0a8b000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  check_heap_object mm/usercopy.c:236 [inline]
  __check_object_size+0x4db/0x5f2 mm/usercopy.c:259
  check_object_size include/linux/thread_info.h:119 [inline]
  check_copy_size include/linux/thread_info.h:150 [inline]
  copy_to_user include/linux/uaccess.h:154 [inline]
  bpf_test_finish.isra.7+0xd9/0x1f0 net/bpf/test_run.c:59
  bpf_prog_test_run_skb+0x7d7/0xa30 net/bpf/test_run.c:144
  bpf_prog_test_run+0x130/0x1a0 kernel/bpf/syscall.c:1686
  __do_sys_bpf kernel/bpf/syscall.c:2323 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2267 [inline]
  __x64_sys_bpf+0x3d8/0x510 kernel/bpf/syscall.c:2267
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4402d9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff168c6558 EFLAGS: 00000213 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402d9
RDX: 0000000000000028 RSI: 0000000020000080 RDI: 000000000000000a
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000401b60
R13: 0000000000401bf0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 045402f983996608 ]---
RIP: 0010:__check_heap_object+0xa7/0xb5 mm/slab.c:4446
Code: 48 c7 c7 90 73 c0 88 e8 87 7a 08 00 5d c3 41 8b 91 04 01 00 00 48 29  
c7 48 39 d7 77 be 48 01 d0 48 29 c8 48 39 f0 72 b3 5d c3 <0f> 0b 48 c7 c7  
90 73 c0 88 e8 6d 81 08 00 44 89 e1 4c 8d 45 c4 48
RSP: 0018:ffff8801ab117a10 EFLAGS: 00010246
RAX: 0000000000000006 RBX: 1ffff10035622f49 RCX: 0000000000000009
RDX: ffff8801c27ff000 RSI: 00000000000003d2 RDI: ffff8801c27ffff2
RBP: ffff8801ab117a10 R08: ffff8801ab37a680 R09: ffff8801da800940
R10: 0000000000000991 R11: 0000000000000001 R12: ffff8801c27ffff2
R13: 00000000000003d2 R14: 0000000000000001 R15: ffffea000709ffc0
FS:  0000000000763880(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 00000001b0a8b000 CR4: 00000000001406f0
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
