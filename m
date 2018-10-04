Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23ED4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10C20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZPiz3O2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC10C20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeJEClb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:41:31 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:45674 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEClb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:41:31 -0400
Received: by mail-qt1-f171.google.com with SMTP id e10-v6so201411qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/+EA7bQ9/iq0TYaBp6k8OBwDdqPOFEpviVmZxk1obk=;
        b=XZPiz3O2jJqE7onE8rmmdwtafuNEiYM/i7Mt51T29TLQtp0tD6cw1jkWf1CBxZQ5Hr
         K2bgjnY2+haWYt3X6F7NUuYdAubD5QDW/uUQkyWuuM4zdWiLT66wCRRNSUgRHGagBuu4
         swRGfeI4RAVea94o++or9+8SM7Xc6IuJJDeg40tZsgW2d8RLV7zXyNJaGSY3mj0xST/v
         iV42oDg9QqmquZV6OfSgGjJ24wOFhdsMKujRk9F6JhQFCzbfXW1tciqVMyfpMSXZOgpq
         fQWswPrKUW60WPOABI5Zqm+n32wQWscrsmE9Jiii+vQziLA7JqCAlY2qrOzEQAQJyRxh
         c7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/+EA7bQ9/iq0TYaBp6k8OBwDdqPOFEpviVmZxk1obk=;
        b=IqqXIdXp2gSBgj+kEpmH1e5Pg0TCMvdSxRx6jSh+fLTszVZrkNknGKHnE0WWcGJ+y1
         /OOdVDdNAc82nMRSR+gSf8C39obTOvH+GtbR8c1O5Y460FppdLZj223azui2iQzSfHaE
         aOVdjpprVx2i765bKFBO98Sa9Ey5EOIt2s6AVvrhfAf9+nWSuYrcTRNmEQqiPGYF5RqB
         S3mFXUD6rVCSGiG22NvI46pNm56Mw7ZyGEa5jdg2hJwFpdso00m4lAQt40vviqXy3epI
         +xbHkkhLNxZ7h5f3+I5ktVMKfn7UL9aTfKA/1sQ0Civ6UA+TRxuJiCSa1B0ct0x4xH96
         4jIw==
X-Gm-Message-State: ABuFfohJn24rEPHf0kjV1Kjx6YN3/j5fEPOrEZ7bSndbeoCCrGskNSgS
        44Rtn2Q+PeXY/LFvXMkkmH+yZ3OGP8rmONGPRlc=
X-Google-Smtp-Source: ACcGV61wz3SwjM5x/SHklykdDqD8RIkxT1hKfgG4DqDNxg6YE0vLjOHYE4lyF/kyy9Pcqs3Rqf+wf7UJXN2rYL4zD8M=
X-Received: by 2002:a0c:87ba:: with SMTP id 55-v6mr6629634qvj.202.1538682406064;
 Thu, 04 Oct 2018 12:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk> <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org> <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
In-Reply-To: <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 4 Oct 2018 21:46:34 +0200
Message-ID: <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux@armlinux.org.uk,
        Robin van der Gracht <robin@protonic.nl>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Dave Airlie <airlied@linux.ie>, robin.murphy@arm.com,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kees Cook <keescook@chromium.org>, treding@nvidia.com,
        mhocko@suse.com, Dan Williams <dan.j.williams@intel.com>,
        kirill.shutemov@linux.intel.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, tchibo@google.com,
        riel@redhat.com, minchan@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, ying.huang@intel.com,
        Andi Kleen <ak@linux.intel.com>, rppt@linux.vnet.ibm.com,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arnd Bergmann <arnd@arndb.de>, cpandya@codeaurora.org,
        hannes@cmpxchg.org, Joe Perches <joe@perches.com>,
        mcgrof@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

On Thu, Oct 4, 2018 at 8:49 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Thu, Oct 4, 2018 at 11:47 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I think this is a bad plan.  What we should rather do is examine the current
> > users of vm_insert_page() and ask "What interface would better replace
> > vm_insert_page()?"
> >
> > As I've said to you before, I believe the right answer is to have a
> > vm_insert_range() which takes an array of struct page pointers.  That
> > fits the majority of remaining users.
>
> Ok, but it will take some time.
> Is it a good idea to introduce the final vm_fault_t patch and then
> start working on vm_insert_range as it will be bit time consuming ?
>

Well, why is there a rush? Development should be done in a patch
series or a tree, and submitted as a whole, instead of sending partial
patches.

Also, not sure if you saw my comments/review: if the interface is not
going to change, why the name change? Why can't we simply keep using
vm_insert_page?

Cheers,
Miguel
