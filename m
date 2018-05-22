Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeEVVb1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:31:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753007AbeEVVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:31:23 -0400
Date: Tue, 22 May 2018 14:31:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm, hmm: mark hmm_devmem_{add, add_resource}
 EXPORT_SYMBOL_GPL
Message-Id: <20180522143121.54d4ebced511277b923d31ba@linux-foundation.org>
In-Reply-To: <20180522063236.GE7925@lst.de>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
        <152694214044.5484.1081005408496303826.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20180522063236.GE7925@lst.de>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 08:32:36 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Mon, May 21, 2018 at 03:35:40PM -0700, Dan Williams wrote:
> > The routines hmm_devmem_add(), and hmm_devmem_add_resource() are small
> > wrappers around devm_memremap_pages(). The devm_memremap_pages()
> > interface is a subset of the hmm functionality which has more and deeper
> > ties into the kernel memory management implementation. It was an
> > oversight that these symbols were not marked EXPORT_SYMBOL_GPL from the
> > outset due to how they originally copied (and now reuse)
> > devm_memremap_pages().
> 
> If we end up keeping this code: absolutely.  Then again I think without
> an actual user this should have never been merged, and should be removed
> until one shows up.
> 

It wasn't simple.  Quite a lot of manufacturers were (are?) developing
quite complex driver code which utilizes hmm.  Merging hmm to give a
stable target for that development and in the expectation that those
things would be coming along was a risk and I don't think we yet know
the outcome.

Jerome, are you able to provide any updates on all of this?
