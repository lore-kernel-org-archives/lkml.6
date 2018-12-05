Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEC5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBBA20672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 05:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ceMEcUYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBBA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeLEFxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 00:53:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38609 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLEFxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 00:53:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id a77so16522895oii.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 21:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSZQnPI0FBoEqglt9fZ3DmEr6tIcOBET7Whd6RBYZ2c=;
        b=ceMEcUYACj06PrSERxWENhlZxTZgy0iZFPghHZybh+9VoOmxEJeCgZtbwQp80l75ui
         TyxS4Qr7AYQMq1HKE/+S4Ha3oaJg8SA6cSifbtNskDL9pKxRmsqiZqIe6HvXZgmhp8eX
         XffBUg2Aq7Ob/ooEEJt4ndIt6pG9bo4AwNiU4r6Qa1va0+5qGXkI3waIVCZSwfsMOMD+
         gtVv4SkvjpiCSDPyh7vlPrCexIAhaLgDJivvL4XXfWNEQfausA2bMD9RbXYHF59NXi7s
         Cpm1a+bEe7pbm2xuSvVNJynHsX1OBvw30ATi+hnBnXmgUqaSQ5t5qvuU2GEM8GcN0UMT
         yo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSZQnPI0FBoEqglt9fZ3DmEr6tIcOBET7Whd6RBYZ2c=;
        b=pjbNT1RoHPZw4XCzvQ3KeY+tyxjCMOY6+V1BD68yIEDe6ZycHr9yN2IiNdOGAq8oza
         nernBFC0GYOgGwsVFpuuUpemFCze+M8y0Aq4pDIT6WhIofNdjjTQBIK9qc3UheQfum5X
         vDGL+Hpb+/X3P4IVhUPwAc2T5GhdAw2eNUPeE94REMKFDegdypvVhmTfVmhlKR55Zi6I
         LsAPzsUEuPeOhtKYOsCx6fbji66UbSsXVcEcH5m5A8wBFs3b3Zz3TBuX2PoGNYXEoitY
         +tpJ4jSBBTNGA9atTKO6HwOobEsbZ8i2nnYSa52Mki730fy+loE/ZLWhBR3Rz8d+VgLb
         wCzg==
X-Gm-Message-State: AA+aEWYHGpvinxAzNHVm+eQ+G1ZbOL6JouzgAeId6+xZYFdnik2KjZcW
        P9HN9teJh9qRLLH8kXdZn70wAYm61Ow3/ZJ20CkKIQ==
X-Google-Smtp-Source: AFSGD/WaQXDwqfHGL70m5iWhhPfizJ/tKJiZgpXKZG45gD/OxZL2QxUdHmVU1uoNO+uxI+krKeUTPQps7TtYfKsoEwY=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr8279595oig.232.1543989186763;
 Tue, 04 Dec 2018 21:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20181204001720.26138-1-jhubbard@nvidia.com> <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com> <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com> <20181205011519.GV10377@bombadil.infradead.org>
In-Reply-To: <20181205011519.GV10377@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Dec 2018 21:52:54 -0800
Message-ID: <CAPcyv4iFi-gU8POphX=wHoMLFweC6D36PVf-yLmMqwUqD19bVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:15 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Dec 04, 2018 at 04:58:01PM -0800, John Hubbard wrote:
> > On 12/4/18 3:03 PM, Dan Williams wrote:
> > > Except the LRU fields are already in use for ZONE_DEVICE pages... how
> > > does this proposal interact with those?
> >
> > Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
> > use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
> > way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
> >
> > If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole
> > LRU field approach is unusable.
>
> We just need to rearrange ZONE_DEVICE pages.  Please excuse the whitespace
> damage:
>
> +++ b/include/linux/mm_types.h
> @@ -151,10 +151,12 @@ struct page {
>  #endif
>                 };
>                 struct {        /* ZONE_DEVICE pages */
> +                       unsigned long _zd_pad_2;        /* LRU */
> +                       unsigned long _zd_pad_3;        /* LRU */
> +                       unsigned long _zd_pad_1;        /* uses mapping */
>                         /** @pgmap: Points to the hosting device page map. */
>                         struct dev_pagemap *pgmap;
>                         unsigned long hmm_data;
> -                       unsigned long _zd_pad_1;        /* uses mapping */
>                 };
>
>                 /** @rcu_head: You can use this to free a page by RCU. */
>
> You don't use page->private or page->index, do you Dan?

I don't use page->private, but page->index is used by the
memory-failure path to do an rmap.
