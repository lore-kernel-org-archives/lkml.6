Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B241C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 04:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21B920833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 04:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21B920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeINJXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 05:23:38 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:37113 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeINJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 05:23:38 -0400
Received: by mail-it0-f69.google.com with SMTP id e63-v6so1102427ite.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 21:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=49yq5SXehTZQZQtgFJZwc8X8UV2Aj/0K8JpTllmaJXY=;
        b=XnavYhc/leBwYVmdyQnf/bcp2IUlamn0duZz71UpOfstzoIDDyDXNMtjq98oD9DMSR
         c+jFxAWdXlhq1M4sFBFRtRrlJFacUDBzz3hfhJFwGnSe4fjfkfHtlwwE1KKXFS6stLn2
         L85u4HblGnpFXYGHtM4iTZLlxuc+z16nA8FcrVgV3B5TbGrDLiG+T+gWjCqN0UkggkyS
         aIzZre23U42LBslTelV4r+jntBeHtevXnXsoHS3hDwb0gDlGjA0U7ebTews9txX0Yqiv
         BvcNcTmPL8AQoL6ZEsIchiC1TXtf5ZnhSutZVwvYPEOJWJEVJ2JvVf2BXECqW0/2P3A4
         WFKA==
X-Gm-Message-State: APzg51BcJE/LVSzUuA1cyjuIuYS8nMwC6GPscA5O4IWBaAjTZCNTBBcw
        oNnh6va7/ieo4SlXe2NAbwdDze1B359CS/KaUttOyoAmFp+K
X-Google-Smtp-Source: ANB0Vdb3rIfGaJRG5/gjqiedcq9G1zRtwJlemCpZ0EOPT6wkfBaKYGj7fHewVZvhuMD7yKNYxHcvQTIrcxAK08j7/PwMdt4fOwGA
MIME-Version: 1.0
X-Received: by 2002:a24:691:: with SMTP id 139-v6mr788341itv.53.1536898263074;
 Thu, 13 Sep 2018 21:11:03 -0700 (PDT)
Date:   Thu, 13 Sep 2018 21:11:03 -0700
In-Reply-To: <000000000000701dac0575ac7d64@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006d2340575cd03c6@google.com>
Subject: Re: general protection fault in reconfigure_super
From:   syzbot <syzbot+87ccdc710b6af3fff875@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f8dcd0279214 Add linux-next specific files for 20180913
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=157a3321400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb7f4703ab2604e5
dashboard link: https://syzkaller.appspot.com/bug?extid=87ccdc710b6af3fff875
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1747e21a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bd47da400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+87ccdc710b6af3fff875@syzkaller.appspotmail.com

random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
random: sshd: uninitialized urandom read (32 bytes read)
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5563 Comm: syz-executor716 Not tainted  
4.19.0-rc3-next-20180913+ #73
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:reconfigure_super+0x48e/0xbb0 fs/super.c:981
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 62 05 00 00 48 ba 00 00 00  
00 00 fc ff df 48 8b 03 48 8d 78 30 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 4d 05 00 00 48 8b 40 30 48 85 c0 48 89 85 20 ff
RSP: 0018:ffff8801b77278d8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801b77279f8 RCX: 0000000000000006
RDX: dffffc0000000000 RSI: ffffffff81cdbc5b RDI: 0000000000000030
RBP: ffff8801b77279c8 R08: ffff8801bb7781c0 R09: fffffbfff12c24e5
R10: fffffbfff12c24e5 R11: ffffffff8961272b R12: ffff8801d928e680
R13: 1ffff10036ee4f20 R14: 0000000000000000 R15: ffff8801b7727adc
FS:  0000000001f01880(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c0 CR3: 00000001d93b7000 CR4: 00000000001406f0
Call Trace:
  do_umount_root+0x2b1/0x320 fs/namespace.c:1434
  do_umount fs/namespace.c:1504 [inline]
  ksys_umount+0x8b6/0x1230 fs/namespace.c:1620
  __do_sys_umount fs/namespace.c:1631 [inline]
  __se_sys_umount fs/namespace.c:1629 [inline]
  __x64_sys_umount+0x54/0x80 fs/namespace.c:1629
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440069
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcf308b4e8 EFLAGS: 00000217 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440069
RDX: 0000000000440069 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004018f0
R13: 0000000000401980 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace b41eea7577a38771 ]---
RIP: 0010:reconfigure_super+0x48e/0xbb0 fs/super.c:981
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 62 05 00 00 48 ba 00 00 00  
00 00 fc ff df 48 8b 03 48 8d 78 30 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f  
85 4d 05 00 00 48 8b 40 30 48 85 c0 48 89 85 20 ff
RSP: 0018:ffff8801b77278d8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffff8801b77279f8 RCX: 0000000000000006
RDX: dffffc0000000000 RSI: ffffffff81cdbc5b RDI: 0000000000000030
RBP: ffff8801b77279c8 R08: ffff8801bb7781c0 R09: fffffbfff12c24e5
R10: fffffbfff12c24e5 R11: ffffffff8961272b R12: ffff8801d928e680
R13: 1ffff10036ee4f20 R14: 0000000000000000 R15: ffff8801b7727adc
FS:  0000000001f01880(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c0 CR3: 00000001d93b7000 CR4: 00000000001406f0

