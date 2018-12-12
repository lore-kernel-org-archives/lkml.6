Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F06C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4282084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6wggmej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4282084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeLLKpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:45:11 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46595 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeLLKpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:45:08 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so14391609ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=UAnmZqgCGROGw/X4+tPzbVUwwhlfk3KcEeALOLW20k0=;
        b=O6wggmejpO1i7kDVmNwMAcdBV8huOtGLSC3wspromwcT4W2eyhvI/KypDHijoIU9lL
         Io4v70gGS6Mk2c4gWcapOjXKsIwNTSlTrDw6hKfYF970Lf9YRIpcRuHLBRxClyEkIOuk
         iRW/gP1PgkPFk8gvQX5VcsRkx86fkqCFXUSuqPtGeMe6wlB0+sE08Rlpn3kd6bqboCTh
         IQiHCGJGEcOA0N/wzTvxBI7FVLOxfNNKQVUbK3PAqkySgB7N8U1Id6jSXsHP98xn0o9z
         lr5SwSysG6Q6ZepxkFD8wvStO4j+bF+2C9wGeIMIyZd9zk3Clnu/xrNQsqhzi775DNtw
         S4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UAnmZqgCGROGw/X4+tPzbVUwwhlfk3KcEeALOLW20k0=;
        b=ffKZ8TN8YPdCfvWmxUUYWRDblQfUiBdqKDeWL3Nx1qzdCqd+6RxBGOCQjnPGzwbvui
         tL75ULym0HrLXNFQv9MKUP2OjllrNlmOiVdblti1g2wjFJ9fZhzoFQ7DzJQqlz+iL8G2
         qEXAO7zIInGUarkok8CRZwhu/jOzJA88dtMebL2ShkKGJYKZ09H3kYXd0ip6XYttoyUq
         Y8kBwnM8wjGaEphkWU61/tkzd+FtNePvll/EX0nxhtA2oTxdkpDjZmTuQ/9cNMiuAR/t
         ZDpQ2Co4fP1W7J7pUp0wdVFyc9lk2cCmcMBQx8j7nh8Qx1+j1lAWuAlsci78TSyv2MFp
         yaUg==
X-Gm-Message-State: AA+aEWbuQQxraKPsuuTK0HM5RcV2ZbnvwjOMipRq6S1ZYb2LHBmL6Vs6
        PUa0yQBIhN8hitI54Lwpo6bh/Qduswzs/yEZbFHYhQ==
X-Google-Smtp-Source: AFSGD/WGBW4v9EehNiiC+fQ2BQYeul6Pyd9k8K3P8OT+cnkWsnM39ZT+FGZSadCRsD2pZb6fhYPWSsUcjzbuwHTRuos=
X-Received: by 2002:a6b:fa0e:: with SMTP id p14mr13540864ioh.271.1544611506395;
 Wed, 12 Dec 2018 02:45:06 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bouzCy+=Pcfp1MKj4bED9S8jcG9wQiYCFb22gfw3HozQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bouzCy+=Pcfp1MKj4bED9S8jcG9wQiYCFb22gfw3HozQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Dec 2018 11:44:55 +0100
