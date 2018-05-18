Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeERGYe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 02:24:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:60132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750888AbeERGYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 02:24:33 -0400
Date: Fri, 18 May 2018 08:24:30 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andi Kleen <andi.kleen@intel.com>,
        Jan Kara <jack@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH -mm] mm, huge page: Copy to access sub-page last when
 copy huge page
Message-ID: <20180518062430.GB21711@dhcp22.suse.cz>
References: <20180518030316.31019-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518030316.31019-1-ying.huang@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 18-05-18 11:03:16, Huang, Ying wrote:
[...]
> The patch is a generic optimization which should benefit quite some
> workloads, not for a specific use case.  To demonstrate the performance
> benefit of the patch, we tested it with vm-scalability run on
> transparent huge page.

It is also adds quite some non-intuitive code. So is this worth? Does
any _real_ workload benefits from the change?

>  include/linux/mm.h |  3 ++-
>  mm/huge_memory.c   |  3 ++-
>  mm/memory.c        | 43 +++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 43 insertions(+), 6 deletions(-)
-- 
Michal Hocko
SUSE Labs
