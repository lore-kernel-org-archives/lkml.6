Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeDUVeW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 17:34:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36486 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeDUVeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 17:34:21 -0400
Date: Sat, 21 Apr 2018 14:34:01 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: viro@zeniv.linux.org.uk, mawilcox@microsoft.com,
        ross.zwisler@linux.intel.com, akpm@linux-foundation.org,
        dan.j.williams@intel.com, mhocko@suse.com, jack@suse.cz,
        kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: dax: Adding new return type vm_fault_t
Message-ID: <20180421213401.GF14610@bombadil.infradead.org>
References: <20180421210529.GA27238@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180421210529.GA27238@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 02:35:29AM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> There was an existing bug inside dax_load_hole()
> if vm_insert_mixed had failed to allocate a page table,
> we'd return VM_FAULT_NOPAGE instead of VM_FAULT_OOM.
> With new vmf_insert_mixed() this issue is addressed.
> 
> vm_insert_mixed_mkwrite has inefficiency when it returns
> an error value, driver has to convert it to vm_fault_t
> type. With new vmf_insert_mixed_mkwrite() this limitation
> will be addressed.
> 
> As new function vmf_insert_mixed_mkwrite() only called
> from fs/dax.c, so keeping both the changes in a single
> patch.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

There's a couple of minor things which could be tidied up, but not worth
doing them as a revision to this patch.
