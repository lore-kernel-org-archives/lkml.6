Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333FCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA21921547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVQlhee0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA21921547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389787AbeIUQzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:55:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38675 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbeIUQzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:55:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id z186-v6so11113868lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 04:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7uqatd69//ARjcWVxEdaHHdEiont/4rQWceZyw8o8w=;
        b=FVQlhee0S4WN8Uh98db7m9en+2NKIJ1QdKaPFNhqJwtHVQ57I9ZoRIjHvcdC7RGtpn
         +d4K37mwhWWaz932/3p7I8Kw85f42zhik5ovEll6olJp4dowQVj8lVeunktId1pzKkLn
         rDBgYhfn99/jKAvAKWuSIi0WXdA215zydavD/l/DhHLVu9rhxbN0RDIvCmOKggeUha01
         CLL7PD1jlO5HbpZ9FeshnFw8svSiTQb2+840wQSeJUACCTzIe96FSCYMclTQn0ukTRsJ
         cLzgRuFbcAon5TKK1nNaIeDhVvvwBdX4HBQJXuNbRt2KgAo+GRaNgwKkfm1ZPu5MWbzj
         l6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7uqatd69//ARjcWVxEdaHHdEiont/4rQWceZyw8o8w=;
        b=Pq+s0kg5TdVgWvSc0PA4rWEXPIcJojJOxa+VUvIXVlGHAo/2nxzNggg0/01zZ4+Kas
         0cY/IkTwwLt7QiCtAtGN3zO02m9qCOF0FZaWy1b434FyP2/x81P/C5kpU4/SekeGl88v
         tQM8YlsTfYw4Uyjc/CWptTWj1QpeGXuLS/KtXVMbOl/FmgQmSxOgkh25WRkAMMe4MEM4
         4sG3PicCUFS2ZKNPyH0nzaNwqV39etXzJUZy6+pQk0oOk3ux3XR72wUTFEjwOVQxwlT3
         4SrppLgW+x9j+BYK7ADLgH/Laj4uE794cLEnUrFepZ9LVo0howrcuGMtPbFPFg1EDHOG
         90uA==
X-Gm-Message-State: APzg51C6liF2f3qLfg1dHPNziQew8EDnAXzA73CTDkNLBFJ5Ev++9ktP
        HkT850RKFwKco+f7vJnaH3SnTz+LsZrQf6W8czs=
X-Google-Smtp-Source: ANB0VdZxw/wm72D9PnxzNEUilsoYR4hxwNpbaaFBG6UfOdKVE+HDLCSX9azb8d2IivmvD/Xq7STchOQivwn5kpnUboA=
X-Received: by 2002:a19:cc97:: with SMTP id c145-v6mr20819215lfg.145.1537528048631;
 Fri, 21 Sep 2018 04:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180920202316.GA6038@jordon-HP-15-Notebook-PC> <CANiq72kQA45ekbSruh-zTsc9B-9EOxZna=cOgOcM7--owxrWsA@mail.gmail.com>
In-Reply-To: <CANiq72kQA45ekbSruh-zTsc9B-9EOxZna=cOgOcM7--owxrWsA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 21 Sep 2018 16:37:16 +0530
Message-ID: <CAFqt6zYtptZNeXbJwcJemb5O8rKjcB9=FpfiH60wK9v6vd0A2A@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay/cfag12864bfb.c: Replace vm_insert_page
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 2:56 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Sep 20, 2018 at 10:23 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > There is a plan to remove vm_insert_page permanently
> > and replace it with new API vmf_insert_page which will
> > return vm_fault_t type. As part of it vm_insert_page
> > is removed from this driver.
>
> A link to the discussion/plan would be nice. The commit 1c8f422059ae5
> ("mm: change return type to vm_fault_t") explains a bit, but has a
> broken link :( Googling for the stuff returns many of the patches, but
> not the actual discussion...

This might be helpful.
https://marc.info/?l=linux-mm&m=152054772413234&w=4
>
> >  static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> >  {
> > -       return vm_insert_page(vma, vma->vm_start,
> > -               virt_to_page(cfag12864b_buffer));
> > +       struct page *page;
> > +       unsigned long size = vma->vm_end - vma->vm_start;
> > +
> > +       page = virt_to_page(cfag12864b_buffer);
> > +       return remap_pfn_range(vma, vma->vm_start, page_to_pfn(page),
> > +                               size, vma->vm_page_prot);
>
> I am out of the loop on these mm changes, so please indulge me, but:
>
>   * Why is there no documentation on vmf_insert_page() while
> vm_insert_page() had it? (specially since it seems you want to remove
> vm_insert_page()).

The plan is to convert vm_insert_{page,pfn,mixed} to
vmf_insert_{page,pfn,mixed}. As a good intermediate
steps inline wrapper vmf_insert_{pfn,page,mixed} are
introduced. After all the drivers converted, we will convert
vm_insert_page to vmf_insert_page and remove the inline
wrapper and update the document at the same time.

>
>   * Shouldn't we have a simple remap_page() or remap_kernel_page() to
> fit this use case and avoid that dance? (another driver in auxdisplay
> will require the same change, and I guess others in the kernel as
> well).


There are few drivers similar like auxdisplay where straight forward
conversion from vm_insert_page to vmf_insert_page is not possible.

So I mapped the kernel memory to user vma using remap_pfn_range
and remove vm_insert_page in this driver.

Other way, is to replace vm_insert_page with vmf_insert_page() and
then convert VM_FAULT_CODE back to errno. But as part of vm_fault_t
migration we have already removed/cleanup most the errno to VM_FAULT_CODE
mapping from drivers. So I prefer not to take this option.

Third, we can introduce a similar API like vm_insert_page say,
vm_insert_kmem_page() and use it for same scenarios like this.

If there is a better way to do this, we can discuss it.
