Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BD5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAFD20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0hhAQ4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAFD20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbeGXHIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:08:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38603 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbeGXHIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:08:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id a4-v6so2134246lff.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HUNlzwLI2RwtpTwtLz1+mEhCJhi8GxXtko/guoNblZs=;
        b=W0hhAQ4I/C5Ow1mKXwToPlWhmDXPB4f3PXeFfUL2QD3CCBZnHy1G2JPgWnEHrjZfxq
         domm+saw6e2tliXuIPsoxmw1U/wETAMAdE1FbdgW/geduHqHLcDqLZorOVafL7wQcjGJ
         Ya+EGI7jVsHiWWxyesBXkgbjkr6t60BecpMGcf97wa0CqVfT7EEuXxk26S7fZL8dEPUS
         5E/0esaCL7C0ItdPuMcumDHcLub4y7TQrbzkidpwokkgJMWFuNRkWuXiJaXmpQwuN8db
         OzprXyCqtJnh9qATsFghTQdfZR8eBMuhsTP6QZEIw2zX2n3kuxC/BNNzeMEv+7UKWXwm
         IcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HUNlzwLI2RwtpTwtLz1+mEhCJhi8GxXtko/guoNblZs=;
        b=Px0vc/7o8UIjQnUzaeNVvjj11G3hdQyc4C5vgXaZ+FO3YdjPEbahgxz4c/rPAasNJQ
         z2ldmXzhKaVAm+WpyRHF01wHMmbemqTaWNceRiAHR0K/OZ4EwhxTnNjKZdL+cEXEmmJU
         TmwjqkyUiZlusOi0H7CkkPF9oeqX4d9aIQTJiwV/kwlCra+zO3eC9d7nLU6f2TigL+AM
         Pyh6A+g1mBwK9+SELutFRNAzcNa2SZei+EimbgJrcXA1eR+1zCUhccTAkuXm3ilFTgfQ
         UR8t41AUu13mHcNIY+Qo2hqi3Fmv4ytEZ04GH/5ebwR31ErtDok2Alh1XQ0+phqI4wEH
         EZvQ==
X-Gm-Message-State: AOUpUlFpddMo09q4ktA6yI2e/lh2WCdeG9ZHNT5FX2nwRrI5mpZ1nEq3
        b842oe/MgpL3MC0oolAXe7UCQNKVahXJsPBJ6aU=
X-Google-Smtp-Source: AAOMgpdLIz/+gCnVo2XU7I8BaBOp63EciKCKJPLYh8uyCHsaivHUaEw/ox2IbsA5bg9RYrn3tRgPhdOUNdCEVlGs5Vs=
X-Received: by 2002:a19:d942:: with SMTP id q63-v6mr8673960lfg.39.1532412192824;
 Mon, 23 Jul 2018 23:03:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:57d1:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 23:03:11
 -0700 (PDT)
In-Reply-To: <CAFqt6zaqh+Jv6vmn2iOZL9jVtX7Qwf9b_QFPSfwg2+EcBRo5vA@mail.gmail.com>
References: <20180703153353.GA3375@jordon-HP-15-Notebook-PC> <CAFqt6zaqh+Jv6vmn2iOZL9jVtX7Qwf9b_QFPSfwg2+EcBRo5vA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 24 Jul 2018 11:33:11 +0530
Message-ID: <CAFqt6zaZYyes+BRcMuCo39fj6q3K26MzAUgG_YhZpM0HMs3a4Q@mail.gmail.com>
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

On Tue, Jul 17, 2018 at 5:04 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 9:03 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> The fault handler code is commented since v4.2.
>> If there is no plan to enable the fault handler
>> code in future, we can remove this dead code.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>> v2: corrected subject line
>>
>
> Any further comment on this patch ?

If no further comment, can we get this patch in queue for 4.19 ?

>
>>  drivers/gpu/drm/virtio/virtgpu_ttm.c | 36 +-----------------------------------
>>  1 file changed, 1 insertion(+), 35 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
>> index 11f8ae5..b6f021c 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
>> @@ -106,29 +106,6 @@ static void virtio_gpu_ttm_global_fini(struct virtio_gpu_device *vgdev)
>>         }
>>  }
>>
>> -#if 0
>> -/*
>> - * Hmm, seems to not do anything useful.  Leftover debug hack?
>> - * Something like printing pagefaults to kernel log?
>> - */
>> -static struct vm_operations_struct virtio_gpu_ttm_vm_ops;
>> -static const struct vm_operations_struct *ttm_vm_ops;
>> -
>> -static int virtio_gpu_ttm_fault(struct vm_fault *vmf)
>> -{
>> -       struct ttm_buffer_object *bo;
>> -       struct virtio_gpu_device *vgdev;
>> -       int r;
>> -
>> -       bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
>> -       if (bo == NULL)
>> -               return VM_FAULT_NOPAGE;
>> -       vgdev = virtio_gpu_get_vgdev(bo->bdev);
>> -       r = ttm_vm_ops->fault(vmf);
>> -       return r;
>> -}
>> -#endif
>> -
>>  int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
>>  {
>>         struct drm_file *file_priv;
>> @@ -143,19 +120,8 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma)
>>                 return -EINVAL;
>>         }
>>         r = ttm_bo_mmap(filp, vma, &vgdev->mman.bdev);
>> -#if 0
>> -       if (unlikely(r != 0))
>> -               return r;
>> -       if (unlikely(ttm_vm_ops == NULL)) {
>> -               ttm_vm_ops = vma->vm_ops;
>> -               virtio_gpu_ttm_vm_ops = *ttm_vm_ops;
>> -               virtio_gpu_ttm_vm_ops.fault = &virtio_gpu_ttm_fault;
>> -       }
>> -       vma->vm_ops = &virtio_gpu_ttm_vm_ops;
>> -       return 0;
>> -#else
>> +
>>         return r;
>> -#endif
>>  }
>>
>>  static int virtio_gpu_invalidate_caches(struct ttm_bo_device *bdev,
>> --
>> 1.9.1
>>
