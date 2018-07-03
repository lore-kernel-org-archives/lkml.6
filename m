Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF065C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8CE244F8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpCU1Wkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8CE244F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeGCGQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:16:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46678 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeGCGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:16:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so570065lju.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t3D84lRtf/dyxknYPi8wpoht901pEUM7hCgr34qGhWg=;
        b=VpCU1WklrXXTFEAs1a4kkgMQsBhK2mrufAET1EMGfcolRUkVCvtywNJKQ5PMo4Gv7p
         45IMS07fokAjVy5a+mf2uSlpOEeVa5jo8aAF2LMr5bOdp+2rnoGSI70g46jI3+8Sxo/V
         DNTUpMe8Ci65cP7b1ouSvWFVvfFLgVt4krckM8lDg3/StClO+TqkZQUixAj+Uw69ipWm
         A30PLOgRDLCPrSuiaUZxBpPOo24RBQJLdwlOvf/u/RXCmvy1xDelJH14LMm2tA6c1Dwx
         sUmrPEmFkngPcSU4P91BkVw9EjgZwYNKS+uN2d9wAHYq3kmMyLWgJ+1uTTHzZrgyQKdG
         ynAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t3D84lRtf/dyxknYPi8wpoht901pEUM7hCgr34qGhWg=;
        b=d8CdS99L4nLRo2ft4Q2oMuQxHIo3hTMBL6qKXY/yONez4D6+LrdxONRadmLNoKrbdh
         CE8SzD/HrsN/QkSfVwqbsFbDWVSfmAPz/ktkG9vMfX/eJIOIVeI89o29GaSLeMzAkKhK
         7xCPgRsNIZA7zFcMksLXJtjEZQirdkenXD4w7JZR/+359ceJqBT1OMrc/TWB67xwciLj
         40BOR3k58SYX4q9N3jsoV5kqlI+UC4qvt6OPzjfsXI0PBf1R5jk+C9QF3qrG4QOpsEVf
         dp1vPBkKN2Dknhm1gUbwDqOC6YwVJjM1peNelRb31kUln2rGAUKJ8F2tOCp4GbSqCV7D
         19Dw==
X-Gm-Message-State: APt69E1d5aHT7kMqckTaS4y+9uwFm6ufcNQn/wU/XsCCr0GuANgfVL8Z
        Dqa7PZpEw43X8M1mi2SdkYPQwUP3Jt4KUe+QAYg=
X-Google-Smtp-Source: AAOMgpfQ085S/JEPY52p9OK2YUczqUeKVVNa8fODcsM9OFbtjXnTVB2E02FCgWuTE9iSP28Ynd8ZJWy+s4UjU6pev4M=
X-Received: by 2002:a2e:4103:: with SMTP id o3-v6mr15639148lja.3.1530598573787;
 Mon, 02 Jul 2018 23:16:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 23:16:13 -0700 (PDT)
In-Reply-To: <CAFqt6zaqxRShzb+87ySiwpiChGCEY+Q2uEyOK9MaW6Z15N73eQ@mail.gmail.com>
References: <20180527004550.GA2263@jordon-HP-15-Notebook-PC>
 <CAFqt6za_3o-tQbYvH9ZetJtUcyM_ksHJasuUA=Z=RDtrYvwM9A@mail.gmail.com> <CAFqt6zaqxRShzb+87ySiwpiChGCEY+Q2uEyOK9MaW6Z15N73eQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 3 Jul 2018 11:46:13 +0530
