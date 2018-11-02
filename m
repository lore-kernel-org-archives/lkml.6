Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C70C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152192081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152192081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeKCArd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:47:33 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:59397 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKCArc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:47:32 -0400
Received: by mail-it1-f199.google.com with SMTP id e197-v6so3033665ita.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 08:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VOJRh/Ma28JQAfAXJrkpa6AwCvxMkmtWEwzwxmy675Q=;
        b=BtppFSpTlxEIy3XG65DY/7xCAVYSMivRyzF8Da3KIOYjmrGbJzs5nwuASgJVnfK0Ej
         yTxqmSOlyCdlzfLgx3uZGumYdieMIsP6DrAR1K1TVOm+I7qZaFszOd1NubXE9/9owPiL
         8S2et9xEGCS2A/Yt4jvjiAyiGUfZ8j12FFVSCExs/7h/uFqtLUM6Swz2VgakGFTcpHNr
         OB+bnzj7OtMMyqktw/GYg32BdHhptmCH+t0zuZUyKcbFGWW8oyTZQ48i0lVh1VrK056l
         dGyT32fBmf/yQtEEOBVECyCnLA2OXZk0c+ut8KqmNvhqnEwPvy9B/lD9iCWqWUhhl+ak
         LqAw==
X-Gm-Message-State: AGRZ1gIZY3iQwLrVCQ6z7j+dJhxYDw0mZn0sujgWfbvuezywE7oZRy+C
        OE5G0w8HmVorBYXyO84BTAHzMnkX1hiDRuBnHn/Cc9yodIbA
X-Google-Smtp-Source: AJdET5c9jiBiSZ/xAmvNBNFl7UMzsb+f2ZnVuvtMLCvQoYTAtQkw7XXToNPIRSJUbpWZPYq8DZEdhgy+HuX/HFaUujs4QY8estbF
MIME-Version: 1.0
X-Received: by 2002:a02:3503:: with SMTP id k3-v6mr6037811jaa.5.1541173202646;
 Fri, 02 Nov 2018 08:40:02 -0700 (PDT)
Date:   Fri, 02 Nov 2018 08:40:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004823040579b05948@google.com>
Subject: general protection fault in xfrmi_lookup
From:   syzbot <syzbot+ef5639e6d1435df3a1f1@syzkaller.appspotmail.com>
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

HEAD commit:    e2a322a0c8ce Merge branch 'net-smc-userspace-breakage-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12087ce9400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
dashboard link: https://syzkaller.appspot.com/bug?extid=ef5639e6d1435df3a1f1
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ef5639e6d1435df3a1f1@syzkaller.appspotmail.com

RBP: 0000000020000000 R08: 00000000000000f0 R09: 0000000000000000
R10: 0000000000000064 R11: 0000000000000293 R12: 00007f25cc19f6d4
R13: 00000000004c48a4 R14: 00000000004d7b90 R15: 0000000000000004
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 32654 Comm: syz-executor4 Not tainted 4.19.0-rc6+ #134
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:net_generic include/net/netns/generic.h:45 [inline]
RIP: 0010:xfrmi_lookup.isra.18+0x11f/0x6c0 net/xfrm/xfrm_interface.c:61
Code: 57 af d3 fa 45 84 ed 0f 84 4c 04 00 00 e8 79 ae d3 fa 48 8d bb 08 1b  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 7b 05 00 00 4c 8d 6d 98 48 8b 9b 08 1b 00 00 48
RSP: 0018:ffff880181996878 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000800 RCX: ffffc90009ecc000
RDX: 0000000000000461 RSI: ffffffff86ab2717 RDI: 0000000000002308
RBP: ffff880181996998 R08: ffff88019690c700 R09: 0000000000000000
R10: fffffbfff128759a R11: 0000000000000000 R12: 0000000000000036
R13: 0000000000000000 R14: ffff8801d596dd68 R15: ffffea00000000d0
FS:  00007f25cc19f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001cc821000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  xfrmi_rcv_cb+0xef/0x9d0 net/xfrm/xfrm_interface.c:256
  xfrm6_rcv_cb+0x220/0x400 net/ipv6/xfrm6_protocol.c:59
  xfrm_rcv_cb net/xfrm/xfrm_input.c:108 [inline]
  xfrm_input+0x8aa/0x3190 net/xfrm/xfrm_input.c:496
  xfrm6_rcv_spi net/ipv6/xfrm6_input.c:31 [inline]
  xfrm6_rcv_tnl+0x168/0x1d0 net/ipv6/xfrm6_input.c:74
  xfrm6_rcv+0x17/0x20 net/ipv6/xfrm6_input.c:81
  xfrm6_esp_rcv+0x1a5/0x3a0 net/ipv6/xfrm6_protocol.c:74
  ip6_input_finish+0x3fc/0x1aa0 net/ipv6/ip6_input.c:383
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ip6_input+0xe9/0x600 net/ipv6/ip6_input.c:426
  ip6_mc_input+0x48a/0xd20 net/ipv6/ip6_input.c:503
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x17a/0x330 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:289 [inline]
  ipv6_rcv+0x120/0x640 net/ipv6/ip6_input.c:271
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4891
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5001
  netif_receive_skb_internal+0x12c/0x620 net/core/dev.c:5104
  napi_frags_finish net/core/dev.c:5642 [inline]
  napi_gro_frags+0x75a/0xc90 net/core/dev.c:5715
  tun_get_user+0x3189/0x4250 drivers/net/tun.c:1923
  tun_chr_write_iter+0xb9/0x154 drivers/net/tun.c:1968
  call_write_iter include/linux/fs.h:1808 [inline]
  do_iter_readv_writev+0x8b0/0xa80 fs/read_write.c:680
  do_iter_write+0x185/0x5f0 fs/read_write.c:959
  vfs_writev+0x1f1/0x360 fs/read_write.c:1004
  do_writev+0x11a/0x310 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457431
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 54 b5 fb ff c3 48  
83 ec 08 e8 1a 2d 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 63 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f25cc19eba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000000004a RCX: 0000000000457431
RDX: 0000000000000001 RSI: 00007f25cc19ebf0 RDI: 00000000000000f0
RBP: 0000000020000000 R08: 00000000000000f0 R09: 0000000000000000
R10: 0000000000000064 R11: 0000000000000293 R12: 00007f25cc19f6d4
R13: 00000000004c48a4 R14: 00000000004d7b90 R15: 0000000000000004
Modules linked in:
---[ end trace 803f6dba779493b5 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:188 [inline]
RIP: 0010:net_generic include/net/netns/generic.h:45 [inline]
RIP: 0010:xfrmi_lookup.isra.18+0x11f/0x6c0 net/xfrm/xfrm_interface.c:61
Code: 57 af d3 fa 45 84 ed 0f 84 4c 04 00 00 e8 79 ae d3 fa 48 8d bb 08 1b  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 7b 05 00 00 4c 8d 6d 98 48 8b 9b 08 1b 00 00 48
RSP: 0018:ffff880181996878 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000800 RCX: ffffc90009ecc000
RDX: 0000000000000461 RSI: ffffffff86ab2717 RDI: 0000000000002308
RBP: ffff880181996998 R08: ffff88019690c700 R09: 0000000000000000
R10: fffffbfff128759a R11: 0000000000000000 R12: 0000000000000036
R13: 0000000000000000 R14: ffff8801d596dd68 R15: ffffea00000000d0
FS:  00007f25cc19f700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000001cc821000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
