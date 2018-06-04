Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751232AbeFDFUj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 01:20:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43774 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeFDFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 01:20:38 -0400
X-Google-Smtp-Source: ADUXVKLgos+dwI4HgfeSOdMAcfw2xJNCxY//4EwIrUGGkhDnWxoNbU5XYP8nWa+L/BjUl+p0k4iUNnNWZ8CZFg8G3Ps=
MIME-Version: 1.0
In-Reply-To: <20180521182520.GA19677@jordon-HP-15-Notebook-PC>
References: <20180521182520.GA19677@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 4 Jun 2018 10:50:35 +0530
Message-ID: <CAFqt6zb_RscnYYhJEqsYYPTHD+mRVaobY3vbbMZzhXRPax+yUA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel: event: core: Change return type to vm_fault_t
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, namhyung@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 11:55 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
>
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
> v2: Updated the change log.
>     Acked by Peter Zijlstra.
>
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 96db9ae..d09f1c4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4918,11 +4918,11 @@ void perf_event_update_userpage(struct perf_event *event)
>  }
>  EXPORT_SYMBOL_GPL(perf_event_update_userpage);
>
> -static int perf_mmap_fault(struct vm_fault *vmf)
> +static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
>  {
>         struct perf_event *event = vmf->vma->vm_file->private_data;
>         struct ring_buffer *rb;
> -       int ret = VM_FAULT_SIGBUS;
> +       vm_fault_t ret = VM_FAULT_SIGBUS;
>
>         if (vmf->flags & FAULT_FLAG_MKWRITE) {
>                 if (vmf->pgoff == 0)
> --
> 1.9.1
>

Any further comment on this patch ?
