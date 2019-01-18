Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C24C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190F92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TAG5o0xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfAREzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:55:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33573 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfAREzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:55:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so9572286lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLyFz/NJZgEoOZrZ2eJV4Pp3mn+Ctdtd9w409+4P7/w=;
        b=TAG5o0xZtljWmnIHysbz45KQ7BDCtWjH7oSSuTR+4rp7IloXFuWN64OzjwO9g3M932
         sV0vlIJjAPfriDu66S9TRVu7irEbS5njMc5vCW3OHJdctjaAIqba392tFmtTx78fLJ86
         qgUbCJUPuKNG5XdI5ww/WGlqXQZ2cfDACqWcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLyFz/NJZgEoOZrZ2eJV4Pp3mn+Ctdtd9w409+4P7/w=;
        b=mujuNXbA9WtA62ox/y2/rSGkZ1hNt98HC9Mmaf1zJosj8F0wQsJSx1EUPc7RG4U4/n
         uZ2Tb2K4uJEiNJ7hHfWOBz/jnf/ZazaYvu7e733LRvV0nJ9NQz5CASQUdVmWBAwda6kl
         R6Wg/P8vk6gqM2Nxk0OhxXa9OGXWI1E9kqTbUuvNgv1lLAMCa3BCmr6EwGfVPZ5fbeC1
         fdiqHZKgTdkz7X7RJ7XGWmGY/fzetSUGkgQ+2sTFKiEjZTSWd0Btvlcy0Q+y+YfJCH06
         1i/CsqHDfQIpHmshod6CAa9/UAPgjTnqcInkkMXA0j1rwvk9KZ4K+CW81ojWr2AkZ7uX
         PDDA==
X-Gm-Message-State: AJcUukcUVgUHhNIVw16hsN3VFNFVJsWRCbEbHyPV4D39G379AKZMTWqJ
        HNHtgbQ04bGgbFS7PYg8FkDgyGLTYoE=
X-Google-Smtp-Source: ALg8bN7zF05+AP67zFzHM89kj/R73x+N0tZizbrkZlx+oLIEV7gZpjBT07lRSCgThBaNYFqKrr+m6g==
X-Received: by 2002:a19:789:: with SMTP id 131mr12368847lfh.11.1547787314853;
        Thu, 17 Jan 2019 20:55:14 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p23sm608564lfh.47.2019.01.17.20.55.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 20:55:13 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id a16so9535062lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:55:12 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr11265403lfj.138.1547787311695;
 Thu, 17 Jan 2019 20:55:11 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <nycvar.YFH.7.76.1901161710470.6626@cbobk.fhfr.pm> <CAHk-=wgsnWvSsMfoEYzOq6fpahkHWxF3aSJBbVqywLa34OXnLg@mail.gmail.com>
 <nycvar.YFH.7.76.1901162120000.6626@cbobk.fhfr.pm> <20190116213708.GN6310@bombadil.infradead.org>
 <CAHk-=wjciBwJo5JHcvUO+JAC13TUME1PH=ftsaNt+0RC-3PCSw@mail.gmail.com>
In-Reply-To: <CAHk-=wjciBwJo5JHcvUO+JAC13TUME1PH=ftsaNt+0RC-3PCSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jan 2019 16:54:54 +1200
X-Gmail-Original-Message-ID: <CAHk-=wg_MZgBvbH3cC9DT5MD694=SYO3+ns_2VnaiyV93vDMRQ@mail.gmail.com>
Message-ID: <CAHk-=wg_MZgBvbH3cC9DT5MD694=SYO3+ns_2VnaiyV93vDMRQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Josh Snyder <joshs@netflix.com>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jan 17, 2019 at 9:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Your patch 3/3 just removes the test.  Am I right in thinking that it
> > doesn't need to be *moved* because the existing test after !PageUptodate
> > catches it?
>
> That's the _hope_.
>
> That's the simplest patch I can come up with as a potential solution.
> But it's possible that there's some nasty performance regression
> because somebody really relies on not even triggering read-ahead, and
> we might need to do some totally different thing.

Oh, and somebody should probably check that there isn't some simple
way to just avoid that readahead code entirely.

In particular, right now we skip readahead for at least these cases:

        /* no read-ahead */
        if (!ra->ra_pages)
                return;

        if (blk_cgroup_congested())
                return;

and I don't think we need to worry about the cgroup congestion case -
if the attack has to also congest its cgroup with IO, I think they
have bigger problems.

And I think 'ra_pages' can be zero only in the presence of IO errors,
but I might be wrong. It would be good if somebody double-checks that.

               Linus
