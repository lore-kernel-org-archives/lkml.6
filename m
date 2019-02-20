Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5574FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DADA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfBTOgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:36:07 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:56033 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfBTOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:36:06 -0500
Received: by mail-it1-f200.google.com with SMTP id j3so11067603itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 06:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5/u99sxH4qazgQczBJx2Z6pcYMTUPuEqEF7OZS+2sTY=;
        b=lNuSYPekZapTKXMKxtNuKl3C4RU95OQO8LSJVbGg/AxSl8qdvdDqE/IIpKEXmJZ2ZO
         pgn8KMKrrdBZIlY/IzbH3VkcttageDawibQTatAB7DxkGYZ4+PK2yEXeZLyvlYnXLGpR
         Sc/iEdEaEKCSjhoDwX4iwh2YliKZDIqs99OFxZ9+mrvLZ5dgB+LFUiZGOh5khir/wYZt
         ODOTY1kqM3otPEscAjqmXtEkgqnC9UXLJvGbyKPVGlOIziieFV/JBRZiIcp6etRF4p39
         6srfSdMWfzFyYVX9nFT7j8tB+5mAWgZ45BwyXV5Og6do/jijFiJyFLqO5sxDj9C3AOsb
         U3XA==
X-Gm-Message-State: AHQUAuZxTkFnkrecr6ssfognytLA6t9n2QxD2tzZuLh4tTrtACJjCETy
        S+hX73IPGd4rdTu0lRwm0ZQgCOCm2/AMYV/rnemCqzxwR3T2
X-Google-Smtp-Source: AHgI3IZJav1KEm6pgraeHyWJZ0Zrhuy8VX41tZi1Db4gU4kEMwgzTF6wVGgg8q/a79+mIFpK2PPz9O317Nzl8BzpzlSnjEzMkvD3
MIME-Version: 1.0
X-Received: by 2002:a5d:8c97:: with SMTP id g23mr25515072ion.0.1550673364581;
 Wed, 20 Feb 2019 06:36:04 -0800 (PST)
