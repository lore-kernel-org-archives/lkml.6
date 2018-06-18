Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCDBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45B7208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="T0IdJ828"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45B7208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934599AbeFRQAO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:00:14 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43250 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932442AbeFRQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:00:12 -0400
Received: by mail-io0-f194.google.com with SMTP id t6-v6so17257958iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UC5UT7DCoM6UP9KeiiKK6268yi5oWSn9Xg9opObNozA=;
        b=T0IdJ828PHm7JZwJ1QodpiSu88UfTQOEU3y+jroJkoCXcWZ3EEyMDJVbn5Ela7QRJw
         b1J2HEoKDuJOUre+F01bvkNDzahKdrIsAEt9DigS60a8bTfkEzYS7DdkSNqutrKK8rzO
         I4Qz73JsVXtmKBl2oH6Eaa543WH1cJw8XbG9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UC5UT7DCoM6UP9KeiiKK6268yi5oWSn9Xg9opObNozA=;
        b=qHymravnke3lQWESKrBuDozfcnOZxAYmUNw56klKe4I/Yn3VhX6PZdTPQvnObcvp87
         ncsPPu90i2lMjLg8w5H7XEupLfgqUQJiJ4q+gXP3Is2eABSZxVe/IxM7hbNqzPxQC3Dy
         Q+MRYjTyiXOzIYRKvmQgUOLQ6vCnBDE9UmqTcW2OiSjN75KsJw7MOTX9tMJ+8yRc+4Ma
         brgLM+0AzYO8TUOrPSLW6fSbz93dNtuvfWSFfHDwC2cpotRN9k+2sNdfHu5pZenfLZCh
         iOVFoHuowni3rZctDoWNXU9cj6E6uDBJlGsZp3Gwlz0Y6FY29/3lqzfniLWLbaXMqkVQ
         nI2A==
X-Gm-Message-State: APt69E2bZ4KwGOei5GajlL2jffkiD2sLG9dHuRFGAQ4wJoIH8hsEpMVF
        U0gP7YxKJ9ahSSIM0iBjYte069L3DptlkXRCUaofQw==
X-Google-Smtp-Source: ADUXVKINFubr1CE1ZFwh1GxvXSnXxfsoXtERITNxlZ4/qrj0wc8TSZKRkZGV/I3lSWpuueej1BZ4OzPQSNrP9uUDPqA=
X-Received: by 2002:a6b:c544:: with SMTP id v65-v6mr10422230iof.278.1529337612073;
 Mon, 18 Jun 2018 09:00:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e48b:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 09:00:11
 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:d0c7:bcda:eea:9e5d]
In-Reply-To: <CAFqt6zZ3NtY6qL2B-ovwMZ3b8R2W8KKgshZuOdZAwuxwPA8aEQ@mail.gmail.com>
References: <20180416150232.GA26745@jordon-HP-15-Notebook-PC>
 <CAFqt6zZ6VaPXoPs+3exLjNZ6yzS=v9=2TMXdFqHf_Zv5zEvSAA@mail.gmail.com>
 <20180510185138.GL33053@art_vandelay> <20180514162617.GD28661@phenom.ffwll.local>
 <CAFqt6zZ+ExTFKmzRycJiSW-u718pbGm1Ute+1UXF2NPn1WpLfA@mail.gmail.com>
 <20180524125756.GO3438@phenom.ffwll.local> <CAFqt6zZ3NtY6qL2B-ovwMZ3b8R2W8KKgshZuOdZAwuxwPA8aEQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 18 Jun 2018 18:00:11 +0200
X-Google-Sender-Auth: 5rmr5DG7On7fPavoV9asu9EUoc0
Message-ID: <CAKMK7uGPSJs2CN-RtKS51sHd5doTXYJrpJcLuhPfJF8g4zCQ+g@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: vgem: Change return type to vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 1:26 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Thu, May 24, 2018 at 6:27 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Wed, May 23, 2018 at 03:05:35PM +0530, Souptick Joarder wrote:
>>> On Mon, May 14, 2018 at 9:56 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> > On Thu, May 10, 2018 at 02:51:38PM -0400, Sean Paul wrote:
>>> >> On Thu, May 10, 2018 at 07:58:11PM +0530, Souptick Joarder wrote:
>>> >> > Hi Sean,
>>> >> >
>>> >> > On Mon, Apr 16, 2018 at 8:32 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> >> > > Use new return type vm_fault_t for fault handler.
>>> >> > >
>>> >> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> >> > > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>>> >> > > ---
>>> >> > >  drivers/gpu/drm/vgem/vgem_drv.c | 5 ++---
>>> >> > >  1 file changed, 2 insertions(+), 3 deletions(-)
>>> >> > >
>>> >> > > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
>>> >> > > index 2524ff1..c64a859 100644
>>> >> > > --- a/drivers/gpu/drm/vgem/vgem_drv.c
>>> >> > > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
>>> >> > > @@ -61,13 +61,13 @@ static void vgem_gem_free_object(struct drm_gem_object *obj)
>>> >> > >         kfree(vgem_obj);
>>> >> > >  }
>>> >> > >
>>> >> > > -static int vgem_gem_fault(struct vm_fault *vmf)
>>> >> > > +static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
>>> >> > >  {
>>> >> > >         struct vm_area_struct *vma = vmf->vma;
>>> >> > >         struct drm_vgem_gem_object *obj = vma->vm_private_data;
>>> >> > >         /* We don't use vmf->pgoff since that has the fake offset */
>>> >> > >         unsigned long vaddr = vmf->address;
>>> >> > > -       int ret;
>>> >> > > +       vm_fault_t ret = VM_FAULT_SIGBUS;
>>> >> > >         loff_t num_pages;
>>> >> > >         pgoff_t page_offset;
>>> >> > >         page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
>>> >> > > @@ -77,7 +77,6 @@ static int vgem_gem_fault(struct vm_fault *vmf)
>>> >> > >         if (page_offset > num_pages)
>>> >> > >                 return VM_FAULT_SIGBUS;
>>> >> > >
>>> >> > > -       ret = -ENOENT;
>>> >> > >         mutex_lock(&obj->pages_lock);
>>> >> > >         if (obj->pages) {
>>> >> > >                 get_page(obj->pages[page_offset]);
>>> >> > > --
>>> >> > > 1.9.1
>>> >> > >
>>> >> >
>>> >> > Any further comment on this patch ?
>>> >>
>>> >> Patch looks good to me. My build test fails, though, since vm_fault_t doesn't
>>> >> exist in drm-misc-next yet.
>>> >
>>> > vm_fault_t is already in upstream, just needs Maarten to do a backmerge.
>>> > Which I think he's done by now ... Otherwise nag him more :-)
>>> > -Daniel
>>> >
>>> >>
>>> >> So, for now,
>>> >>
>>> >> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>>> >>
>>> >>
>>> >> --
>>> >> Sean Paul, Software Engineer, Google / Chromium OS
>>> >> _______________________________________________
>>> >> dri-devel mailing list
>>> >> dri-devel@lists.freedesktop.org
>>> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>> >
>>> > --
>>> > Daniel Vetter
>>> > Software Engineer, Intel Corporation
>>> > http://blog.ffwll.ch
>>>
>>> Daniel/ Sean, is this patch already merged for 4.18 ?
>>
>> Nope, fell through the cracks. Thanks for the reminder, queued for 4.18
>> now.
>> -Daniel
>>
>
> Daniel, This patch is not available in 4.18-rc-1 :-)

I mixed up my book-keeping, it was queued for 4.19. Should show up in
linux-next any day (well as soon as drm-misc maintainers get their
book-keeping updated).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
