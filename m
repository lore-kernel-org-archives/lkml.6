Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030472AbeCAMo1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:44:27 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37560 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030425AbeCAMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:44:25 -0500
X-Google-Smtp-Source: AG47ELuG2oCW4H2s7h4g1I1tvsgZKEFIClKZdpP6bvUhRXCcr31BcBaE3SEAjxgEGWpCvIyLPohX8A==
Date: Thu, 1 Mar 2018 15:44:12 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Split page_type out from mapcount
Message-ID: <20180301124412.gm6jxwzyfskzxspa@node.shutemov.name>
References: <20180228223157.9281-1-willy@infradead.org>
 <20180301081750.42b135c3@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301081750.42b135c3@mschwideX1>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 08:17:50AM +0100, Martin Schwidefsky wrote:
> On Wed, 28 Feb 2018 14:31:53 -0800
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > From: Matthew Wilcox <mawilcox@microsoft.com>
> > 
> > I want to use the _mapcount field to record what a page is in use as.
> > This can help with debugging and we can also expose that information to
> > userspace through /proc/kpageflags to help diagnose memory usage (not
> > included as part of this patch set).
> > 
> > First, we need s390 to stop using _mapcount for its own purposes;
> > Martin, I hope you have time to look at this patch.  I must confess I
> > don't quite understand what the different bits are used for in the upper
> > nybble of the _mapcount, but I tried to replicate what you were doing
> > faithfully.
> 
> Yeah, that is a nasty bit of code. On s390 we have 2K page tables (pte)
> but 4K pages. If we use full pages for the pte tables we waste 2K of
> memory for each of the tables. So we allocate 4K and split it into two
> 2K pieces. Now we have to keep track of the pieces to be able to free
> them again.

Have you considered to use slab for page table allocation instead?
IIRC some architectures practice this already.

-- 
 Kirill A. Shutemov
