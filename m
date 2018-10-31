Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C5AECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E4120840
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Yr8Ov/5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E4120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeJaNhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:37:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34113 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbeJaNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:37:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so326440wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 21:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuB+km0LMAbwqhBPSE0z5upz2c8PWBTaUi2I3CbmuY8=;
        b=Yr8Ov/5fvhd9aO52cRacUwUgzrmRLoK3jqgJ1sM7H7OFeYOLjAt676JaWoWPP5TUFl
         syNvd4/1BU2W0xuYm7jYipw1hTNieCIOmcsB/DbJ74S66KvIgy2snJpguKmPDJ+wyT0V
         9dxIGW3SiTsgNeiRYJ5e6P3cdBYllM8iQAZWpSffgobF2yTb/sff8cz7F6WTUUPhXBXu
         1x2RtjrcYgk4Lc0mecMwXRswYpv7qk5g0ycW+WO9w4F85h9agfR3hzW+wyyB6dkvd24T
         eJY1PQQX5zw/SRxelpQQu1HUDVO78oQHEWzsBptq9h8mq7ka6rz+MbQQXaU8SjFZAC78
         /5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuB+km0LMAbwqhBPSE0z5upz2c8PWBTaUi2I3CbmuY8=;
        b=XqedE8QiQwkO2nLGWgR6p64zniS9uj82A9QftzbYUQ4kxEgsExTX0FVab888HTxtqa
         LVDQlLUxfmgluVUbaDO7R4nVReYpNs/FKBBJcpwtBj+IhY1e5NZf9mLIPlwejiu8CqFP
         AEE+uYr5Iz08CqLYiYbG5Fs+2ghzuG2YlGPYMNZEjNh9fy6rSEg3lQCCPryiQ7ATENWX
         +cxLMUxALqpybaWtFQLgfkLsLIq1cPfGPGu0B5cyUiVdcxMvzhb7OYUkPA6JqzF3F/7x
         Izz2E10KHNvR1YnaodZBDoNngl9tSkuWsCHIHHSzN+g6oEPZudz19aKKAY7818Q6eMcj
         abrA==
X-Gm-Message-State: AGRZ1gJGQ3dnCoyGsZv62APfhckjGDrk2Iz5QYa32dtdMgGVsSDi8csb
        7p+w7uREp8Kp1vjO9zbIHqeTvWFYjqPjZwrkxddGDQ==
X-Google-Smtp-Source: AJdET5da2fWDOBqUm/NfMQo0FfaejNVTvyDWDmJIuOPBGo9zkY9ccnZamzEZmlflpUrPCg3ryi2Q8jzp6SNqWde+UUU=
X-Received: by 2002:a1c:410a:: with SMTP id o10-v6mr1003272wma.19.1540960885281;
 Tue, 30 Oct 2018 21:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net> <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <20181030175814.GB10491@bombadil.infradead.org>
 <20181030182841.GE7343@cisco> <20181030192021.GC10491@bombadil.infradead.org>
 <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com> <20181030213557.GE10491@bombadil.infradead.org>
In-Reply-To: <20181030213557.GE10491@bombadil.infradead.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 30 Oct 2018 21:41:13 -0700
Message-ID: <CALCETrW1FcT88u0QY9k_PMOeZj0G8H6KNb5Bnreo-12NvmmCEQ@mail.gmail.com>
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 2:36 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 30, 2018 at 10:43:14PM +0200, Igor Stoppa wrote:
> > On 30/10/2018 21:20, Matthew Wilcox wrote:
> > > > > So the API might look something like this:
> > > > >
> > > > >         void *p = rare_alloc(...);      /* writable pointer */
> > > > >         p->a = x;
> > > > >         q = rare_protect(p);            /* read-only pointer */
> >
> > With pools and memory allocated from vmap_areas, I was able to say
> >
> > protect(pool)
> >
> > and that would do a swipe on all the pages currently in use.
> > In the SELinux policyDB, for example, one doesn't really want to
> > individually protect each allocation.
> >
> > The loading phase happens usually at boot, when the system can be assumed to
> > be sane (one might even preload a bare-bone set of rules from initramfs and
> > then replace it later on, with the full blown set).
> >
> > There is no need to process each of these tens of thousands allocations and
> > initialization as write-rare.
> >
> > Would it be possible to do the same here?
>
> What Andy is proposing effectively puts all rare allocations into
> one pool.  Although I suppose it could be generalised to multiple pools
> ... one mm_struct per pool.  Andy, what do you think to doing that?

Hmm.  Let's see.

To clarify some of this thread, I think that the fact that rare_write
uses an mm_struct and alias mappings under the hood should be
completely invisible to users of the API.  No one should ever be
handed a writable pointer to rare_write memory (except perhaps during
bootup or when initializing a large complex data structure that will
be rare_write but isn't yet, e.g. the policy db).

For example, there could easily be architectures where having a
writable alias is problematic.  On such architectures, an entirely
different mechanism might work better.  And, if a tool like KNOX ever
becomes a *part* of the Linux kernel (hint hint!)

If you have multiple pools and one mm_struct per pool, you'll need a
way to find the mm_struct from a given allocation.  Regardless of how
the mm_structs are set up, changing rare_write memory to normal memory
or vice versa will require a global TLB flush (all ASIDs and global
pages) on all CPUs, so having extra mm_structs doesn't seem to buy
much.

(It's just possible that changing rare_write back to normal might be
able to avoid the flush if the spurious faults can be handled
reliably.)
