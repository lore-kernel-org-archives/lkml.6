Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B1720831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0N03DeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B1720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbeKTBdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:33:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40932 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbeKTBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:33:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so5465318lji.7;
        Mon, 19 Nov 2018 07:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvR9CCPpY/aLV5Jk38x7MS/QbnbaQkYNH7EwbFZeHZs=;
        b=G0N03DePCZtEY/S19OCFp9LVhQuBp4OalDGEJgLLQyQgzirQ5QLFQ8znzKvNi3fPWI
         A4M1/+uzZbxSpDkMtDovc8CA27mhQdH4o43ejEuYZq6igcSGYmxD3Cf8OTBHiRk4SnfV
         kvqfpNfKDwwWr+hk9gWNjkbDjztpLldf9+kGFWc5PW04OUzEg0vLec7dVo3NhTmjoCT9
         lXAOeQ0JpVBE4nQmFfW3TLHkPjFlUd00hBXGSCb2M6syJEAySYaZWMkdYhZEyh90wmZr
         xr50T7TMUlLnIGEntitw2zoqqobQt1M+Rg5Hfh9qhn17v9I1DQSQ83p3vyw+8NwpTAWM
         dPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvR9CCPpY/aLV5Jk38x7MS/QbnbaQkYNH7EwbFZeHZs=;
        b=WAHEtNWEBtR7BR9anqJtqeDVJdchV5eTa6wGf9FRy9giRLyCyYSQDEgOlwR26ge5K3
         sHGOIF7kiU5EEenAup5BtxC/Q3dNb8mONtNrpYw38n1x67tNIxrfKsnQYoYBg8VQxqJL
         9DIdAl4jeaFJvW6jRdZlPeqm2nzj7I+5c94lT670JdR7jvXvHBeZn//YJFauGk85RhFv
         x5IgI3fQnI80edwaJ4EeHmi9ouuDIMCwoo9TvMihYXBqB5Ndjkp9aMOsWQPqM3Bwxfqu
         q5tsTVZYx2+PGv6ufSFdSTi/sP+yi/DuBHknEBJ8Xsc1a7dD1u3p727x4rLT56ZKUXKn
         sqLA==
X-Gm-Message-State: AGRZ1gLKsfdgH7cCiFLQ7e94Yp7giIuH+J75MBn+iDMPjzTK+eyWxzMC
        FFtiEt1CIz3mf6aauFhmRP9pK99oHqFzpg+q1YAEFlb5
X-Google-Smtp-Source: AFSGD/XY+n8YDA9XvnM2p4vE00ddLVjQYc6i51Z5rDvKJcuFzFmoQrz1KQIsEGBuonpdrIaEUeZVt4QcOc/dSFyD6Ho=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr1350401lji.93.1542640181361;
 Mon, 19 Nov 2018 07:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <20181116182836.GB17088@rapoport-lnx> <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
 <20181117143742.GB7861@bombadil.infradead.org>
In-Reply-To: <20181117143742.GB7861@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 19 Nov 2018 20:43:09 +0530
Message-ID: <CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
To:     Matthew Wilcox <willy@infradead.org>, rppt@linux.ibm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, Rik van Riel <riel@surriel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        rppt@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        oleksandr_andrushchenko@epam.com, joro@8bytes.org,
        pawel@osciak.com, Kyungmin Park <kyungmin.park@samsung.com>,
        mchehab@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, xen-devel@lists.xen.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sat, Nov 17, 2018 at 8:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Nov 17, 2018 at 12:26:38PM +0530, Souptick Joarder wrote:
> > On Fri, Nov 16, 2018 at 11:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > + * vm_insert_range - insert range of kernel pages into user vma
> > > > + * @vma: user vma to map to
> > > > + * @addr: target user address of this page
> > > > + * @pages: pointer to array of source kernel pages
> > > > + * @page_count: no. of pages need to insert into user vma
> > > > + *
> > > > + * This allows drivers to insert range of kernel pages they've allocated
> > > > + * into a user vma. This is a generic function which drivers can use
> > > > + * rather than using their own way of mapping range of kernel pages into
> > > > + * user vma.
> > >
> > > Please add the return value and context descriptions.
> > >
> >
> > Sure I will wait for some time to get additional review comments and
> > add all of those requested changes in v2.
>
> You could send your proposed wording now which might remove the need
> for a v3 if we end up arguing about the wording.

Does this description looks good ?

/**
 * vm_insert_range - insert range of kernel pages into user vma
 * @vma: user vma to map to
 * @addr: target user address of this page
 * @pages: pointer to array of source kernel pages
 * @page_count: number of pages need to insert into user vma
 *
 * This allows drivers to insert range of kernel pages they've allocated
 * into a user vma. This is a generic function which drivers can use
 * rather than using their own way of mapping range of kernel pages into
 * user vma.
 *
 * Context - Process context. Called by mmap handlers.
 * Return - int error value
 * 0                    - OK
 * -EINVAL              - Invalid argument
 * -ENOMEM              - No memory
 * -EFAULT              - Bad address
 * -EBUSY               - Device or resource busy
 */