Message-ID: <CACT4Y+YSEF6ZEDCJ=NyF+su5dYZr3xJL-1TK4R+NMLK_d_1zjg@mail.gmail.com>
Subject: Re: tipc: NULL deref in tipc_net_finalize
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        tipc-discussion@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 4:33 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Hello,
>
> The following program crashes upstream kernel on
> 40e020c129cfc991e8ab4736d2665351ffd1468d (Dec 9) with:
>
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP PTI
> CPU: 1 PID: 45 Comm: kworker/1:1 Not tainted 4.20.0-rc6 #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Workqueue: events tipc_net_finalize_work
> RIP: 0010:rht_bucket_nested+0x31/0x90 lib/rhashtable.c:1190
> Code: 89 f3 e8 32 84 ca ff 8b 4d 04 b8 01 00 00 00 48 8b 95 80 00 00
> 00 44 8b 65 00 d3 e0 83 e8 01 41 d3 ec 21 d8 d3 eb 48 8d 04 c2 <48> 8b
> 28 48 85 ed 75 22 eb 29 e8 00 84 ca ff 89 d8 41 c1 ec 09 c1
> RSP: 0018:ffffb1bd8045fd68 EFLAGS: 00010246
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffff9f0e
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9f0efa5433e0
> RBP: ffff9f0efa5433e0 R08: 00000006c423ea71 R09: 0000000000000027
> R10: ffffb1bd80377df8 R11: fefefefefefefeff R12: 000000000003e951
> R13: ffffb1bd8045fdf0 R14: 0000000000000000 R15: ffff9f0efa5433e0
> FS:  0000000000000000(0000) GS:ffff9f0efda80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000001 CR3: 0000000015e0a002 CR4: 0000000000160ee0
> Call Trace:
>  rht_bucket include/linux/rhashtable.h:280 [inline]
>  __rhashtable_walk_find_next+0x1af/0x1e0 lib/rhashtable.c:801
>  rhashtable_walk_next+0x56/0xf0 lib/rhashtable.c:885
>  tipc_sk_reinit+0xaa/0x120 net/tipc/socket.c:2726
>  tipc_net_finalize.part.4+0x26/0x50 net/tipc/net.c:138
>  tipc_net_finalize net/tipc/net.c:134 [inline]
>  tipc_net_finalize_work+0x3f/0x50 net/tipc/net.c:148
>  process_one_work+0x290/0x540 kernel/workqueue.c:2153
>  worker_thread+0x39/0x500 kernel/workqueue.c:2296
>  kthread+0x12c/0x150 kernel/kthread.c:246
>  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:352
> Modules linked in:
> CR2: 0000000000000001
> ---[ end trace 49f6dae32389e817 ]---
> RIP: 0010:rht_bucket_nested+0x31/0x90 lib/rhashtable.c:1190
> Code: 89 f3 e8 32 84 ca ff 8b 4d 04 b8 01 00 00 00 48 8b 95 80 00 00
> 00 44 8b 65 00 d3 e0 83 e8 01 41 d3 ec 21 d8 d3 eb 48 8d 04 c2 <48> 8b
> 28 48 85 ed 75 22 eb 29 e8 00 84 ca ff 89 d8 41 c1 ec 09 c1
> RSP: 0018:ffffb1bd8045fd68 EFLAGS: 00010246
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00000000ffff9f0e
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9f0efa5433e0
> RBP: ffff9f0efa5433e0 R08: 00000006c423ea71 R09: 0000000000000027
> R10: ffffb1bd80377df8 R11: fefefefefefefeff R12: 000000000003e951
> R13: ffffb1bd8045fdf0 R14: 0000000000000000 R15: ffff9f0efa5433e0
> FS:  0000000000000000(0000) GS:ffff9f0efda80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000001 CR3: 0000000015e0a002 CR4: 0000000000160ee0
>
> Kernel config (nothing special: mostly defconfig+enabled tipc):
> https://gist.githubusercontent.com/dvyukov/b67e6428ecc170b090b9f65eec784e5a/raw/b77b0f3e86d702f868ab7511d04ca307180f3abc/gistfile1.txt
>
> Reproducer program:
> https://gist.github.com/dvyukov/9d9d9f2f87b05766323e3a97e07b5af8
>
> There is a bunch of boilerplate to enable namespaces and net devices,
> etc, but in a nutshell it  basically does only TIPC_NL_BEARER_ENABLE:
>
> r0 = socket$nl_generic(0x10, 0x3, 0x10)
> r1 = syz_genetlink_get_family_id$tipc2(&(0x7f0000000000)='TIPCv2\x00')
> sendmsg$TIPC_NL_BEARER_ENABLE(r0, &(0x7f0000000080)={0x0, 0x0,
> &(0x7f00000000c0)={&(0x7f0000000100)={0x54, r1, 0x1, 0x123, 0x234, {},
> [@TIPC_NLA_BEARER={0x40, 0x1, [@TIPC_NLA_BEARER_NAME={0x10, 0x1,
> @udp='udp:syz0\x00'}, @TIPC_NLA_BEARER_UDP_OPTS={0x2c, 0x4, {{0x14,
> 0x1, @in={0x2, 0x4e20, @loopback}}, {0x14, 0x2, @in={0x2, 0x4e20,
> @loopback}}}}]}]}, 0x54}}, 0x0)
>
> This makes overall tipc testing a bit problematic as kernel always
> crashes whenever syzkaller tries to do just anything with udp bearer,
> so I would appreciate timely fix.
>
> Thanks

FTR, this is fixed by Cong with "tipc: use lock_sock() in tipc_sk_reinit()"
https://www.spinics.net/lists/netdev/msg538775.html
