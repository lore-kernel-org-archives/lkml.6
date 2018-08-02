Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F26C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59B4208DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulcmEJsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59B4208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeHBHGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 03:06:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46323 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeHBHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 03:06:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so585154pfn.13;
        Wed, 01 Aug 2018 22:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLlLk72lJLv56FhCDGbi1AQnEboRfjZnd6MpRmxNcIk=;
        b=ulcmEJsJkc9gd2IfZkyIqrmYIpNlPeIUjbiS11yMTmami+Q/UCyTlmq8qoZnXHzy4a
         c0/8pTdQlhRmEikk/HGGBI6QpiWyejuQkC3/BlcN7YYGAovtPIzGZnG+5l+1vU9gW7rr
         7Yh3jCsA7/tFAemw3xZ6PPPCtbYOhesBt3Hu2M2UzdrPc5Eu8Q4ZT7kuW5+4ptSAfnA6
         eRCf3R3j0sYxoiT+EBjWJBRUKIxQhTHYAWi228NTrC0i3QhZ8ZC0Vc2xb7cBqBmiotmp
         B937nBAw+zDDdIrRP/2LrUjpExbWC2c9wnw3Gb1avOLhWfxmhFst+8vBJT1/mtxe9GyH
         eNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLlLk72lJLv56FhCDGbi1AQnEboRfjZnd6MpRmxNcIk=;
        b=m6JwJy1qmK1aO9K0Fp4QpDmYFWgNzsUY0snztzrIYAxiAtOvLQddTWxH0S1Wcu60bU
         kxHjwzT0jVeEjUoih2tBf2eqR3P7Qyc0HeVEr76pQK4BU2T5yiHPJnzP1ZNSJXWC/d5Z
         VvfM32dCCnL2aLEIxXMp3ZTH2MF56dVbgBRPeGjz2CGH7l7hb08aS5sRU+7H4YbH7lZP
         vP/1uFEYTdVj73WSiHA0YTnYpg45yOHS1SwJ+SSOTee/jZF6bHWmzllqcvJxr6LrmlXW
         xPkniue7pZjiMgfSeeFPI3zirSkHKAA/ZOzp6HhFd2DVLmHbxgFWU203/XBLm2QnGvZ2
         bfiQ==
X-Gm-Message-State: AOUpUlE/GIcvT1DU/HbohH1MARsmKAcNmqNlyD6Rl+P6sTQieespYYJW
        qzBA1Ve8X6h6/7AwBLC5pa53Ef5tGpZfFgFzNywadQ==
X-Google-Smtp-Source: AAOMgpd9GtwXczFVdJCTVSE28aTuezAu4Gy2Ipz30Hx+T1rOMrlfmiPzHWR2O8o95wyEyJBT/YetI+06vrf0VTigrBA=
X-Received: by 2002:a65:5545:: with SMTP id t5-v6mr1237797pgr.157.1533187044841;
 Wed, 01 Aug 2018 22:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000004fe2be05724ac084@google.com> <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
 <20180731134014.GA32114@bistromath.localdomain> <CAM_iQpURKOMAaPfs9v7FzhqqQPzj71sQD2LS0eU8cuqTML-YoA@mail.gmail.com>
 <20180801081537.GA31982@bistromath.localdomain>
In-Reply-To: <20180801081537.GA31982@bistromath.localdomain>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 1 Aug 2018 22:23:42 -0700
Message-ID: <CAM_iQpUN=1-b13OfHcuahPGw6kDMBhFHAqu70NJ7UvmQreM6LQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        lucien xin <lucien.xin@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 1:15 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
>
> 2018-07-31, 16:03:13 -0700, Cong Wang wrote:
> > On Tue, Jul 31, 2018 at 6:41 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> > >
> > > 2018-07-31, 05:41:56 -0700, Eric Dumazet wrote:
> > > >
> > > >
> > > > On 07/31/2018 05:31 AM, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    61f4b23769f0 netlink: Don't shift with UB on nlk->ngroups
> > > > > git tree:       net
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14a9de58400000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=41f9c04b50ef70c66947
> > > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > [...]
> > >
> > > > Probably also caused by :
> > > >
> > > >
> > > > commit df18b50448fab1dff093731dfd0e25e77e1afcd1
> > > > Author: Sabrina Dubroca <sd@queasysnail.net>
> > > > Date:   Mon Jul 30 16:23:10 2018 +0200
> > > >
> > > >     net/ipv6: fix metrics leak
> > >
> > > Yeah, I'm looking into both those reports :/
> >
> > Looks like this commit is completely unnecessary,
> > fib6_drop_pcpu_from() calls fib6_info_release()
> > which calls fib6_info_destroy_rcu(), so this metrics
> > will be released twice...
>
> kmemleak disagrees:


This information is missing from changelog. :)


>
> unreferenced object 0xffff88006b605080 (size 96):
>   comm "ip", pid 433, jiffies 4294889793 (age 74.844s)
>   hex dump (first 32 bytes):
>     00 00 00 00 f4 01 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000002650e4e2>] ip6_route_info_create+0x770/0x4050
>     [<000000000a8d4c52>] ip6_route_add+0x18/0x90
>     [<00000000474d669c>] inet6_rtm_newroute+0xeb/0x100
>     [<0000000019fb732d>] rtnetlink_rcv_msg+0x3b5/0xb40
>     [<000000006f891e19>] netlink_rcv_skb+0x137/0x380
>     [<0000000070451985>] netlink_unicast+0x47f/0x6e0
>     [<000000004487d656>] netlink_sendmsg+0x7a7/0x10c0
>     [<0000000089fdf5ae>] sock_sendmsg+0xac/0x160
>     [<00000000aae19c54>] ___sys_sendmsg+0x6e0/0xbb0
>     [<00000000a3906352>] __sys_sendmsg+0xdc/0x230
>     [<00000000c7c8548a>] do_syscall_64+0x15d/0x740
>     [<000000007dfdad73>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<000000003adb705a>] 0xffffffffffffffff

My kernel dev machine is broken now.
I will take a look tomorrow after I fix my kernel dev machine.

Thanks!
