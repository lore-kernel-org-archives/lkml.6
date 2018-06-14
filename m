Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 188C2C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA833208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOFxImtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA833208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755339AbeFNTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:12:14 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35022 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754660AbeFNTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:12:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so11095946lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HJbSyhUji9dGbrWW26NRJkHbkfTMZoBDZ84z57bU3Z0=;
        b=FOFxImtGe1Rla+4TJMOvlMu1oB/3LHJvOfD43NS0rBVuQlEeUTgzrnQH3dhdaMTk2l
         B1ptNe0MOc2pPW2Wae4rV66ZvBHZouWH5LhNIKAabwIhp4IKIiNY3iiom+mFYiXwuHj7
         U6c2Ug4HazoCvAbMpuZl54l6FlKzD6u19b0fN/eFc2SBsIkPDBa5dpiXSJzmVWgJhXEx
         oVWveS/zF3PN/SVN7O1fs2uuw4r+02qxiERfGIpOtHdrwhN3zafItOn6rbEfGUrVZXVT
         vMHQxLBHOnhlhDFRgyyfLv4bc79ATHFKQUBo/4HNnZ/VJAyu2Kx0MD/n9P+9/2U5nxJk
         B4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HJbSyhUji9dGbrWW26NRJkHbkfTMZoBDZ84z57bU3Z0=;
        b=SGhsYX91fp381OaSYu20bykA2wYn0Xa4hIXQ3CKxQlVO8EVyTOhqc72Vo7BuIjvZ06
         bowH/0v5yMc51uXZ+8RBIlg8qVpId5oA5EkWhBa0uWnD6PBq4OQS3lNnpJ9I3k6mPGz/
         odMQ6caqkFK83zgzxvvg2S/ByetOYbWeuyhk+NneIYNI5Q/C8dp8BO/SCTEatsw0ymfw
         ELF10HRm6bMW2XPMT+ubuHG4oAtbbqB4YuxPhP4RTPu3VwHIku3M43pRMCdghZiA0evY
         5oR3SFO6b3mw+kEC0XL9sPl9KgxBYrbFSgxz+k0/c4rjY6QEicnAsT0sfoaJLZswNee3
         pVsw==
X-Gm-Message-State: APt69E3XN9lwt2qv/9V/aqBm5xvsPdQ+40IQOkwLy2xX6GPbBgFDSPyF
        fQ5MOCUuncs1NVmOTlMbG8IYP4CLhiP1ORKTqTM=
X-Google-Smtp-Source: ADUXVKIniOQyJvzgD+VmdSnfsRuUQzusqIvNUQN8vUjnUMPZYpaOVCUUFfceAyCLuVidmvjOuvEKTL59Z/PhEGMsFCA=
X-Received: by 2002:a19:e117:: with SMTP id y23-v6mr6741794lfg.9.1529003531229;
 Thu, 14 Jun 2018 12:12:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 12:12:10
 -0700 (PDT)
In-Reply-To: <CAFqt6za_3o-tQbYvH9ZetJtUcyM_ksHJasuUA=Z=RDtrYvwM9A@mail.gmail.com>
References: <20180527004550.GA2263@jordon-HP-15-Notebook-PC> <CAFqt6za_3o-tQbYvH9ZetJtUcyM_ksHJasuUA=Z=RDtrYvwM9A@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 15 Jun 2018 00:42:10 +0530
Message-ID: <CAFqt6zaqxRShzb+87ySiwpiChGCEY+Q2uEyOK9MaW6Z15N73eQ@mail.gmail.com>
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

