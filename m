Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbeEVG10 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:27:26 -0400
Received: from verein.lst.de ([213.95.11.211]:46695 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVG1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:27:23 -0400
Date: Tue, 22 May 2018 08:32:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm, hmm: mark hmm_devmem_{add, add_resource}
        EXPORT_SYMBOL_GPL
Message-ID: <20180522063236.GE7925@lst.de>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com> <152694214044.5484.1081005408496303826.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152694214044.5484.1081005408496303826.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:35:40PM -0700, Dan Williams wrote:
> The routines hmm_devmem_add(), and hmm_devmem_add_resource() are small
> wrappers around devm_memremap_pages(). The devm_memremap_pages()
> interface is a subset of the hmm functionality which has more and deeper
> ties into the kernel memory management implementation. It was an
> oversight that these symbols were not marked EXPORT_SYMBOL_GPL from the
> outset due to how they originally copied (and now reuse)
> devm_memremap_pages().

If we end up keeping this code: absolutely.  Then again I think without
an actual user this should have never been merged, and should be removed
until one shows up.

Reviewed-by: Christoph Hellwig <hch@lst.de>
