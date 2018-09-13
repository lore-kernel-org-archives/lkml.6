Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020BFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A134120854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A134120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeIMSkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:40:32 -0400
Received: from mail-it0-f69.google.com ([209.85.214.69]:33978 "EHLO
        mail-it0-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbeIMSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:40:32 -0400
Received: by mail-it0-f69.google.com with SMTP id k204-v6so1639577ite.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Nof/oB5PGgL/aqixjAUQ8MvpEUTKPMFti4nsJHVzEY0=;
        b=ELKr7ltweL8eI5V+6P3t4AKSlX8154aD1VOWvcUvp/3AQF+RV3dhERGCIRIpB6Li2p
         Iaq99/RCnf/9w5YxUCpRztdOVL/vu75PWMTKCqXyPykxq/70UTqnJsAYJ2avXal48T4z
         riXgHx+Nlib/n52OXhJPxH6oAe+AS2Ux9kj8GbSG7YjWQZBPSTRZpf3woGq8OSR7jeme
         xztJkX7usGZ5fa/A/zx7m4jdkmSghaFfWYsM94CYdVNAF/vNbGnvudZj/1YJp5D7O5Tx
         oc4icMhHUT5nM4XMH/QuiBEElFMH4Of3jbHCmruoqHqLLKvNzB2h50aS7yTkF0iPkMYs
         vVuQ==
X-Gm-Message-State: APzg51CdG1th/o987ytLpJNH+ONy/Exyk6LVBIitOS2adXGe8JdqBwQ6
        azNDTZllL7LRYh6uDfcF6ynX51cThg39Kk8eXxMsceckKVQW
X-Google-Smtp-Source: ANB0VdZJaTGSzyIxrF/62TQjtx7AVie/fSqscxSjgoqd3xtRfq7bU1UO//ynhVPC9uFCyBXGTWrGIzbaSI/odbepq3KRhXr6Bkzc
MIME-Version: 1.0
X-Received: by 2002:a24:d205:: with SMTP id z5-v6mr5751600itf.35.1536845462565;
 Thu, 13 Sep 2018 06:31:02 -0700 (PDT)
Date:   Thu, 13 Sep 2018 06:31:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000defd200575c0b7dd@google.com>
Subject: general protection fault in xfrmi_rcv_cb
From:   syzbot <syzbot+af91688fec2b033aa620@syzkaller.appspotmail.com>
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

HEAD commit:    11957be20ff6 htb: use anonymous union for simplicity
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1773c6da400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
dashboard link: https://syzkaller.appspot.com/bug?extid=af91688fec2b033aa620
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+af91688fec2b033aa620@syzkaller.appspotmail.com

RBP: 0000000020000000 R08: 00000000000000f0 R09: 0000000000000000
R10: 0000000000000064 R11: 0000000000000293 R12: 0000000000000004
R13: 00000000004d7270 R14: 00000000004ca37e R15: 0000000000000003
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12674 Comm: syz-executor3 Not tainted 4.19.0-rc2+ #211
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:xs_net include/net/xfrm.h:253 [inline]
RIP: 0010:xfrmi_rcv_cb+0xd4/0x9d0 net/xfrm/xfrm_interface.c:256
Code: 7c e5 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f0 07 00 00 48 b8 00  
00 00 00 00 fc ff df 4f 8b 64 e5 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 da 07 00 00 49 8b 3c 24 49 8d b4 24 d0 00 00 00
RSP: 0018:ffff88019dd3e968 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8801c56c5bc0 RCX: ffffc90003252000
RDX: 0000000000000000 RSI: ffffffff86b73915 RDI: ffff8801b93b6b88
RBP: ffff88019dd3e9a8 R08: ffff880191300640 R09: 1ffffffff12f43cd
R10: ffffed003b584732 R11: ffff8801dac23993 R12: 0000000000000000
R13: ffff8801b93b6b80 R14: ffff8801c56c5c28 R15: 0000000000000001
FS:  00007f969fbaa700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
kobject: 'loop0' (000000007546342c): kobject_uevent_env
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000019bf04000 CR4: 00000000001406f0
Call Trace:
  xfrm6_rcv_cb+0x220/0x400 net/ipv6/xfrm6_protocol.c:59
kobject: 'tx-3' (000000000393e75f): kobject_uevent_env
  xfrm_rcv_cb net/xfrm/xfrm_input.c:108 [inline]
  xfrm_input+0x8aa/0x3190 net/xfrm/xfrm_input.c:495
kobject: 'loop0' (000000007546342c): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'tx-3' (000000000393e75f): fill_kobj_path: path  
= '/devices/virtual/mac80211_hwsim/hwsim3/net/wlan1/queues/tx-3'
kobject: 'loop1' (000000003d7d00b3): kobject_uevent_env
kobject: 'loop1' (000000003d7d00b3): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
  xfrm6_rcv_spi net/ipv6/xfrm6_input.c:31 [inline]
  xfrm6_rcv_tnl+0x168/0x1d0 net/ipv6/xfrm6_input.c:73
  xfrm6_rcv+0x17/0x20 net/ipv6/xfrm6_input.c:80
kobject: 'loop4' (00000000627de047): kobject_uevent_env
  xfrm6_esp_rcv+0x1a5/0x3a0 net/ipv6/xfrm6_protocol.c:74
kobject: 'loop4' (00000000627de047): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
  ip6_input_finish+0x3fc/0x1aa0 net/ipv6/ip6_input.c:383
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ip6_input+0xe9/0x600 net/ipv6/ip6_input.c:426
  ip6_mc_input+0x48a/0xd20 net/ipv6/ip6_input.c:503
  dst_input include/net/dst.h:450 [inline]
  ip6_rcv_finish+0x17a/0x330 net/ipv6/ip6_input.c:76
  NF_HOOK include/linux/netfilter.h:287 [inline]
  ipv6_rcv+0x11e/0x650 net/ipv6/ip6_input.c:271
  __netif_receive_skb_one_core+0x14d/0x200 net/core/dev.c:4894
  __netif_receive_skb+0x2c/0x1e0 net/core/dev.c:5004
  netif_receive_skb_internal+0x12c/0x620 net/core/dev.c:5107
  napi_frags_finish net/core/dev.c:5643 [inline]
  napi_gro_frags+0x75a/0xc90 net/core/dev.c:5716
  tun_get_user+0x31d5/0x42a0 drivers/net/tun.c:1965
  tun_chr_write_iter+0xb9/0x154 drivers/net/tun.c:2010
  call_write_iter include/linux/fs.h:1807 [inline]
  do_iter_readv_writev+0x8b0/0xa80 fs/read_write.c:680
  do_iter_write+0x185/0x5f0 fs/read_write.c:959
  vfs_writev+0x1f1/0x360 fs/read_write.c:1004
  do_writev+0x11a/0x310 fs/read_write.c:1039
  __do_sys_writev fs/read_write.c:1112 [inline]
  __se_sys_writev fs/read_write.c:1109 [inline]
  __x64_sys_writev+0x75/0xb0 fs/read_write.c:1109
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457161
Code: 75 14 b8 14 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 34 b6 fb ff c3 48  
83 ec 08 e8 da 2c 00 00 48 89 04 24 b8 14 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 23 2d 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f969fba9ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 000000000000004a RCX: 0000000000457161
RDX: 0000000000000001 RSI: 00007f969fba9bf0 RDI: 00000000000000f0
RBP: 0000000020000000 R08: 00000000000000f0 R09: 0000000000000000
R10: 0000000000000064 R11: 0000000000000293 R12: 0000000000000004
R13: 00000000004d7270 R14: 00000000004ca37e R15: 0000000000000003
Modules linked in:
---[ end trace 37ac9ade311d7a37 ]---
RIP: 0010:xs_net include/net/xfrm.h:253 [inline]
RIP: 0010:xfrmi_rcv_cb+0xd4/0x9d0 net/xfrm/xfrm_interface.c:256
Code: 7c e5 10 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 f0 07 00 00 48 b8 00  
00 00 00 00 fc ff df 4f 8b 64 e5 10 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f  
85 da 07 00 00 49 8b 3c 24 49 8d b4 24 d0 00 00 00
RSP: 0018:ffff88019dd3e968 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8801c56c5bc0 RCX: ffffc90003252000
RDX: 0000000000000000 RSI: ffffffff86b73915 RDI: ffff8801b93b6b88
RBP: ffff88019dd3e9a8 R08: ffff880191300640 R09: 1ffffffff12f43cd
R10: ffffed003b584732 R11: ffff8801dac23993 R12: 0000000000000000
R13: ffff8801b93b6b80 R14: ffff8801c56c5c28 R15: 0000000000000001
FS:  00007f969fbaa700(0000) GS:ffff8801dac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000019bf04000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
