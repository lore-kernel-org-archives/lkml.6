Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id sMTGI7oHGltvDQAAmS7hNA
	; Fri, 08 Jun 2018 04:36:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 74D6B607DC; Fri,  8 Jun 2018 04:36:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EISNkac3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC45060590;
	Fri,  8 Jun 2018 04:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC45060590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbeFHEgH (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:36:07 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40441 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeFHEgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:36:05 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so17981886lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 21:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xdf4irS1w99O1UwKiA7wqgNR4lvzLDH0ipSQI5Dik18=;
        b=EISNkac37aexQDzIwRXGjZA7KE9ATdBRKCgXRDtR49ZeJJYVYA3fpyCA947+fZT3RG
         QhtVy1bxY08sALThVhRzpCo8QGY8g4EfAM+RwEcZm+E0d9wR/Uli4mh5qWMYvGP0foLI
         +GgGwAIXS8sJ40ORXj4jgT3rQ6QNjP+5M6oZId66kfHk6C1A5PzwElxbqfa8faDZgmgO
         vxbkT0rfAt9gwMQMJS3TWbIylrPgpb4fnhxWo0zrlkf+aLcdpsluH8W7GKXvTjT50MhJ
         aiel6ycSgZIz/1ia5Tg4pc/xtZ3MrSx2hEYNLGQ3/Vr0Jd9j18aKRWA6mTYbgc93lMuo
         caLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xdf4irS1w99O1UwKiA7wqgNR4lvzLDH0ipSQI5Dik18=;
        b=ptqjl24Wv0kRzHKpc75EpcT2ewtlUYLv664bmEQzC3otlzBd0fxwjvDQZNODVj5AYr
         X8LuMmwNB2aR7SOFLcu3VUR9ZvTvPp9l9D5aNDcHesroXrfTwbt5n1Of5mdTTbCGpdLP
         XIbpOayRQI83EPzzIJRgCuEXJ+KM45tkBU97TMwJMjzuPmqq3oqfkUXEUlTmLi/xWDUu
         iac9nJ+kbCQFN+JCgeWdpq6I+wHgV+rdkwVLeuMiftMVwsuODhoV+0rHJ1l9pbqe+KdP
         f9qXzm1OU0Ukftt3ZB4KWRJxfcY6qzEV+jAcpOxokZmt2ViG/8CwT9eK54dsrvARUeRe
         lTCQ==
X-Gm-Message-State: APt69E0a07g+BnARWuhf63wW+z3eo9HRY6hwtnWB396gbGjImlsxsw7J
        dKLJkhvOSjPNrfChlRR5x8I0vU3hEPOw1wgp/aI=
X-Google-Smtp-Source: ADUXVKKtnOMG8kC6o0c6K5/S8PjTf/CsYyB4HmaUSRsSISMmPc9pEWBp3QO2Nuh4i689HjpIo3zJJ0mq+TO2ojAJqD0=
X-Received: by 2002:a19:1647:: with SMTP id m68-v6mr2954123lfi.131.1528432564056;
 Thu, 07 Jun 2018 21:36:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d885:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 21:36:03 -0700 (PDT)
In-Reply-To: <20180601192724.GA2001@jordon-HP-15-Notebook-PC>
References: <20180601192724.GA2001@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 8 Jun 2018 10:06:03 +0530
Message-ID: <CAFqt6zZr5WaXk9QSEE7100zs94Tx0p4inuXUF5WXgU8=9rp+bw@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: ttm: Adding new return type vm_fault_t
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 12:57 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
>
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>
> Previously vm_insert_{mixed,pfn} returns err which driver
> mapped into VM_FAULT_* type. The new function
> vmf_insert_{mixed,pfn} will replace this inefficiency by
> returning VM_FAULT_* type.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: Address christian's comment. Put reverse
>     xmas tree order for variable declarations.
>
>  drivers/gpu/drm/ttm/ttm_bo_vm.c | 45 ++++++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 8eba95b..9de8b4f 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -43,10 +43,11 @@
>
>  #define TTM_BO_VM_NUM_PREFAULT 16
>
> -static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
> +static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>                                 struct vm_fault *vmf)
>  {
> -       int ret = 0;
> +       vm_fault_t ret = 0;
> +       int err = 0;
>
>         if (likely(!bo->moving))
>                 goto out_unlock;
> @@ -77,9 +78,9 @@ static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>         /*
>          * Ordinary wait.
>          */
> -       ret = dma_fence_wait(bo->moving, true);
> -       if (unlikely(ret != 0)) {
> -               ret = (ret != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
> +       err = dma_fence_wait(bo->moving, true);
> +       if (unlikely(err != 0)) {
> +               ret = (err != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
>                         VM_FAULT_NOPAGE;
>                 goto out_unlock;
>         }
> @@ -104,7 +105,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
>                 + page_offset;
>  }
>
> -static int ttm_bo_vm_fault(struct vm_fault *vmf)
> +static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma = vmf->vma;
>         struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
> @@ -115,8 +116,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>         unsigned long pfn;
>         struct ttm_tt *ttm = NULL;
>         struct page *page;
> -       int ret;
> +       int err;
>         int i;
> +       vm_fault_t ret = VM_FAULT_NOPAGE;
>         unsigned long address = vmf->address;
>         struct ttm_mem_type_manager *man =
>                 &bdev->man[bo->mem.mem_type];
> @@ -128,9 +130,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>          * for reserve, and if it fails, retry the fault after waiting
>          * for the buffer to become unreserved.
>          */
> -       ret = ttm_bo_reserve(bo, true, true, NULL);
> -       if (unlikely(ret != 0)) {
> -               if (ret != -EBUSY)
> +       err = ttm_bo_reserve(bo, true, true, NULL);
> +       if (unlikely(err != 0)) {
> +               if (err != -EBUSY)
>                         return VM_FAULT_NOPAGE;
>
>                 if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
> @@ -162,8 +164,8 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>         }
>
>         if (bdev->driver->fault_reserve_notify) {
> -               ret = bdev->driver->fault_reserve_notify(bo);
> -               switch (ret) {
> +               err = bdev->driver->fault_reserve_notify(bo);
> +               switch (err) {
>                 case 0:
>                         break;
>                 case -EBUSY:
> @@ -191,13 +193,13 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>                 goto out_unlock;
>         }
>
> -       ret = ttm_mem_io_lock(man, true);
> -       if (unlikely(ret != 0)) {
> +       err = ttm_mem_io_lock(man, true);
> +       if (unlikely(err != 0)) {
>                 ret = VM_FAULT_NOPAGE;
>                 goto out_unlock;
>         }
> -       ret = ttm_mem_io_reserve_vm(bo);
> -       if (unlikely(ret != 0)) {
> +       err = ttm_mem_io_reserve_vm(bo);
> +       if (unlikely(err != 0)) {
>                 ret = VM_FAULT_SIGBUS;
>                 goto out_io_unlock;
>         }
> @@ -265,23 +267,20 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>                 }
>
>                 if (vma->vm_flags & VM_MIXEDMAP)
> -                       ret = vm_insert_mixed(&cvma, address,
> +                       ret = vmf_insert_mixed(&cvma, address,
>                                         __pfn_to_pfn_t(pfn, PFN_DEV));
>                 else
> -                       ret = vm_insert_pfn(&cvma, address, pfn);
> +                       ret = vmf_insert_pfn(&cvma, address, pfn);
>
>                 /*
>                  * Somebody beat us to this PTE or prefaulting to
>                  * an already populated PTE, or prefaulting error.
>                  */
>
> -               if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
> +               if (unlikely((ret == VM_FAULT_NOPAGE && i > 0)))
>                         break;
> -               else if (unlikely(ret != 0)) {
> -                       ret =
> -                           (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
> +               else if (unlikely(ret & VM_FAULT_ERROR))
>                         goto out_io_unlock;
> -               }
>
>                 address += PAGE_SIZE;
>                 if (unlikely(++page_offset >= page_last))
> --
> 1.9.1
>

If no further comment, we would like get this patch in 4.18 / 4.18-rc-x.
