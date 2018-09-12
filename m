Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83457C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C52C20883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJwQGZzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C52C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeILFxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:53:12 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50186 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeILFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:53:12 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so803931ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Bp5lpcwY2KV1TK1laCJynoM0S298G59R+JbaKrUErY=;
        b=hJwQGZzoMI1pZFeshvtiz1oOB4Me+JkiYnAeIkf4ShEh/6i5LwOb1JD1TiNEqCJtDv
         cWVejsKyMCL77ObnORGBzG7Vtf3+WPWpEsIigNxQIwYe/2wUUgbNgFiPTLDQ87QEfxSl
         BqLX9zXUFcnzsByrfRydWBNg37az+YFyCGpHJgBzXbvlGh+KDGim0apyDBtTHzVk8AqG
         FBAmWrynAm0VMYlOmwPIT/5DZlqNNWg6TLz5aRx1Cb0N28OI0j/LKPnd4HAOXfByIYqF
         wpu66WdoePaUX1aEGgFBzsAdx/DpIsBLpczRVkS/LOBJyv8e4YhTMG3B7LomM3znBPFF
         d04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Bp5lpcwY2KV1TK1laCJynoM0S298G59R+JbaKrUErY=;
        b=CeJhgXg/u/ngi5BAoonH5ksivHagkHbayMsEEZGJK64sunzWEnCoSTOL675aOitbKT
         UEu6dKW7ggzS/HeEV77kBqaecUT8SRhhUKAVnzgvpMel7LlelT6wNrgXm/DQRANB8vee
         U9yp6JBwOG750zAVmi+rYSlZM7ivE/2EA0il3u7kkFAYAKSQU9Obn9orIkP07zLAjFYi
         K7C7HguVc9LciwJV+0SLnvrrmIZA6iWp0QhO4Zhfw4IxKagYo7kKaUAgP64K7yWoiYfG
         2xTjIQkzmfZayh+Zu5zJZp7XhGz9oT2HkO8S29Y+1xgeAsmxbv8qQrhgV2DxKZz3ok0b
         Aw1w==
X-Gm-Message-State: APzg51CDl9hF/Vyg4otdAWMrJgn1fZ8ZYQUXRwJS+Q/TtGhkP0qSlyd1
        7ZWkN4ol6o1aU+J/+jMLDWtAaa4W08yIYJqq5fSpsg==
X-Google-Smtp-Source: ANB0VdZBbUZpoVOV1SCmkyVTK1rNaiNPC4cVaYzvQxKtaqVl3VsZ+jUpYMOhjhGjWuigGPTv2KgRKUNs30LcOEElarU=
X-Received: by 2002:a24:ed84:: with SMTP id r126-v6mr4216409ith.58.1536713478893;
 Tue, 11 Sep 2018 17:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234354.4068.65260.stgit@localhost.localdomain> <CAPcyv4ja7=eUbwwJZhreexa9_7JyJotQwObrQm=nCEcgcfbWyw@mail.gmail.com>
In-Reply-To: <CAPcyv4ja7=eUbwwJZhreexa9_7JyJotQwObrQm=nCEcgcfbWyw@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 11 Sep 2018 17:51:07 -0700
Message-ID: <CAKgT0UdmkAXLdR6cfgmu-LcJUOO8a4qAS8zO3Bn+LwjJ9rT3pg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     dan.j.williams@intel.com
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org, pavel.tatashin@microsoft.com,
        Michal Hocko <mhocko@suse.com>, dave.jiang@intel.com,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, jglisse@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>, logang@deltatee.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 3:35 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Sep 10, 2018 at 4:43 PM, Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> >
> > The ZONE_DEVICE pages were being initialized in two locations. One was with
> > the memory_hotplug lock held and another was outside of that lock. The
> > problem with this is that it was nearly doubling the memory initialization
> > time. Instead of doing this twice, once while holding a global lock and
> > once without, I am opting to defer the initialization to the one outside of
> > the lock. This allows us to avoid serializing the overhead for memory init
> > and we can instead focus on per-node init times.
> >
> > One issue I encountered is that devm_memremap_pages and
> > hmm_devmmem_pages_create were initializing only the pgmap field the same
> > way. One wasn't initializing hmm_data, and the other was initializing it to
> > a poison value. Since this is something that is exposed to the driver in
> > the case of hmm I am opting for a third option and just initializing
> > hmm_data to 0 since this is going to be exposed to unknown third party
> > drivers.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > ---
> >  include/linux/mm.h |    2 +
> >  kernel/memremap.c  |   24 +++++---------
> >  mm/hmm.c           |   12 ++++---
> >  mm/page_alloc.c    |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>
> Hmm, why mm/page_alloc.c and not kernel/memremap.c for this new
> helper? I think that would address the kbuild reports and keeps all
> the devm_memremap_pages / ZONE_DEVICE special casing centralized. I
> also think it makes sense to move memremap.c to mm/ rather than
> kernel/ especially since commit 5981690ddb8f "memremap: split
> devm_memremap_pages() and memremap() infrastructure". Arguably, that
> commit should have went ahead with the directory move.

The issue ends up being the fact that I would then have to start
exporting infrastructure such as __init_single_page from page_alloc. I
have some follow-up patches I am working on that will generate some
other shared functions that can be used by both memmap_init_zone and
memmap_init_zone_device, as well as pulling in some of the code from
the deferred memory init.
