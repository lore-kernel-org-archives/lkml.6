Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031615AbeCAOvC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:51:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031346AbeCAOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:51:00 -0500
Date: Thu, 1 Mar 2018 06:50:58 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Split page_type out from mapcount
Message-ID: <20180301145058.GA19662@bombadil.infradead.org>
References: <20180228223157.9281-1-willy@infradead.org>
 <20180301081750.42b135c3@mschwideX1>
 <20180301124412.gm6jxwzyfskzxspa@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301124412.gm6jxwzyfskzxspa@node.shutemov.name>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 03:44:12PM +0300, Kirill A. Shutemov wrote:
> On Thu, Mar 01, 2018 at 08:17:50AM +0100, Martin Schwidefsky wrote:
> > Yeah, that is a nasty bit of code. On s390 we have 2K page tables (pte)
> > but 4K pages. If we use full pages for the pte tables we waste 2K of
> > memory for each of the tables. So we allocate 4K and split it into two
> > 2K pieces. Now we have to keep track of the pieces to be able to free
> > them again.
> 
> Have you considered to use slab for page table allocation instead?
> IIRC some architectures practice this already.

You're not allowed to do that any more.  Look at pgtable_page_ctor(),
or rather ptlock_init().
