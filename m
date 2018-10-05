Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A61C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375CC20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 05:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5sCKCtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375CC20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeJEMsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:48:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40945 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeJEMsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:48:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id r83-v6so10494693ljr.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 22:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIgBsJgITCialaB2v+GU0Fc6nzO65o16U8AsPvywMGQ=;
        b=S5sCKCtDA8z9oGefRw0baclbjwRlYpjU20Ug11UveVm0JQa0nvcvXxEYWz2F3jg4ru
         n3VSVQNuha2rX6MPVpFxnlFIzQE1lFs8vKKzE10eDSj+dLhVE+BY/YNJL5wKE6Ys8tbt
         1Jy8VW5P47umnbrEpr5a8u52QjGblEIWmiBmGUmZeAJGJVHix9wf/xMxXruqbjLHRzLe
         aNMyrOy+f+foCatcoS/0LLuWf0ZV4cHwW4jEOcuodCKoG43nyXIjfrJn3LA/7BTzney1
         vYbpBElPCTpXyc6KOf3IJn59McUo7LEM3/FG+nuCnq2UwN6hdSI/Pbw2iC4jE+MZFRYw
         eNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIgBsJgITCialaB2v+GU0Fc6nzO65o16U8AsPvywMGQ=;
        b=jzcSni4rK2S+wnNftSbTsF/eiHX+PFx4+dSrt+tTYpKd6/BMjQ3pqWWspxnWbY2WfA
         WV6Pd8PqhtOsUPfYUJt67/dU4XsX8ktDhmQRIYqKA4WZz+VgpjLT4EIpXFLigcj2yCJO
         t1w+gaLKZEi5U0Llsda83LwOqEPaZf1APkGswKdoUcvn6z0UteLm4FXINQS1w03kFDYR
         a4jk1XZKuL6VYUO+1nkvPeMieKRqxHecXb8b/IEExzxAaDfxNXlqkLoOkFMxNZ5/T0sC
         vBRsJrmlJR5zZwkEt0zoNCN4BMSYgmgO0w1ukT1NsOfPatTVzSGfqxDyfYJY86lA/KZR
         8K2g==
X-Gm-Message-State: ABuFfoiHdPdbOwMkWJcS3D+DvmtoldtmitbToIqhyLb1xo7UDKlBOOd1
        J4u/XYG5AKkbkHGN0JP2hVEyBZZ6vCOWiY2snfk=
X-Google-Smtp-Source: ACcGV63fxqmuP+GYsbGOmYQb6cbBAN4girYk2To14eFlKZvDrDH7kA2qEaYWhXJwyWwHir+tot55cQh3ZRpghHjG2QE=
X-Received: by 2002:a2e:91d3:: with SMTP id u19-v6mr5956682ljg.64.1538718661663;
 Thu, 04 Oct 2018 22:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk> <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org> <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
 <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
In-Reply-To: <CANiq72mkTP_m20vqei-cpN+ypQ_gU472qn5m68vb_4Nqj5afMQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 5 Oct 2018 11:20:49 +0530
Message-ID: <CAFqt6zaFc_GenhfvsD0VPfepR-jjXypj+4CgNEuHMVq1WXV+8w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin@protonic.nl, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kees Cook <keescook@chromium.org>, treding@nvidia.com,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, aryabinin@virtuozzo.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, tchibo@google.com,
        riel@redhat.com, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, ak@linux.intel.com,
        rppt@linux.vnet.ibm.com, linux@dominikbrodowski.net,
        Arnd Bergmann <arnd@arndb.de>, cpandya@codeaurora.org,
        hannes@cmpxchg.org, Joe Perches <joe@perches.com>,
        mcgrof@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 1:16 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Souptick,
>
> On Thu, Oct 4, 2018 at 8:49 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Thu, Oct 4, 2018 at 11:47 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > I think this is a bad plan.  What we should rather do is examine the current
> > > users of vm_insert_page() and ask "What interface would better replace
> > > vm_insert_page()?"
> > >
> > > As I've said to you before, I believe the right answer is to have a
> > > vm_insert_range() which takes an array of struct page pointers.  That
> > > fits the majority of remaining users.
> >
> > Ok, but it will take some time.
> > Is it a good idea to introduce the final vm_fault_t patch and then
> > start working on vm_insert_range as it will be bit time consuming ?
> >
>
> Well, why is there a rush? Development should be done in a patch
> series or a tree, and submitted as a whole, instead of sending partial
> patches.

Not in hurry, will do it in a patch series :-)
>
> Also, not sure if you saw my comments/review: if the interface is not
> going to change, why the name change? Why can't we simply keep using
> vm_insert_page?

yes, changing the name without changing the interface is a
bad approach and this can't be taken. As Matthew mentioned,
"vm_insert_range() which takes an array of struct page pointers.
That fits the majority of remaining users" would be a better approach
to fit this use case.

But yes, we can't keep vm_insert_page and vmf_insert_page together
as it doesn't guarantee  that future drivers will not use vm_insert_page
in #PF context ( which will generate new errno to VM_FAULT_CODE).

Any further comment form others on vm_Insert_range() approach ?
