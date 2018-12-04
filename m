Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3297CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE5620834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WQjltOEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE5620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLDSb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:31:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43073 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:31:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so15150207oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1DQd71qV8AokaIi9gsNc0oVk8hNGFNIRnal/i0F+Duk=;
        b=WQjltOEGzUymcS6LRPGCfBVtqCHyPiyTpEWS2IynZwU7CCsTV14YIE9xec2XQUS0XG
         PNh7Pt1pTJHOqha53wlmbPZAY4Aq2v9evhg3Bbib6pStU6qVaHARhv3qIn1i8AoUzUEj
         cidD1jOfYBqzPnBe3uasPloknfTshvQMiiLdY6VVsehoXqWSfUkkzv+OnMkhMHbKBRTo
         aIQfFPW2rvnZ3c3qgpUy7esmScHRGmv6w0QB++vzUrxwgh2JXoD/gOhg6iJHo2z6FErT
         IJaKuUfkMfkCiWa5N7YpCRvfQmyKPq2ttf1IVlNJrL6iXi1jUzFxZu6amRJAffRbm7VB
         oO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DQd71qV8AokaIi9gsNc0oVk8hNGFNIRnal/i0F+Duk=;
        b=tzoxcbQhGUBX4HGLKbvsF3oX1eIGlk/m0ZpffPFiFV93DvH2PSrpjsrnWiMIt9qcMm
         VH092sDHoUF9qPN/xRXq9Fsn5yU5ICT04Z7gVNlL7RRLMBCGL2r8bfLFSlgzT80p8sWy
         LUO0YfVDSKDf9NqmCn3ADACfiSOYQ3e8oMtbCjtA5Y6yR22fIBdBa6MzM6G727UX8xYx
         WML2TX3iibADSpQSU6RciqDghRdmbjWl1QXzva+EuT/8/3Wrjdlw6ri1nQQA8HW7Nq26
         O5EdGshuyDLUx8Frd0fT3RZrjS++2B2s13P6FErO/b1Rj38M5GMjN3KIlb/ixbE3xH/0
         nl1Q==
X-Gm-Message-State: AA+aEWan24xffE1N0I9gXG49bAKIHomxGDTekzNTMKKT2u7x3QRnIJyl
        5tC3MepQKHaI9xR9ibooSIEqDY9zKkrY4kwk7w5cBA==
X-Google-Smtp-Source: AFSGD/W6tBmglBPNjPah2X+QF6Gby4sbZ2v6Fv5lNwQ7krpqK/GKv3RPu5FE10r+S4iuHqfH4wuqgc8sysRyWVIhIA4=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr7215960oig.232.1543948288251;
 Tue, 04 Dec 2018 10:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20181203233509.20671-1-jglisse@redhat.com> <20181203233509.20671-3-jglisse@redhat.com>
 <875zw98bm4.fsf@linux.intel.com> <20181204182421.GC2937@redhat.com>
In-Reply-To: <20181204182421.GC2937@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Dec 2018 10:31:17 -0800
Message-ID: <CAPcyv4gtv7eUc1_3Yhz-f-B3Lct=Vq7zqUJKOqCtWYb4BS6i9g@mail.gmail.com>
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

On Tue, Dec 4, 2018 at 10:24 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Dec 04, 2018 at 09:06:59AM -0800, Andi Kleen wrote:
> > jglisse@redhat.com writes:
> >
> > > +
> > > +To help with forward compatibility each object as a version value and
> > > +it is mandatory for user space to only use target or initiator with
> > > +version supported by the user space. For instance if user space only
> > > +knows about what version 1 means and sees a target with version 2 then
> > > +the user space must ignore that target as if it does not exist.
> >
> > So once v2 is introduced all applications that only support v1 break.
> >
> > That seems very un-Linux and will break Linus' "do not break existing
> > applications" rule.
> >
> > The standard approach that if you add something incompatible is to
> > add new field, but keep the old ones.
>
> No that's not how it is suppose to work. So let says it is 2018 and you
> have v1 memory (like your regular main DDR memory for instance) then it
> will always be expose a v1 memory.
>
> Fast forward 2020 and you have this new type of memory that is not cache
> coherent and you want to expose this to userspace through HMS. What you
> do is a kernel patch that introduce the v2 type for target and define a
> set of new sysfs file to describe what v2 is. On this new computer you
> report your usual main memory as v1 and your new memory as v2.
>
> So the application that only knew about v1 will keep using any v1 memory
> on your new platform but it will not use any of the new memory v2 which
> is what you want to happen. You do not have to break existing application
> while allowing to add new type of memory.

That sounds needlessly restrictive. Let the kernel arbitrate what
memory an application gets, don't design a system where applications
are hard coded to a memory type. Applications can hint, or optionally
specify an override and the kernel can react accordingly.
