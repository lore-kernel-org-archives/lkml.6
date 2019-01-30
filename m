Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787CFC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4BA20857
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMlwppvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfA3Oau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:30:50 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54760 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfA3Oar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:30:47 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so10493346ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOM0zPYYY9Po+taasPsv0r8kfU7hbJO/hDTgEGjkrL8=;
        b=WMlwppvMLf8afgeoOZ0N2300BdCEJ4lMcCKfVv5r1eTDqOUS4cfcdO6wk6NXOQ3b4V
         +PbKcd5PiK1QQy3dZE05egNnAxyExFSlVUHKBHYJYyB9GX/AXg9zMPI3yIm/GQsPmo2E
         vBxO0orZoMIuoke0PrLoUS1vt7JqVnKoa6z8OPlDfkkFTW2IWmf5GKwynLgw3jTiDaqU
         ZZlqSyGm9RcLC7K4GwtiH0OKfz4ZlcPV/GiwAEdAQfR3VP3C7kNreLI7Rub95w/UJ/KS
         A003TnnlMski80hRj+nvOqcltp23FuZDfaPz1t0/yyTquqc/TBOiqUE81IYVAlfXsm94
         2pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOM0zPYYY9Po+taasPsv0r8kfU7hbJO/hDTgEGjkrL8=;
        b=c6ayAxHbyuh0Sgmv4AI2Av87CaM/bbnjzN+tlKRaFoDsjp/L2SWM3SqOI7CDGh56QH
         gHZWxWHn6mM14QRuUF81xpCqmiezNyIBL4fxC2zQdmdcy7KXymTD26vtM0YE+AhGbAHj
         79i5bUFkvQvQCG0af6Z85HX8ci99tb8qq5b0xXNF+7pjjEpOxl4/hgbx9YdkQM9+DM4h
         Jd1kh0m3ryKjkJiG6SaOx+7DUSlsQvooVWP8AgUHxuIDwT9eK4T5Vx+jzFZLrsW5uojY
         vOeSN74E+7kJt0tK4by1qn2PynMIJR+GRpbvfb24wkBpz0M1SGPOqw/GXkGLF/IMrMaw
         nRwg==
X-Gm-Message-State: AJcUukd0uhUEt86NA04q6dUZgV61p72NPXEfOrx1tvxlXZbplLtZOjc2
        G7uTzNbq2W/CKZ1NaEe1v7MTwO0/MFfsba+DIpdXBA==
X-Google-Smtp-Source: ALg8bN6MQ8ar1quzHxt/sQg0llF/vzOgFNdOsBSCZkASNXxy9ujphxMrQSuqedVkWwUvtr2gEnGTTJGbYX/FWPWPKko=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr12909209iti.166.1548858646506;
 Wed, 30 Jan 2019 06:30:46 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007b129305809553da@google.com> <20190129094144.bln4dnirr5kz3dl4@breakpoint.cc>
 <CACT4Y+YB_icD2B6Bj6=5KjAvfamyCUeLnYHm5i5PQKO35=RMFA@mail.gmail.com> <20190130142050.ilcccckfatn2zj6o@breakpoint.cc>
In-Reply-To: <20190130142050.ilcccckfatn2zj6o@breakpoint.cc>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Jan 2019 15:30:35 +0100
Message-ID: <CACT4Y+ZWafAqKCt0ubJREcuHx4EiKhNKL0X-et_Y9YZBr8adbg@mail.gmail.com>
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

On Wed, Jan 30, 2019 at 3:20 PM Florian Westphal <fw@strlen.de> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> wrote:
> > > syzbot <syzbot+e6e1fe9148cffa18cf97@syzkaller.appspotmail.com> wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    085c4c7dd2b6 net: lmc: remove -I. header search path
> > > > git tree:       net-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12347128c00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=505743eba4e4f68
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e6e1fe9148cffa18cf97
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > net-next doesn't contain the fixes for the rbtree fallout yet, so
> > > this might already be fixed (fingers crossed).
> >
> > Hi Florian,
> >
> > What is that fix for the record?
>
> I don't know.  I managed to add every bug class imagineable in that series 8-(
>
> The last (most recent) fix from the 'fallout cleanup' is:
> 12750abad517a991c4568969bc748db302ab52cd
> ("xfrm: policy: fix infinite loop when merging src-nodes")
>
> so if syzkaller can generate a splat with that change present
> something is still broken.
>
> > We will need to close this later. Or perhaps we can already mark this
> > as fixed by that patch with "#syz fix:" command?
>
> There are a lot of open xfrm related splats that could all be explained
> by the rbtree bugs (one had a reproducer, the fix has appropriate
> reported-by tag).
>
> It would be great if there was a way to tell syzkaller to report those
> again if they still appear.

That's exactly what "#syz fix:" will do.
syzbot will wait until the fixing commit appears in all builds/trees
it tests, then close this bug, and then any new similarly looking
crash will produce a new bug report. So if the patch indeed fixes the
bug, then the bug will be closed and we are done. If it does not fix
this bug, then we will get another report but at that time on a tree
that includes the commit.

> I could pretend and claim above commit as "sys-fix", but it seems fishy.
>
> Let me know and I can tag all of them.

It's "safe" to mark these crashes as fixed when we are not 100% sure
in the sense that we won't lose the bug (it will be reported again
later if it's not fixed).
It's also useful to keep the list of open/active bugs shorter and more
precise (don't leave too many obsoleted open bugs). What happened
multiple times is that a bug was fixed but left open, and then a
similarly looking crashes started happening again (a new bug), but it
wasn't reported by syzbot because for syzbot it looked like the old
still unfixed bug.
