Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeCHWHL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:07:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeCHWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:07:10 -0500
Date: Thu, 8 Mar 2018 14:07:08 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] mm/vmalloc: Add interfaces to free unused page table
Message-ID: <20180308220708.GA29073@bombadil.infradead.org>
References: <20180307183227.17983-1-toshi.kani@hpe.com>
 <20180307183227.17983-2-toshi.kani@hpe.com>
 <20180308040016.GB9082@bombadil.infradead.org>
 <1520527285.2693.56.camel@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520527285.2693.56.camel@hpe.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 03:56:30PM +0000, Kani, Toshi wrote:
> On Wed, 2018-03-07 at 20:00 -0800, Matthew Wilcox wrote:
> > On Wed, Mar 07, 2018 at 11:32:26AM -0700, Toshi Kani wrote:
> > > +/**
> > > + * pud_free_pmd_page - clear pud entry and free pmd page
> > > + *
> > > + * Returns 1 on success and 0 on failure (pud not cleared).
> > > + */
> > > +int pud_free_pmd_page(pud_t *pud)
> > > +{
> > > +	return pud_none(*pud);
> > > +}
> > 
> > Wouldn't it be clearer if you returned 'bool' instead of 'int' here?
> 
> I thought about it and decided to use 'int' since all other pud/pmd/pte
> interfaces, such as pud_none() above, use 'int'.

These interfaces were introduced before we had bool ... I suspect nobody's
taken the time to go through and convert them all.