Date:   Wed, 20 Feb 2019 06:36:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f080605825447c6@google.com>
Subject: general protection fault in xfrmi_decode_session
From:   syzbot <syzbot+b69368fd933c6c592f4c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf446c90405 Add linux-next specific files for 20190220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175c2248c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=463cb576ac40e350
dashboard link: https://syzkaller.appspot.com/bug?extid=b69368fd933c6c592f4c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dfb248c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133bd26cc00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b69368fd933c6c592f4c@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device batadv0
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7683 Comm: syz-executor240 Not tainted 5.0.0-rc7-next-20190220  
#39
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:xs_net include/net/xfrm.h:253 [inline]
RIP: 0010:xfrmi_decode_session net/xfrm/xfrm_interface.c:82 [inline]
RIP: 0010:xfrmi_decode_session+0x15c/0x6c0 net/xfrm/xfrm_interface.c:73
Code: 7c fc 08 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2e 05 00 00 48 b8 00  
00 00 00 00 fc ff df 4f 8b 64 fc 08 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 01 05 00 00 4d 8b 3c 24 e8 91 62 55 fb e8 cc b7
RSP: 0018:ffff88808870f128 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888096313e00 RCX: ffffffff860899d3
RDX: 0000000000000000 RSI: ffffffff86089a10 RDI: ffff8880a0ef4f08
RBP: ffff88808870f150 R08: ffff88808fc2a300 R09: ffffed1015d05bc8
R10: ffffed1015d05bc7 R11: ffff8880ae82de3b R12: 0000000000000000
R13: 0000000000000036 R14: ffff888096313e10 R15: ffffffffffffffff
FS:  0000000001129880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000a000 CR3: 0000000092970000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __xfrm_policy_check+0x1f8/0x2730 net/xfrm/xfrm_policy.c:3316
  __xfrm_policy_check2 include/net/xfrm.h:1176 [inline]
  xfrm_policy_check include/net/xfrm.h:1181 [inline]
  xfrm4_policy_check include/net/xfrm.h:1186 [inline]
  vti_input+0x4e3/0x7b0 net/ipv4/ip_vti.c:63
  vti_rcv+0x10b/0x140 net/ipv4/ip_vti.c:109
  xfrm4_esp_rcv+0xd8/0x230 net/ipv4/xfrm4_protocol.c:100
  ip_protocol_deliver_rcu+0x60/0x8e0 net/ipv4/ip_input.c:208
  ip_local_deliver_finish+0x23b/0x390 net/ipv4/ip_input.c:234
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_local_deliver+0x1e9/0x520 net/ipv4/ip_input.c:255
  dst_input include/net/dst.h:450 [inline]
  ip_rcv_finish+0x1db/0x2f0 net/ipv4/ip_input.c:414
  NF_HOOK include/linux/netfilter.h:289 [inline]
  NF_HOOK include/linux/netfilter.h:283 [inline]
  ip_rcv+0xe8/0x3f0 net/ipv4/ip_input.c:524
  __netif_receive_skb_one_core+0x115/0x1a0 net/core/dev.c:4973
  __netif_receive_skb+0x2c/0x1c0 net/core/dev.c:5083
  netif_receive_skb_internal+0x117/0x660 net/core/dev.c:5186
  napi_frags_finish net/core/dev.c:5753 [inline]
  napi_gro_frags+0xade/0xd10 net/core/dev.c:5827
  tun_get_user+0x28ae/0x3b20 drivers/net/tun.c:1974
  tun_chr_write_iter+0xbd/0x160 drivers/net/tun.c:2019
  call_write_iter include/linux/fs.h:1857 [inline]
  do_iter_readv_writev+0x5e1/0x8e0 fs/read_write.c:680
  do_iter_write fs/read_write.c:956 [inline]
  do_iter_write+0x184/0x610 fs/read_write.c:937
  vfs_writev+0x1b3/0x2f0 fs/read_write.c:1001
  do_writev+0xf6/0x290 fs/read_write.c:1036
  __do_sys_writev fs/read_write.c:1109 [inline]
  __se_sys_writev fs/read_write.c:1106 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1106
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441e50
Code: 05 48 3d 01 f0 ff ff 0f 83 3d 0f fc ff c3 66 2e 0f 1f 84 00 00 00 00  
00 66 90 83 3d c1 91 29 00 00 75 14 b8 14 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 14 0f fc ff c3 48 83 ec 08 e8 7a 2b 00 00
RSP: 002b:00007fff989f5108 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007fff989f5150 RCX: 0000000000441e50
RDX: 0000000000000001 RSI: 00007fff989f5150 RDI: 00000000000000f0
RBP: 00007fff989f5120 R08: 0000000000000100 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000403280 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 75b9c68f6203bc58 ]---
RIP: 0010:xs_net include/net/xfrm.h:253 [inline]
RIP: 0010:xfrmi_decode_session net/xfrm/xfrm_interface.c:82 [inline]
RIP: 0010:xfrmi_decode_session+0x15c/0x6c0 net/xfrm/xfrm_interface.c:73
Code: 7c fc 08 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 2e 05 00 00 48 b8 00  
00 00 00 00 fc ff df 4f 8b 64 fc 08 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 01 05 00 00 4d 8b 3c 24 e8 91 62 55 fb e8 cc b7
RSP: 0018:ffff88808870f128 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888096313e00 RCX: ffffffff860899d3
RDX: 0000000000000000 RSI: ffffffff86089a10 RDI: ffff8880a0ef4f08
RBP: ffff88808870f150 R08: ffff88808fc2a300 R09: ffffed1015d05bc8
R10: ffffed1015d05bc7 R11: ffff8880ae82de3b R12: 0000000000000000
R13: 0000000000000036 R14: ffff888096313e10 R15: ffffffffffffffff
FS:  0000000001129880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000a000 CR3: 0000000092970000 CR4: 00000000001406f0
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
