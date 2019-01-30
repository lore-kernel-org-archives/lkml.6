Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B859C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B3820855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfA3OU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:20:58 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:34994 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfA3OU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:20:58 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1goqjS-000807-Lb; Wed, 30 Jan 2019 15:20:50 +0100
Date:   Wed, 30 Jan 2019 15:20:50 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Florian Westphal <fw@strlen.de>,
        syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in __xfrm_policy_bysel_ctx
Message-ID: <20190130142050.ilcccckfatn2zj6o@breakpoint.cc>
References: <0000000000007b129305809553da@google.com>
 <20190129094144.bln4dnirr5kz3dl4@breakpoint.cc>
 <CACT4Y+YB_icD2B6Bj6=5KjAvfamyCUeLnYHm5i5PQKO35=RMFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YB_icD2B6Bj6=5KjAvfamyCUeLnYHm5i5PQKO35=RMFA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> wrote:
> > syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com> wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    085c4c7dd2b6 net: lmc: remove -I. header search path
> > > git tree:       net-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=12347128c00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e6e1fe9148cffa18cf97
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > net-next doesn't contain the fixes for the rbtree fallout yet, so
> > this might already be fixed (fingers crossed).
> 
> Hi Florian,
> 
> What is that fix for the record?

I don't know.  I managed to add every bug class imagineable in that series 8-(

The last (most recent) fix from the 'fallout cleanup' is:
12750abad517a991c4568969bc748db302ab52cd
("xfrm: policy: fix infinite loop when merging src-nodes")

so if syzkaller can generate a splat with that change present
something is still broken.

> We will need to close this later. Or perhaps we can already mark this
> as fixed by that patch with "#syz fix:" command?

There are a lot of open xfrm related splats that could all be explained
by the rbtree bugs (one had a reproducer, the fix has appropriate
reported-by tag).

It would be great if there was a way to tell syzkaller to report those
again if they still appear.
I could pretend and claim above commit as "sys-fix", but it seems fishy.

Let me know and I can tag all of them.
