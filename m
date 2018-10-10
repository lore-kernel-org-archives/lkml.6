Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B4C2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B4C2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJJPSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:18:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:41372 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:18:02 -0400
Received: by mail-it1-f199.google.com with SMTP id 207-v6so5008242itj.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WhSdhkufR7MlphxAC/dLggfiz1KX6Ghnfc62Xsu15nA=;
        b=Kutwe8Dbzm4f/KDppvEbyg+p0odxrf3AXycGoxKW30JdQ76Ge8I62ANAeiaQZuz/eb
         D6Dt+veM7ZLNw6IQYgL/aYEUWL8gSyFT0Xo0aj70Q7QNNUQuwxk0J5VHLGdddocb9Wh7
         NXWSqVOKVeA/zs1l5D8M/bfaE20SFt21uKWrUhUQw5DlmsPsdtxYQAEB4qXep/sb2BtS
         S/Ip2qFFjDJQLrxssPi2VyrN0tn4BNY3aoPsDroiixEcuaKPxBsTJFzDDiRP9I6qfLxb
         F7+6rV4RPA3cCT/cMuVswQQNpyYoTi6Vnl91T03t9NJSsGCUoAR5av9t5RB8uo9TEfuE
         kRGw==
X-Gm-Message-State: ABuFfoi2TbQB/d+mMn9vxQ/w1xvNKZ4RbENPk11rCKtzn0WQ/0bzmbp+
        jfPQ+jQs7ltgDD3ER8Rn+C4KNxafA70xrM7xZVS2r7EjaCKc
X-Google-Smtp-Source: ACcGV62c7pG4KWKtwA5vnsa3QMOUcko6wzhTZBrRPO5VPJu2ZgDgVj7krdAFzB54pDbvOcxdj3p58ouFCkeMeUyZCxfNDCt3brJ9
MIME-Version: 1.0
X-Received: by 2002:a24:9ec3:: with SMTP id p186-v6mr4391663itd.11.1539158224023;
 Wed, 10 Oct 2018 00:57:04 -0700 (PDT)
Date:   Wed, 10 Oct 2018 00:57:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000323c300577db3338@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in sha256_mb_mgr_get_comp_job_avx2
From:   syzbot <syzbot+2be67c86b63d3bf6e001@syzkaller.appspotmail.com>
To:     bp@alien8.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, megha.dey@linux.intel.com,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, tim.c.chen@linux.intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    64c5e530ac2c Merge tag 'arc-4.19-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1294e2d6400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=2be67c86b63d3bf6e001
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2be67c86b63d3bf6e001@syzkaller.appspotmail.com

audit: type=1804 audit(1539118025.521:29867): pid=31406 uid=0  
auid=4294967295 ses=4294967295 subj==unconfined op=invalid_pcr  
cause=open_writers comm="syz-executor2"  
name="/root/syzkaller-testdir968705726/syzkaller.1KeZRV/124/file0/bus"  
dev="sda1" ino=16590 res=1
BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
PGD 1d82fa067 P4D 1d82fa067 PUD 1d937c067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3868 Comm: kworker/1:1 Not tainted 4.19.0-rc7+ #275
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: crypto mcryptd_queue_worker
RIP: 0010:sha256_mb_mgr_get_comp_job_avx2+0x66/0xe3  
arch/x86/crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S:255
Code: 3b d3 c4 c1 79 7e d0 49 f7 c0 f0 ff ff ff 0f 85 93 00 00 00 49 6b d8  
08 48 8d 9c 1f 68 01 00 00 48 8b 03 48 c7 03 00 00 00 00 <c7> 40 40 02 00  
00 00 48 8b 9f 60 01 00 00 48 c1 e3 04 4c 09 c3 48
RSP: 0018:ffff88017c5e7370 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801d527f728 RCX: ffffffff8184e1ca
RDX: 1ffffd1ffffa2534 RSI: ffffffff814593ba RDI: ffff8801d527f5c0
RBP: ffff88017c5e74d0 R08: 0000000000000000 R09: ffffed0037cd50c7
R10: ffffed0037cd50c7 R11: ffff8801be6a863b R12: ffff88017c5e74a8
R13: 0000000000000001 R14: ffff8801be6a86e0 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000040 CR3: 00000001d83ec000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  sha256_mb_flusher+0x2f4/0x610 arch/x86/crypto/sha256-mb/sha256_mb.c:919
  mcryptd_opportunistic_flush crypto/mcryptd.c:142 [inline]
  mcryptd_queue_worker+0x49c/0x71f crypto/mcryptd.c:172
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Modules linked in:
CR2: 0000000000000040
---[ end trace 8d1a13a59eafe937 ]---
RIP: 0010:sha256_mb_mgr_get_comp_job_avx2+0x66/0xe3  
arch/x86/crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S:255
Code: 3b d3 c4 c1 79 7e d0 49 f7 c0 f0 ff ff ff 0f 85 93 00 00 00 49 6b d8  
08 48 8d 9c 1f 68 01 00 00 48 8b 03 48 c7 03 00 00 00 00 <c7> 40 40 02 00  
00 00 48 8b 9f 60 01 00 00 48 c1 e3 04 4c 09 c3 48
RSP: 0018:ffff88017c5e7370 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801d527f728 RCX: ffffffff8184e1ca
RDX: 1ffffd1ffffa2534 RSI: ffffffff814593ba RDI: ffff8801d527f5c0
RBP: ffff88017c5e74d0 R08: 0000000000000000 R09: ffffed0037cd50c7
R10: ffffed0037cd50c7 R11: ffff8801be6a863b R12: ffff88017c5e74a8
R13: 0000000000000001 R14: ffff8801be6a86e0 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000040 CR3: 00000001d83ec000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
