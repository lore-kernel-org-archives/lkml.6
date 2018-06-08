Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Zrz6I3UHGlvBEQAAmS7hNA
	; Fri, 08 Jun 2018 04:37:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D3BE607DC; Fri,  8 Jun 2018 04:37:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bViEaJ1U"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 75C236063F;
	Fri,  8 Jun 2018 04:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75C236063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeFHEhc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:37:32 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40550 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeFHEhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:37:31 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so17985325lfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 21:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=klwXvFMNI/nBgv2zh8lvWsCWdo1nim2nBFA2ecSQzTk=;
        b=bViEaJ1UeEK2bWcUYV6UgvcjRVDj4E9zKvowE3BWfw2ltB4gWwwbRpDGIcp2XI89aq
         haCjKoO6bZ28ApSlFHB5K1Q4hTZ4tYZmUG3H2sdjdaEFjzOe6axOExt/S90WULEhu1V6
         JH1rKZvhUm2THl8chZZbM3ryHkJrCzZuVBZtKqqRM6S3PiHq79hdPBzHH94tlg1p5WO/
         EaZ1uUK/TcIWBhZlTZSjukTQJXZ/VomlfPAUauNSTqiRd/pV6xZ7e+uJ3g++lNYzA6dA
         /I4oaN5guhoQcvAn1JcIkq5MTEBqf4va7m2ytYs8BMlX6KI5fpTvqVkPdcn8OqDDeB2r
         58hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=klwXvFMNI/nBgv2zh8lvWsCWdo1nim2nBFA2ecSQzTk=;
        b=gJ+EsrkvV1xlcLJmxPIuU0aQWFcirAOzzc3Blv8r8ygftQCVvcYuncN+TScCPRdL8H
         CL4uw4B/M7Cn017rR9GNY1dea1H13fjrGUodK/SkyDbFX4RCOWIjfgORXS1uPCA3YKsq
         hi++h3+KLRyX/tHqMHsKWni+ZwzCjKLxqDE7H9idha2Sbcc1uX30jQvoRSGA0+Ph56Ls
         sXaDF5n6UHqq0Zj81zZPvYyjnjFuhIzaKAN1q/5Ln7sZiTi6IvnJApGWzXeFT71w9TYn
         KXTSoHomWFpdekcb7NDKXrfsqUOgeLm+T5HD5zO4bpIJcvl1JV3wyew58/RCMp0isR/g
         Knmw==
X-Gm-Message-State: APt69E3i+BgrQX847cx3y7eq3TpHes9ltJuX3j3COmx4EOP3T40REsI3
        JKAObtDjmMx71iEuEC2l+O6G8s4TJZn8IlzTWXo=
X-Google-Smtp-Source: ADUXVKKC4RDOalHY1bfvrwOPBo2XKpbrNoVgQXsZ9tYU6vOEzENP1FKmmccmL5fAfuv6lwfGsowljNaR+MlIs45axm8=
X-Received: by 2002:a2e:93c9:: with SMTP id p9-v6mr1020883ljh.117.1528432649364;
 Thu, 07 Jun 2018 21:37:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d885:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 21:37:28 -0700 (PDT)
