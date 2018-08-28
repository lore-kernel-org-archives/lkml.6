Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E222C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05BC2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7qsOhj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05BC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeH1UnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:43:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37523 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeH1UnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:43:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so1949398lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OvWrUFoHNp/TwO+3fUI5+xkJvgY3UK6qh0BgbdHdO8=;
        b=U7qsOhj8FSrsp/+mqx2DKb7KsxPM5iA1aWpTtf5UuyA2NxMugK/1OdFUFKsLSnrVT6
         POwuPo3YaXaT49OtZ0cekC6iJN281EhPCniFbJyAewWO40Qd3jFCHNKgEqPcW690VaJW
         x/StGbW7PWvIR/WZGH1rVHUc8Nu+d6WPFgvhV7G+q5AlHwjMEV4kjS5sfxYqt36vtVX6
         3zJu8W/Lrq8YL/7cZApuwcciH+F6d12Qbg9pQxfbqCV7ROCsnO9v2N0lrp7bLX40QXwH
         ZHEtdK3Uf7JXknbgPlKb7YptrzkRFF21/kDF4k8dR9m+Le9I3CCZ7Be2Vxiwn0T2DwW2
         fyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OvWrUFoHNp/TwO+3fUI5+xkJvgY3UK6qh0BgbdHdO8=;
        b=hyx0FkQUZcxwd9PAUIqGbsvvo+E/JgW7qR5lpolbfPaYKN4+eBI82tW5O8CdkuqZeA
         LL2kymT49yDx6bzJ/mYR1IMudmZs9v9QvitBVWvPjY8k1MV9zmt9TKarpL/Zc+zpHN9a
         +SMD07u81icfbj+QYXR752HeFnD66lbU795ZdFi6s0JQypFIQQpnm5HMCLeezqMrLd0h
         wkR1+CHUsxvTVqwMqNZY0hwWfA2k0qoeM3ZcJCH84GlDl8KdcKgL4KxyBvOK+S8+tLNd
         pGppNxLMTGr6LXP6GiNkVi3BQasr/VC9/V6IJ/kZyCJi3+pl1Kps1vSswypmPbgbLkg+
         jgFw==
X-Gm-Message-State: APzg51DFwB+AZzviQ5TBd8XOqXofcaBR0dYHVRFguqrv5CRoKyJYwnx+
        D1u4FSVlhFP6DQlhw9iCDCa2W8PfFAhHPTMb566ySg==
X-Google-Smtp-Source: ANB0Vdafk1yR2XLYSBrOBBvMemCH+oJPz71uB5LzaUZf0pJvC0xOxOCjIURFMinHv4gh7lYXL/LSQkKTZ8wWdqAp22Q=
X-Received: by 2002:a19:5c57:: with SMTP id q84-v6mr1755150lfb.51.1535475040695;
 Tue, 28 Aug 2018 09:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180726144549.GA9434@jordon-HP-15-Notebook-PC> <20180730183454.GA5400@juma>
In-Reply-To: <20180730183454.GA5400@juma>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 28 Aug 2018 22:23:32 +0530
Message-ID: <CAFqt6zbbEi3F7FUaM=CH5R-eT0Ap5fbt3c-AqLgg4J9BOWOZaQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/vkms: Use new return type vm_fault_t
To:     Gustavo Padovan <gustavo@padovan.org>
Cc:     Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        gustavo.padovan@collabora.com,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:05 AM Gustavo Padovan <gustavo@padovan.org> wrote:
>
> Hi Souptick,
>
> On Thu, Jul 26, 2018 at 08:15:49PM +0530, Souptick Joarder wrote:
> > Use new return type vm_fault_t for fault handler.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> > v2: Updated patch title
> >
> >  drivers/gpu/drm/vkms/vkms_drv.h | 2 +-
> >  drivers/gpu/drm/vkms/vkms_gem.c | 5 ++---
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> > index 07be29f..d5d04a8 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -65,7 +65,7 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
> >                                      u32 *handle,
> >                                      u64 size);
> >
> > -int vkms_gem_fault(struct vm_fault *vmf);
> > +vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
> >
> >  int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
> >                    struct drm_mode_create_dumb *args);
> > diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
> > index c7e3836..62e05dc 100644
> > --- a/drivers/gpu/drm/vkms/vkms_gem.c
> > +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> > @@ -43,14 +43,14 @@ void vkms_gem_free_object(struct drm_gem_object *obj)
> >       kfree(gem);
> >  }
> >
> > -int vkms_gem_fault(struct vm_fault *vmf)
> > +vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
> >  {
> >       struct vm_area_struct *vma = vmf->vma;
> >       struct vkms_gem_object *obj = vma->vm_private_data;
> >       unsigned long vaddr = vmf->address;
> >       pgoff_t page_offset;
> >       loff_t num_pages;
> > -     int ret;
> > +     vm_fault_t ret = VM_FAULT_SIGBUS;
> >
> >       page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
> >       num_pages = DIV_ROUND_UP(obj->gem.size, PAGE_SIZE);
> > @@ -58,7 +58,6 @@ int vkms_gem_fault(struct vm_fault *vmf)
> >       if (page_offset > num_pages)
> >               return VM_FAULT_SIGBUS;
> >
> > -     ret = -ENOENT;
> >       mutex_lock(&obj->pages_lock);
> >       if (obj->pages) {
> >               get_page(obj->pages[page_offset]);
> > --
> > 1.9.1
>
> Patch pushed to drm-misc-next. vkms is still experimental so I'm not
> queueing this for 4.19. Thanks.
>
> Gustavo

Gustavo, can we get this patch into 4.19-rc-x ?
