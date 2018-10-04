Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DF4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E991A2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQM79BAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E991A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeJEBDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:03:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36800 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEBDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:03:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id p89-v6so9254703ljb.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmCl55HHVWSyxHrVt/nDzHRgW9+8ODnWDxc+exJYcws=;
        b=YQM79BAgI9c/SXOrW+RO/O/jcVsTOmPPdTQAs8Ni8XfMDziUn6rILuqDmxErUdjIIa
         jNwE9f7dZ7kIGhx+0k4g3XfPaiaJWEjx+dQ0877vIo1QSWTFeL0DbEksANq7oKyZWLq2
         Ox0g25uulNmj9M3l5l6N6XhBxzNho33TuiHOBqPyuQKwytj/xlFYvbOcJAsUuQHtVxVW
         ouXcpkWi9M6UsfM9VNV+xwHxWvZmdoDFpLhnBPrNFunGfosH9q6H/mOfLb8Ci2kmrhIA
         4PMtXncqpIYCCaov/1dkCiT+3AduQfX5abx/kx7HYL6FO973txpHtpLSk5yOt6DTbuKB
         MMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmCl55HHVWSyxHrVt/nDzHRgW9+8ODnWDxc+exJYcws=;
        b=qR+RIJDt2+CT4mPpDbOrPzEIjqtJPHoFoxsj5r0ISgH947tXJwIlbUuHY8EWC8cOiC
         mQeaH3AEKP8zXOm/HQxOdOf0WxvyWnxen/CNrcb7P7+gfDyED+sOpVvqwXJkgGz5IvN/
         OzIwrbZ/bwN5itQrGTB0ed52O/h7H2+7e01mrueYVYN2v13c0BK+3zXOTd0PVOg8R2Lj
         G6bEdQL8X/M5l63GLt6oSwiLuU1+C7ukdqhqtyLHYY/0gHBIJ1CMy8tuULtAyijZBdaC
         lRcOKEk6wCbAhgpgfROPFgiYbkMFbws7qMPV0CH4WbreEFnY1euJLmvLwcM/oEDlDRFg
         d2+w==
X-Gm-Message-State: ABuFfoguZUVAcE/8DZJZXn+tLZSGM8p0rbsEEE7Q04YT+ppaBUFxOh8T
        oVxFxOSoc569usVsJ+4lkJE6S3rZZWiKa+0aTB4=
X-Google-Smtp-Source: ACcGV61Pr2ntSuNrh9T8icO9yqY6Xq4raNtkn7RsZP2tnOElzzWcuNOeFc8kNmahyhWzB7ZiSEmAlHARxFwQHJq6nX8=
X-Received: by 2002:a2e:b04b:: with SMTP id d11-v6mr4820960ljl.93.1538676551564;
 Thu, 04 Oct 2018 11:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com> <20181004123400.GC30658@n2100.armlinux.org.uk>
In-Reply-To: <20181004123400.GC30658@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 4 Oct 2018 23:42:18 +0530
Message-ID: <CAFqt6zZPOM17QwmcWKF3F1gqkJm=2PxvuJ3naWuRXZGHc2HrEQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
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

