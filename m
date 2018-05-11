Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeEKSUK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:20:10 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34117 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeEKSUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:20:08 -0400
X-Google-Smtp-Source: AB8JxZqwoRp4BgjGRW5kOF/jsvNhmjHlrPRV/rFEWer/oG3XMx8aOWK6NwHSCK1hMHEI8OvRXUSmwRxBzCB5i04WEJ4=
MIME-Version: 1.0
In-Reply-To: <20180423105409.GC2308@bombadil.infradead.org>
References: <20180417134755.GA30291@jordon-HP-15-Notebook-PC>
 <20180418082439.GA4646@ulmo> <20180423105409.GC2308@bombadil.infradead.org>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 11 May 2018 23:50:05 +0530
Message-ID: <CAFqt6zYR1n75iXtjWtgVVGWDPaeAN5BPVBsGXR-58t5d4_Fi9Q@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: tegra: Adding new typedef vm_fault_t
To: Matthew Wilcox <willy@infradead.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, airlied@linux.ie,
        jonathanh@nvidia.com, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 4:24 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Apr 18, 2018 at 10:24:39AM +0200, Thierry Reding wrote:
>> > @@ -437,20 +436,7 @@ static int tegra_bo_fault(struct vm_fault *vmf)
>> >     offset = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
>> >     page = bo->pages[offset];
>> >
>> > -   err = vm_insert_page(vma, vmf->address, page);
>> > -   switch (err) {
>> > -   case -EAGAIN:
>> > -   case 0:
>> > -   case -ERESTARTSYS:
>> > -   case -EINTR:
>> > -   case -EBUSY:
>> > -           return VM_FAULT_NOPAGE;
>> > -
>> > -   case -ENOMEM:
>> > -           return VM_FAULT_OOM;
>> > -   }
>> > -
>> > -   return VM_FAULT_SIGBUS;
>> > +   return vmf_insert_page(vma, vmf->address, page);
>> >  }
>>
>> This new function returns VM_FAULT_NOPAGE only for 0 and -EBUSY, whereas
>> we used to return VM_FAULT_NOPAGE for -EAGAIN, -ERESTARTSYS and -EINTR
>> as well. Was this previously wrong?
>
> Not so much wrong as unnecessary.  vm_insert_page() can't return -EAGAIN,
> -ERESTARTSYS or -EINTR.

If no further comment on this patch, We would like to get this patch
queued for 4.18.
