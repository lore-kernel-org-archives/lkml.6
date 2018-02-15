Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165896AbeBOUWg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:22:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:62681 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033275AbeBOUWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:22:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="18047298"
Subject: Re: [RFC PATCH 0/3] Interface for higher order contiguous allocations
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@kernel.org>, Christopher Lameter <cl@linux.com>,
        Guy Shattah <sguy@mellanox.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vlastimil Babka <vbabka@suse.cz>, David Nellans <dnellans@nvidia.com>,
        Laura Abbott <labbott@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Dave Hansen <dave.hansen@intel.com>
References: <20180212222056.9735-1-mike.kravetz@oracle.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <770445b3-6caa-a87a-5de7-3157fc5280c2@intel.com>
Date: Thu, 15 Feb 2018 12:22:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180212222056.9735-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2/12/2018 2:20 PM, Mike Kravetz wrote:
> These patches came out of the "[RFC] mmap(MAP_CONTIG)" discussions at:
> http://lkml.kernel.org/r/21f1ec96-2822-1189-1c95-79a2bb491571@oracle.com
> 
> One suggestion in that thread was to create a friendlier interface that
> could be used by drivers and others outside core mm code to allocate a
> contiguous set of pages.  The alloc_contig_range() interface is used for
> this purpose today by CMA and gigantic page allocation.  However, this is
> not a general purpose interface.  So, wrap alloc_contig_range() in the
> more general interface:
> 
> struct page *find_alloc_contig_pages(unsigned int order, gfp_t gfp, int nid,
> 					nodemask_t *nodemask)
> 
> No underlying changes are made to increase the likelihood that a contiguous
> set of pages can be found and allocated.  Therefore, any user of this
> interface must deal with failure.  The hope is that this interface will be
> able to satisfy some use cases today.

As discussed in another thread a new feature, Cache Pseudo-Locking,
requires large contiguous regions. Until now I just exposed
alloc_gigantic_page() to handle these allocations in my testing. I now
moved to using find_alloc_contig_pages() as introduced here and all my
tests passed. I do hope that an API supporting large contiguous regions
become available.

Thank you very much for creating this.

Tested-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
