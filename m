Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeEVGYz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 02:24:55 -0400
Received: from verein.lst.de ([213.95.11.211]:46661 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeEVGYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 02:24:53 -0400
Date: Tue, 22 May 2018 08:30:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm, devm_memremap_pages: handle errors allocating
        final devres action
Message-ID: <20180522063006.GB7925@lst.de>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com> <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 03:35:24PM -0700, Dan Williams wrote:
> The last step before devm_memremap_pages() returns success is to
> allocate a release action to tear the entire setup down. However, the
> result from devm_add_action() is not checked.
> 
> Checking the error also means that we need to handle the fact that the
> percpu_ref may not be killed by the time devm_memremap_pages_release()
> runs. Add a new state flag for this case.

Looks good (modulo any stable tag issues):

Reviewed-by: Christoph Hellwig <hch@lst.de>
