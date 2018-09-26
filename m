Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10824C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EDA20684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EDA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeIZUkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:40:18 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48420 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeIZUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:40:17 -0400
Received: by mail-io1-f72.google.com with SMTP id n26-v6so52578752iog.15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wFAM1YfouwVmvxvpEy3lARLXQlzorEZwmgGdoMp3UUI=;
        b=SUdTomob74c+KNU4PcQ+1yb+h5fMR7HKXAZoPu0YAGq6vzqUACMJTaw8thVDFMcHyJ
         2jNhURTS44kuotQVME3Lw9pSmSPaWWZpetXeUzOUnyoCBv0K7cLMA1lyv3RRPAEoOPvi
         c7eRA+nHz1VU1dRMhX1VZdSDX48UufgPB/V7OdObwcjzp/zm5kO038D+VV25u/9gnniS
         SEUA0/4EDGAwiH/2E9Ok16mITYK9A62h5gyzb3XEena2VC/Z3jG2Ng5H8Zz7uIH21Z0U
         xEeO39j1+iZ0mN9VzfbNTvd7aUy4Yy6AYuAYd2y5LoFiCH3BdoK6Z1vGiOBN8Vba5lWj
         QthA==
X-Gm-Message-State: ABuFfojOXxDolJv1z9SoS+kLQuE9fD1t0LxePutves5T0VjmjfY2sFoo
        Xo9dw2dyvLUg5pvXZ7QkkgGDVZYzsLBySo1ND3+hZgJIO4Xj
X-Google-Smtp-Source: ACcGV6214q3aeebBYxdDCRLv1Q+OOWmViVpCSzc9JYXOOPdTZh0iWFE6c9j5SEh1B4Tyiscik7fVm1R7zziPzj8hn7F6j/kaqRz9
MIME-Version: 1.0
X-Received: by 2002:a02:8a76:: with SMTP id e51-v6mr4649660jal.26.1537972024283;
 Wed, 26 Sep 2018 07:27:04 -0700 (PDT)
Date:   Wed, 26 Sep 2018 07:27:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e9bdb0576c70441@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in sha1_mb_mgr_get_comp_job_avx2
From:   syzbot <syzbot+87dbe4b17debcec16d71@syzkaller.appspotmail.com>
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

HEAD commit:    a38523185b40 erge tag 'libnvdimm-fixes-4.19-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1767b7fa400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
dashboard link: https://syzkaller.appspot.com/bug?extid=87dbe4b17debcec16d71
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87dbe4b17debcec16d71@syzkaller.appspotmail.com

BUG: unable to handle kernel NULL pointer dereference at 0000000000000034
PGD 1b8b87067 P4D 1b8b87067 PUD 1b8b88067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 24 Comm: kworker/1:1 Not tainted 4.19.0-rc5+ #32
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: crypto mcryptd_flusher
RIP: 0010:sha1_mb_mgr_get_comp_job_avx2+0x62/0xba  
arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S:256
Code: 04 c4 e2 69 3b d3 c4 c1 79 7e d0 49 f7 c0 f0 ff ff ff 75 6e 49 6b d8  
08 48 8d 9c 1f 08 01 00 00 48 8b 03 48 c7 03 00 00 00 00 <c7> 40 34 02 00  
00 00 48 8b 9f 00 01 00 00 48 c1 e3 04 4c 09 c3 48
kobject: 'loop1' (00000000307f8c2f): kobject_uevent_env
RSP: 0018:ffff8801d94473c0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801d4818688 RCX: 1ffff1003b2869e1
RDX: 1ffffd1ffffa2591 RSI: ffffffff81454f3a RDI: ffff8801d4818580
RBP: ffff8801d9447520 R08: 0000000000000000 R09: 0000000000000006
kobject: 'loop1' (00000000307f8c2f): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
R10: 0000000000000000 R11: ffff8801d9434640 R12: ffff8801d94474f8
R13: 0000000000000001 R14: ffff8801bb509720 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kobject: 'loop4' (00000000fa342cfc): kobject_uevent_env
CR2: 0000000000000034 CR3: 00000001b8b85000 CR4: 00000000001406e0
kobject: 'loop4' (00000000fa342cfc): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
Call Trace:
  sha1_mb_flusher+0x2f4/0x60b arch/x86/crypto/sha1-mb/sha1_mb.c:918
  mcryptd_flusher+0x3af/0x520 crypto/mcryptd.c:208
  process_one_work+0xc90/0x1b90 kernel/workqueue.c:2153
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x420 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
Modules linked in:
CR2: 0000000000000034
---[ end trace 7d3a48e5625a9543 ]---
RIP: 0010:sha1_mb_mgr_get_comp_job_avx2+0x62/0xba  
arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S:256
Code: 04 c4 e2 69 3b d3 c4 c1 79 7e d0 49 f7 c0 f0 ff ff ff 75 6e 49 6b d8  
08 48 8d 9c 1f 08 01 00 00 48 8b 03 48 c7 03 00 00 00 00 <c7> 40 34 02 00  
00 00 48 8b 9f 00 01 00 00 48 c1 e3 04 4c 09 c3 48
RSP: 0018:ffff8801d94473c0 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801d4818688 RCX: 1ffff1003b2869e1
RDX: 1ffffd1ffffa2591 RSI: ffffffff81454f3a RDI: ffff8801d4818580
RBP: ffff8801d9447520 R08: 0000000000000000 R09: 0000000000000006
R10: 0000000000000000 R11: ffff8801d9434640 R12: ffff8801d94474f8
R13: 0000000000000001 R14: ffff8801bb509720 R15: 0000000000000200
FS:  0000000000000000(0000) GS:ffff8801dad00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000034 CR3: 00000001b8b85000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