In-Reply-To: <CAFqt6zaksGTZPeT1T_7KdcsGMRmsF=91tp8rvXNUi3wy-5QUBQ@mail.gmail.com>
References: <20180522181357.GA31257@jordon-HP-15-Notebook-PC> <CAFqt6zaksGTZPeT1T_7KdcsGMRmsF=91tp8rvXNUi3wy-5QUBQ@mail.gmail.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 8 Jun 2018 10:07:28 +0530
Message-ID: <CAFqt6zaib6=LjQYkCGN_X7Q1uH=t5L0fw=2zOYz9aOvShQqdJg@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: drm: omapdrm: Adding new typedef vm_fault_t
To: tomi.valkeinen@ti.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 11:11 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Tue, May 22, 2018 at 11:43 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Previously vm_insert_mixed() returns err which driver
>> mapped into VM_FAULT_* type. Also return value of
>> vm_insert_mixed() not handled correctly and 0 was
>> returned inside fault_2d() as default. The new function
>> vmf_insert_mixed() will replace this inefficiency by
>> returning correct VM_FAULT_* type.
>>
>> vmf_error() is the newly introduce inline function
>> in 4.17-rc6.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>> v2: Fixed kbuild error by initialized ret
>>     in fault_2d().
>>
>>  drivers/gpu/drm/omapdrm/omap_gem.c | 51 +++++++++++++++++---------------------
>>  drivers/gpu/drm/omapdrm/omap_gem.h |  3 ++-
>>  2 files changed, 25 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
>> index 0faf042..99e4300 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
>> @@ -371,7 +371,7 @@ size_t omap_gem_mmap_size(struct drm_gem_object *obj)
>>   */
>>
>>  /* Normal handling for the case of faulting in non-tiled buffers */
>> -static int fault_1d(struct drm_gem_object *obj,
>> +static vm_fault_t fault_1d(struct drm_gem_object *obj,
>>                 struct vm_area_struct *vma, struct vm_fault *vmf)
>>  {
>>         struct omap_gem_object *omap_obj = to_omap_bo(obj);
>> @@ -392,11 +392,12 @@ static int fault_1d(struct drm_gem_object *obj,
>>         VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
>>                         pfn, pfn << PAGE_SHIFT);
>>
>> -       return vm_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
>> +       return vmf_insert_mixed(vma, vmf->address,
>> +                       __pfn_to_pfn_t(pfn, PFN_DEV));
>>  }
>>
>>  /* Special handling for the case of faulting in 2d tiled buffers */
>> -static int fault_2d(struct drm_gem_object *obj,
>> +static vm_fault_t fault_2d(struct drm_gem_object *obj,
>>                 struct vm_area_struct *vma, struct vm_fault *vmf)
>>  {
>>         struct omap_gem_object *omap_obj = to_omap_bo(obj);
>> @@ -407,7 +408,8 @@ static int fault_2d(struct drm_gem_object *obj,
>>         unsigned long pfn;
>>         pgoff_t pgoff, base_pgoff;
>>         unsigned long vaddr;
>> -       int i, ret, slots;
>> +       int i, err, slots;
>> +       vm_fault_t ret = VM_FAULT_NOPAGE;
>>
>>         /*
>>          * Note the height of the slot is also equal to the number of pages
>> @@ -473,9 +475,10 @@ static int fault_2d(struct drm_gem_object *obj,
>>         memset(pages + slots, 0,
>>                         sizeof(struct page *) * (n - slots));
>>
>> -       ret = tiler_pin(entry->block, pages, ARRAY_SIZE(pages), 0, true);
>> -       if (ret) {
>> -               dev_err(obj->dev->dev, "failed to pin: %d\n", ret);
>> +       err = tiler_pin(entry->block, pages, ARRAY_SIZE(pages), 0, true);
>> +       if (err) {
>> +               ret = vmf_error(err);
>> +               dev_err(obj->dev->dev, "failed to pin: %d\n", err);
>>                 return ret;
>>         }
>>
>> @@ -485,7 +488,10 @@ static int fault_2d(struct drm_gem_object *obj,
>>                         pfn, pfn << PAGE_SHIFT);
>>
>>         for (i = n; i > 0; i--) {
>> -               vm_insert_mixed(vma, vaddr, __pfn_to_pfn_t(pfn, PFN_DEV));
>> +               ret = vmf_insert_mixed(vma,
>> +                       vaddr, __pfn_to_pfn_t(pfn, PFN_DEV));
>> +               if (ret & VM_FAULT_ERROR)
>> +                       break;
>>                 pfn += priv->usergart[fmt].stride_pfn;
>>                 vaddr += PAGE_SIZE * m;
>>         }
>> @@ -494,7 +500,7 @@ static int fault_2d(struct drm_gem_object *obj,
>>         priv->usergart[fmt].last = (priv->usergart[fmt].last + 1)
>>                                  % NUM_USERGART_ENTRIES;
>>
>> -       return 0;
>> +       return ret;
>>  }
>>
>>  /**
>> @@ -509,14 +515,15 @@ static int fault_2d(struct drm_gem_object *obj,
>>   * vma->vm_private_data points to the GEM object that is backing this
>>   * mapping.
>>   */
>> -int omap_gem_fault(struct vm_fault *vmf)
>> +vm_fault_t omap_gem_fault(struct vm_fault *vmf)
>>  {
>>         struct vm_area_struct *vma = vmf->vma;
>>         struct drm_gem_object *obj = vma->vm_private_data;
>>         struct omap_gem_object *omap_obj = to_omap_bo(obj);
>>         struct drm_device *dev = obj->dev;
>>         struct page **pages;
>> -       int ret;
>> +       int err;
>> +       vm_fault_t ret;
>>
>>         /* Make sure we don't parallel update on a fault, nor move or remove
>>          * something from beneath our feet
>> @@ -524,9 +531,11 @@ int omap_gem_fault(struct vm_fault *vmf)
>>         mutex_lock(&dev->struct_mutex);
>>
>>         /* if a shmem backed object, make sure we have pages attached now */
>> -       ret = get_pages(obj, &pages);
>> -       if (ret)
>> +       err = get_pages(obj, &pages);
>> +       if (err) {
>> +               ret = vmf_error(err);
>>                 goto fail;
>> +       }
>>
>>         /* where should we do corresponding put_pages().. we are mapping
>>          * the original page, rather than thru a GART, so we can't rely
>> @@ -542,21 +551,7 @@ int omap_gem_fault(struct vm_fault *vmf)
>>
>>  fail:
>>         mutex_unlock(&dev->struct_mutex);
>> -       switch (ret) {
>> -       case 0:
>> -       case -ERESTARTSYS:
>> -       case -EINTR:
>> -       case -EBUSY:
>> -               /*
>> -                * EBUSY is ok: this just means that another thread
>> -                * already did the job.
>> -                */
>> -               return VM_FAULT_NOPAGE;
>> -       case -ENOMEM:
>> -               return VM_FAULT_OOM;
>> -       default:
>> -               return VM_FAULT_SIGBUS;
>> -       }
>> +       return ret;
>>  }
>>
>>  /** We override mainly to fix up some of the vm mapping flags.. */
>> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.h b/drivers/gpu/drm/omapdrm/omap_gem.h
>> index a78bde0..c1c45fb 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_gem.h
>> +++ b/drivers/gpu/drm/omapdrm/omap_gem.h
>> @@ -21,6 +21,7 @@
>>  #define __OMAPDRM_GEM_H__
>>
>>  #include <linux/types.h>
>> +#include <linux/mm_types.h>
>>
>>  enum dma_data_direction;
>>
>> @@ -80,7 +81,7 @@ struct dma_buf *omap_gem_prime_export(struct drm_device *dev,
>>  struct drm_gem_object *omap_gem_prime_import(struct drm_device *dev,
>>                 struct dma_buf *buffer);
>>
>> -int omap_gem_fault(struct vm_fault *vmf);
>> +vm_fault_t omap_gem_fault(struct vm_fault *vmf);
>>  int omap_gem_roll(struct drm_gem_object *obj, u32 roll);
>>  void omap_gem_cpu_sync_page(struct drm_gem_object *obj, int pgoff);
>>  void omap_gem_dma_sync_buffer(struct drm_gem_object *obj,
>> --
>> 1.9.1
>>
>
> Any comment for this patch ? We would like to get this patch
> in queue for 4.18.

If no comment, we would like to get this patch in 4.18.
