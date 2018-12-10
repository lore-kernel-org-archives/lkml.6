Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A737C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB1A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDq/FZjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB1A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeLJPeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:34:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42607 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeLJPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:34:12 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so9029246ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7JPhw/aYjUVnqPXJgRHawHNXPrwCYPKTju6u1T1d2C0=;
        b=VDq/FZjKn5TDl/por4Wo9uklawxXsXJRJ5Tqx66yywPwbDMOm1/WJTvvYZD3qxEZo5
         VoS7nEg524jpVRIS7kWHxci9gKGxUdCpG3nIQ1IYWUkJr5yLPd0n/itLbly3ebaFnjGT
         sdupuXCudZjJ+1gd4S2P9QiGWa/4nfT0h6JijVq9pibf5FZe1pnIkLalR3Z/MCkcC3gN
         wjl3MiyLA40xfss2kP1wD45pXloan0CybsXfLvkI319DWFeqgtTvYaUlH7pc11uDS1iL
         cZizKavxLjydvNraYOirYq1wts1Be33CuMI0PIe28VCTKLziMOMAggGTi/o7AukdEv+w
         IY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7JPhw/aYjUVnqPXJgRHawHNXPrwCYPKTju6u1T1d2C0=;
        b=SEjCMLF++tVzihOMlcP27XC0FfKwmKSeGXWMAtJJMLDH/CzRuiEspIKhSLZKclgV6U
         l9yOO66e6W/TSgbSWAG0ME+c9p1Pq60ClbRdKF4I6dfTy3cUU1GOGTCVCNkuTLIIiI8E
         JsBPFrvTjDM9zJFtNr51n8bfWq6q0ZGhHw7Nna06nG5R2NFfx+xSTbRxH4egshxuJLPx
         JsJI6K7uHNDJ/I64Toud5YHkPafzokg2AMqvUxp3VFaBSIMpsaJ1lE4Ij/cIa/uZ8FMn
         3GF1nMJoDwEAMXT3/goPifeAPtagNvs0lqlJY7dkej0O2Xt5eE03+giKo5AzL0HMq9tT
         +XjA==
X-Gm-Message-State: AA+aEWb4TCmpOe8gdmM90y/rseJjRH7bbMs7kiTaOSvcfIkADoyP1fH/
        BRpLWJ01Da5ax48PgfIX7i8Y5ElbUUbyEbYFU3k33w==
X-Google-Smtp-Source: AFSGD/X+hqUJIHrSjv+56IuiztxLHvHaHJP78M8PHSqtDbldqKMqcGoVMJCbH4n/Dd7v6mAu9eZjkN3O0GxMlzHBj68=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr8587958ior.282.1544456050875;
 Mon, 10 Dec 2018 07:34:10 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 10 Dec 2018 16:33:59 +0100
