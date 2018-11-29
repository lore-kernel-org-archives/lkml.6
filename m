Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC63C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB1C205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB1C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeK2WvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:51:10 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:41121 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeK2WvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:51:10 -0500
Received: by mail-io1-f69.google.com with SMTP id k3-v6so1644009ioq.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 03:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Kn+v27EbtToLhmCnZvRf2p/eSbRenzfhHNKDyIEin3Y=;
        b=j3+KhmmpcNW1ePt3ioPa1WOJs2Y0ammIzv5mg0p7Ihpg688zDHe/YpVs2uptttjHxz
         N/DCVk3hdvA0IAg/uIOwlQJCuVQnEx8iFUVq7jWSSpiezJ8XHYAZ/rYv/I6LAlcE7qyx
         ikErxUmcQJAs2IumBDsVLF4Nxl1M4NzFcdiaduvK6v3kN6QW6uczptsq62xJ5R5eFh7V
         eItyRaZJt5AdLZEif+1TrUj7ouiKbIYCS3DXfqzbjDGUgwTuud+VqokIDyp8WQcXWEAo
         GoM3trJT/As3rw9TObZyZalai8QLUHdS128lredSeaeKqSEILBBzpuDcehsq2WGOpDGF
         n0Nw==
X-Gm-Message-State: AA+aEWanjT9eLx1lsgmMnCoufMnVY7BE3Cl71rE9j13589mAq7FkLqxq
        ZyGQl2/smtlTQMES0Pi6TucLCDsATu0jz+JMSMzFc9TA0NLk
X-Google-Smtp-Source: AFSGD/WY15ojeit0OEOpTHKhQ/N58Hk5NSWA36kNLHU0oaL8+EFKpmRvtE6iGsSDk9vgy44sn86BB3vEw5SpVVBvQfFT12quvY3U
MIME-Version: 1.0
X-Received: by 2002:a24:8342:: with SMTP id d63mr1002021ite.26.1543491964385;
 Thu, 29 Nov 2018 03:46:04 -0800 (PST)
Date:   Thu, 29 Nov 2018 03:46:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000404067057bcc3a71@google.com>
Subject: general protection fault in bpf_prog_kallsyms_add
From:   syzbot <syzbot+876c69d3b667c06f1971@syzkaller.appspotmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    295daee4ba10 selftests/bpf: add config fragment CONFIG_FTR..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=177cc5f5400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c36a72af2123e78a
dashboard link: https://syzkaller.appspot.com/bug?extid=876c69d3b667c06f1971
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+876c69d3b667c06f1971@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 30162 Comm: syz-executor4 Not tainted 4.20.0-rc3+ #158
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:182 [inline]
RIP: 0010:list_empty include/linux/list.h:226 [inline]
RIP: 0010:bpf_prog_ksym_node_add kernel/bpf/core.c:473 [inline]
RIP: 0010:bpf_prog_kallsyms_add+0x18f/0x9b0 kernel/bpf/core.c:505
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 d3 07 00 00 48 b8 00 00 00 00 00  
fc ff df 4d 8b 74 24 20 49 8d 5e 68 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f  
85 b9 07 00 00 4c 8d a5 58 ff ff ff 4d 8b 6e 68 48
RSP: 0018:ffff8881b305f998 EFLAGS: 00010a03
RAX: dffffc0000000000 RBX: 800000019811706f RCX: 0000000000000001
RDX: 1000000033022e0d RSI: 0000000000000004 RDI: ffffc9000197d020
RBP: ffff8881b305fb08 R08: ffffed103660bf21 R09: ffffed103660bf20
R10: ffffed103660bf20 R11: 0000000000000003 R12: ffffc9000197d000
R13: ffff8881b305fcf8 R14: 8000000198117007 R15: 1ffff1103660bf38
FS:  00007fd823c2d700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000a40021 CR3: 00000001d7f0d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  bpf_prog_load+0x13c8/0x1c30 kernel/bpf/syscall.c:1554
  __do_sys_bpf kernel/bpf/syscall.c:2538 [inline]
  __se_sys_bpf kernel/bpf/syscall.c:2500 [inline]
  __x64_sys_bpf+0x36f/0x520 kernel/bpf/syscall.c:2500
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd823c2cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000048 RSI: 0000000020000200 RDI: 0000000000000005
RBP: 000000000072bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd823c2d6d4
R13: 00000000004bda3c R14: 00000000004ccd10 R15: 00000000ffffffff
Modules linked in:
---[ end trace 101945b7574ca4df ]---
kobject: 'loop0' (00000000a634eda0): kobject_uevent_env
RIP: 0010:__read_once_size include/linux/compiler.h:182 [inline]
RIP: 0010:list_empty include/linux/list.h:226 [inline]
RIP: 0010:bpf_prog_ksym_node_add kernel/bpf/core.c:473 [inline]
RIP: 0010:bpf_prog_kallsyms_add+0x18f/0x9b0 kernel/bpf/core.c:505
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 d3 07 00 00 48 b8 00 00 00 00 00  
fc ff df 4d 8b 74 24 20 49 8d 5e 68 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f  
85 b9 07 00 00 4c 8d a5 58 ff ff ff 4d 8b 6e 68 48
RSP: 0018:ffff8881b305f998 EFLAGS: 00010a03
RAX: dffffc0000000000 RBX: 800000019811706f RCX: 0000000000000001
RDX: 1000000033022e0d RSI: 0000000000000004 RDI: ffffc9000197d020
RBP: ffff8881b305fb08 R08: ffffed103660bf21 R09: ffffed103660bf20
R10: ffffed103660bf20 R11: 0000000000000003 R12: ffffc9000197d000
R13: ffff8881b305fcf8 R14: 8000000198117007 R15: 1ffff1103660bf38
FS:  00007fd823c2d700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000a40021 CR3: 00000001d7f0d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
kobject: 'loop0' (00000000a634eda0): fill_kobj_path: path  
= '/devices/virtual/block/loop0'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
