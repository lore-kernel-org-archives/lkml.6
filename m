Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B924C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B45218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhJgtecZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfAaIuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:50:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33678 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAaIuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:50:07 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so1816376itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HexTHriba6dZyN6f7xPeWIlL9InO+C1p4EnY9y0DCeY=;
        b=dhJgtecZuLbWAXihS5vPg2E1D0HormWQdXoEQ6Cs4hWS8TG574jMBvnwYCmnOSuVJ2
         LOTf4jhIgl+o4NItTuZHBQsVoJ3htghIE2LJ8Sziy6ACrIIxDKHq9onJCi64UGHHyKaH
         5TSPqNf69H2HLBy51zTGiyb/cB1P63TYCqRD6sJr4sjDFRn/034mmnYZJd9uHIYraqOG
         Bj7amDiuo6Eya3zD6xPehZYFb6qtLt3IiCttxR0MOzluEd1MM7H/as482zdnCOexq9lp
         t5CfbHkaMq148x15mn2BobCaoeL7EkZ1WE7pp6bhZ7FdDny8s7oOjBSXNX1JmkAh8vWT
         N8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HexTHriba6dZyN6f7xPeWIlL9InO+C1p4EnY9y0DCeY=;
        b=PUrwcjDVUYLZkJ8dQzKVEejnEJF1gspf6Z/eIoe8C+MrolXanHZ1XuhJILZ/wNIOJi
         xPyC5K91sEPF90sa7D8SUCW/p9hjRMbxZNqTxxPUVT2qV1wfnQ9K0n+tXaTo0/yeG6bZ
         He6EtBKwMFs9kbgVwwU0mOvrhC++QmyVrrws0+DclmvoCTPx3OOcHl1OPQZlSOvverQu
         Gzpoan+DSf+ePK3jA+QZyV9SLB84XzEtAk5PPInIRB55bNVjVtS+osEOW+9uwcd5tsOA
         ZgvREM9yhkou1uFttmDlmXj0NB8B2RMQ2aE6uhyy3lJJLXg8u6Vewm2QpSH1WoE6wWIt
         +jJA==
X-Gm-Message-State: AJcUukfSqTO613DqZolotQE+1OQgijL/+hwGaQUWN50keWr/k9rX0ftP
        42dKEjgP/YK5zzRqNo2mFqJfwYyOcWIVnOdd5aR8wA==
X-Google-Smtp-Source: ALg8bN7Wxx02SI2XL9kKVMpe++/i2yRDO5pi/BY2lRrTshMqyd5QcV6SkfaGNexrogjeDVPfy3SDftSZn7CqYG124BE=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr20379830jaj.82.1548924604839;
 Thu, 31 Jan 2019 00:50:04 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007b129305809553da@google.com> <20190129094144.bln4dnirr5kz3dl4@breakpoint.cc>
 <CACT4Y+YB_icD2B6Bj6=5KjAvfamyCUeLnYHm5i5PQKO35=RMFA@mail.gmail.com>
 <20190130142050.ilcccckfatn2zj6o@breakpoint.cc> <CACT4Y+ZWafAqKCt0ubJREcuHx4EiKhNKL0X-et_Y9YZBr8adbg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZWafAqKCt0ubJREcuHx4EiKhNKL0X-et_Y9YZBr8adbg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 31 Jan 2019 09:49:53 +0100
Message-ID: <CACT4Y+Zh6zYe1+R=PiZdfOBB5Kmxhw-0AOrHakCxpLg8traYZg@mail.gmail.com>
Subject: Re: general protection fault in __xfrm_policy_bysel_ctx
To:     Florian Westphal <fw@strlen.de>
Cc:     syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 3:30 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jan 30, 2019 at 3:20 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com> wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    085c4c7dd2b6 net: lmc: remove -I. header search path
> > > > > git tree:       net-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12347128c00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e6e1fe9148cffa18cf97
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > net-next doesn't contain the fixes for the rbtree fallout yet, so
> > > > this might already be fixed (fingers crossed).
> > >
> > > Hi Florian,
> > >
> > > What is that fix for the record?
> >
> > I don't know.  I managed to add every bug class imagineable in that series 8-(
> >
> > The last (most recent) fix from the 'fallout cleanup' is:
> > 12750abad517a991c4568969bc748db302ab52cd
> > ("xfrm: policy: fix infinite loop when merging src-nodes")
> >
> > so if syzkaller can generate a splat with that change present
> > something is still broken.
> >
> > > We will need to close this later. Or perhaps we can already mark this
> > > as fixed by that patch with "#syz fix:" command?
> >
> > There are a lot of open xfrm related splats that could all be explained
> > by the rbtree bugs (one had a reproducer, the fix has appropriate
> > reported-by tag).
> >
> > It would be great if there was a way to tell syzkaller to report those
> > again if they still appear.
>
> That's exactly what "#syz fix:" will do.
> syzbot will wait until the fixing commit appears in all builds/trees
> it tests, then close this bug, and then any new similarly looking
> crash will produce a new bug report. So if the patch indeed fixes the
> bug, then the bug will be closed and we are done. If it does not fix
> this bug, then we will get another report but at that time on a tree
> that includes the commit.
>
> > I could pretend and claim above commit as "sys-fix", but it seems fishy.
> >
> > Let me know and I can tag all of them.
>
> It's "safe" to mark these crashes as fixed when we are not 100% sure
> in the sense that we won't lose the bug (it will be reported again
> later if it's not fixed).
> It's also useful to keep the list of open/active bugs shorter and more
> precise (don't leave too many obsoleted open bugs). What happened
> multiple times is that a bug was fixed but left open, and then a
> similarly looking crashes started happening again (a new bug), but it
> wasn't reported by syzbot because for syzbot it looked like the old
> still unfixed bug.

Thanks for cleaning it all up!

(Florian updated 17 other bugs)
