Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8824C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC3220693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3uYHWa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC3220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936041AbeFRVny (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:43:54 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54869 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933241AbeFRVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:43:51 -0400
Received: by mail-it0-f67.google.com with SMTP id 76-v6so14267786itx.4;
        Mon, 18 Jun 2018 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/gGtEXR/lxRYAVlA1pSE60aCTJ+5VXSLezaexBh7SVo=;
        b=Z3uYHWa3SzLYExVDr4/4mtwCe1lSzcJaO29RYg1WSPz5oHdyBEC9r/OG5lTFJiVFO9
         F450xZuJefyTQxHJ4oEhHssSCR9W3OgVu0AjJOyfH1mNOH8Xl+vSAABAhc2aNGDp6pRI
         pDMj/6LC5t3fAhujg8Pnz8e5eNoJjvJp9WMsGIECGbc06UbvzAXTf5n2im7KfKSPpjxg
         boMQSISvTI5BEbi0nJ1R7C4Uh/6ZtFU1thFqd/CzuDEVZS0eze4PNs/lS+oUU5Sc/jGi
         UmD4nxThaqXNB0LQR91+kSypKAGFguY4R1XAeCCFQKjqGvr/H6CM0HbrlWP3NCxyKGtg
         S03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/gGtEXR/lxRYAVlA1pSE60aCTJ+5VXSLezaexBh7SVo=;
        b=N1U3I5Q0jUqDlVg4SUnPuFWLv8n2O9z1yAyX/ycDHFbOqaRrOdrmoVWdA5pk+Ws656
         nFhvTpHqlzvIu4guy5cDkQNXJGSbzyeN8DHnHITijS+0UrYjU7lmF4EX0wM5W4QZ4fBc
         xF8+SoqGtIDI6OvIhFK2DOsmlyW/Lqe9y+rtJCrHP3IXl4q7vEay7M++h/ajqlIn9DRU
         cDNUtATb1/UqL8R7S1G3qcwTyzMl0U+8Zo6Hdc52obUAKpyjJaYZmx9ITDc1zJ2mW8GH
         POHuSg0XKyL4+R6cZWUIlPdlLD5QShO5gjpSYI9abOYi1u5bzFd/sPk7n8IzeODdgiJC
         cg7A==
X-Gm-Message-State: APt69E0+E3wIGy3B3++ihwldTxPAq6XnLq0+eoO+RUrWjP8XQd/Omcki
        ++B89a5hGAvsF5t1h/KJNC4IqxHbQJtH0eKYI7A=
X-Google-Smtp-Source: ADUXVKLaxu225cRyg+W1blw2G8W1ZblYd2x6i4sJYGzNrzsDtn594waJPfrj2i6wojYj+iTrqCzyFMlhMXiKKiiZInw=
X-Received: by 2002:a24:c246:: with SMTP id i67-v6mr11751155itg.45.1529358230689;
 Mon, 18 Jun 2018 14:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a7aa:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 14:43:50
 -0700 (PDT)
In-Reply-To: <CAFqt6zaVbJWCvCf8AF5nKPCpqrSi1Aweog2=V9xzJFzWGbmd3w@mail.gmail.com>
References: <20180521172948.GA18605@jordon-HP-15-Notebook-PC>
 <CAFqt6zY8VJ791_6C_pqrGgjG91T1kirEmUyA3JC+3JsN8QjFAw@mail.gmail.com>
 <20180531175902.GC11565@jcrouse-lnx.qualcomm.com> <CAFqt6zaVbJWCvCf8AF5nKPCpqrSi1Aweog2=V9xzJFzWGbmd3w@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Mon, 18 Jun 2018 17:43:50 -0400
Message-ID: <CAF6AEGvEkC9WiEC79W-Wny0mVCnjDJq4xhgduEZSSx6WaiSjmw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] gpu: drm: msm: Change return type to vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        Matthew Wilcox <willy@infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 11:40 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Thu, May 31, 2018 at 11:29 PM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
>> On Mon, May 28, 2018 at 12:38:41PM +0530, Souptick Joarder wrote:
>>> On Mon, May 21, 2018 at 10:59 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> > Use new return type vm_fault_t for fault handler. For
>>> > now, this is just documenting that the function returns
>>> > a VM_FAULT value rather than an errno. Once all instances
>>> > are converted, vm_fault_t will become a distinct type.
>>> >
>>> > Ref- commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>> >
>>> > Previously vm_insert_mixed() returns err which driver
>>> > mapped into VM_FAULT_* type. The new function
>>> > vmf_insert_mixed() will replace this inefficiency by
>>> > returning VM_FAULT_* type.
>>> >
>>> > vmf_error() is the newly introduce inline function
>>> > in 4.17-rc6.
>>> >
>>> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>>> > ---
>>> >  drivers/gpu/drm/msm/msm_drv.h |  3 ++-
>>> >  drivers/gpu/drm/msm/msm_gem.c | 33 ++++++++++-----------------------
>>> >  2 files changed, 12 insertions(+), 24 deletions(-)
>>> >
>>> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>>> > index 0a653dd..44b4ca7 100644
>>> > --- a/drivers/gpu/drm/msm/msm_drv.h
>>> > +++ b/drivers/gpu/drm/msm/msm_drv.h
>>> > @@ -33,6 +33,7 @@
>>> >  #include <linux/of_graph.h>
>>> >  #include <linux/of_device.h>
>>> >  #include <asm/sizes.h>
>>> > +#include <linux/mm_types.h>
>>> >
>>> >  #include <drm/drmP.h>
>>> >  #include <drm/drm_atomic.h>
>>> > @@ -188,7 +189,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>>> >  int msm_gem_mmap_obj(struct drm_gem_object *obj,
>>> >                         struct vm_area_struct *vma);
>>> >  int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
>>> > -int msm_gem_fault(struct vm_fault *vmf);
>>> > +vm_fault_t msm_gem_fault(struct vm_fault *vmf);
>>> >  uint64_t msm_gem_mmap_offset(struct drm_gem_object *obj);
>>> >  int msm_gem_get_iova(struct drm_gem_object *obj,
>>> >                 struct msm_gem_address_space *aspace, uint64_t *iova);
>>> > diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
>>> > index 07376de..27a5ab5 100644
>>> > --- a/drivers/gpu/drm/msm/msm_gem.c
>>> > +++ b/drivers/gpu/drm/msm/msm_gem.c
>>> > @@ -217,7 +217,7 @@ int msm_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>>> >         return msm_gem_mmap_obj(vma->vm_private_data, vma);
>>> >  }
>>> >
>>> > -int msm_gem_fault(struct vm_fault *vmf)
>>> > +vm_fault_t msm_gem_fault(struct vm_fault *vmf)
>>> >  {
>>> >         struct vm_area_struct *vma = vmf->vma;
>>> >         struct drm_gem_object *obj = vma->vm_private_data;
>>> > @@ -225,15 +225,18 @@ int msm_gem_fault(struct vm_fault *vmf)
>>> >         struct page **pages;
>>> >         unsigned long pfn;
>>> >         pgoff_t pgoff;
>>> > -       int ret;
>>> > +       int err;
>>> > +       vm_fault_t ret;
>>> >
>>> >         /*
>>> >          * vm_ops.open/drm_gem_mmap_obj and close get and put
>>> >          * a reference on obj. So, we dont need to hold one here.
>>> >          */
>>> > -       ret = mutex_lock_interruptible(&msm_obj->lock);
>>> > -       if (ret)
>>> > +       err = mutex_lock_interruptible(&msm_obj->lock);
>>> > +       if (err) {
>>> > +               ret = VM_FAULT_NOPAGE;
>>> >                 goto out;
>>> > +       }
>>> >
>>> >         if (WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED)) {
>>> >                 mutex_unlock(&msm_obj->lock);
>>> > @@ -243,7 +246,7 @@ int msm_gem_fault(struct vm_fault *vmf)
>>> >         /* make sure we have pages attached now */
>>> >         pages = get_pages(obj);
>>> >         if (IS_ERR(pages)) {
>>> > -               ret = PTR_ERR(pages);
>>> > +               ret = vmf_error(PTR_ERR(pages));
>>> >                 goto out_unlock;
>>> >         }
>>> >
>>> > @@ -255,27 +258,11 @@ int msm_gem_fault(struct vm_fault *vmf)
>>> >         VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
>>> >                         pfn, pfn << PAGE_SHIFT);
>>> >
>>> > -       ret = vm_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
>>> > -
>>> > +       ret = vmf_insert_mixed(vma, vmf->address, __pfn_to_pfn_t(pfn, PFN_DEV));
>>> >  out_unlock:
>>> >         mutex_unlock(&msm_obj->lock);
>>> >  out:
>>> > -       switch (ret) {
>>> > -       case -EAGAIN:
>>> > -       case 0:
>>> > -       case -ERESTARTSYS:
>>> > -       case -EINTR:
>>> > -       case -EBUSY:
>>> > -               /*
>>> > -                * EBUSY is ok: this just means that another thread
>>> > -                * already did the job.
>>> > -                */
>>> > -               return VM_FAULT_NOPAGE;
>>> > -       case -ENOMEM:
>>> > -               return VM_FAULT_OOM;
>>> > -       default:
>>> > -               return VM_FAULT_SIGBUS;
>>> > -       }
>>> > +       return ret;
>>> >  }
>>> >
>>> >  /** get mmap offset */
>>> > --
>>> > 1.9.1
>>> >
>>>
>>> Any comment for this patch ?
>>
>> Sorry for the delay, I wanted to get a chance to test it. It seems to pass the
>> usual regression tests. LGTM.
>>
>
> Jordan, This patch is not merged in 4.18-rc-1.

this was on my list to pull into msm-next for 4.19 as soon as I have a
chance to do my next round of pulling patches from patchwork, so it
should show up in linux-next shortly..

BR,
-R
