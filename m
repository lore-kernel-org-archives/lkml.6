Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeEKSP7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:15:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeEKSP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:15:58 -0400
Date: Fri, 11 May 2018 11:15:46 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hughd@google.com,
        dan.j.williams@intel.com, rientjes@google.com, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com, aneesh.kumar@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Change return type to vm_fault_t
Message-ID: <20180511181546.GA25613@bombadil.infradead.org>
References: <20180511180639.GA1792@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511180639.GA1792@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:36:39PM +0530, Souptick Joarder wrote:
>  mm/hugetlb.c | 2 +-
>  mm/mmap.c    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Don't we also need to convert include/linux/mm_types.h:

@@ -621,7 +621,7 @@ struct vm_special_mapping {
         * If non-NULL, then this is called to resolve page faults
         * on the special mapping.  If used, .pages is not checked.
         */
-       int (*fault)(const struct vm_special_mapping *sm,
+       vm_fault_t (*fault)(const struct vm_special_mapping *sm,
                     struct vm_area_struct *vma,
                     struct vm_fault *vmf);
 
or are you leaving that for a later patch?
