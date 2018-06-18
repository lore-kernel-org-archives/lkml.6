Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E1BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D64208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVz1HnD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D64208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933774AbeFRL0l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:26:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43371 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932585AbeFRL0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:26:37 -0400
Received: by mail-lf0-f67.google.com with SMTP id x13-v6so8621556lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=N1Mz/eRDIlnNveXhuYQeIiSEn0mcMiP1W8hbUPnrC5Q=;
        b=QVz1HnD3oZ1NMoomkHgf1ZYyCb4ysJdHlQPwVH6C7SjQG4JtK6og0pLjVh3+YX4+qm
         HqdZMchYlEWJHJZeHzvcxsBHUgK+cXbqjcnyFhAOMqwvPC/DLo4wqvmazb9eKHoA/iHY
         jOaqncH/MO37xWPj4F6uDLmbim1xIgipzKVJirDwt7sMVGxTOcd5n2/pdGcHPd/6J1hV
         WK28kJ/sritI8a6jd6fxlUW1YM6G6IrFHkiDUMeatPnnuprqty8YvOefcLHn0kfpPpdN
         VkKf6Keb2bigPN/E94SqGR05YLul6yCMhrAsomNPERVYPD4evv2FniaEFZpUX0qpO5Al
         QG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=N1Mz/eRDIlnNveXhuYQeIiSEn0mcMiP1W8hbUPnrC5Q=;
        b=MqhEW0gDiYwmkQOmTgjlK96GPxiuBLCcSGmYsBCI7XESPZJDKBNow4k0gCAwgVQxll
         W3Plhek5smaG0Egf2ugx3llRRwcc3lhioEUytYV0yQO7mE70muhpJbdufsBC+W3yY9WT
         92OqrfQhSMWAX9X3KBPOXd3ysqQOAYqsVYShWukbV7GD9ZxenRFtXN0xpVCpNOtrPypx
         6WxRzDvjv2GPys6geDYiQL4vwHD7MA97wG3ZAAh495/rZofyWSpO3ddSG63JhZ5Vz3oL
         o/F+CcXAjS/YVo35wxkpprVSftYEPyP1Y1qWA5ss0TYcjfAig8Hk3HIgytGwnpSeawUi
         axEg==
X-Gm-Message-State: APt69E222La13+1BWOLE3Fj5n7cf+iXCOdnOKUUWjHugErg8MT3pLB/N
        /oOLIkVVrg+wTpYsp3Y5htKRglhNnudOEwh3R3Y=
X-Google-Smtp-Source: ADUXVKL3lxXbdFVfGQNNjmKp1fMNamfYXTm9SQWaaQmdWV/8tOujcCHDOr0QmW0ZsqQcFA+YPtlilaAqOuIgsRPUebM=
X-Received: by 2002:a19:1647:: with SMTP id m68-v6mr7554278lfi.131.1529321196250;
 Mon, 18 Jun 2018 04:26:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 04:26:35
 -0700 (PDT)
In-Reply-To: <20180524125756.GO3438@phenom.ffwll.local>
References: <20180416150232.GA26745@jordon-HP-15-Notebook-PC>
 <CAFqt6zZ6VaPXoPs+3exLjNZ6yzS=v9=2TMXdFqHf_Zv5zEvSAA@mail.gmail.com>
 <20180510185138.GL33053@art_vandelay> <20180514162617.GD28661@phenom.ffwll.local>
 <CAFqt6zZ+ExTFKmzRycJiSW-u718pbGm1Ute+1UXF2NPn1WpLfA@mail.gmail.com> <20180524125756.GO3438@phenom.ffwll.local>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 18 Jun 2018 16:56:35 +0530
Message-ID: <CAFqt6zZ3NtY6qL2B-ovwMZ3b8R2W8KKgshZuOdZAwuxwPA8aEQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: vgem: Change return type to vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 6:27 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, May 23, 2018 at 03:05:35PM +0530, Souptick Joarder wrote:
>> On Mon, May 14, 2018 at 9:56 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> > On Thu, May 10, 2018 at 02:51:38PM -0400, Sean Paul wrote:
>> >> On Thu, May 10, 2018 at 07:58:11PM +0530, Souptick Joarder wrote:
>> >> > Hi Sean,
>> >> >
>> >> > On Mon, Apr 16, 2018 at 8:32 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> >> > > Use new return type vm_fault_t for fault handler.
>> >> > >
>> >> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >> > > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> >> > > ---
>> >> > >  drivers/gpu/drm/vgem/vgem_drv.c | 5 ++---
>> >> > >  1 file changed, 2 insertions(+), 3 deletions(-)
>> >> > >
>> >> > > diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
>> >> > > index 2524ff1..c64a859 100644
>> >> > > --- a/drivers/gpu/drm/vgem/vgem_drv.c
>> >> > > +++ b/drivers/gpu/drm/vgem/vgem_drv.c
>> >> > > @@ -61,13 +61,13 @@ static void vgem_gem_free_object(struct drm_gem_object *obj)
>> >> > >         kfree(vgem_obj);
>> >> > >  }
>> >> > >
>> >> > > -static int vgem_gem_fault(struct vm_fault *vmf)
>> >> > > +static vm_fault_t vgem_gem_fault(struct vm_fault *vmf)
>> >> > >  {
>> >> > >         struct vm_area_struct *vma = vmf->vma;
>> >> > >         struct drm_vgem_gem_object *obj = vma->vm_private_data;
>> >> > >         /* We don't use vmf->pgoff since that has the fake offset */
>> >> > >         unsigned long vaddr = vmf->address;
>> >> > > -       int ret;
>> >> > > +       vm_fault_t ret = VM_FAULT_SIGBUS;
>> >> > >         loff_t num_pages;
>> >> > >         pgoff_t page_offset;
>> >> > >         page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
>> >> > > @@ -77,7 +77,6 @@ static int vgem_gem_fault(struct vm_fault *vmf)
>> >> > >         if (page_offset > num_pages)
>> >> > >                 return VM_FAULT_SIGBUS;
>> >> > >
>> >> > > -       ret = -ENOENT;
>> >> > >         mutex_lock(&obj->pages_lock);
>> >> > >         if (obj->pages) {
>> >> > >                 get_page(obj->pages[page_offset]);
>> >> > > --
>> >> > > 1.9.1
>> >> > >
>> >> >
>> >> > Any further comment on this patch ?
>> >>
>> >> Patch looks good to me. My build test fails, though, since vm_fault_t doesn't
>> >> exist in drm-misc-next yet.
>> >
>> > vm_fault_t is already in upstream, just needs Maarten to do a backmerge.
>> > Which I think he's done by now ... Otherwise nag him more :-)
>> > -Daniel
>> >
>> >>
>> >> So, for now,
>> >>
>> >> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>> >>
>> >>
>> >> --
>> >> Sean Paul, Software Engineer, Google / Chromium OS
>> >> _______________________________________________
>> >> dri-devel mailing list
>> >> dri-devel@lists.freedesktop.org
>> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>> >
>> > --
>> > Daniel Vetter
>> > Software Engineer, Intel Corporation
>> > http://blog.ffwll.ch
>>
>> Daniel/ Sean, is this patch already merged for 4.18 ?
>
> Nope, fell through the cracks. Thanks for the reminder, queued for 4.18
> now.
> -Daniel
>

Daniel, This patch is not available in 4.18-rc-1 :-)
