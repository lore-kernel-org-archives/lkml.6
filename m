Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35961C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E160C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E160C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeIZODo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:03:44 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:52155 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeIZODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:03:43 -0400
Received: by mail-it1-f199.google.com with SMTP id 204-v6so2124969itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9PZ4iHBII9y3RpziERaTrf7+LklL3zsLNpD1Lq4nBWg=;
        b=TPRFvhK+HhRBCbfn8XY2dLNeDOw54IeNoMu6XzRkwpC3RQJwqTxGwlHJpZWvH/xrZA
         9b+1uAssKdQFzF3CyXD+ltOEbCZrY028c+26dPjTWCL+sToV2x4d2ANAYpitiUn7nzAa
         nY8qvHwpCpWhK5stkFCNtJnXtHFNCPSwwE1lDz58OB0TI44XZfC5kQv2eOJ+wi3DHpLG
         1DYfKAWMKiMNh3ncrzjKkBRPOJR6ZfVBWfziQbiL2y4XH9GBmcoEpSpsWjswmr36tcpN
         YeZyLfkyKQxNZTWqnQZfPxazD7B6L6OkKGRT0G3Hmc1CTs5mjciPEjtHL2S+voMGfNRQ
         VegA==
X-Gm-Message-State: ABuFfogy4/gTaHQY9hSWrLz7nDZLJX7XOR96nZ2S2bVllgJtc3rXzfPy
        mUjzukNzlz+LWS/25WAHKiqQui9hI2wKcuHXibFugjWtI1Sd
X-Google-Smtp-Source: ACcGV60K8dBh47Ki+ByeP3Z73JdwdCZ1pzjYVBC4NHu33pqBr6tJkzAXa0HqgLXNzv/0XycjSb0/7dGM0RFvVMuYqjjOjHjMypL1
MIME-Version: 1.0
X-Received: by 2002:a24:748:: with SMTP id f69-v6mr3244928itf.23.1537948324851;
 Wed, 26 Sep 2018 00:52:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 00:52:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095faa90576c17f86@google.com>
Subject: general protection fault in __aa_lookupn_ns
From:   syzbot <syzbot+9b37e75e781b5e400f65@syzkaller.appspotmail.com>
To:     jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    dad486875956 Add linux-next specific files for 20180924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15da1fd1400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e793f6258a2ee8f
dashboard link: https://syzkaller.appspot.com/bug?extid=9b37e75e781b5e400f65
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142c6769400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12af5556400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9b37e75e781b5e400f65@syzkaller.appspotmail.com

audit: type=1400 audit(1537815185.042:10): apparmor="DENIED"  
operation="stack_onexec" info="label not found" error=-2  
profile="unconfined" name="&&" pid=5560 comm="syz-executor398"
audit: type=1400 audit(1537815185.072:11): apparmor="DENIED"  
operation="stack_onexec" info="label not found" error=-2  
profile="unconfined" name="&&" pid=5561 comm="syz-executor398"
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5565 Comm: syz-executor398 Not tainted  
4.19.0-rc5-next-20180924+ #78
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memcmp+0x28/0x160 lib/string.c:856
Code: 00 00 48 85 d2 0f 84 0a 01 00 00 48 b8 00 00 00 00 00 fc ff df 55 48  
89 f9 48 89 e5 48 c1 e9 03 41 54 53 48 89 fb 48 83 ec 18 <0f> b6 04 01 48  
89 f9 83 e1 07 38 c8 7f 08 84 c0 0f 85 98 00 00 00
RSP: 0018:ffff8801bbf0ef98 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: 0000000041b58ab3 RCX: 000000000836b156
RDX: 0000000000000002 RSI: ffffffff885fb8e0 RDI: 0000000041b58ab3
RBP: ffff8801bbf0efc0 R08: ffff8801d8628280 R09: ffffed003b585b57
R10: ffffed003b585b57 R11: ffff8801dac2dabb R12: 0000000000000002
R13: ffffffff885fb8e0 R14: ffff8801fda67e03 R15: dffffc0000000000
FS:  0000000000bf8880(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cb090 CR3: 00000001d884a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  strnstr+0x4b/0x70 lib/string.c:934
  __aa_lookupn_ns+0xc1/0x570 security/apparmor/policy_ns.c:209
  aa_lookupn_ns+0x88/0x1e0 security/apparmor/policy_ns.c:240
  aa_fqlookupn_profile+0x1b9/0x1010 security/apparmor/policy.c:468
  fqlookupn_profile+0x80/0xc0 security/apparmor/label.c:1844
  aa_label_strn_parse+0xa3a/0x1230 security/apparmor/label.c:1908
  aa_label_parse+0x42/0x50 security/apparmor/label.c:1943
  aa_change_profile+0x513/0x3510 security/apparmor/domain.c:1362
  apparmor_setprocattr+0xab7/0x1180 security/apparmor/lsm.c:759
  security_setprocattr+0x66/0xc0 security/security.c:1336
  proc_pid_attr_write+0x301/0x540 fs/proc/base.c:2555
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440d49
Code: e8 cc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcbaaf0448 EFLAGS: 00000213 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440d49
RDX: 0000000000000009 RSI: 0000000020000180 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000bf8880 R11: 0000000000000213 R12: 0000000000008f07
R13: 0000000000401d20 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 848eed09df759209 ]---
RIP: 0010:memcmp+0x28/0x160 lib/string.c:856
Code: 00 00 48 85 d2 0f 84 0a 01 00 00 48 b8 00 00 00 00 00 fc ff df 55 48  
89 f9 48 89 e5 48 c1 e9 03 41 54 53 48 89 fb 48 83 ec 18 <0f> b6 04 01 48  
89 f9 83 e1 07 38 c8 7f 08 84 c0 0f 85 98 00 00 00
RSP: 0018:ffff8801bbf0ef98 EFLAGS: 00010292
RAX: dffffc0000000000 RBX: 0000000041b58ab3 RCX: 000000000836b156
RDX: 0000000000000002 RSI: ffffffff885fb8e0 RDI: 0000000041b58ab3
RBP: ffff8801bbf0efc0 R08: ffff8801d8628280 R09: ffffed003b585b57
R10: ffffed003b585b57 R11: ffff8801dac2dabb R12: 0000000000000002
R13: ffffffff885fb8e0 R14: ffff8801fda67e03 R15: dffffc0000000000
FS:  0000000000bf8880(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006cb090 CR3: 00000001d884a000 CR4: 00000000001406f0
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
