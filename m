Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C40C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588E20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IsOsQKNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLDTTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:19:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44716 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeLDTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:19:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so16243120otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7D2l3o5N5A78m1xj+XeOgS0XVOw4H+IMlC/3L9b1SY=;
        b=IsOsQKNjE0U6SZkZtDXKygODq44f26V+LnR2myCvJU9R3cVgKeI66I/H4t+0YZBla8
         jJ1IIu6Fko87Vzp8cjFYTVcsaDjP0hX/Wa6z88FVNECZo7oUA3elRCXW6EnzpFmj03Xh
         mwBeOc28hs5oUlxaUjFGHVwBZ89z+rEvzPJo2Gtcoou3A79yOfCWCldR90zHfrpL3c23
         gzCnwdaUhzzCeu+vi711oQB2BO1R5BIPsPxY8GcZ7iATFuy3bLOwbBHBITrhzkAkLD7g
         Kj5m5FY661rZitjyV5z7yvdcM+OrWnJtrZFDdVEmZXi6hlIFz/MYIxJE++axiwgeezZk
         Xu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7D2l3o5N5A78m1xj+XeOgS0XVOw4H+IMlC/3L9b1SY=;
        b=HmpB8ZfXtPVjGzFSLIbV14BIum+xDHCwoaMM+dznbSGtv3mAXRnXWHpFDJ0jswKGDK
         HMLCBMP0U/fXJ6GmJ01WrpTPcP0o9o6b1v5iAGBGvs994/5EndrPQnCl6/jlVa2nBxrh
         orH8+iKotCV9nDlJIpq0dBSsV56wj2JBjeDpIlr9HonGkYQo6gWhxCudebfTbEGU+laz
         EJSwsdJloYUtyhSoAqGn97U7vj4pZGsd/Vhun5dTymybr1b9X4CdZzNPEXvA6knppT0P
         6uUDxyteJepn44bXkcBqs+2KHGzYtdAFojIN9+mZwGhYrWdyEIaJW4i7N+NWVFYPLx4q
         F7tA==
X-Gm-Message-State: AA+aEWZuMm2IsfZS5QHW1QzpRHvK1ThnRnTl4szSJkXojmz3Sps/V5bn
        QllrbwvlqPWEErDtDx+3J9+0S4aij5qUU7GhX7XkiA==
X-Google-Smtp-Source: AFSGD/VAJJNPp1l+tSj1hNnRLu01SsPaXeLWwhmGlkSiuLbLzF7sFO3gQxJYyyaKGOd6QF2jCj28ZQ8b1MUuY1DAo88=
X-Received: by 2002:a9d:a78:: with SMTP id 111mr13258943otg.229.1543951175069;
 Tue, 04 Dec 2018 11:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20181203233509.20671-1-jglisse@redhat.com> <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com> <20181204182421.GC2937@redhat.com>
 <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com> <20181204185725.GE2937@redhat.com>
In-Reply-To: <20181204185725.GE2937@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Dec 2018 11:19:23 -0800
Message-ID: <CAPcyv4iddjvOvdRRRMrD5RtrVzLB13cPATbpE52ZcuPWWsyx-w@mail.gmail.com>
Subject: Re: [RFC PATCH 02/14] mm/hms: heterogenenous memory system (HMS) documentation
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>, balbirs@au1.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, Philip.Yang@amd.com,
        "Koenig, Christian" <christian.koenig@amd.com>,
        "Blinzer, Paul" <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>, rcampbell@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 10:58 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Dec 04, 2018 at 10:31:17AM -0800, Dan Williams wrote:
> > On Tue, Dec 4, 2018 at 10:24 AM Jerome Glisse <jglisse@redhat.com> wrote:
> > >
> > > On Tue, Dec 04, 2018 at 09:06:59AM -0800, Andi Kleen wrote:
> > > > jglisse@redhat.com writes:
> > > >
> > > > > +
> > > > > +To help with forward compatibility each object as a version value and
> > > > > +it is mandatory for user space to only use target or initiator with
> > > > > +version supported by the user space. For instance if user space only
> > > > > +knows about what version 1 means and sees a target with version 2 then
> > > > > +the user space must ignore that target as if it does not exist.
> > > >
> > > > So once v2 is introduced all applications that only support v1 break.
> > > >
> > > > That seems very un-Linux and will break Linus' "do not break existing
> > > > applications" rule.
> > > >
> > > > The standard approach that if you add something incompatible is to
> > > > add new field, but keep the old ones.
> > >
> > > No that's not how it is suppose to work. So let says it is 2018 and you
> > > have v1 memory (like your regular main DDR memory for instance) then it
> > > will always be expose a v1 memory.
> > >
> > > Fast forward 2020 and you have this new type of memory that is not cache
> > > coherent and you want to expose this to userspace through HMS. What you
> > > do is a kernel patch that introduce the v2 type for target and define a
> > > set of new sysfs file to describe what v2 is. On this new computer you
> > > report your usual main memory as v1 and your new memory as v2.
> > >
> > > So the application that only knew about v1 will keep using any v1 memory
> > > on your new platform but it will not use any of the new memory v2 which
> > > is what you want to happen. You do not have to break existing application
> > > while allowing to add new type of memory.
> >
> > That sounds needlessly restrictive. Let the kernel arbitrate what
> > memory an application gets, don't design a system where applications
> > are hard coded to a memory type. Applications can hint, or optionally
> > specify an override and the kernel can react accordingly.
>
> You do not want to randomly use non cache coherent memory inside your
> application :)

The kernel arbitrates memory, it's a bug if it hands out something
that exotic to an unaware application.
