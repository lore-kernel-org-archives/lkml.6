Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0B6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A18E20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwNd5rdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A18E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJDTI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:08:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43404 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJDTI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:08:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id r8-v6so8124115ljc.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owfY93D/AZyx/pWCU2S4gZFwRLheDcKJ6m0Ky0moCA0=;
        b=FwNd5rdB9Hj56MpI/YhPqXpPChMVrX5x9XRkdsE+ekihFtUZJiV5aOD3H0QRh1PIzy
         p5LVenOeMzterFzKfI+cAnJoCgWe0ZejLQiGfzitApKI8N0df08ytWASvtrfTm7IBL2U
         LUuEvpzeXC7vNx4ZNSTv+n82kedHut95pR5rL7izCzL7eTnOihI/Rk/hEeARyZ59b/3c
         QVaMqbGTPSmwZDLD9pQr3GLImAoBPDVbeRcdMn5chMkCQZnANySpErmpXwqllyuu/gQt
         Cqg8OHhctPuQ/XtoAhkbUUa4BFW2Sf2U/IkpxbG9tExt+DvEAUV0JPocrmBBWmGY395s
         YFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owfY93D/AZyx/pWCU2S4gZFwRLheDcKJ6m0Ky0moCA0=;
        b=SpNb69nCHgNdsVsOUR3GbvBnqi8isbdI/DMjp1RudH5yje2DWfk/GzBORIold3t5bi
         F43qBIXHoHRJT3EHxLKeX0wzXtKAUeHakyV9CwZvj+jgcxIbC3txg225ZjhmXj+3Tp5G
         9ETAjEbTX2nwCIH8BuCc/lqCKuZ6XVgKMVL6wT4/Bw3Hro4QzKvG5RLL9qhXYLMui9sV
         lAMicMEGwL4flHET3DoQHe1zPIg+QjEW6WnFTw41GesdsXFmbiKUdOhbS/V/bxKFRy1s
         neI9smvVED2b6cbdlRy+Skl5ciSRn5hdn1X7mvVbwcShKVubRb2UWNhUWGvja7Ug1ApC
         Y/cA==
X-Gm-Message-State: ABuFfogL3jLcn2MwOyL9wguB2W92TkMhic+KvdnaoowC7ctioLHW4qIl
        SIt9VJKx+kLM1pSSpqALLX1J/knSo+i57irqyv0=
X-Google-Smtp-Source: ACcGV61ChL/YkEaob5D8q1Q1A+q6gACPVpRrR5jaSH4Ljem3rLVtRbnlLeVZc1HTCXYNu3ggz1KI6VbU1NDS6m8NITo=
X-Received: by 2002:a2e:b04b:: with SMTP id d11-v6mr3942847ljl.93.1538655325719;
 Thu, 04 Oct 2018 05:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org> <20181003221444.GZ30658@n2100.armlinux.org.uk>
In-Reply-To: <20181003221444.GZ30658@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 4 Oct 2018 17:45:13 +0530
Message-ID: <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
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

On Thu, Oct 4, 2018 at 3:45 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Wed, Oct 03, 2018 at 01:00:03PM -0700, Matthew Wilcox wrote:
> > On Thu, Oct 04, 2018 at 12:28:54AM +0530, Souptick Joarder wrote:
> > > These are the approaches which could have been taken to handle
> > > this scenario -
> > >
> > > *  Replace vm_insert_page with vmf_insert_page and then write few
> > >    extra lines of code to convert VM_FAULT_CODE to errno which
> > >    makes driver users more complex ( also the reverse mapping errno to
> > >    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
> > >    not preferred to introduce anything similar again)
> > >
> > > *  Maintain both vm_insert_page and vmf_insert_page and use it in
> > >    respective places. But it won't gurantee that vm_insert_page will
> > >    never be used in #PF context.
> > >
> > > *  Introduce a similar API like vm_insert_page, convert all non #PF
> > >    consumer to use it and finally remove vm_insert_page by converting
> > >    it to vmf_insert_page.
> > >
> > > And the 3rd approach was taken by introducing vm_insert_kmem_page().
> > >
> > > In short, vmf_insert_page will be used in page fault handlers
> > > context and vm_insert_kmem_page will be used to map kernel
> > > memory to user vma outside page fault handlers context.
> >
> > As far as I can tell, vm_insert_kmem_page() is line-for-line identical
> > with vm_insert_page().  Seriously, here's a diff I just did:
> >
> > -static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> > -                       struct page *page, pgprot_t prot)
> > +static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > +               struct page *page, pgprot_t prot)
> > -       /* Ok, finally just insert the thing.. */
> > -int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> > +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > -       return insert_page(vma, addr, page, vma->vm_page_prot);
> > +       return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
> > -EXPORT_SYMBOL(vm_insert_page);
> > +EXPORT_SYMBOL(vm_insert_kmem_page);
> >
> > What on earth are you trying to do?

>
> Reading the commit log, it seems that the intention is to split out
> vm_insert_page() used outside of page-fault handling with the use
> within page-fault handling, so that different return codes can be
> used.
>
> I don't see that justifies the code duplication - can't
> vm_insert_page() and vm_insert_kmem_page() use the same mechanics
> to do their job, and just translate the error code from the most-
> specific to the least-specific error code?  Do we really need two
> copies of the same code just to return different error codes.

Sorry about it.
can I take below approach in a patch series ->

create a wrapper function vm_insert_kmem_page using vm_insert_page.
Convert all the non #PF users to use it.
Then make vm_insert_page static and convert inline vmf_insert_page to caller.
