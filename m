Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6A8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88A320868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="L1Yqe0X/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88A320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeJLScT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:32:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39424 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeJLScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:32:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so5692457pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GEbrC9WoMx7yLYsqRtPBIyhrSuV+9giyvr/7VnB22LM=;
        b=L1Yqe0X/Iqbxggpg5gRFq0LOixMi+S3+WUyl1dAahvrs/73UFCbyJB7p7xUNsJCqz2
         J/55GuQdzQeSrWw5vmoMEE8bXsjr2xRVwJHTHHWhSP2jbj8b5qLJctFEjk10PIoV/lXH
         XRGrqfDuXDTB2dTifT9N9Bz0Z3yh9v9PMVqv3dbfw7yAAcEXQ0+UeFCamQfoVqfGxpX2
         n0PDkLLD5QlFBx8GJW+Q/DG4bztQIqOGF9zjZnnP60DiSaD8otbMye1DdStyUPUfiJ3Z
         wv5TAaNIBxLEG/OUwcGmdq6Msj/IPw4Yeu/wLa4P7U2V4G/BGO0bgJ6aChv4zFKsQoIk
         1SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GEbrC9WoMx7yLYsqRtPBIyhrSuV+9giyvr/7VnB22LM=;
        b=Ju97LipcNUaNAbCcuH1fNDbslE+ajOWjkl9GMRpakdASRNhbYp72WjimglPI523AgM
         ZWDmeUVswbfH8Kedop+GMP5ddQXta4wTFavw9awmfn8F9b473Gt/+tgnyPcXzULeaTu7
         9HSl+scKBxOIge7QFM3zriIaz6UUQ5nIAhhVr4pcX0emqV5vFc9e3Ldzw8blFklXTj+O
         0ju4yb21d20l3bLC59CiuJtlQaXLmSzhfOz1pVsQTfbZ151yordms+Q06les6pxvEMpZ
         hRpo5iwNVcelaQSQDObxGJfVN6e6tWGKj/ERf/B6l/PeZx3iU9Uvvghysp5pBMa3SfgS
         5qMg==
X-Gm-Message-State: ABuFfogz0WgpPPdCnThkd3fK47YJdddWZR+Wg9F35p2aLLo0L3XKJxtQ
        3u0hkhK2iOzGsqL7skAcCqfXQg==
X-Google-Smtp-Source: ACcGV63koZtTeExokCUUCsPLV/i/1S/yoXhw+2CogLyBAt9QXtAalOEi9ocMmbIibE8F8TX2ngTkdQ==
X-Received: by 2002:a62:830e:: with SMTP id h14-v6mr5683608pfe.29.1539342025895;
        Fri, 12 Oct 2018 04:00:25 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id r73-v6sm1962024pfk.157.2018.10.12.04.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:00:24 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 85BBE300030; Fri, 12 Oct 2018 14:00:20 +0300 (+03)
Date:   Fri, 12 Oct 2018 14:00:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <keith.busch@intel.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHv2] mm/gup: Cache dev_pagemap while pinning pages
Message-ID: <20181012110020.pu5oanl6tnz4mibr@kshutemo-mobl1>
References: <20181011175542.13045-1-keith.busch@intel.com>
 <CAPcyv4gGqhGpR8g-HmNzoEnMAysO5uAO+8njeAokHq2CT9x71A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gGqhGpR8g-HmNzoEnMAysO5uAO+8njeAokHq2CT9x71A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 04:24:02PM -0700, Dan Williams wrote:
> On Thu, Oct 11, 2018 at 11:00 AM Keith Busch <keith.busch@intel.com> wrote:
> >
> > Getting pages from ZONE_DEVICE memory needs to check the backing device's
> > live-ness, which is tracked in the device's dev_pagemap metadata. This
> > metadata is stored in a radix tree and looking it up adds measurable
> > software overhead.
> >
> > This patch avoids repeating this relatively costly operation when
> > dev_pagemap is used by caching the last dev_pagemap while getting user
> > pages. The gup_benchmark kernel self test reports this reduces time to
> > get user pages to as low as 1/3 of the previous time.
> >
> > Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> Other than the 2 comments below, this looks good to me:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me too:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> 
> [..]
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 1abc8b4afff6..d2700dff6f66 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> [..]
> > @@ -431,7 +430,22 @@ struct page *follow_page_mask(struct vm_area_struct *vma,
> >                 return no_page_table(vma, flags);
> >         }
> >
> > -       return follow_p4d_mask(vma, address, pgd, flags, page_mask);
> > +       return follow_p4d_mask(vma, address, pgd, flags, ctx);
> > +}
> > +
> > +struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
> > +                        unsigned int foll_flags)
> > +{
> > +       struct page *page;
> > +       struct follow_page_context ctx = {
> > +               .pgmap = NULL,
> > +               .page_mask = 0,
> > +       };
> 
> You don't need to init all members. It is defined that if you init at
> least one member then all non initialized members are set to zero, so
> you should be able to do " = { 0 }".
> 
> > +
> > +       page = follow_page_mask(vma, address, foll_flags, &ctx);
> > +       if (ctx.pgmap)
> > +               put_dev_pagemap(ctx.pgmap);
> > +       return page;
> >  }
> >
> >  static int get_gate_page(struct mm_struct *mm, unsigned long address,
> > @@ -659,9 +673,9 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
> >                 unsigned int gup_flags, struct page **pages,
> >                 struct vm_area_struct **vmas, int *nonblocking)
> >  {
> > -       long i = 0;
> > -       unsigned int page_mask;
> > +       long ret = 0, i = 0;
> >         struct vm_area_struct *vma = NULL;
> > +       struct follow_page_context ctx = {};
> 
> Does this have defined behavior? I would feel better with " = { 0 }"
> to be explicit.

Well, it's not allowed by the standart, but GCC allows this.
You can see a warning with -pedantic.

We use empty-list initializers a lot in the kernel:
$ git grep 'struct .*= {};' | wc -l
997

It should be fine.

-- 
 Kirill A. Shutemov