Message-ID: <CACT4Y+bouzCy+=Pcfp1MKj4bED9S8jcG9wQiYCFb22gfw3HozQ@mail.gmail.com>
Subject: tipc: NULL deref in tipc_net_finalize
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following program crashes upstream kernel on
40e020c129cfc991e8ab4736d2665351ffd1468d (Dec 9) with:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 1 PID: 45 Comm: kworker/1:1 Not tainted 4.20.0-rc6 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
Workqueue: events tipc_net_finalize_work
RIP: 0010:rht_bucket_nested+0x31/0x90 lib/rhashtable.c:1190
Code: 89 f3 e8 32 84 ca ff 8b 4d 04 b8 01 00 00 00 48 8b 95 80 00 00
00 44 8b 65 00 d3 e0 83 e8 01 41 d3 ec 21 d8 d3 eb 48 8d 04 c2 <48> 8b
28 48 85 ed 75 22 eb 29 e8 00 84 ca ff 89 d8 41 c1 ec 09 c1
RSP: 0018:ffffb1bd8045fd68 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffff9f0e
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9f0efa5433e0
RBP: ffff9f0efa5433e0 R08: 00000006c423ea71 R09: 0000000000000027
R10: ffffb1bd80377df8 R11: fefefefefefefeff R12: 000000000003e951
R13: ffffb1bd8045fdf0 R14: 0000000000000000 R15: ffff9f0efa5433e0
FS:  0000000000000000(0000) GS:ffff9f0efda80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000001 CR3: 0000000015e0a002 CR4: 0000000000160ee0
Call Trace:
 rht_bucket include/linux/rhashtable.h:280 [inline]
 __rhashtable_walk_find_next+0x1af/0x1e0 lib/rhashtable.c:801
 rhashtable_walk_next+0x56/0xf0 lib/rhashtable.c:885
 tipc_sk_reinit+0xaa/0x120 net/tipc/socket.c:2726
 tipc_net_finalize.part.4+0x26/0x50 net/tipc/net.c:138
 tipc_net_finalize net/tipc/net.c:134 [inline]
 tipc_net_finalize_work+0x3f/0x50 net/tipc/net.c:148
 process_one_work+0x290/0x540 kernel/workqueue.c:2153
 worker_thread+0x39/0x500 kernel/workqueue.c:2296
 kthread+0x12c/0x150 kernel/kthread.c:246
 ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: 0000000000000001
---[ end trace 49f6dae32389e817 ]---
RIP: 0010:rht_bucket_nested+0x31/0x90 lib/rhashtable.c:1190
Code: 89 f3 e8 32 84 ca ff 8b 4d 04 b8 01 00 00 00 48 8b 95 80 00 00
00 44 8b 65 00 d3 e0 83 e8 01 41 d3 ec 21 d8 d3 eb 48 8d 04 c2 <48> 8b
28 48 85 ed 75 22 eb 29 e8 00 84 ca ff 89 d8 41 c1 ec 09 c1
RSP: 0018:ffffb1bd8045fd68 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffff9f0e
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9f0efa5433e0
RBP: ffff9f0efa5433e0 R08: 00000006c423ea71 R09: 0000000000000027
R10: ffffb1bd80377df8 R11: fefefefefefefeff R12: 000000000003e951
R13: ffffb1bd8045fdf0 R14: 0000000000000000 R15: ffff9f0efa5433e0
FS:  0000000000000000(0000) GS:ffff9f0efda80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000001 CR3: 0000000015e0a002 CR4: 0000000000160ee0

Kernel config (nothing special: mostly defconfig+enabled tipc):
https://gist.githubusercontent.com/dvyukov/b67e6428ecc170b090b9f65eec784e5a/raw/b77b0f3e86d702f868ab7511d04ca307180f3abc/gistfile1.txt

Reproducer program:
https://gist.github.com/dvyukov/9d9d9f2f87b05766323e3a97e07b5af8

There is a bunch of boilerplate to enable namespaces and net devices,
etc, but in a nutshell it  basically does only TIPC_NL_BEARER_ENABLE:

r0 = socket$nl_generic(0x10, 0x3, 0x10)
r1 = syz_genetlink_get_family_id$tipc2(&(0x7f0000000000)='TIPCv2\x00')
sendmsg$TIPC_NL_BEARER_ENABLE(r0, &(0x7f0000000080)={0x0, 0x0,
&(0x7f00000000c0)={&(0x7f0000000100)={0x54, r1, 0x1, 0x123, 0x234, {},
[@TIPC_NLA_BEARER={0x40, 0x1, [@TIPC_NLA_BEARER_NAME={0x10, 0x1,
@udp='udp:syz0\x00'}, @TIPC_NLA_BEARER_UDP_OPTS={0x2c, 0x4, {{0x14,
0x1, @in={0x2, 0x4e20, @loopback}}, {0x14, 0x2, @in={0x2, 0x4e20,
@loopback}}}}]}]}, 0x54}}, 0x0)

This makes overall tipc testing a bit problematic as kernel always
crashes whenever syzkaller tries to do just anything with udp bearer,
so I would appreciate timely fix.

Thanks
