Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A654C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34BE21AA6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bakxOi29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34BE21AA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752801AbeGDOrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:47:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44298 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbeGDOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:47:19 -0400
Received: by mail-lf0-f65.google.com with SMTP id h7-v6so4570885lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1aYtqBLj9mYvdM9rv1dvJT1WMWfB13AdlPCK3juPBmA=;
        b=bakxOi29fxMw5hAOLnJNmV9RJdJ1HyWI3PzVGhGRAg1E/wadAcf1cEpK8KaCaiEr/L
         QmkYI58s+I6vWNebfluttP0YaZyOp1seQntG9+L6N/PvCc2K3MarGMcsxdYCN6Ruz9oL
         m5LFAJJnNVV8W84H2GW+ELN+6GEfvg3NSBfUWeDMwFghFXXiu6HqC/kS6089mbCjCvQ6
         gqoSmaOKV1JFJITA+ijcEQfDDhf4docCXcgzm1qftB9DAxCG/72E6Avko6rr91oADBZM
         aIm25BQenvlWL/FrCMO0qnznMSvmCHGUFS3A4UTK8BHi049VJQbRYb05vkb3TI6DFWIH
         OPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1aYtqBLj9mYvdM9rv1dvJT1WMWfB13AdlPCK3juPBmA=;
        b=U0h2jiX5a1em5rTJghVh/0zhx7VEcF7PEu/gI3M+cWsFyZ1QZjm2jIsAh7DmchYNra
         LndxBF6N0rsXnF/5pgWl/Tec47vfrrp0WxcgBpEfUyre6EqXWr6NfpTmlB9wqkK3mejP
         esTB++G7qXXhnTl9VM1f6h1cLeAPEvPLmoE0HAc0egLT2QvzhJVlGhFVZi2kj1MjHwO8
         Cm1J1ppHswEI9Sx/RWFYna6G4ZM+ATHcsbE3kYuybWbpV5kUtMokGeCwuYZ4EvpUah2O
         3oZWFOXInAwdiW0Z3DyedOQiqkHs4uea8TNnXQpalmC48+lWw5bN4pw5mlAqDUE7qiu/
         6bOQ==
X-Gm-Message-State: APt69E1hsuA9rK1uKR8Y3UQ/1nJOcqy87Gww5Xr2AaD/2enAaS6l3D3k
        WkH6UhOSQ71TvzW+Uq1wdl23GHQnzhS9db9FzWA=
X-Google-Smtp-Source: AAOMgpdEr3J4Si+kzkUF5IYetx5LLlh64jBTaU2bw+4Y8u6gq6uC1VZaDPhKWXTlCKES4Sj0TEhaAJdQmOuBnuM+SIU=
X-Received: by 2002:a19:d942:: with SMTP id q63-v6mr1053717lfg.39.1530715638304;
 Wed, 04 Jul 2018 07:47:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:47:17 -0700 (PDT)
In-Reply-To: <20180704144850.GA10995@jordon-HP-15-Notebook-PC>
References: <20180704144850.GA10995@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 4 Jul 2018 20:17:17 +0530
Message-ID: <CAFqt6zZJPPBbOV21+Hu6jfuSW7p4Ym=SiKH5GtdXuCprP=CeZQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: v3d: use new return type vm_fault_t
To:     Matthew Wilcox <willy@infradead.org>,
        Eric Anholt <eric@anholt.net>, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        SUMAN TRIPATHI <svptas.linux@gmail.com>,
        brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        ajitn.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore this mail.

On Wed, Jul 4, 2018 at 8:18 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Convert v3d_gem_fault to return vm_fault_t
>
> Instead of converting an errno into a vm_fault_t ourselves, use
> vmf_insert_mixed() which returns a vm_fault_t directly.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/v3d/v3d_bo.c  | 28 +++++-----------------------
>  drivers/gpu/drm/v3d/v3d_drv.h |  3 ++-
>  2 files changed, 7 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
> index 7b1e2a5..54d9651 100644
> --- a/drivers/gpu/drm/v3d/v3d_bo.c
> +++ b/drivers/gpu/drm/v3d/v3d_bo.c
> @@ -227,37 +227,19 @@ struct reservation_object *v3d_prime_res_obj(struct drm_gem_object *obj)
>         vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
>  }
>
> -int v3d_gem_fault(struct vm_fault *vmf)
> +vm_fault_t v3d_gem_fault(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma = vmf->vma;
>         struct drm_gem_object *obj = vma->vm_private_data;
>         struct v3d_bo *bo = to_v3d_bo(obj);
> -       unsigned long pfn;
> +       pfn_t pfn;
>         pgoff_t pgoff;
> -       int ret;
>
>         /* We don't use vmf->pgoff since that has the fake offset: */
>         pgoff = (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> -       pfn = page_to_pfn(bo->pages[pgoff]);
> -
> -       ret = vm_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
> -
> -       switch (ret) {
> -       case -EAGAIN:
> -       case 0:
> -       case -ERESTARTSYS:
> -       case -EINTR:
> -       case -EBUSY:
> -               /*
> -                * EBUSY is ok: this just means that another thread
> -                * already did the job.
> -                */
> -               return VM_FAULT_NOPAGE;
> -       case -ENOMEM:
> -               return VM_FAULT_OOM;
> -       default:
> -               return VM_FAULT_SIGBUS;
> -       }
> +       pfn = __pfn_to_pfn_t(page_to_pfn(bo->pages[pgoff]), PFN_DEV);
> +
> +       return vmf_insert_mixed(vma, vmf->address, pfn);
>  }
>
>  int v3d_mmap(struct file *filp, struct vm_area_struct *vma)
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index a043ac3..09aa634 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2015-2018 Broadcom */
>
>  #include <linux/reservation.h>
> +#include <linux/mm_types.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_gem.h>
> @@ -248,7 +249,7 @@ int v3d_mmap_bo_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *file_priv);
>  int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *file_priv);
> -int v3d_gem_fault(struct vm_fault *vmf);
> +vm_fault_t v3d_gem_fault(struct vm_fault *vmf);
>  int v3d_mmap(struct file *filp, struct vm_area_struct *vma);
>  struct reservation_object *v3d_prime_res_obj(struct drm_gem_object *obj);
>  int v3d_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
> --
> 1.9.1
>
