Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3642087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3642087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbeGLVq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:46:29 -0400
Received: from mail-it0-f70.google.com ([209.85.214.70]:42087 "EHLO
        mail-it0-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733113AbeGLVq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:46:28 -0400
Received: by mail-it0-f70.google.com with SMTP id p21-v6so5739848itc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 14:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hpVTDGTQG9iUEzS/1EQYqCrQiekgOZud5Tg3I1m2qyM=;
        b=mxyBjlkQ4fZAa6OHMbDoXi/GZ0gt738GIUN8XTF1BwBdNCtUjoSYWNvHYpg9MRUu6C
         lC2CN+W9WuKnXzN4McTPwmhi0gnN51qkJxqZXbhBwHyTP9sc5QDj/FboBAfTYUGQLVBT
         c3K2GLVJJmDnn8FfCXY6gMSg9aHJWob3iQ165/jEA0RlO54Zn8ykHCRP040ai577fhdG
         dgCjZO44RxsTdzvdadQ/b6y3fG0XDej+m6eDqpoKmp3CZFMlofOtZEo+HJbqgBDKHngO
         8Mhl3Bzjloc3BhwnjN3pHQTWFOJIxE8GB1DmBW3pDJb0sF2wMvaWySAc5ctusPOkVNo6
         2baA==
X-Gm-Message-State: AOUpUlGnSER+dGDWmaS6obBJkiWuO/gp7D7097ogkzu8aPvaPYKvwYPX
        MbKZTphIvaaFe5AMo7THiyGuK51gBlLiPQuTp9qisLdZsqeU
X-Google-Smtp-Source: AAOMgpcjeY4WlgcfD/MH4gk201Dnq+kDPU0pFU/hZbPmOiV8KUbyBOoFUHJ/Z3rZpvYpLCHbn4+z8iqTQ1hpa0CLwRSLCBSk7MUR
MIME-Version: 1.0
X-Received: by 2002:a24:b310:: with SMTP id e16-v6mr1530183itf.50.1531431302163;
 Thu, 12 Jul 2018 14:35:02 -0700 (PDT)
Date:   Thu, 12 Jul 2018 14:35:02 -0700
In-Reply-To: <000000000000798298056e76cbbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c37ca80570d422f7@google.com>
Subject: Re: BUG: MAX_LOCK_DEPTH too low! (2)
From:   syzbot <syzbot+802a5abb8abae86eb6de@syzkaller.appspotmail.com>
To:     davem@davemloft.net, e@erig.me, edumazet@google.com,
        jbenc@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pshelar@ovn.org,
        syzkaller-bugs@googlegroups.com, yi.y.yang@intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    6e6fddc78323 bpf: fix panic due to oob in bpf_prog_test_ru..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1364db94400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca6c7a31d407f86
dashboard link: https://syzkaller.appspot.com/bug?extid=802a5abb8abae86eb6de
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=11572794400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16aff568400000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+802a5abb8abae86eb6de@syzkaller.appspotmail.com

IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
IPv6: ADDRCONF(NETDEV_UP): veth1: link is not ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
8021q: adding VLAN 0 to HW filter on device team0
BUG: MAX_LOCK_DEPTH too low!
turning off the locking correctness validator.
depth: 48  max: 48!
48 locks held by syz-executor169/4820:
  #0: (____ptrval____) (rcu_read_lock_bh){....}, at:  
__dev_queue_xmit+0x328/0x3910 net/core/dev.c:3503
  #1: (____ptrval____) (&(&sch->seqlock)->rlock){+...}, at: spin_trylock  
include/linux/spinlock.h:320 [inline]
  #1: (____ptrval____) (&(&sch->seqlock)->rlock){+...}, at: qdisc_run_begin  
include/net/sch_generic.h:124 [inline]
  #1: (____ptrval____) (&(&sch->seqlock)->rlock){+...}, at: qdisc_run  
include/net/pkt_sched.h:117 [inline]
  #1: (____ptrval____) (&(&sch->seqlock)->rlock){+...}, at: __dev_xmit_skb  
net/core/dev.c:3229 [inline]
  #1: (____ptrval____) (&(&sch->seqlock)->rlock){+...}, at:  
__dev_queue_xmit+0x13a3/0x3910 net/core/dev.c:3537
  #2: (____ptrval____) (dev->qdisc_running_key ?: &qdisc_running_key){+...},  
at: dev_queue_xmit+0x17/0x20 net/core/dev.c:3602
  #3: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #3: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #4: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #4: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #5: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #5: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #6: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #6: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #7: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #7: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #8: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #8: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #9: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #9: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #10: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #10: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #11: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #11: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #12: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #12: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #13: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #13: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #14: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #14: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #15: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #15: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #16: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #16: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #17: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #17: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #18: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #18: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #19: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #19: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #20: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #20: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #21: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #21: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #22: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #22: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #23: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #23: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #24: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #24: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #25: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #25: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #26: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #26: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #27: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #27: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #28: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #28: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #29: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #29: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #30: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #30: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #31: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #31: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #32: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #32: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #33: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #33: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #34: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #34: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #35: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #35: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #36: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #36: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #37: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #37: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #38: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #38: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #39: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #39: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #40: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #40: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #41: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #41: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #42: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #42: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #43: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #43: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #44: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #44: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #45: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #45: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #46: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #46: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
  #47: (____ptrval____) (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2080 [inline]
  #47: (____ptrval____) (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x229/0x740 net/core/dev.c:2787
INFO: lockdep is turned off.
CPU: 0 PID: 4820 Comm: syz-executor169 Not tainted 4.18.0-rc3+ #8
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
  __lock_acquire+0x175d/0x5020 kernel/locking/lockdep.c:3453
  lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
  rcu_lock_acquire include/linux/rcupdate.h:245 [inline]
  rcu_read_lock include/linux/rcupdate.h:631 [inline]
  skb_mac_gso_segment+0x263/0x740 net/core/dev.c:2789
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3b5/0x740 net/core/dev.c:2792
  __skb_gso_segment+0x3c3/0x880 net/core/dev.c:2865
  skb_gso_segment include/linux/netdevice.h:4099 [inline]
  validate_xmit_skb+0x640/0xf30 net/core/dev.c:3104
  validate_xmit_skb_list+0xbf/0x120 net/core/dev.c:3154
  sch_direct_xmit+0x30e/0x1140 net/sched/sch_generic.c:312
  qdisc_restart net/sched/sch_generic.c:390 [inline]
  __qdisc_run+0x619/0x19f0 net/sched/sch_generic.c:398
  qdisc_run include/net/pkt_sched.h:118 [inline]
  __dev_xmit_skb net/core/dev.c:3229 [inline]
  __dev_queue_xmit+0x1419/0x3910 net/core/dev.c:3537
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3602
  packet_snd net/packet/af_packet.c:2919 [inline]
  packet_sendmsg+0x428e/0x6130 net/packet/af_packet.c:2944
  sock_sendmsg_nosec net/socket.c:641 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:651
  ___sys_sendmsg+0x7fd/0x930 net/socket.c:2125
  __sys_sendmsg+0x11d/0x290 net/socket.c:2163
  __do_sys_sendmsg net/socket.c:2172 [inline]
  __se_sys_sendmsg net/socket.c:2170 [inline]
  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2170
  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a99
Code: e8 9c bb 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f18672ffdb8 EFLAGS: 00000297 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000006dcc24 RCX: 0000000000446a99
RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000004
RBP: 00000000006dcc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000297 R12: 0000000000000000
R13: 00007ffcf80e967f R14: 00007f18673009c0 R15: 0000000000000007
==================================================================
------------[ cut here ]------------
BUG: KASAN: stack-out-of-bounds in lookup_object lib/debugobjects.c:157  
[inline]
BUG: KASAN: stack-out-of-bounds in debug_object_deactivate+0x425/0x450  
lib/debugobjects.c:540
ODEBUG: deactivate not available (active state 0) object type: hrtimer  
hint: tick_sched_timer+0x0/0x130 kernel/time/tick-sched.c:66
Read of size 8 at addr ffff8801d770f830 by task syz-executor169/4820
WARNING: CPU: 1 PID: 0 at lib/debugobjects.c:329  
debug_print_object+0x16a/0x210 lib/debugobjects.c:326


