Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE70C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABE12152D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABE12152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeHTH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 03:28:03 -0400
Received: from mail-io0-f200.google.com ([209.85.223.200]:55381 "EHLO
        mail-io0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeHTH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 03:28:03 -0400
Received: by mail-io0-f200.google.com with SMTP id m2-v6so12296258ioc.22
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 21:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oH+aseHDMWzXo3yNdre7bSSt2F9yw1Dqiw306pqJm7Q=;
        b=TSD2tlcmPFVDcII3UEXL0UeAUbFUGvvyGBRtDYIdK8knnGM6MTvSs74sT/Z26iLl6y
         QN4zajXVq5WC9Ips7aV3KCPIILqqinFVWYreELSH0Gbkd9rZaJe2N6Y864gFm2CPOvzn
         hUkyz55WyRb+Gk41Bjavn5Qr8VWxDEqvXlAEn43lA5NqENRaztNThObml2kWfP6cWEvD
         iquUFXsZKB6UzJQJZaWSY0E4tk9xoy/2JuNNUqNbC4TzUH6R3HTW9YuUOcf4Z+TfzJPa
         HE014xxCwkiJttUqpeJppBFChLKDbdT4vTS0/jp+YtnAOxgcg2qMF8lbR9jxRVOuHejo
         ZsOA==
X-Gm-Message-State: AOUpUlEMd8MWcL0P0PIp8OY3f/p1/Lmt/WWwODHlG/1gSXD/GH/R3E5J
        ZBOqTYRiiRZymNDyajHAm+zeT4UyUnAgfMz7AoUPvIuf+UKl
X-Google-Smtp-Source: AA+uWPzaU5bxiTo/TAcLZ4Y1mKqapm8xPNDcmk51h3g1mmIIisd7O9ERsAiCyr3+LVm9n3ywVgulJSUkBiXXLhzlHUfl+9nCppcc
MIME-Version: 1.0
X-Received: by 2002:a02:5656:: with SMTP id o83-v6mr21817334jab.30.1534738443889;
 Sun, 19 Aug 2018 21:14:03 -0700 (PDT)
Date:   Sun, 19 Aug 2018 21:14:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5745b0573d62311@google.com>
Subject: WARNING in xfrm_policy_fini
From:   syzbot <syzbot+9bce6db6c82f06b85d8b@syzkaller.appspotmail.com>
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

HEAD commit:    3eb2ce825ea1 Linux 4.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1132989b800000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8addcf4530d93e53
dashboard link: https://syzkaller.appspot.com/bug?extid=9bce6db6c82f06b85d8b
compiler:       gcc (GCC) 7.1.1 20170620

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bce6db6c82f06b85d8b@syzkaller.appspotmail.com

bond0 (unregistering): Released all slaves
WARNING: CPU: 1 PID: 7312 at net/xfrm/xfrm_policy.c:2925  
xfrm_policy_fini+0x414/0x560 net/xfrm/xfrm_policy.c:2925
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 7312 Comm: kworker/u4:7 Not tainted 4.16.0-rc7+ #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:17 [inline]
  dump_stack+0x194/0x24d lib/dump_stack.c:53
  panic+0x1e4/0x41c kernel/panic.c:183
  __warn+0x1dc/0x200 kernel/panic.c:547
  report_bug+0x1f4/0x2b0 lib/bug.c:186
  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
  fixup_bug arch/x86/kernel/traps.c:247 [inline]
  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
  invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
RIP: 0010:xfrm_policy_fini+0x414/0x560 net/xfrm/xfrm_policy.c:2925
RSP: 0018:ffff8801b25d70d8 EFLAGS: 00010293
RAX: ffff8801b129c540 RBX: ffff8801b5608200 RCX: ffffffff8587ff74
RDX: 0000000000000000 RSI: 1ffff100362539c5 RDI: ffffffff87acabf8
RBP: ffff8801b25d7260 R08: 1ffff100364badd1 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff100364bae27
R13: ffff8801b25d7238 R14: ffff8801b56096f0 R15: ffff8801d71c5820
  xfrm_net_exit+0x1d/0x70 net/xfrm/xfrm_policy.c:2980
  ops_exit_list.isra.6+0xae/0x150 net/core/net_namespace.c:142
  cleanup_net+0x6a1/0xcb0 net/core/net_namespace.c:517
  process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
  worker_thread+0x223/0x1990 kernel/workqueue.c:2247
  kthread+0x33c/0x400 kernel/kthread.c:238
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406
Dumping ftrace buffer:
    (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
