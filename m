Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B401C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221B22070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbeLSTt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:49:29 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:37630 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728468AbeLSTt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:49:28 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gZhqM-0002hu-9s; Wed, 19 Dec 2018 20:49:22 +0100
Date:   Wed, 19 Dec 2018 20:49:22 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+e1d3a7522b4d05aeede4@syzkaller.appspotmail.com>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: rcu detected stall in pfkey_sendmsg
Message-ID: <20181219194922.z6vyih2lmnjyetwd@breakpoint.cc>
References: <000000000000db57ce057d644c81@google.com>
 <CACT4Y+bqojrDW6J5TqJq0BFTuKLZTkxJk5rjT1ZxU==QXH1r4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bqojrDW6J5TqJq0BFTuKLZTkxJk5rjT1ZxU==QXH1r4w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Dec 19, 2018 at 7:37 PM syzbot
> <syzbot+e1d3a7522b4d05aeede4@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    a26d94bff4d5 net: bridge: remove unneeded variable 'err'
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14c7a4cd400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d9655b05acfc97ff
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e1d3a7522b4d05aeede4
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> 
> +Florian, this looks related to:
> INFO: rcu detected stall in xfrm_hash_rebuild
> https://syzkaller.appspot.com/bug?id=62ee9df6b17e143dcd22a6bc5383c1b4ba797c8c
> https://groups.google.com/forum/#!msg/syzkaller-bugs/4yD3ts-wWRA/63scKqSyDAAJ
> 
> Should we dup them?

No, not yet anyway.  First report triggers rcu stall during hash
rebuild, this looks like stall is directly on insertion.

(Could obviously still be same bug).
