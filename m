Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836B6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389CB205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="0Eu/5A5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389CB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeJYQnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:43:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51542 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeJYQnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:43:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id 143-v6so538883wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4GvxGFKzNAUdnVvq5ALjFaJxTeQT6fedOqXQs6Nl+Cs=;
        b=0Eu/5A5zGVIqdsitCio+oF2mJA+TBdgWEeL0O6Tb32pQvr8keCU0kESbHDtBJFEMa6
         8/Mf736AJdLDtBGSSNJstj6VmcYxUnc/VxVrTx4yEomBqlxV2DJeWrgf4nD2csvKYY5V
         vXplcRsNkc6XAvIL+EknLrLNuCO22RmruDzOt3apa3R8/qSvZq/dBn53kMKYPx3Qv0dw
         ImvWH+CyWFE68PaL442YwHk5cW9KtCSYb7Zx5HembqySvGqenFooU4MAH+wfraTfrfNl
         bksX22FEYpjB0+xxFpHzjHZirQCJHrORqLoWJYvISvvVwIZTnCuVeRDPVXj4M8XXEP5V
         VzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4GvxGFKzNAUdnVvq5ALjFaJxTeQT6fedOqXQs6Nl+Cs=;
        b=njvzX7cJm7R6WrYHFOdydqNeurdES0HEDwE0L1Qj2YLhXyYHupy/JLQsB79csS2Q/n
         uPGdg0ENNVptrPoMK+bkc7/RB0lwKGfzCAoQ6f2xONt7YTFC2i5zpWQ16kLjDCv7rokg
         7ZSx+6qTDhxjV+n445puaorFQjl2lcwsZrtEDdOP5a0LLrDY21m9Fdol24oTLgBbbnc+
         32D61qyYm2hwmNLDP2QU8zIH3nvKAxvGoKbwAfCyXLSlVk+e6C3rIah6HxlfHSaHItIX
         WEfrj4Mr8xJ5uPGhjyWW1fY8qU1VeYInxtbV+bfyYFKlAkO+/FWQotYnqNggNqXg7HgI
         PvAg==
X-Gm-Message-State: AGRZ1gJGLbHy3RU4YEjhEkSQEtWOCDhlG9D4mXh+pekeCyCOp6cEdxfX
        OyatApuMUFtEjR7cEhKm0vgyrw==
X-Google-Smtp-Source: AJdET5dFHkVDiy1ovSxuYbIwgFzfIouC5CvV3hBvDt3kd8x5/xqf1PQy16RA4en0CsgCZfvHGlhCBA==
X-Received: by 2002:a1c:9901:: with SMTP id b1-v6mr723909wme.15.1540455100460;
        Thu, 25 Oct 2018 01:11:40 -0700 (PDT)
Received: from cisco ([173.38.220.34])
        by smtp.gmail.com with ESMTPSA id q77-v6sm420220wmd.33.2018.10.25.01.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:11:39 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:11:30 +0100
From:   Tycho Andersen <tycho@tycho.ws>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        igor stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/17] prmem: llist, hlist, both plain and rcu
Message-ID: <20181025081130.GA31945@cisco>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-15-igor.stoppa@huawei.com>
 <1634210774.446.1540381072927.JavaMail.zimbra@efficios.com>
 <243a8ff2-889c-089f-a1ff-c882933ca5c3@gmail.com>
 <20181024145606.GA9019@cisco>
 <d630474b-73a5-c6ae-2141-49c1184381b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d630474b-73a5-c6ae-2141-49c1184381b2@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 01:52:11AM +0300, Igor Stoppa wrote:
> On 24/10/2018 17:56, Tycho Andersen wrote:
> > On Wed, Oct 24, 2018 at 05:03:01PM +0300, Igor Stoppa wrote:
> > > On 24/10/18 14:37, Mathieu Desnoyers wrote:
> > > > Also, is it the right approach to duplicate existing APIs, or should we
> > > > rather hook into page fault handlers and let the kernel do those "shadow"
> > > > mappings under the hood ?
> > > 
> > > This question is probably a good candidate for the small Q&A section I have
> > > in the 00/17.
> > > 
> > > 
> > > > Adding a new GFP flags for dynamic allocation, and a macro mapping to
> > > > a section attribute might suffice for allocation or definition of such
> > > > mostly-read-only/seldom-updated data.
> > > 
> > > I think what you are proposing makes sense from a pure hardening standpoint.
> > >  From a more defensive one, I'd rather minimise the chances of giving a free
> > > pass to an attacker.
> > > 
> > > Maybe there is a better implementation of this, than what I have in mind.
> > > But, based on my current understanding of what you are describing, there
> > > would be few issues:
> > > 
> > > 1) where would the pool go? The pool is a way to manage multiple vmas and
> > > express common property they share. Even before a vma is associated to the
> > > pool.
> > > 
> > > 2) there would be more code that can seamlessly deal with both protected and
> > > regular data. Based on what? Some parameter, I suppose.
> > > That parameter would be the new target.
> > > If the code is "duplicated", as you say, the actual differences are baked in
> > > at compile time. The "duplication" would also allow to have always inlined
> > > functions for write-rare and leave more freedom to the compiler for their
> > > non-protected version.
> > > 
> > > Besides, I think the separate wr version also makes it very clear, to the
> > > user of the API, that there will be a price to pay, in terms of performance.
> > > The more seamlessly alternative might make this price less obvious.
> > 
> > What about something in the middle, where we move list to list_impl.h,
> > and add a few macros where you have list_set_prev() in prlist now, so
> > we could do,
> > 
> > // prlist.h
> > 
> > #define list_set_next(head, next) wr_ptr(&head->next, next)
> > #define list_set_prev(head, prev) wr_ptr(&head->prev, prev)
> > 
> > #include <linux/list_impl.h>
> > 
> > // list.h
> > 
> > #define list_set_next(next) (head->next = next)
> > #define list_set_next(prev) (head->prev = prev)
> > 
> > #include <linux/list_impl.h>
> > 
> > I wonder then if you can get rid of some of the type punning too? It's
> > not clear exactly why that's necessary from the series, but perhaps
> > I'm missing something obvious :)
> 
> nothing obvious, probably there is only half a reference in the slides I
> linked-to in the cover letter :-)
> 
> So far I have minimized the number of "intrinsic" write rare functions,
> mostly because I would want first to reach an agreement on the
> implementation of the core write-rare.
> 
> However, once that is done, it might be good to convert also the prlists to
> be "intrinsics". A list node is 2 pointers.
> If that was the alignment, i.e. __align(sizeof(list_head)), it might be
> possible to speed up a lot the list handling even as write rare.
> 
> Taking as example the insertion operation, it would be probably sufficient,
> in most cases, to have only two remappings:
> - one covering the page with the latest two nodes
> - one covering the page with the list head
> 
> That is 2 vs 8 remappings, and a good deal of memory barriers less.
> 
> This would be incompatible with what you are proposing, yet it would be
> justifiable, I think, because it would provide better performance to prlist,
> potentially widening its adoption, where performance is a concern.

I guess the writes to these are rare, right? So perhaps it's not such
a big deal :)

> > I also wonder how much the actual differences being baked in at
> > compile time makes. Most (all?) of this code is inlined.
> 
> If the inlined function expects to receive a prlist_head *, instead of a
> list_head *, doesn't it help turning runtime bugs into buildtime bugs?

In principle it's not a bug to use the prmem helpers where the regular
ones would do, it's just slower (assuming the types are the same). But
mostly, it's a way to avoid actually copying and pasting most of the
implementations of most of the data structures. I see some other
replies in the thread already, but this seems not so good to me.

Tycho
