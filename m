Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeEKQei (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:34:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39640 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeEKQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:34:37 -0400
X-Google-Smtp-Source: AB8JxZqtrsel65bynqFcF3/vBiOsxJKDOodaBTiX5NU6U/5+eNxj/l316eYRXg4WxcV6g60085OpscJiyXIT8BdsNNs=
MIME-Version: 1.0
In-Reply-To: <20180511163421.GA32728@jordon-HP-15-Notebook-PC>
References: <20180511163421.GA32728@jordon-HP-15-Notebook-PC>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 11 May 2018 09:34:36 -0700
Message-ID: <CAPcyv4i1=q45aqSHXkWvQQgXBqkwuHR2ZxXWmpbeQxptXCcAFA@mail.gmail.com>
Subject: Re: [PATCH v4] dax: Change return type to vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        zi.yan@cs.rutgers.edu, Ross Zwisler <ross.zwisler@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>, Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        David Rientjes <rientjes@google.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 9:34 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
>
> Commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>
> Previously vm_insert_mixed() returns err which driver
> mapped into VM_FAULT_* type. The new function
> vmf_insert_mixed() will replace this inefficiency by
> returning VM_FAULT_* type.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> ---
> v2: Modified the change log
>
> v3: Updated the change log and
>     added Ross in review list
>
> v4: Addressed David's comment.
>     Changes in huge_memory.c put
>     together in a single patch that
>     it is bisectable in furture

Thanks, I'll carry this in the nvdimm tree since it collides with some
work-in progress development.
