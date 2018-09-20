Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF592ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0C21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiAGorQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB0C21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeIUDMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:12:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41761 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:12:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id n3-v6so6332059qkn.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C65gcnhzFZDrTXelwDqfRuHxABI0s98NpgZXKP8xF8c=;
        b=KiAGorQh9C3OOh63iZ3begYbjdaS3jVMeUFWvvjasiYjcROsW8A2m3V7cXdhzRRWoh
         vgQxzoKGxheHhQTft4szSitsOdlNPmeT2DfWrRkAUvUz4dWpIKccbDLxUJ0U7E4KuJJa
         1yS1SkaCt/opkszbGWT1c95LASoZpiCEwZ9fiH422PTWwe2C1E1ZE1Xm64b8wYahp73w
         hW5Gf+XZ1jOoxaxaBiSZLjQFxSODiiautZpCdAiu0EaLZSbT3DjAuulU2lb9OZaAdZBh
         HHkoW+KFO19AQjK06HqMFSqNF3tX+DyxifOh6QG7IXb1t0fRzIMn/pw/si6eicIHYjiw
         W22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C65gcnhzFZDrTXelwDqfRuHxABI0s98NpgZXKP8xF8c=;
        b=aU6x2Ru5JHgypIyLhihWPtGLsGVpoLHn+AoqS7NzCDAoi1DHmcDL2SCrBbVFm7R9Tv
         6cOpQ09jcpMhSmPMy7Zvx0uTYTOZ27GNX+t2Ds8qmM8Ec+UQvf0HoyrJZCV4vFzHmY5E
         hPW+0yrfK9q8vAo/Ao6aUjXGRZqrUEPHDoSJ1ojyqbYEEMuoY0xn5qzBpDrW5hbc2l83
         rbda7fcWaml/Kx9LsFElxDk2zUVGgqFe+yiIsvsR5MGS/xrFsk1PrgBo3Dc5+8jgipoA
         Z66TbbYtlWU9xVPP7b4VdqioSsVhJ6pE8JMzVI8dSs2WEr84ocwOC8xQolrCbTDd4H7T
         z0VA==
X-Gm-Message-State: APzg51Dd3p9GHOSXV+jyL5SBoiD+svZuUHO6o/bryVNBVo8W8SeW7W7E
        jqgxrOXkWzznR4FKyTen1IBS+WrwNCQhQvNIMqE=
X-Google-Smtp-Source: ANB0VdZhGiKjeIHG8bLIUkuWpNieRNcqWTXsZiKvcWb+A/9SBLxY9FaEr+Ka/bDZ4kWjCEp7SAxpFwXDLxH93qJU+P8=
X-Received: by 2002:ac8:34ce:: with SMTP id x14-v6mr4308377qtb.115.1537478796567;
 Thu, 20 Sep 2018 14:26:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 14:26:16
 -0700 (PDT)
In-Reply-To: <20180920202316.GA6038@jordon-HP-15-Notebook-PC>
References: <20180920202316.GA6038@jordon-HP-15-Notebook-PC>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Sep 2018 23:26:16 +0200
Message-ID: <CANiq72kQA45ekbSruh-zTsc9B-9EOxZna=cOgOcM7--owxrWsA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay/cfag12864bfb.c: Replace vm_insert_page
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:23 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> There is a plan to remove vm_insert_page permanently
> and replace it with new API vmf_insert_page which will
> return vm_fault_t type. As part of it vm_insert_page
> is removed from this driver.

A link to the discussion/plan would be nice. The commit 1c8f422059ae5
("mm: change return type to vm_fault_t") explains a bit, but has a
broken link :( Googling for the stuff returns many of the patches, but
not the actual discussion...

>  static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
>  {
> -       return vm_insert_page(vma, vma->vm_start,
> -               virt_to_page(cfag12864b_buffer));
> +       struct page *page;
> +       unsigned long size = vma->vm_end - vma->vm_start;
> +
> +       page = virt_to_page(cfag12864b_buffer);
> +       return remap_pfn_range(vma, vma->vm_start, page_to_pfn(page),
> +                               size, vma->vm_page_prot);

I am out of the loop on these mm changes, so please indulge me, but:

  * Why is there no documentation on vmf_insert_page() while
vm_insert_page() had it? (specially since it seems you want to remove
vm_insert_page()).

  * Shouldn't we have a simple remap_page() or remap_kernel_page() to
fit this use case and avoid that dance? (another driver in auxdisplay
will require the same change, and I guess others in the kernel as
well).

Thanks!

Cheers,
Miguel
