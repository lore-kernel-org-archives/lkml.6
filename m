Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeEKS0v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:26:51 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44379 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEKS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:26:50 -0400
X-Google-Smtp-Source: AB8JxZoH2zOY3r5ftX2C/217dDSzYgJn+EVOKSzHQkl2vNlDwNDhyd9xZHeq2pKsjD6QpAOBI03RSQGn4gHEbvooJE0=
MIME-Version: 1.0
In-Reply-To: <20180511181546.GA25613@bombadil.infradead.org>
References: <20180511180639.GA1792@jordon-HP-15-Notebook-PC> <20180511181546.GA25613@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 11 May 2018 23:56:48 +0530
Message-ID: <CAFqt6zbZw74s=Kqh=UgtZti_jJJ8UcCXVqBgXyG3vruRbqg9Yw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Change return type to vm_fault_t
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:45 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Fri, May 11, 2018 at 11:36:39PM +0530, Souptick Joarder wrote:
>>  mm/hugetlb.c | 2 +-
>>  mm/mmap.c    | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Don't we also need to convert include/linux/mm_types.h:
>
> @@ -621,7 +621,7 @@ struct vm_special_mapping {
>          * If non-NULL, then this is called to resolve page faults
>          * on the special mapping.  If used, .pages is not checked.
>          */
> -       int (*fault)(const struct vm_special_mapping *sm,
> +       vm_fault_t (*fault)(const struct vm_special_mapping *sm,
>                      struct vm_area_struct *vma,
>                      struct vm_fault *vmf);
>
> or are you leaving that for a later patch?

Ahh, I didn't realise. No I think, we can add it as part of this
patch. Will send v3.
