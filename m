Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14A6C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5178F2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9QWadSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5178F2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbeJEBMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:12:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39952 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEBMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:12:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id r83-v6so9256092ljr.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDeLDOWiZ8D1+ftD5UEn1y6/xC0783YQihFZtOX3SlM=;
        b=d9QWadSYa0IlXJobbcvGI2jdUhXzZFIzK0+/IIXuCamUzKmeSYQBeBMk0yAo6I99W/
         MMWpHpIYbpJTPBjdQEU3EFMK69EBv8Wf4oFSehngnSZZbxDQEgjQoTJC+TkMYgjr/cNv
         I2nooDURofCzZ/vP631Ik90uU1yrt8E/6UU9p5J4qWzmj7UDuAm7XElsDtmA88kXWWi1
         FIwDnWIaEOB1lh1wx90NvUujwUeaB1W48XK+JNG6IOuAhvm3PmQ5wq1Yqb2EBt0wLcAO
         U6bHUXQ+Gx7VM3gOUuDucLs7ScBbTSt6PYV+R13u04jWJFjoadq2a1aHopvG876pDxRM
         BFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDeLDOWiZ8D1+ftD5UEn1y6/xC0783YQihFZtOX3SlM=;
        b=URzyERhqOIIM4TKbYE7Gq5UgJDEXkvEKUOcbyfg+rg05lTPbgiqGp9zNEq/7a4dL8I
         fUuW8Tsypd7IW3yhrf1D4+qD8CN9xxElhW4AlY//To/4S7mNHV3FVtHZYFCgjcqL82dY
         71XoRQB2wubdbchBfguKxUYeUx4MqJJgGZocpSk/WoiTMXZ55Z/SjDmzJ5hKDZ0Mb3hf
         El/Y5fNBLtCfpmWckNHO2VSHAf6pnBbyj5BnefFwHzeCgSC/jB+0UfIXHPl3GrqWjjIE
         azkhFy6yda//A+HrAMb42C2Qdq4gR9C0d92Lm2EH9guzwlvJlCylSH4f3onVRG+8QM+3
         Zepg==
X-Gm-Message-State: ABuFfohGwOyMrlJ8+V4SovTvbrZoyGwDml+OOA28K7Bs1GCzpsaWyu8b
        KtsTevgQ/AVKNFpPkRPNsgsGNWDBsehSDnuA3UA=
X-Google-Smtp-Source: ACcGV62dJPrYY7/5wWDYKX3MG3keouCXNrBeVOFQpcMWkb3hobs47g/jj3ypmIbxUv2HxCdd4WKNKViIn3GQ9KZgseU=
X-Received: by 2002:a2e:8514:: with SMTP id j20-v6mr3437910lji.111.1538677084201;
 Thu, 04 Oct 2018 11:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC> <20181003200003.GA9965@bombadil.infradead.org>
In-Reply-To: <20181003200003.GA9965@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 4 Oct 2018 23:51:12 +0530
Message-ID: <CAFqt6za_OxXArRQfzK1h3L1o+TgU+Xz02gLy2yp0rxAJfFwnqA@mail.gmail.com>
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

Hi Matthew,

On Thu, Oct 4, 2018 at 1:30 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Oct 04, 2018 at 12:28:54AM +0530, Souptick Joarder wrote:
> > These are the approaches which could have been taken to handle
> > this scenario -
> >
> > *  Replace vm_insert_page with vmf_insert_page and then write few
> >    extra lines of code to convert VM_FAULT_CODE to errno which
> >    makes driver users more complex ( also the reverse mapping errno to
> >    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
> >    not preferred to introduce anything similar again)
> >
> > *  Maintain both vm_insert_page and vmf_insert_page and use it in
> >    respective places. But it won't gurantee that vm_insert_page will
> >    never be used in #PF context.
> >
> > *  Introduce a similar API like vm_insert_page, convert all non #PF
> >    consumer to use it and finally remove vm_insert_page by converting
> >    it to vmf_insert_page.
> >
> > And the 3rd approach was taken by introducing vm_insert_kmem_page().
> >
> > In short, vmf_insert_page will be used in page fault handlers
> > context and vm_insert_kmem_page will be used to map kernel
> > memory to user vma outside page fault handlers context.
>
> As far as I can tell, vm_insert_kmem_page() is line-for-line identical
> with vm_insert_page().  Seriously, here's a diff I just did:
>
> -static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> -                       struct page *page, pgprot_t prot)
> +static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> +               struct page *page, pgprot_t prot)
> -       /* Ok, finally just insert the thing.. */
> -int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> -       return insert_page(vma, addr, page, vma->vm_page_prot);
> +       return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
> -EXPORT_SYMBOL(vm_insert_page);
> +EXPORT_SYMBOL(vm_insert_kmem_page);
>
> What on earth are you trying to do?

Shall I take below approach rather than just creating a identical API
same as vm_insert_page ??

1. create a wrapper function vm_insert_kmem_page using vm_insert_page.
2. Convert all the non #PF users to use it.
3. Then make vm_insert_page static and convert inline vmf_insert_page to caller.

In that way we will be having two functions vmf_insert_page (#PF) and
vm_insert_kmem_page (non #PF) and both will be using common vm_insert_page
which will be static.

I am clear with the problem statement but not very clear on my solution.
