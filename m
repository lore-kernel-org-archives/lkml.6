Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10901C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAB42084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtycxMkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAB42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeJEBoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:44:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42316 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeJEBoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:44:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id y71-v6so9337207lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqp7Pdu20JDrIixHYYf9jYer1nswBdQmONLZEpVOXh8=;
        b=PtycxMkKQXDg93LLMZWWqJlGgGYqgY7Auh24jX/iVheECKy1I4jhIAX4Uv1tOhqDUJ
         WlsxkRCBpTNQ7gWkP/SpibTyJzWHld9om5+KCVlQ2TAPs87U1kxWkzSaW62barrZJAlT
         ZgIjrll//xKxGKaMQsoF664Z/hBW9uBR3m+BkeAWgLe7pBO7Ir5k0XPdnSH+dl4PwHYm
         kHEm9bqlPXF1EVCUj2MIjmAFHRAJz9Gv8GYwqhMWQbm0BqfffZMrFn2gqWMd1eQgP0Y/
         +SeZJjnHWV80mc0Zro9NRpqm/58tKEaX/v4uiJL6dlJoC0aX0wIT7Q4pqnvScvlz3XVV
         b01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqp7Pdu20JDrIixHYYf9jYer1nswBdQmONLZEpVOXh8=;
        b=YndKAvaluYNDMgkirwGkICP2iNp0fp38TCTxLbvasnDDEQP7p0oHJoAREk2BlMON2H
         2BwP6hwjMko/DCqck+2utL8wpV7A8Gqq96pgnOrZxpvBedLOEMwiqCdtuRFVpB3Q4qqM
         05lcNuZ5B4DxtIOHvzg7+bhNaxjcx4D+CmgEEeY6jO1jc/zSJFpnyT4NsdhdbMSOXVj9
         87VO3fy9HeLVT2pvVrgFAJgtFc/FmsE9jnTLLBzIBwPCRbRhIPa6hxwIFfWqjUSKUAqh
         YI+SrT1EeZDpmqYZYUzCRFaeyyeo5tEYJUssN2tW4ulq7K3tntZqFqT0PjxlyEdcy+0V
         lKHg==
X-Gm-Message-State: ABuFfohAPTivsZcDYELCxv4oojBt5GB/IZMbeioV4uMJBiXDSxxlOdXd
        I3Tj0+gLVQcccTMRHKV/LzLBQmv0c11R2gEnkVU=
X-Google-Smtp-Source: ACcGV63NYom1Hq7KViwk92CR25fyWWm6gPjUqm+1aRHNVh0bB0QGqc/BaiV33Rym5xz0Suwst+6TS4ej0QF2LbsJ6Js=
X-Received: by 2002:a2e:5586:: with SMTP id g6-v6mr4874524lje.75.1538678999118;
 Thu, 04 Oct 2018 11:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
 <20181004123400.GC30658@n2100.armlinux.org.uk> <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
 <20181004181736.GB20842@bombadil.infradead.org>
In-Reply-To: <20181004181736.GB20842@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 5 Oct 2018 00:23:07 +0530
Message-ID: <CAFqt6zaN0PQHkjuwFf8VriROLy7qrPDu-iNE=VPiXJw8C7GpQg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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

On Thu, Oct 4, 2018 at 11:47 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Oct 04, 2018 at 11:42:18PM +0530, Souptick Joarder wrote:
> > On Thu, Oct 4, 2018 at 6:04 PM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > I'm confused, what are you trying to do?
> > >
> > > It seems that we already have:
> > >
> > > vm_insert_page() - returns an errno
> > > vmf_insert_page() - returns a VM_FAULT_* code
> > >
> > > From what I _think_ you're saying, you're trying to provide
> > > vm_insert_kmem_page() as a direct replacement for the existing
> > > vm_insert_page(), and then make vm_insert_page() behave as per
> > > vmf_insert_page(), so we end up with:
> >
> > yes, vm_insert_kmem_page() can be a direct replacement of vm_insert_page
> > or might be a wrapper function written using vm_insert_page whichever
> > suites better
> > based on feedback.
> >
> > >
> > > vm_insert_kmem_page() - returns an errno
> > > vm_insert_page() - returns a VM_FAULT_* code
> > > vmf_insert_page() - returns a VM_FAULT_* code and is identical to
> > >       vm_insert_page()
> > >
> >
> > After completion of conversion we end up with
> >
> >  vm_insert_kmem_page() - returns an errno
> >  vmf_insert_page() - returns a VM_FAULT_* code
> >
> >
> > > Given that the documentation for vm_insert_page() says:
> > >
> > >  * Usually this function is called from f_op->mmap() handler
> > >  * under mm->mmap_sem write-lock, so it can change vma->vm_flags.
> > >  * Caller must set VM_MIXEDMAP on vma if it wants to call this
> > >  * function from other places, for example from page-fault handler.
> > >
> > > this says that the "usual" use method for vm_insert_page() is
> > > _outside_ of page fault handling - if it is used _inside_ page fault
> > > handling, then it states that additional fixups are required on the
> > > VMA.  So I don't get why your patch commentry seems to be saying that
> > > users of vm_insert_page() outside of page fault handling all need to
> > > be patched - isn't this the use case that this function is defined
> > > to be handling?
> >
> > The answer is yes best of my knowledge.
> >
> > But as mentioned in change log ->
> >
> > Going forward, the plan is to restrict future drivers not
> > to use vm_insert_page ( *it will generate new errno to
> > VM_FAULT_CODE mapping code for new drivers which were already
> > cleaned up for existing drivers*) in #PF (page fault handler)
> > context but to make use of vmf_insert_page which returns
> > VMF_FAULT_CODE and that is not possible until both vm_insert_page
> > and vmf_insert_page API exists.
> >
> > But there are some consumers of vm_insert_page which use it
> > outside #PF context. straight forward conversion of vm_insert_page
> > to vmf_insert_page won't work there as those function calls expects
> > errno not vm_fault_t in return.
> >
> > If both {vm, vmf}_insert_page exists, vm_insert_page might be used for
> > #PF context which we want to protect by removing/ replacing vm_insert_page
> > with another similar/ wrapper API.
> >
> > Is that the right answer of your question ? no ?
>
> I think this is a bad plan.  What we should rather do is examine the current
> users of vm_insert_page() and ask "What interface would better replace
> vm_insert_page()?"
>
> As I've said to you before, I believe the right answer is to have a
> vm_insert_range() which takes an array of struct page pointers.  That
> fits the majority of remaining users.

Ok, but it will take some time.
Is it a good idea to introduce the final vm_fault_t patch and then
start working on vm_insert_range as it will be bit time consuming ?

>
> ----
>
> If we do want to rename vm_insert_page() to vm_insert_kmem_page(), then
> the right answer is to _just do that_.  Not duplicate vm_insert_page()
> in its entirety.  I don't see the point to doing that.
