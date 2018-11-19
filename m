Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38374C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB64214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9AflzgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB64214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389912AbeKTEGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:06:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35838 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389109AbeKTEGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:06:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so20147718lfc.2;
        Mon, 19 Nov 2018 09:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rFIGnhbbxJlKc/xgO0vXKwYw+G/JysDisiDFhdxpmu8=;
        b=Q9AflzgVy3pshc/bFJP5B7VEvO4Ssj24P1ua3FSAV2Sjn6WmXucsWjCAxTr4+uQNKh
         +zwpskzEjsY6EN1fCPqeeLuglqKflA669vngPOvrbOeciIvpjUUfNW/I1nFp8LJMxgbM
         YH9BMehBcXQCb3N7Eb+BxdgMAahIX4dxM7r0MW9bM0jU3/Xm8pw7dHWYoCsFpun8RvYR
         mCZbKzqbwZmpqgC/ygvBiG62U2iJaNnniwvRaUHIZAVzy0dGkirkdSsaMinGsy9vkAIk
         2JX/3hOCG4iMo2rnhHVY48Wbhi5X+qP62Ttfb+bz6hB7dvPqBUehcPSCZBPYxeM3+FXx
         Pthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rFIGnhbbxJlKc/xgO0vXKwYw+G/JysDisiDFhdxpmu8=;
        b=VKmF48g1plqiuxWeMKgJuIuUWPydrm1wQFVNOjS7QAadASxDwpEiU3L/bxHyieEP4r
         /NVx5Jmf+QVupmZ3Hg3IBz+cGt1evCuntQgOa8lIgBTo2mYneJ+UrY6a+SFiuScerMWS
         2Wlx9KhRcgz4GrfxvMSd/NNTb7Zia6m6MZMo62+Mj+HjHp7AxgJwX5zRTjF1X4ENFgDR
         xE0DZiOzJpNEPWdFXgvj30dXQtOTnK/oEhBFEu992QbfARnXbPi6Wlw+to1HYc4/vxs9
         C2jjxEm4oEXHjZEHH0XFwNYdzJS1Fsw7KAaiimR8Y5DFzBRhK+FoglRzTZTkXhX9su3d
         kQyg==
X-Gm-Message-State: AGRZ1gKpRmy+UBKe0p9DZNvK2x+8xGuwsQ0EfENa1TQQppDOScCZEZtV
        lvja04zh2FUkpejtOqVVR4x1WJhqn7AHVBj0j58=
X-Google-Smtp-Source: AJdET5d2HXhE6GkMZ1IErSe2C2Zq8xG47FfN8OIaADB+XeRxOQi3mrmOlwByP1Zcs1luUtqjQYtLC4IFRKXyrNyAqWw=
X-Received: by 2002:a19:d912:: with SMTP id q18mr10709927lfg.24.1542649308760;
 Mon, 19 Nov 2018 09:41:48 -0800 (PST)
MIME-Version: 1.0
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <20181116182836.GB17088@rapoport-lnx> <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
 <20181117143742.GB7861@bombadil.infradead.org> <CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww@mail.gmail.com>
 <20181119162623.GA13200@rapoport-lnx>
In-Reply-To: <20181119162623.GA13200@rapoport-lnx>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 19 Nov 2018 23:15:15 +0530
Message-ID: <CAFqt6zbhodAGQz-RCB3C-wt_Mvb9QDmQ8pFeP2EO+ba2k2OccA@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
To:     rppt@linux.ibm.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Nov 19, 2018 at 9:56 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Nov 19, 2018 at 08:43:09PM +0530, Souptick Joarder wrote:
> > Hi Mike,
> >
> > On Sat, Nov 17, 2018 at 8:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sat, Nov 17, 2018 at 12:26:38PM +0530, Souptick Joarder wrote:
> > > > On Fri, Nov 16, 2018 at 11:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > > > + * vm_insert_range - insert range of kernel pages into user vma
> > > > > > + * @vma: user vma to map to
> > > > > > + * @addr: target user address of this page
> > > > > > + * @pages: pointer to array of source kernel pages
> > > > > > + * @page_count: no. of pages need to insert into user vma
> > > > > > + *
> > > > > > + * This allows drivers to insert range of kernel pages they've allocated
> > > > > > + * into a user vma. This is a generic function which drivers can use
> > > > > > + * rather than using their own way of mapping range of kernel pages into
> > > > > > + * user vma.
> > > > >
> > > > > Please add the return value and context descriptions.
> > > > >
> > > >
> > > > Sure I will wait for some time to get additional review comments and
> > > > add all of those requested changes in v2.
> > >
> > > You could send your proposed wording now which might remove the need
> > > for a v3 if we end up arguing about the wording.
> >
> > Does this description looks good ?
> >
> > /**
> >  * vm_insert_range - insert range of kernel pages into user vma
> >  * @vma: user vma to map to
> >  * @addr: target user address of this page
> >  * @pages: pointer to array of source kernel pages
> >  * @page_count: number of pages need to insert into user vma
> >  *
> >  * This allows drivers to insert range of kernel pages they've allocated
> >  * into a user vma. This is a generic function which drivers can use
> >  * rather than using their own way of mapping range of kernel pages into
> >  * user vma.
> >  *
> >  * Context - Process context. Called by mmap handlers.
>
> Context:
>
> >  * Return - int error value
>
> Return:
>
> >  * 0                    - OK
> >  * -EINVAL              - Invalid argument
> >  * -ENOMEM              - No memory
> >  * -EFAULT              - Bad address
> >  * -EBUSY               - Device or resource busy
>
> I don't think that elaborate description of error values is needed, just "0
> on success and error code otherwise" would be sufficient.

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
 * Context: Process context. Called by mmap handlers.
 * Return: 0 on success and error code otherwise
 */
