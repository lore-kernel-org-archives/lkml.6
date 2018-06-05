Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeFESYm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:24:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751764AbeFESYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:24:41 -0400
Date: Tue, 5 Jun 2018 14:24:38 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm, hmm: mark hmm_devmem_{add, add_resource}
 EXPORT_SYMBOL_GPL
Message-ID: <20180605182438.GB4423@redhat.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152694214044.5484.1081005408496303826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180522063236.GE7925@lst.de>
 <20180522143121.54d4ebced511277b923d31ba@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180522143121.54d4ebced511277b923d31ba@linux-foundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 02:31:21PM -0700, Andrew Morton wrote:
> On Tue, 22 May 2018 08:32:36 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Mon, May 21, 2018 at 03:35:40PM -0700, Dan Williams wrote:
> > > The routines hmm_devmem_add(), and hmm_devmem_add_resource() are small
> > > wrappers around devm_memremap_pages(). The devm_memremap_pages()
> > > interface is a subset of the hmm functionality which has more and deeper
> > > ties into the kernel memory management implementation. It was an
> > > oversight that these symbols were not marked EXPORT_SYMBOL_GPL from the
> > > outset due to how they originally copied (and now reuse)
> > > devm_memremap_pages().
> > 
> > If we end up keeping this code: absolutely.  Then again I think without
> > an actual user this should have never been merged, and should be removed
> > until one shows up.
> > 
> 
> It wasn't simple.  Quite a lot of manufacturers were (are?) developing
> quite complex driver code which utilizes hmm.  Merging hmm to give a
> stable target for that development and in the expectation that those
> things would be coming along was a risk and I don't think we yet know
> the outcome.
> 
> Jerome, are you able to provide any updates on all of this?

Sorry for taking so long to reply to this, I am just back from vacation.

I posted a v1 for nouveau to use HMM back in April or early May. I want
to post a v2 soon in June. For it to get upstream it needs to fullfill
linux drm sub-system requirement which are an open source userspace for
any functionality added to GPU driver. Work for this have been going
on for a while too and userspace bits are slowly getting upstream inside
Mesa. I need to sync up to see what is still missing in Mesa.

So i won't be able to get nouveau HMM bits merge before the userspace
bits are merge too. I was hopping for 4.18 but more likely 4.19.

I know HMM have been a big chicken and egg thing and that timing for
the egg did not match the timing for the chicken :) But it is getting
there.


Also I expect more hardware and associated upstream driver to make use
of HMM but i can not comment further on that at this time because of
NDA.

Cheers,
Jérôme
