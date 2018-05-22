Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeEVG0o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:26:44 -0400
Received: from verein.lst.de ([213.95.11.211]:46684 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEVG0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:26:43 -0400
Date: Tue, 22 May 2018 08:31:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm, hmm: replace hmm_devmem_pages_create() with
        devm_memremap_pages()
Message-ID: <20180522063156.GD7925@lst.de>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com> <152694213486.5484.5340142369038375338.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152694213486.5484.5340142369038375338.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:35:34PM -0700, Dan Williams wrote:
> Commit e8d513483300 "memremap: change devm_memremap_pages interface to
> use struct dev_pagemap" refactored devm_memremap_pages() to allow a
> dev_pagemap instance to be supplied. Passing in a dev_pagemap interface
> simplifies the design of pgmap type drivers in that they can rely on
> container_of() to lookup any private data associated with the given
> dev_pagemap instance.
> 
> In addition to the cleanups this also gives hmm users multi-order-radix
> improvements that arrived with commit ab1b597ee0e4 "mm,
> devm_memremap_pages: use multi-order radix for ZONE_DEVICE lookups"

None of them has any caller despite being in the tree for 9 month.
I think it's time to simply drop the whole hmm code instead instead of
carrying this dead weight around.
