Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ED8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0FE20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpASiNdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0FE20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeGQMGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:06:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37663 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbeGQMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:06:20 -0400
Received: by mail-lf0-f68.google.com with SMTP id j8-v6so585854lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NjIoU8iVbdp5BUj3tjBOhKA9ML/OfDIrN3wWVfW+tDY=;
        b=VpASiNdb9TH8jXmnoHVxQHifXsFvR8rhVifX1HKJH3GeDHFs7c3kss8xwEdKhequGE
         LcN+ZCjAMEh+FN/9HgU64Dnhv6u/S6IsspExvauu+1Nf42Y7GIVH3//Pg80vnAe4dwa9
         A2yfZZD5wiSdYNNVgorgGjvmlaDjSeS28c5a2zxEzvPFyS4WD/jbjb0zcS++dgMoL3HX
         hsqEfzgBsnWBFvYKZc7FT0lGRjKEkmO0Zcn7s8dEvdbWFSsaNy2ccISfWIKQ7a8Wp+/7
         qAjOSQqZ36c0suRrn7wtj1nvTDke2xvzBWeNWwq5GXwHrZXQQl1oNYX4nshKwYm7B/Vn
         F2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NjIoU8iVbdp5BUj3tjBOhKA9ML/OfDIrN3wWVfW+tDY=;
        b=NCdo7C1TmBlArT4k90rBYCgHccWfmHtocufFU5/aq2JJKy9YHOKkmFwDieQbGlBPdS
         OKfjvKr4Eqk5pSQYDfdH5gXKx+c/9nWzIWw2oXdVYrkS7jEtmvcvSJY81M+LaBo/GQsq
         c7e4RD1nZiNgxUhIIUtDKjFpo4fFz5NU4dcyo6D5fnR5dYATkuQmg6r5kdcaN3mxV6kk
         WYAn5KXuX84VY0mzsRHQPouVlTE3OmgR9CiPjhyHhWEifn1sXk3t8fv4lq1JWJkVg8Pg
         1cJcSbd9adz4SDKKTCngLCXV7vuT4HxQsnoHq+UmIEgm3Uox1gAkvxqIzLQVh1vZrsBv
         yhlw==
X-Gm-Message-State: AOUpUlHzhCFRX4By5l4t0Cvg29FyCrb3Hvm6yCArr57EoU1aLWkDumDD
        rldkUKyP7g5Shn7O1EuorLyIULQ7gpKW1lRa9Ss=
X-Google-Smtp-Source: AAOMgpenBcUCEJRylHt4hMsHXO2cD04yh8bDWamW35MEuKzd3ki7LmR8hJo+33FTmvI5DAGqUkzaInp5xTNnpuAm01o=
X-Received: by 2002:a19:8d07:: with SMTP id p7-v6mr1062354lfd.117.1531827246878;
 Tue, 17 Jul 2018 04:34:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 04:34:05
 -0700 (PDT)
In-Reply-To: <20180703153353.GA3375@jordon-HP-15-Notebook-PC>
References: <20180703153353.GA3375@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 17 Jul 2018 17:04:05 +0530
Message-ID: <CAFqt6zaqh+Jv6vmn2iOZL9jVtX7Qwf9b_QFPSfwg2+EcBRo5vA@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: virtio: code cleanup
To:     airlied@linux.ie, Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        SUMAN TRIPATHI <svptas.linux@gmail.com>,
        Ajit Linux <ajitn.linux@gmail.com>, brajeswar.linux@gmail.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:03 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> The fault handler code is commented since v4.2.
> If there is no plan to enable the fault handler
> code in future, we can remove this dead code.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: corrected subject line
>

Any further comment on this patch ?

>  drivers/gpu/drm/virtio/virtgpu_ttm.c | 36 +-----------------------------------
>  1 file changed, 1 insertion(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> index 11f8ae5..b6f021c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -106,29 +106,6 @@ static void virtio_gpu_ttm_global_fini(struct virtio_gpu_device *vgdev)
>         }
>  }
>
> -#if 0
> -/*
> - * Hmm, seems to not do anything useful.  Leftover debug hack?
> - * Something like printing pagefaults to kernel log?
> - */
> -static struct vm_operations_struct virtio_gpu_ttm_vm_ops;
> -static const struct vm_operations_struct *ttm_vm_ops;
> -
> -static int virtio_gpu_ttm_fault(struct vm_fault *vmf)
> -{
> -       struct ttm_buffer_object *bo;
> -       struct virtio_gpu_device *vgdev;
> -       int r;
> -
> -       bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
> -       if (bo == NULL)
> -               return VM_FAULT_NOPAGE;
> -       vgdev = virtio_gpu_get_vgdev(bo->bdev);
> -       r = ttm_vm_ops->fault(vmf);
> -       return r;
> -}
> -#endif
> -
>  int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>         struct drm_file *file_priv;
> @@ -143,19 +120,8 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
>                 return -EINVAL;
>         }
>         r = ttm_bo_mmap(filp, vma, &vgdev->mman.bdev);
> -#if 0
> -       if (unlikely(r != 0))
> -               return r;
> -       if (unlikely(ttm_vm_ops == NULL)) {
> -               ttm_vm_ops = vma->vm_ops;
> -               virtio_gpu_ttm_vm_ops = *ttm_vm_ops;
> -               virtio_gpu_ttm_vm_ops.fault = &virtio_gpu_ttm_fault;
> -       }
> -       vma->vm_ops = &virtio_gpu_ttm_vm_ops;
> -       return 0;
> -#else
> +
>         return r;
> -#endif
>  }
>
>  static int virtio_gpu_invalidate_caches(struct ttm_bo_device *bdev,
> --
> 1.9.1
>
