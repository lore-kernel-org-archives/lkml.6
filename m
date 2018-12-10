Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DCFC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD92081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFD92081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbeLJHtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 02:49:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:43521 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLJHtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 02:49:03 -0500
Received: by mail-io1-f69.google.com with SMTP id k4so10490054ioc.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 23:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AffpOObK+6hbkxl9D9m3W2gl8zOZBlO+JLKeIvuBjhs=;
        b=G1ifLTEYuznJcFQFEprDo+Jt7etGn1zaHFlkJL7TAIg25Q1kChdqBbGJH6ut4U95xG
         Pej3vt8BRxxkk7yNeitvPRz+1kgCvRRf3mp188iiFBTisjz3X8jd9IemLqet1JGCTT1+
         vXjxMAF+40zTiSKXVaydX4WO9jdIchcbe+892Q99Q/htGQ1SxPtKS/2MBx13KOlYg7g2
         dawkcS71GvPl1GB9A0NHxfKcnE8WZu7qwcX3ejkQlsoRB21meZL/Rrlyh0/kS0G87ZlP
         WHjr3ByUVspqzJbn4b107+Tol437KgZjj7xIy6rt/reJCeKNZUlyW7oEI/kBG9Qp8zZc
         JYPA==
X-Gm-Message-State: AA+aEWZJRxSTuv2hn2TE7AZDbgxZN/v/vF+u3x/aubnzAUlT7BN9rsvy
        VOiuMnGE0kqaom8Z98Lih4DMJBFdugX4UtTtAFyUU40rc4R7
X-Google-Smtp-Source: AFSGD/UECkz1sY1iovffKkXvEMeTM4LQdkE/PNjMxqGqxwka0gB5UJ11Rg53eb+ssqTBJhMmn7Gu1ZMcExP4J2es+rcp51aoSRjN
MIME-Version: 1.0
X-Received: by 2002:a6b:cd8d:: with SMTP id d135mr8599042iog.19.1544428142820;
 Sun, 09 Dec 2018 23:49:02 -0800 (PST)
Date:   Sun, 09 Dec 2018 23:49:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d58636057ca63247@google.com>
Subject: WARNING in xfrm_policy_inexact_gc_tree
From:   syzbot <syzbot+0b2f1bc876d301440d44@syzkaller.appspotmail.com>
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

HEAD commit:    74c4a24df7ca Add linux-next specific files for 20181207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17bbea7d400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e9413388bf37bed
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2f1bc876d301440d44
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0b2f1bc876d301440d44@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
WARNING: CPU: 0 PID: 13116 at net/xfrm/xfrm_policy.c:1066  
xfrm_policy_inexact_gc_tree+0x233/0x280 net/xfrm/xfrm_policy.c:1066
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 13116 Comm: kworker/u4:10 Not tainted 4.20.0-rc5-next-20181207+  
#163
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x244/0x39d lib/dump_stack.c:113
  panic+0x2ad/0x632 kernel/panic.c:214
  __warn.cold.8+0x20/0x4f kernel/panic.c:571
  report_bug+0x254/0x2d0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:271
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:290
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:969
RIP: 0010:xfrm_policy_inexact_gc_tree+0x233/0x280  
net/xfrm/xfrm_policy.c:1066
Code: 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 d6 00 ae fa 0f b6 9d 2b ff ff  
ff 31 ff 89 de e8 96 01 ae fa 84 db 74 8c e8 bd 00 ae fa <0f> 0b eb 83 48  
8d 7d 98 e8 e0 00 f2 fa e9 d0 fe ff ff e8 36 00 f2
RSP: 0018:ffff88819c307108 EFLAGS: 00010293
RAX: ffff8881be8a82c0 RBX: 0000000000000001 RCX: ffffffff86d1f6ea
RDX: 0000000000000000 RSI: ffffffff86d1f6f3 RDI: 0000000000000001
RBP: ffff88819c3071f0 R08: ffff8881be8a82c0 R09: 0000000000000008
R10: 0000000000000e65 R11: ffff8881be8a82c0 R12: dffffc0000000000
R13: ffffed1033860e31 R14: ffff8881be45a330 R15: ffff8881bf82cdc8
  __xfrm_policy_inexact_prune_bin+0x123/0x420 net/xfrm/xfrm_policy.c:1079
  xfrm_policy_fini+0x473/0x650 net/xfrm/xfrm_policy.c:3887
  xfrm_net_exit+0x1d/0x70 net/xfrm/xfrm_policy.c:3928
  ops_exit_list.isra.5+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x555/0xb10 net/core/net_namespace.c:551
  process_one_work+0xc90/0x1c40 kernel/workqueue.c:2153
kobject: 'loop5' (00000000d2e25176): kobject_uevent_env
kobject: 'loop5' (00000000d2e25176): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  worker_thread+0x17f/0x1390 kernel/workqueue.c:2296
  kthread+0x35a/0x440 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
