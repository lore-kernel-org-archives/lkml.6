Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C42C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9955620873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYaANE8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfBKDdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:33:39 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41089 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBKDdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 22:33:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id v10so903783qtp.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 19:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cM+zzXGhWaqF3fPIJowNeJ4tza9eMdnKD7TbXZ42D4k=;
        b=dYaANE8ISZVTy8K9j2qBi30GCQrQq0ROn67Xv0kwipw1IxVPx1MbT9Q4txscDNVk8E
         TpqUfdG5Bp4G7Y2jMQ99rDaIvI3vaoDvnabzkEqfDh956BmGAllK6qJcMicKVE1pHuXl
         yzX1iiX2cKFs9A9KkVaDLkIkwn8aj0gdisZnqUXOHzDpHS+IHeYIwAmR5gr3MrYr5lKv
         UJxUYUyoHXCRsnqlMdwI66IAPCj8u2yP6bV9kVuQ6m320mgJZctaQTzVeEHfzQ+Grjdo
         SxUjmVwSL9qmLEr+x8lcPTASIYPNBqJcZjUtoNyMIK5pipYpiKgIscxiqmUq1Y51Gb5U
         gJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cM+zzXGhWaqF3fPIJowNeJ4tza9eMdnKD7TbXZ42D4k=;
        b=Z+c1kzXmZoW+lGzkA19vSAYgCwsPbDA4bgyVuoI6nYQdomU8vTGTw03MJr8nCPs1YC
         rxiiaHfNSpo1iweLn+bti+rvyLoLUL6huSMzDpoRK8JRpM3UNak/+Jf248uKBZBXgWOM
         75UTPlVNbgplRltFSolGQ7SrYoAr40ngPh++nl7zUFKQaTclmFI2+6mBjqPuhrsDvokh
         nruiYGqQlHRlxzYfM/nUhwExBUqom4WBmQBIDYZbTTzwWUDhDROeDCwqvHH8jxn0Cr8b
         OWX1VMuuct+WTGgVPUg9FeWWkRlzNvnHjuPuDIq36iSjEanfxZ6Vw9KcCrp92T6v/iqw
         YTvQ==
X-Gm-Message-State: AHQUAuaecVgRBB4FH1xPf39tOYhHGYQXiPjY3j7yZfnJHjV8nPKyas7k
        nidnFGUBHU6puXYunvEj2mw3H9e+0Dt4aEqTXTpm+zy3
X-Google-Smtp-Source: AHgI3Ib/y7iuMGO3AOnanMNXeQYFAOdIvkEL1I/zslXT7qbqlj+0dB8+Ykt0TDSTpM/ln6HHlwdX8O5axB8hrHpY0CQ=
X-Received: by 2002:a0c:b8ac:: with SMTP id y44mr25001986qvf.76.1549856017071;
 Sun, 10 Feb 2019 19:33:37 -0800 (PST)
MIME-Version: 1.0
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <154966356809.132359.5318207850182898116.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <63ae370c-2239-62c5-2378-98916608acc4@linux.intel.com>
In-Reply-To: <63ae370c-2239-62c5-2378-98916608acc4@linux.intel.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Sun, 10 Feb 2019 21:33:25 -0600
Message-ID: <CABhMZUUKe0b9RkscDX6WR0tpQmhW_nFoYKHTvthpKwZ4vMirOA@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] iommu/vt-d: Remove unnecessary local variable initializations
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 8:00 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi,
>
> On 2/9/19 6:06 AM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > A local variable initialization is a hint that the variable will be used in
> > an unusual way.  If the initialization is unnecessary, that hint becomes a
> > distraction.
> >
> > Remove unnecessary initializations.  No functional change intended.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/iommu/intel-iommu.c |   27 +++++++++++++--------------
> >   1 file changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 81077803880f..2acd08c82cdc 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -865,7 +865,7 @@ static void free_context_table(struct intel_iommu *iommu)
> >   static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
> >                                     unsigned long pfn, int *target_level)
> >   {
> > -     struct dma_pte *parent, *pte = NULL;
> > +     struct dma_pte *parent, *pte;
> >       int level = agaw_to_level(domain->agaw);
> >       int offset;
> >
> > @@ -922,7 +922,7 @@ static struct dma_pte *dma_pfn_level_pte(struct dmar_domain *domain,
> >                                        unsigned long pfn,
> >                                        int level, int *large_page)
> >   {
> > -     struct dma_pte *parent, *pte = NULL;
> > +     struct dma_pte *parent, *pte;
> >       int total = agaw_to_level(domain->agaw);
> >       int offset;
> >
> > @@ -954,7 +954,7 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
> >                               unsigned long start_pfn,
> >                               unsigned long last_pfn)
> >   {
> > -     unsigned int large_page = 1;
> > +     unsigned int large_page;
> >       struct dma_pte *first_pte, *pte;
> >
> >       BUG_ON(!domain_pfn_supported(domain, start_pfn));
> > @@ -1132,7 +1132,7 @@ static struct page *domain_unmap(struct dmar_domain *domain,
> >                                unsigned long start_pfn,
> >                                unsigned long last_pfn)
> >   {
> > -     struct page *freelist = NULL;
> > +     struct page *freelist;
>
> I am afraid this change might cause problem. "freelist" might go through
> dma_pte_clear_level() without any touches.

Thanks for your review!  Can you clarify your concern?  "freelist"
isn't passed into dma_pte_clear_level().  Here's the existing code
(before this patch).  I don't see a use of "freelist" before we assign
the result of dma_pte_clear_level() to it.  But maybe I'm overlooking
something.

static struct page *domain_unmap(struct dmar_domain *domain,
                                 unsigned long start_pfn,
                                 unsigned long last_pfn)
{
        struct page *freelist = NULL;

        BUG_ON(!domain_pfn_supported(domain, start_pfn));
        BUG_ON(!domain_pfn_supported(domain, last_pfn));
        BUG_ON(start_pfn > last_pfn);

        /* we don't need lock here; nobody else touches the iova range */
        freelist = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
                                       domain->pgd, 0, start_pfn,
last_pfn, NULL);
