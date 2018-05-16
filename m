Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeEPID2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:03:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:9237 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeEPIDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:03:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="49645842"
Date: Wed, 16 May 2018 11:03:12 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH -mm] mm, hugetlb: Pass fault address to no page handler
Message-ID: <20180516080312.rx6owusozklkmypj@black.fi.intel.com>
References: <20180515005756.28942-1-ying.huang@intel.com>
 <20180515103812.aapv4b4hbzno52zl@kshutemo-mobl1>
 <878t8kzb0c.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878t8kzb0c.fsf@yhuang-dev.intel.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 12:42:43AM +0000, Huang, Ying wrote:
> >> +	unsigned long address = faddress & huge_page_mask(h);
> >
> > faddress? I would rather keep it address and rename maked out variable to
> > 'haddr'. We use 'haddr' for the cause in other places.
> 
> I found haddr is popular in huge_memory.c but not used in hugetlb.c at
> all.  Is it desirable to start to use "haddr" in hugetlb.c?

Yes, I think so. There's no reason to limit haddr convention to THP.

-- 
 Kirill A. Shutemov
