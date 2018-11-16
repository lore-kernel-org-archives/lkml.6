Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A713C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EFB2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29EFB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390183AbeKQD5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:57:23 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:52532 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeKQD5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:57:23 -0500
Received: by mail-io1-f70.google.com with SMTP id h7so8942598iof.19
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 09:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HCiR3VuBtC4wm/yl415iYVvRNxFm24OdD6UCXcm9n68=;
        b=nzmQN5odvebyuNMoYEjU9umt67nnt84rK2FOYHwqipOAUJQGnvf2iXL6Pt8K2r5HAm
         yRKnImPO3W7fs07AxwCAq1MKgfFwtIUTzrKg58pNzVQEQN7JVrkG2fRXF+cNlD/6FbZj
         gMlk5JnKugsNvIDEWaLMQzkAz3DYDqpDp46O97IB3+wepvdt8EbXxqXRfzAG1wcdo71z
         g3e0MYtMBIBmePngelnWgnK5fcYEQdZUa3rAC6WFPr/TViLfo4GxoqbFCyyTg1IHqmsJ
         3iR1jzvYzsdN4zJM00HxBTBAKJL7Vjgahk8FtYF7rlQHHp3BohOKhC6HDbVLZ+5AdoJt
         XNLg==
X-Gm-Message-State: AGRZ1gKJPzX0/h+hOW9wHoocJjEzT5+wxUQ+8M9tg7E2YBWWiD+sx81c
        Xh1BUVLyvL2hPkK/wydnCihMr/tC2Dpt1zl62KPTusGCpQ6N
X-Google-Smtp-Source: AJdET5dXVNnfx3Hm5f526yGvbbnqGdhfgVkqnXyz2BfDMAH0dk3/pxlYTVWA/NECd5S2ANo/yxhvK+m12JEsQxIpDyisQr33rfde
MIME-Version: 1.0
X-Received: by 2002:a02:8ca9:: with SMTP id f38mr4231834jak.14.1542390243003;
 Fri, 16 Nov 2018 09:44:03 -0800 (PST)
Date:   Fri, 16 Nov 2018 09:44:02 -0800
In-Reply-To: <000000000000396c09057a17b6fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a1687057acbb692@google.com>
Subject: Re: general protection fault in rdma_listen (2)
From:   syzbot <syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com>
To:     danielj@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    da5322e65940 Merge tag 'selinux-pr-20181115' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a06f7b400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
dashboard link: https://syzkaller.appspot.com/bug?extid=6b46b135602a3f3ac99e
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fa8a47400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6b46b135602a3f3ac99e@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6328 Comm: syz-executor0 Not tainted 4.20.0-rc2+ #337
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:cma_bind_listen drivers/infiniband/core/cma.c:3355 [inline]
RIP: 0010:rdma_listen+0x357/0x990 drivers/infiniband/core/cma.c:3469
Code: 4c 8b ab c8 01 00 00 31 f6 48 c7 c7 60 3b db 89 e8 9e eb 25 02 48 b8  
00 00 00 00 00 fc ff df 49 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 64 05 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff8881b266f970 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8881ba9a6d80 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000008
RBP: ffff8881b266fa10 R08: fffffbfff13b6775 R09: fffffbfff13b6774
R10: ffff8881b266f960 R11: ffffffff89db3ba3 R12: 1ffff110364cdf31
R13: 0000000000000000 R14: 0000000000000003 R15: ffff8881d908fa80
FS:  00007f22f9e27700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004cef08 CR3: 00000001ba4b4000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ucma_listen+0x1a4/0x260 drivers/infiniband/core/ucma.c:1100
  ucma_write+0x365/0x460 drivers/infiniband/core/ucma.c:1689
  __vfs_write+0x119/0x9f0 fs/read_write.c:485
  vfs_write+0x1fc/0x560 fs/read_write.c:549
  ksys_write+0x101/0x260 fs/read_write.c:598
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457569
Code: fd b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f22f9e26c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000457569
RDX: 0000000000000010 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f22f9e276d4
R13: 00000000004c571f R14: 00000000004d9360 R15: 00000000ffffffff
Modules linked in:
---[ end trace ad276a0bcb316fb3 ]---
RIP: 0010:cma_bind_listen drivers/infiniband/core/cma.c:3355 [inline]
RIP: 0010:rdma_listen+0x357/0x990 drivers/infiniband/core/cma.c:3469
Code: 4c 8b ab c8 01 00 00 31 f6 48 c7 c7 60 3b db 89 e8 9e eb 25 02 48 b8  
00 00 00 00 00 fc ff df 49 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 64 05 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
RSP: 0018:ffff8881b266f970 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8881ba9a6d80 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000008
RBP: ffff8881b266fa10 R08: fffffbfff13b6775 R09: fffffbfff13b6774
R10: ffff8881b266f960 R11: ffffffff89db3ba3 R12: 1ffff110364cdf31
R13: 0000000000000000 R14: 0000000000000003 R15: ffff8881d908fa80
FS:  00007f22f9e27700(0000) GS:ffff8881daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000001ba4b4000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

