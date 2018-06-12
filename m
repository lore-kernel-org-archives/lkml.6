Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5C118C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F273820891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F273820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbeFLTXE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:23:04 -0400
Received: from mail-it0-f72.google.com ([209.85.214.72]:41616 "EHLO
        mail-it0-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932463AbeFLTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:23:03 -0400
Received: by mail-it0-f72.google.com with SMTP id m12-v6so432532ita.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 12:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=tjF1zRKJlfvxeNRLmUvs63rTMD+Mr8L4D+QFcXS8o/Q=;
        b=pwQZJWco6BXUH+Q6l9hPPR8jg31kfHruiUr90VT1jZSWAUtzEPaMqO3IVgQ0OUMpdK
         39bkXB5pATIu3hLxPX4ZCstDavt46v/jXfSMyGTV0mI217Ax7zX/+cv6moe8xtWIy/TF
         jpQdzsdKBQCmFZ8Yj0oyyF20CGHMtDlOsgl5eIODuYqhtLzTfXF1V9q/hzeMuL9voGvS
         MqraVfq1ndNdxHnUQa0oq4YIkdsSrTSsbZpqjNvhF3MHeDmJ6CuMYLNl1LB4mTfk69A1
         Lj6KdNvhRfpVLWSO/y9JJp/wXHW28wFkIMZnUwJJEKlM0Q5W1Df1OILLy2uABDF5oUXK
         BMrA==
X-Gm-Message-State: APt69E1SIIkEj0Dl3rr0HdcVFEiiAUz6Prczk8p3mlpV156u+EmxdKMS
        W0yEaKOUHOaQ6Qr67Nk5HMx5BjE1f0l3taEwMJsxP8chQUiu
X-Google-Smtp-Source: ADUXVKLkEQZJfFFt2wK4bJjA753eds7I2z1WYPYRDsCdMfrduCmzzBy+XjDeQii1J0aResjvPABAEa4CtM8Ed9xV2Rf11GO5jCS7
MIME-Version: 1.0
X-Received: by 2002:a24:2201:: with SMTP id o1-v6mr737719ito.12.1528831382483;
 Tue, 12 Jun 2018 12:23:02 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:23:02 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000798298056e76cbbb@google.com>
Subject: BUG: MAX_LOCK_DEPTH too low! (2)
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

Hello,

syzbot found the following crash on:

HEAD commit:    ae40832e53c3 bpfilter: fix a build err
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17094ed7800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7db1a87249322f90
dashboard link: https://syzkaller.appspot.com/bug?extid=802a5abb8abae86eb6de
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+802a5abb8abae86eb6de@syzkaller.appspotmail.com

BUG: MAX_LOCK_DEPTH too low!
turning off the locking correctness validator.
depth: 48  max: 48!
48 locks held by syz-executor6/30643:
  #0: 00000000ac2541d7 (rcu_read_lock_bh){....}, at:  
__dev_queue_xmit+0x323/0x3900 net/core/dev.c:3521
  #1: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #1: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #2: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #2: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #3: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #3: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #4: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #4: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #5: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #5: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #6: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #6: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #7: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #7: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #8: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #8: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #9: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #9: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
  #10: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #10: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #11: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #11: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #12: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #12: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #13: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #13: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #14: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #14: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #15: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #15: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #16: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #16: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
netlink: 8 bytes leftover after parsing attributes in process  
`syz-executor5'.
  #17: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #17: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #18: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #18: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #19: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #19: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #20: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #20: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #21: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #21: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #22: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #22: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #23: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #23: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #24: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #24: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #25: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #25: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #26: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #26: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #27: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #27: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #28: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #28: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #29: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #29: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #30: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #30: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #31: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #31: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #32: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #32: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #33: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #33: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #34: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #34: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #35: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #35: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #36: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #36: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #37: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #37: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #38: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #38: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #39: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #39: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #40: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #40: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #41: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #41: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #42: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #42: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #43: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #43: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #44: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #44: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #45: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #45: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #46: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #46: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
  #47: 00000000c22902c0 (rcu_read_lock){....}, at: __skb_pull  
include/linux/skbuff.h:2082 [inline]
  #47: 00000000c22902c0 (rcu_read_lock){....}, at:  
skb_mac_gso_segment+0x221/0x720 net/core/dev.c:2787
INFO: lockdep is turned off.
CPU: 1 PID: 30643 Comm: syz-executor6 Not tainted 4.17.0-rc6+ #68
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1b9/0x294 lib/dump_stack.c:113
  __lock_acquire+0x1788/0x5140 kernel/locking/lockdep.c:3449
  lock_acquire+0x1dc/0x520 kernel/locking/lockdep.c:3920
  rcu_lock_acquire include/linux/rcupdate.h:246 [inline]
  rcu_read_lock include/linux/rcupdate.h:632 [inline]
  skb_mac_gso_segment+0x25b/0x720 net/core/dev.c:2789
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  nsh_gso_segment+0x470/0xb40 net/nsh/nsh.c:111
  skb_mac_gso_segment+0x3ad/0x720 net/core/dev.c:2792
  __skb_gso_segment+0x3bb/0x870 net/core/dev.c:2865
  skb_gso_segment include/linux/netdevice.h:4072 [inline]
  validate_xmit_skb+0x54d/0xd90 net/core/dev.c:3122
  __dev_queue_xmit+0xc0c/0x3900 net/core/dev.c:3579
  dev_queue_xmit+0x17/0x20 net/core/dev.c:3620
  packet_snd net/packet/af_packet.c:2921 [inline]
  packet_sendmsg+0x4275/0x6100 net/packet/af_packet.c:2946
  sock_sendmsg_nosec net/socket.c:629 [inline]
  sock_sendmsg+0xd5/0x120 net/socket.c:639
  __sys_sendto+0x3d7/0x670 net/socket.c:1789
  __do_sys_sendto net/socket.c:1801 [inline]
  __se_sys_sendto net/socket.c:1797 [inline]
  __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1797
  do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455a09
RSP: 002b:00007f125b3edc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f125b3ee6d4 RCX: 0000000000455a09
RDX: 0000000000000176 RSI: 00000000200000c0 RDI: 0000000000000013
RBP: 000000000072bea0 R08: 0000000020000080 R09: 000000000000001c
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000005d8 R14: 00000000006fdce0 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 30643 Comm: syz-executor6 Not tainted 4.17.0-rc6+ #68
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:skb_reset_network_header include/linux/skbuff.h:2306 [inline]
RIP: 0010:nsh_gso_segment+0x3a/0xb40 net/nsh/nsh.c:87
RSP: 0018:ffff8801aa585f98 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffffffff897e00e0 RCX: 1fecbfffffde10cc
RDX: ffffed00354b0c22 RSI: ffffffff876a7afd RDI: ff65fffffef0858b
RBP: ffff8801aa586020 R08: ffff880198924600 R09: 0000000000000000
R10: fffffbfff12ea1dc R11: ffff880198924600 R12: ff65fffffef0858b
R13: dffffc0000000000 R14: 0000000000004f89 R15: 0000000000004f89
FS:  00007f125b3ee700(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200002c0 CR3: 00000001d8346000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Code:
------------[ cut here ]------------
kasan: GPF could be caused by NULL-ptr deref or user memory access
Bad or missing usercopy whitelist? Kernel memory overwrite attempt detected  
to SLAB object 'vm_area_struct' (offset 119, size 1)!
WARNING: CPU: 1 PID: 30643 at mm/usercopy.c:81 usercopy_warn+0xf5/0x120  
mm/usercopy.c:76


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