On Thu, Oct 4, 2018 at 6:04 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 04, 2018 at 05:45:13PM +0530, Souptick Joarder wrote:
> > On Thu, Oct 4, 2018 at 3:45 AM Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Wed, Oct 03, 2018 at 01:00:03PM -0700, Matthew Wilcox wrote:
> > > > On Thu, Oct 04, 2018 at 12:28:54AM +0530, Souptick Joarder wrote:
> > > > > These are the approaches which could have been taken to handle
> > > > > this scenario -
> > > > >
> > > > > *  Replace vm_insert_page with vmf_insert_page and then write few
> > > > >    extra lines of code to convert VM_FAULT_CODE to errno which
> > > > >    makes driver users more complex ( also the reverse mapping errno to
> > > > >    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
> > > > >    not preferred to introduce anything similar again)
> > > > >
> > > > > *  Maintain both vm_insert_page and vmf_insert_page and use it in
> > > > >    respective places. But it won't gurantee that vm_insert_page will
> > > > >    never be used in #PF context.
> > > > >
> > > > > *  Introduce a similar API like vm_insert_page, convert all non #PF
> > > > >    consumer to use it and finally remove vm_insert_page by converting
> > > > >    it to vmf_insert_page.
> > > > >
> > > > > And the 3rd approach was taken by introducing vm_insert_kmem_page().
> > > > >
> > > > > In short, vmf_insert_page will be used in page fault handlers
> > > > > context and vm_insert_kmem_page will be used to map kernel
> > > > > memory to user vma outside page fault handlers context.
> > > >
> > > > As far as I can tell, vm_insert_kmem_page() is line-for-line identical
> > > > with vm_insert_page().  Seriously, here's a diff I just did:
> > > >
> > > > -static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> > > > -                       struct page *page, pgprot_t prot)
> > > > +static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > > > +               struct page *page, pgprot_t prot)
> > > > -       /* Ok, finally just insert the thing.. */
> > > > -int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> > > > +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > > > -       return insert_page(vma, addr, page, vma->vm_page_prot);
> > > > +       return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
> > > > -EXPORT_SYMBOL(vm_insert_page);
> > > > +EXPORT_SYMBOL(vm_insert_kmem_page);
> > > >
> > > > What on earth are you trying to do?
> >
> > >
> > > Reading the commit log, it seems that the intention is to split out
> > > vm_insert_page() used outside of page-fault handling with the use
> > > within page-fault handling, so that different return codes can be
> > > used.
> > >
> > > I don't see that justifies the code duplication - can't
> > > vm_insert_page() and vm_insert_kmem_page() use the same mechanics
> > > to do their job, and just translate the error code from the most-
> > > specific to the least-specific error code?  Do we really need two
> > > copies of the same code just to return different error codes.
> >
> > Sorry about it.
> > can I take below approach in a patch series ->
> >
> > create a wrapper function vm_insert_kmem_page using vm_insert_page.
> > Convert all the non #PF users to use it.
> > Then make vm_insert_page static and convert inline vmf_insert_page to caller.
>
> I'm confused, what are you trying to do?
>
> It seems that we already have:
>
> vm_insert_page() - returns an errno
> vmf_insert_page() - returns a VM_FAULT_* code
>
> From what I _think_ you're saying, you're trying to provide
> vm_insert_kmem_page() as a direct replacement for the existing
> vm_insert_page(), and then make vm_insert_page() behave as per
> vmf_insert_page(), so we end up with:

yes, vm_insert_kmem_page() can be a direct replacement of vm_insert_page
or might be a wrapper function written using vm_insert_page whichever
suites better
based on feedback.

>
> vm_insert_kmem_page() - returns an errno
> vm_insert_page() - returns a VM_FAULT_* code
> vmf_insert_page() - returns a VM_FAULT_* code and is identical to
>       vm_insert_page()
>

After completion of conversion we end up with

 vm_insert_kmem_page() - returns an errno
 vmf_insert_page() - returns a VM_FAULT_* code


> Given that the documentation for vm_insert_page() says:
>
>  * Usually this function is called from f_op->mmap() handler
>  * under mm->mmap_sem write-lock, so it can change vma->vm_flags.
>  * Caller must set VM_MIXEDMAP on vma if it wants to call this
>  * function from other places, for example from page-fault handler.
>
> this says that the "usual" use method for vm_insert_page() is
> _outside_ of page fault handling - if it is used _inside_ page fault
> handling, then it states that additional fixups are required on the
> VMA.  So I don't get why your patch commentry seems to be saying that
> users of vm_insert_page() outside of page fault handling all need to
> be patched - isn't this the use case that this function is defined
> to be handling?

The answer is yes best of my knowledge.

But as mentioned in change log ->

Going forward, the plan is to restrict future drivers not
to use vm_insert_page ( *it will generate new errno to
VM_FAULT_CODE mapping code for new drivers which were already
cleaned up for existing drivers*) in #PF (page fault handler)
context but to make use of vmf_insert_page which returns
VMF_FAULT_CODE and that is not possible until both vm_insert_page
and vmf_insert_page API exists.

But there are some consumers of vm_insert_page which use it
outside #PF context. straight forward conversion of vm_insert_page
to vmf_insert_page won't work there as those function calls expects
errno not vm_fault_t in return.

If both {vm, vmf}_insert_page exists, vm_insert_page might be used for
#PF context which we want to protect by removing/ replacing vm_insert_page
with another similar/ wrapper API.

Is that the right answer of your question ? no ?

>
> If you're going to be changing the semantics, doesn't this create a
> flag day where we could get new users of vm_insert_page() using the
> _existing_ semantics merged after you've changed its semantics (eg,
> the return code)?

No, vm_insert_page API will remove/ replace only when all the user are
converted.
We will do it intermediately by first introducing new API, convert all
user to use it
and at final step remove the old API.
