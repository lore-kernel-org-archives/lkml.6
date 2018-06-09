Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zx/5F270G1u0agAAmS7hNA
	; Sat, 09 Jun 2018 15:38:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F723608C1; Sat,  9 Jun 2018 15:38:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=2.0 tests=BAYES_00,FROM_LOCAL_HEX,
	MAILING_LIST_MULTI,SORTED_RECIPS autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AF56A607DC;
	Sat,  9 Jun 2018 15:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF56A607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933154AbeFIPiU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:38:20 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:59506 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933152AbeFIPgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:36:02 -0400
Received: by mail-it0-f70.google.com with SMTP id v127-v6so4279731ith.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 08:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=1bUmUa3NuIeeF1Y9aewinoxWvokau+EyUezmM6pr+D0=;
        b=I3ae4DJSjedLcn4IEqqmbXK6UwKRY+Xmt/iYbduNI3KdlHROsbO390IW6o9Z7IlXSt
         yvEwpdW2cq8LY4A0UruXxf06NuZasB1C5if5CrFuj94AktT0DHWsXoC0bAnw63D7pPCm
         AymUyjNv2scMyX5zxrKWFkma17xC4xgzH4HX9bcxx4y5tzqesf6RdnGXZWWOLRB8zXeF
         Ny3wT9y/g2DTMKgBHTOQn44PL7JVCVZkwgqiWwz0qhFDYyGJz9h1dv/Vwo3d16RFkOCf
         MTQETQL1RzGPEhuegDu/4nELJva16AWYDd/rOQzgM7qTQU+8HDnzHuK4aTxeP+6+WJs3
         qtlg==
X-Gm-Message-State: APt69E31+EqxUMjwEmdjMkp8w9wfzS0fOeHe79WR/N9k8iVNmeBwa9xG
        3UFR/RCiimusMbit4JSGnlwsS3DWL1EW5EzHixdf3OR6iCwZ
X-Google-Smtp-Source: ADUXVKLjLpcZXl2VkrzuDnkoX8wCvMN+1a9D7pax/uGAU+xPkUFIxcPTRZPe3tgHfnZdg1l6zB1CVUtv9I+P8AyD6eWCs8txbCJ0
MIME-Version: 1.0
X-Received: by 2002:a24:5cca:: with SMTP id q193-v6mr2617141itb.38.1528558561645;
 Sat, 09 Jun 2018 08:36:01 -0700 (PDT)
Date: Sat, 09 Jun 2018 08:36:01 -0700
In-Reply-To: <000000000000973c2c056e0ecddd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015df96056e374691@google.com>
Subject: Re: general protection fault in __vfs_write
From: syzbot <syzbot+7ade6c94abb2774c0fee@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    3a979e8c07e3 Merge tag 'mailbox-v4.18' of git://git.linaro..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e0c81f800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412e35656a3f7c09
dashboard link: https://syzkaller.appspot.com/bug?extid=7ade6c94abb2774c0fee
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1665abf7800000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7ade6c94abb2774c0fee@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device team0
bpfilter: read fail -512
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 4546 Comm: syz-executor6 Not tainted 4.17.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:file_write_hint include/linux/fs.h:1932 [inline]
RIP: 0010:init_sync_kiocb include/linux/fs.h:1942 [inline]
RIP: 0010:new_sync_write fs/read_write.c:470 [inline]
RIP: 0010:__vfs_write+0x4a6/0x960 fs/read_write.c:487
Code: c1 ea 03 80 3c 02 00 0f 85 1b 04 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 20 49 8d bc 24 c8 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e ec 02 00 00 41 8b 84 24 c8 00
RSP: 0018:ffff8801ae407850 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801cd88f580 RCX: ffffffff81c0d6fb
RDX: 0000000000000019 RSI: ffffffff81c0d70a RDI: 00000000000000c8
RBP: ffff8801ae4079c8 R08: ffff8801d88ee680 R09: fffffbfff130c5d9
R10: ffff8801ae407a10 R11: ffffffff89862ecb R12: 0000000000000000
R13: ffff8801ae4079a0 R14: 0000000000000000 R15: ffff8801ae407a88
FS:  000000000102f940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f52ac0518 CR3: 00000001d8d8a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __kernel_write+0x10c/0x380 fs/read_write.c:506
  __bpfilter_process_sockopt+0x1d8/0x35b net/bpfilter/bpfilter_kern.c:66
  bpfilter_mbox_request+0x4d/0xb0 net/ipv4/bpfilter/sockopt.c:25
  bpfilter_ip_get_sockopt+0x6b/0x90 net/ipv4/bpfilter/sockopt.c:42
  ip_getsockopt+0x238/0x2a0 net/ipv4/ip_sockglue.c:1563
  tcp_getsockopt+0x93/0xe0 net/ipv4/tcp.c:3532
  sock_common_getsockopt+0x9a/0xe0 net/core/sock.c:3012
  __sys_getsockopt+0x1a5/0x370 net/socket.c:1972
  __do_sys_getsockopt net/socket.c:1983 [inline]
  __se_sys_getsockopt net/socket.c:1980 [inline]
  __x64_sys_getsockopt+0xbe/0x150 net/socket.c:1980
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4584ea
Code: b8 34 01 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 1d 8f fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 37 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fa 8e fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:0000000000a3e328 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000a3e350 RCX: 00000000004584ea
RDX: 0000000000000040 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000706f20 R08: 0000000000a3e34c R09: 0000000000004000
R10: 0000000000a3e350 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000706860
Modules linked in:
Dumping ftrace buffer:
    (ftrace buffer empty)
---[ end trace 9a583fc95516c106 ]---
RIP: 0010:file_write_hint include/linux/fs.h:1932 [inline]
RIP: 0010:init_sync_kiocb include/linux/fs.h:1942 [inline]
RIP: 0010:new_sync_write fs/read_write.c:470 [inline]
RIP: 0010:__vfs_write+0x4a6/0x960 fs/read_write.c:487
Code: c1 ea 03 80 3c 02 00 0f 85 1b 04 00 00 48 b8 00 00 00 00 00 fc ff df  
4c 8b 63 20 49 8d bc 24 c8 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e ec 02 00 00 41 8b 84 24 c8 00
RSP: 0018:ffff8801ae407850 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801cd88f580 RCX: ffffffff81c0d6fb
RDX: 0000000000000019 RSI: ffffffff81c0d70a RDI: 00000000000000c8
RBP: ffff8801ae4079c8 R08: ffff8801d88ee680 R09: fffffbfff130c5d9
R10: ffff8801ae407a10 R11: ffffffff89862ecb R12: 0000000000000000
R13: ffff8801ae4079a0 R14: 0000000000000000 R15: ffff8801ae407a88
FS:  000000000102f940(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f52ac0518 CR3: 00000001d8d8a000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