Message-ID: <CAFqt6zZKZ=yXJLEJKRMy0NbSW=y5-EAVxHxGtsKPMwUHvVpQWg@mail.gmail.com>
Subject: Re: [PATCH v3] gpu: drm: gma500: Change return type to vm_fault_t
To:     Matthew Wilcox <willy@infradead.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:42 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Mon, Jun 4, 2018 at 10:47 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> On Sun, May 27, 2018 at 6:15 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> Use new return type vm_fault_t for fault handler. For
>>> now, this is just documenting that the function returns
>>> a VM_FAULT value rather than an errno. Once all instances
>>> are converted, vm_fault_t will become a distinct type.
>>>
>>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>>
>>> Previously vm_insert_{pfn,mixed} returns err which driver
>>> mapped into VM_FAULT_* type. The new function
>>> vmf_insert_{pfn,mixed} will replace this inefficiency by
>>> returning VM_FAULT_* type.
>>>
>>> vmf_error() is the newly introduce inline function
>>> in 4.17-rc6.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>>> ---
>>> v2: updated the change log
>>>
>>> v3: Fixed kbuild error
>>>
>>>  drivers/gpu/drm/gma500/framebuffer.c | 14 +++++---------
>>>  drivers/gpu/drm/gma500/gem.c         | 27 ++++++++++-----------------
>>>  drivers/gpu/drm/gma500/psb_drv.h     |  3 ++-
>>>  3 files changed, 17 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
>>> index cb0a2ae..632aadb 100644
>>> --- a/drivers/gpu/drm/gma500/framebuffer.c
>>> +++ b/drivers/gpu/drm/gma500/framebuffer.c
>>> @@ -111,7 +111,7 @@ static int psbfb_pan(struct fb_var_screeninfo *var, struct fb_info *info)
>>>          return 0;
>>>  }
>>>
>>> -static int psbfb_vm_fault(struct vm_fault *vmf)
>>> +static vm_fault_t psbfb_vm_fault(struct vm_fault *vmf)
>>>  {
>>>         struct vm_area_struct *vma = vmf->vma;
>>>         struct psb_framebuffer *psbfb = vma->vm_private_data;
>>> @@ -120,7 +120,7 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
>>>         int page_num;
>>>         int i;
>>>         unsigned long address;
>>> -       int ret;
>>> +       vm_fault_t ret = VM_FAULT_SIGBUS;
>>>         unsigned long pfn;
>>>         unsigned long phys_addr = (unsigned long)dev_priv->stolen_base +
>>>                                   psbfb->gtt->offset;
>>> @@ -133,18 +133,14 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
>>>         for (i = 0; i < page_num; i++) {
>>>                 pfn = (phys_addr >> PAGE_SHIFT);
>>>
>>> -               ret = vm_insert_mixed(vma, address,
>>> +               ret = vmf_insert_mixed(vma, address,
>>>                                 __pfn_to_pfn_t(pfn, PFN_DEV));
>>> -               if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
>>> +               if (unlikely(ret & VM_FAULT_ERROR))
>>>                         break;
>>> -               else if (unlikely(ret != 0)) {
>>> -                       ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
>>> -                       return ret;
>>> -               }
>>>                 address += PAGE_SIZE;
>>>                 phys_addr += PAGE_SIZE;
>>>         }
>>> -       return VM_FAULT_NOPAGE;
>>> +       return ret;
>>>  }
>>>
>>>  static void psbfb_vm_open(struct vm_area_struct *vma)
>>> diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
>>> index 1312397..e7be5c9 100644
>>> --- a/drivers/gpu/drm/gma500/gem.c
>>> +++ b/drivers/gpu/drm/gma500/gem.c
>>> @@ -134,12 +134,13 @@ int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>>>   *     vma->vm_private_data points to the GEM object that is backing this
>>>   *     mapping.
>>>   */
>>> -int psb_gem_fault(struct vm_fault *vmf)
>>> +vm_fault_t psb_gem_fault(struct vm_fault *vmf)
>>>  {
>>>         struct vm_area_struct *vma = vmf->vma;
>>>         struct drm_gem_object *obj;
>>>         struct gtt_range *r;
>>> -       int ret;
>>> +       int err;
>>> +       vm_fault_t ret;
>>>         unsigned long pfn;
>>>         pgoff_t page_offset;
>>>         struct drm_device *dev;
>>> @@ -158,9 +159,10 @@ int psb_gem_fault(struct vm_fault *vmf)
>>>         /* For now the mmap pins the object and it stays pinned. As things
>>>            stand that will do us no harm */
>>>         if (r->mmapping == 0) {
>>> -               ret = psb_gtt_pin(r);
>>> -               if (ret < 0) {
>>> -                       dev_err(dev->dev, "gma500: pin failed: %d\n", ret);
>>> +               err = psb_gtt_pin(r);
>>> +               if (err < 0) {
>>> +                       dev_err(dev->dev, "gma500: pin failed: %d\n", err);
>>> +                       ret = vmf_error(err);
>>>                         goto fail;
>>>                 }
>>>                 r->mmapping = 1;
>>> @@ -175,18 +177,9 @@ int psb_gem_fault(struct vm_fault *vmf)
>>>                 pfn = (dev_priv->stolen_base + r->offset) >> PAGE_SHIFT;
>>>         else
>>>                 pfn = page_to_pfn(r->pages[page_offset]);
>>> -       ret = vm_insert_pfn(vma, vmf->address, pfn);
>>> -
>>> +       ret = vmf_insert_pfn(vma, vmf->address, pfn);
>>>  fail:
>>>         mutex_unlock(&dev_priv->mmap_mutex);
>>> -       switch (ret) {
>>> -       case 0:
>>> -       case -ERESTARTSYS:
>>> -       case -EINTR:
>>> -               return VM_FAULT_NOPAGE;
>>> -       case -ENOMEM:
>>> -               return VM_FAULT_OOM;
>>> -       default:
>>> -               return VM_FAULT_SIGBUS;
>>> -       }
>>> +
>>> +       return ret;
>>>  }
>>> diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
>>> index e8300f5..93d2f40 100644
>>> --- a/drivers/gpu/drm/gma500/psb_drv.h
>>> +++ b/drivers/gpu/drm/gma500/psb_drv.h
>>> @@ -21,6 +21,7 @@
>>>  #define _PSB_DRV_H_
>>>
>>>  #include <linux/kref.h>
>>> +#include <linux/mm_types.h>
>>>
>>>  #include <drm/drmP.h>
>>>  #include <drm/drm_global.h>
>>> @@ -749,7 +750,7 @@ extern int psb_gem_get_aperture(struct drm_device *dev, void *data,
>>>                         struct drm_file *file);
>>>  extern int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>>>                         struct drm_mode_create_dumb *args);
>>> -extern int psb_gem_fault(struct vm_fault *vmf);
>>> +extern vm_fault_t psb_gem_fault(struct vm_fault *vmf);
>>>
>>>  /* psb_device.c */
>>>  extern const struct psb_ops psb_chip_ops;
>>> --
>>> 1.9.1
>>>
>>
>> If no comment, we would like to get this patch
>> in 4.18.
>
> Patrik, Is it possible to get this patch in 4.18 ?

Can we get this patch in queue for 4.19 ?
