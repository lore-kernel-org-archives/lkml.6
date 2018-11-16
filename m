Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A6AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B751A208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 08:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmqwLX+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B751A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbeKPS1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:27:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36379 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeKPS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 13:27:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so6911808ljk.3;
        Fri, 16 Nov 2018 00:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCg0WvMuoayQXkA0T12ud3whxcbYCfvy+f3I9Mi9au0=;
        b=kmqwLX+mfCKMIdW7/lOeafvCpy3XLpkhVqoVeCn75uaH7BhiBZEN8OOffyhAUqtHPY
         BpIebFBbDd07fRorDK1WWv2harcCwBg3icnOFhoQB8OLXJHz8TaQGi+utnl2esHxNT/E
         +lF3BZbfrHE68CJHirnG9BFSHldC89YPSXcFSr2Jv0De0OZvAvB+IUZwLvuyoyskwFVz
         l2yXQpmYP0m534l8WYfhpQeY4XuwGenjMqI/ELCtQQWIsD6+nZz3ERj+7DN6oq4HpZRb
         tILkId5RcYaDX1cdzByfKhmVl9WGCWIHr0meaLgOI2dJ1SLnaC/v+8W/uUKygMZh7yJ2
         X0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCg0WvMuoayQXkA0T12ud3whxcbYCfvy+f3I9Mi9au0=;
        b=riLvrozcHfV+xRTYb/CpXgO1rVPb4KfozXCYRXgJyF+wWgQl3fKeUZ51tIHG5W144l
         sc8+1Cqc06CGyqQz8AX99pzIq2Fr3omaXmlcqcIr+zx1sAwG2OPmNfGeinBeCrzaQ3tA
         AS+k6OUe/Rm6BHUn4gKMe1lsCMhfrPlmdcunBqhj4Qf5wy4uJVCOYO0AqRaBESA0YTZO
         MoA+23KtnHFSyIeiTmB0dvMkkP4ThgwQoGvLrdpHjwwDedvDE3GimTUn9sq+3x5LnAvX
         aBBZY25b9x1oIf4TJb/Vzpx91NgjsKFZQ7TvgMd4QOkHHn8Cf+oyV4oN8yNw4jjH48W8
         LgYw==
X-Gm-Message-State: AA+aEWY1lBLITcXgW3j11KT0FP1sz4pQrL0EPYRzUUIpJx/+82wTS5lZ
        babT9rSHIdLWlaRX6i4t+cDkWZeyzbciofac4x0=
X-Google-Smtp-Source: AFSGD/UYBfhE4wBhpDBwE5yZLs9JFILY8wGjF/DK+YX9NDDn6w6/fierFS0VAWKxp7BKElWOEfFeXyWofHHWnC+X/p8=
X-Received: by 2002:a2e:9f0b:: with SMTP id u11-v6mr2377435ljk.99.1542356162476;
 Fri, 16 Nov 2018 00:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org> <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
 <20181116064049.GA5320@bombadil.infradead.org>
In-Reply-To: <20181116064049.GA5320@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 16 Nov 2018 13:45:48 +0530
Message-ID: <CAFqt6zbL1tu4VWtZ5Wz-BgbOS+M2GJziMj958_h_ri4Th3n9bQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm: Introduce new vm_insert_range API
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
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

On Fri, Nov 16, 2018 at 12:11 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Nov 16, 2018 at 11:00:30AM +0530, Souptick Joarder wrote:
> > On Thu, Nov 15, 2018 at 11:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 11/15/18 7:45 AM, Souptick Joarder wrote:
> > > What is the opposite of vm_insert_range() or even of vm_insert_page()?
> > > or is there no need for that?
> >
> > There is no opposite function of vm_insert_range() / vm_insert_page().
> > My understanding is, in case of any error, mmap handlers will return the
> > err to user process and user space will decide the next action. So next
> > time when mmap handler is getting invoked it will map from the beginning.
> > Correct me if I am wrong.
>
> The opposite function, I suppose, is unmap_region().
>
> > > s/no./number/
> >
> > I didn't get it ??
>
> This is a 'sed' expression.  's' is the 'substitute' command; the /
> is a separator, 'no.' is what you wrote, and 'number' is what Randy
> is recommending instead.

Ok. Will change it in v2.
>
> > > > +     for (i = 0; i < page_count; i++) {
> > > > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > >
> > > For a non-trivial value of page_count:
> > > Is it a problem if vm_insert_page() succeeds for several pages
> > > and then fails?
> >
> > No, it will be considered as total failure and mmap handler will return
> > the err to user space.
>
> I think what Randy means is "What happens to the inserted pages?" and
> the answer is that mmap_region() jumps to the 'unmap_and_free_vma'
> label, which is an accurate name.

Sorry for incorrect understanding of the question.
