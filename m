Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA020FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942E920873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVWSrfnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942E920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeG3GTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:19:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46501 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeG3GTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:19:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so9217860ljj.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xSPPahrJHUeB20VFlUnG3g7FNZ0k9zxztEC7Idse5Tg=;
        b=FVWSrfnSCIzoRYWjefplingQg15UN0MdEX0FDp2JAVab2ny9nzmIlR5unF0usF4dyv
         /XZi/BwIZcUrHmUKP170XHfCzuF/+Y5Anm6jSeA0VpS5fyQ4d5cOgRQUTvZdjyTk3BI3
         Gc5SgAKBlPg1k8scgVPh9rTPfTckEPtdiS5u6V8dbdZJhAixi6+8kKsAFYf4b4XZ3ycT
         3bQkeRRSuA/82PIZvb/EV1aWfc0EL6kwGGvn2oCfE8I/iVEtGZoQxGmJ+4AAnuxu3+Zq
         76BjFncqpdpmNf4pYhzJYslJdo8kEhs24zYLTuIOzY3aLo4l5GYn/qddnf66gZZX4SIt
         oKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xSPPahrJHUeB20VFlUnG3g7FNZ0k9zxztEC7Idse5Tg=;
        b=O/5bqkNF5jUMPKIADEcrwLRyGYzrOIHT++60MgeVaTL2t7B2qMsr8dOrMmXiMZW0F8
         DD/Td/XWPJVlZkYNoNKbedWxy9OruPeyp6t4iM7QmAKUbq/uYsd2lek0SREp92OVutdE
         2EfmLrb8Ijr9GDLmBSJQUky1deQQzP6zRXQk7iGxuwoYDZnWGQcsNLqycjwvrbFbj1zt
         hsPanXOPeRtKsJcwyaWuGQBZIuQPGkHuosPgpBtsKtGeSDC2/F2UBhYa2LuvTopY1Kl0
         5JUTJ8dX38hy47iHtUgfoNpDx7r1taEwgjmcIQ3cEzsTdFbIOyWqaXnDOi0czLL59zoa
         FtJQ==
X-Gm-Message-State: AOUpUlG0qjGqOIBLd1rNRaOXcdiDHtQqh0M4dHkG6yYcxZ1cCHFFaDXK
        ERlCGDn5ZcEutBtdzo484jP2Vf3IH+Ahc+eZWR8=
X-Google-Smtp-Source: AAOMgpdB0wyE84ghJueISnmk141Ca3xfuhbI2Bf9EURDAHCSzEdep9OgVt5v+9DGw+QrNpRyHL7hbN92nxwBv6lXe+g=
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr10933010ljf.36.1532926006514;
 Sun, 29 Jul 2018 21:46:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 21:46:45
 -0700 (PDT)
In-Reply-To: <CAFqt6zaZYyes+BRcMuCo39fj6q3K26MzAUgG_YhZpM0HMs3a4Q@mail.gmail.com>
References: <20180703153353.GA3375@jordon-HP-15-Notebook-PC>
 <CAFqt6zaqh+Jv6vmn2iOZL9jVtX7Qwf9b_QFPSfwg2+EcBRo5vA@mail.gmail.com> <CAFqt6zaZYyes+BRcMuCo39fj6q3K26MzAUgG_YhZpM0HMs3a4Q@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 30 Jul 2018 10:16:45 +0530
Message-ID: <CAFqt6zYap9s3fp3uiZxoDciDtS2vMJ1a5J-268C5x1s-88vvrQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: virtio: code cleanup
To:     airlied@linux.ie, Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        SUMAN TRIPATHI <svptas.linux@gmail.com>,
        Ajit Linux <ajitn.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:33 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Tue, Jul 17, 2018 at 5:04 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> On Tue, Jul 3, 2018 at 9:03 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> The fault handler code is commented since v4.2.
>>> If there is no plan to enable the fault handler
>>> code in future, we can remove this dead code.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> ---
>>> v2: corrected subject line
>>>
>>
>> Any further comment on this patch ?
>
> If no further comment, can we get this patch in queue for 4.19 ?
>

Gerd, can we get this patch in queue for 4.19 ?

>>
>>>  drivers/gpu/drm/virtio/virtgpu_ttm.c | 36 +-----------------------------------
>>>  1 file changed, 1 insertion(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
>>> index 11f8ae5..b6f021c 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
>>> @@ -106,29 +106,6 @@ static void virtio_gpu_ttm_global_fini(struct virtio_gpu_device *vgdev)
>>>         }
>>>  }
>>>
>>> -#if 0
>>> -/*
>>> - * Hmm, seems to not do anything useful.  Leftover debug hack?
>>> - * Something like printing pagefaults to kernel log?
>>> - */
>>> -static struct vm_operations_struct virtio_gpu_ttm_vm_ops;
>>> -static const struct vm_operations_struct *ttm_vm_ops;
>>> -
>>> -static int virtio_gpu_ttm_fault(struct vm_fault *vmf)
>>> -{
>>> -       struct ttm_buffer_object *bo;
>>> -       struct virtio_gpu_device *vgdev;
>>> -       int r;
>>> -
>>> -       bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
>>> -       if (bo == NULL)
>>> -               return VM_FAULT_NOPAGE;
>>> -       vgdev = virtio_gpu_get_vgdev(bo->bdev);
>>> -       r = ttm_vm_ops->fault(vmf);
>>> -       return r;
>>> -}
>>> -#endif
>>> -
>>>  int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
>>>  {
>>>         struct drm_file *file_priv;
>>> @@ -143,19 +120,8 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
>>>                 return -EINVAL;
>>>         }
>>>         r = ttm_bo_mmap(filp, vma, &vgdev->mman.bdev);
>>> -#if 0
>>> -       if (unlikely(r != 0))
>>> -               return r;
>>> -       if (unlikely(ttm_vm_ops == NULL)) {
>>> -               ttm_vm_ops = vma->vm_ops;
>>> -               virtio_gpu_ttm_vm_ops = *ttm_vm_ops;
>>> -               virtio_gpu_ttm_vm_ops.fault = &virtio_gpu_ttm_fault;
>>> -       }
>>> -       vma->vm_ops = &virtio_gpu_ttm_vm_ops;
>>> -       return 0;
>>> -#else
>>> +
>>>         return r;
>>> -#endif
>>>  }
>>>
>>>  static int virtio_gpu_invalidate_caches(struct ttm_bo_device *bdev,
>>> --
>>> 1.9.1
>>>