On Mon, Jun 4, 2018 at 10:47 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Sun, May 27, 2018 at 6:15 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Previously vm_insert_{pfn,mixed} returns err which driver
>> mapped into VM_FAULT_* type. The new function
>> vmf_insert_{pfn,mixed} will replace this inefficiency by
>> returning VM_FAULT_* type.
>>
>> vmf_error() is the newly introduce inline function
>> in 4.17-rc6.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>> v2: updated the change log
>>
>> v3: Fixed kbuild error
>>
>>  drivers/gpu/drm/gma500/framebuffer.c | 14 +++++---------
>>  drivers/gpu/drm/gma500/gem.c         | 27 ++++++++++-----------------
>>  drivers/gpu/drm/gma500/psb_drv.h     |  3 ++-
>>  3 files changed, 17 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
>> index cb0a2ae..632aadb 100644
>> --- a/drivers/gpu/drm/gma500/framebuffer.c
>> +++ b/drivers/gpu/drm/gma500/framebuffer.c
>> @@ -111,7 +111,7 @@ static int psbfb_pan(struct fb_var_screeninfo *var, struct fb_info *info)
>>          return 0;
>>  }
>>
>> -static int psbfb_vm_fault(struct vm_fault *vmf)
>> +static vm_fault_t psbfb_vm_fault(struct vm_fault *vmf)
>>  {
>>         struct vm_area_struct *vma = vmf->vma;
>>         struct psb_framebuffer *psbfb = vma->vm_private_data;
>> @@ -120,7 +120,7 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
>>         int page_num;
>>         int i;
>>         unsigned long address;
>> -       int ret;
>> +       vm_fault_t ret = VM_FAULT_SIGBUS;
>>         unsigned long pfn;
>>         unsigned long phys_addr = (unsigned long)dev_priv->stolen_base +
>>                                   psbfb->gtt->offset;
>> @@ -133,18 +133,14 @@ static int psbfb_vm_fault(struct vm_fault *vmf)
>>         for (i = 0; i < page_num; i++) {
>>                 pfn = (phys_addr >> PAGE_SHIFT);
>>
>> -               ret = vm_insert_mixed(vma, address,
>> +               ret = vmf_insert_mixed(vma, address,
>>                                 __pfn_to_pfn_t(pfn, PFN_DEV));
>> -               if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
>> +               if (unlikely(ret & VM_FAULT_ERROR))
>>                         break;
>> -               else if (unlikely(ret != 0)) {
>> -                       ret = (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
>> -                       return ret;
>> -               }
>>                 address += PAGE_SIZE;
>>                 phys_addr += PAGE_SIZE;
>>         }
>> -       return VM_FAULT_NOPAGE;
>> +       return ret;
>>  }
>>
>>  static void psbfb_vm_open(struct vm_area_struct *vma)
>> diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
>> index 1312397..e7be5c9 100644
>> --- a/drivers/gpu/drm/gma500/gem.c
>> +++ b/drivers/gpu/drm/gma500/gem.c
>> @@ -134,12 +134,13 @@ int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>>   *     vma->vm_private_data points to the GEM object that is backing this
>>   *     mapping.
>>   */
>> -int psb_gem_fault(struct vm_fault *vmf)
>> +vm_fault_t psb_gem_fault(struct vm_fault *vmf)
>>  {
>>         struct vm_area_struct *vma = vmf->vma;
>>         struct drm_gem_object *obj;
>>         struct gtt_range *r;
>> -       int ret;
>> +       int err;
>> +       vm_fault_t ret;
>>         unsigned long pfn;
>>         pgoff_t page_offset;
>>         struct drm_device *dev;
>> @@ -158,9 +159,10 @@ int psb_gem_fault(struct vm_fault *vmf)
>>         /* For now the mmap pins the object and it stays pinned. As things
>>            stand that will do us no harm */
>>         if (r->mmapping == 0) {
>> -               ret = psb_gtt_pin(r);
>> -               if (ret < 0) {
>> -                       dev_err(dev->dev, "gma500: pin failed: %d\n", ret);
>> +               err = psb_gtt_pin(r);
>> +               if (err < 0) {
>> +                       dev_err(dev->dev, "gma500: pin failed: %d\n", err);
>> +                       ret = vmf_error(err);
>>                         goto fail;
>>                 }
>>                 r->mmapping = 1;
>> @@ -175,18 +177,9 @@ int psb_gem_fault(struct vm_fault *vmf)
>>                 pfn = (dev_priv->stolen_base + r->offset) >> PAGE_SHIFT;
>>         else
>>                 pfn = page_to_pfn(r->pages[page_offset]);
>> -       ret = vm_insert_pfn(vma, vmf->address, pfn);
>> -
>> +       ret = vmf_insert_pfn(vma, vmf->address, pfn);
>>  fail:
>>         mutex_unlock(&dev_priv->mmap_mutex);
>> -       switch (ret) {
>> -       case 0:
>> -       case -ERESTARTSYS:
>> -       case -EINTR:
>> -               return VM_FAULT_NOPAGE;
>> -       case -ENOMEM:
>> -               return VM_FAULT_OOM;
>> -       default:
>> -               return VM_FAULT_SIGBUS;
>> -       }
>> +
>> +       return ret;
>>  }
>> diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
>> index e8300f5..93d2f40 100644
>> --- a/drivers/gpu/drm/gma500/psb_drv.h
>> +++ b/drivers/gpu/drm/gma500/psb_drv.h
>> @@ -21,6 +21,7 @@
>>  #define _PSB_DRV_H_
>>
>>  #include <linux/kref.h>
>> +#include <linux/mm_types.h>
>>
>>  #include <drm/drmP.h>
>>  #include <drm/drm_global.h>
>> @@ -749,7 +750,7 @@ extern int psb_gem_get_aperture(struct drm_device *dev, void *data,
>>                         struct drm_file *file);
>>  extern int psb_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
>>                         struct drm_mode_create_dumb *args);
>> -extern int psb_gem_fault(struct vm_fault *vmf);
>> +extern vm_fault_t psb_gem_fault(struct vm_fault *vmf);
>>
>>  /* psb_device.c */
>>  extern const struct psb_ops psb_chip_ops;
>> --
>> 1.9.1
>>
>
> If no comment, we would like to get this patch
> in 4.18.

Patrik, Is it possible to get this patch in 4.18 ?
