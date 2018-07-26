Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF6DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161FA20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU3CBZos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161FA20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeGZFmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:42:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46252 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeGZFmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:42:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so298099ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 21:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nCD22D8QKl4DJqMH+utnwsBLaI5u3H/D5w8ielRQaNc=;
        b=HU3CBZosv7JhmiBJ76KBQ8YRcM56AK/un1+5B37lrjYf1eJj4GqEDvC7fdefZOj0gW
         d4FN2nc/+A3xX1bvxet5TW6mp7MPUmMlaVzKvskIEkX716hPkld2WhiyFnWVpL2QVsae
         Gsf/QCk66sAPT7RX62RYSVWEjAkjJxtrljBShNK6FNVEoeW22/WZSCtpAFbelLv2ra/Q
         JG8/ULhAnVwn9+R1hZw5RTdNDrSiCcuWZLKd5wAQwa/PRMS/3U1zn4dIn8nOMbQFTAGI
         XvkBsrQygiTGvLgr3/0XhnzLvRyfNSTC8QMVaIo0kkkDhVZeZW0IdZZIBKLTmJ5raOul
         OECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nCD22D8QKl4DJqMH+utnwsBLaI5u3H/D5w8ielRQaNc=;
        b=l70bwjUuAkGENcNlkQV8opJKu/pKWjJFboTwoGclSzgg35V1QZG4WS/cPYEPPEwy3U
         TQeRW99YNJM/Cqf4D+/yXvWmCRf85pFlQlO97Il+WfNl9Ij59LRon2U/7o0JROhIKDwe
         hr47n3Psc7tH3p2tlgUCAXLLB0E1U+/YZY6BWTQaKx7OhT9o1eHdsgxM8kOzIJYgZqxP
         dCawtW9vIr9o4TEpsYxMd5A07r9A1U2OuJQYpoS/cTiZ1vGQvIckZFghZlhpstrTmH9B
         f6fzj/78hKzR3bFl+W4j6DqPkGKdafJXmticIvdBXYV6B6YTOB0yaG6CMLoXYJq1rOQf
         zfEA==
X-Gm-Message-State: AOUpUlFcf13pSY1hlfzcJnbQ11rqicSYQ6/GM41yLG7OzY6Zfl79EaCK
        pkBoDoF2sZ1h4n7qayFaOiqeTfs3rtQ8mmBQLpA=
X-Google-Smtp-Source: AAOMgpctVSZsto3mQHuErlyrNfpDb+y/zKIbiGDYO7cmxssPJThXGNosyR9j/byD6Ye32ZttSqC/jELLtbQkgAvLGkM=
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr217496ljf.36.1532579229582;
 Wed, 25 Jul 2018 21:27:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 21:27:08
 -0700 (PDT)
In-Reply-To: <20180725131742.knj2udm5aydxqrkg@smtp.gmail.com>
References: <20180723170418.GA6417@jordon-HP-15-Notebook-PC> <20180725131742.knj2udm5aydxqrkg@smtp.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 26 Jul 2018 09:57:08 +0530
Message-ID: <CAFqt6zaYTukiwRiKXkM0tvSoE30rSJjMmak_ys-g72jnN9s5=w@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/vkms: Use new return type vm_fault_t
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, airlied@linux.ie,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        gustavo.padovan@collabora.com,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 6:47 PM, Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
> Hi,
>
> Thanks for the patch,
>
> I reviewed and tested it; everything is fine. I only suggest removing
> the "gpu" part from the patch title (i.e., "drm/vkms: Use new return
> type vm_fault_t").

ok. I Will post v2.

>
> On 07/23, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/vkms/vkms_drv.h | 2 +-
>>  drivers/gpu/drm/vkms/vkms_gem.c | 5 ++---
>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
>> index 07be29f..d5d04a8 100644
>> --- a/drivers/gpu/drm/vkms/vkms_drv.h
>> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
>> @@ -65,7 +65,7 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
>>                                      u32 *handle,
>>                                      u64 size);
>>
>> -int vkms_gem_fault(struct vm_fault *vmf);
>> +vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
>>
>>  int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
>>                    struct drm_mode_create_dumb *args);
>> diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
>> index c7e3836..62e05dc 100644
>> --- a/drivers/gpu/drm/vkms/vkms_gem.c
>> +++ b/drivers/gpu/drm/vkms/vkms_gem.c
>> @@ -43,14 +43,14 @@ void vkms_gem_free_object(struct drm_gem_object *obj)
>>       kfree(gem);
>>  }
>>
>> -int vkms_gem_fault(struct vm_fault *vmf)
>> +vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
>>  {
>>       struct vm_area_struct *vma = vmf->vma;
>>       struct vkms_gem_object *obj = vma->vm_private_data;
>>       unsigned long vaddr = vmf->address;
>>       pgoff_t page_offset;
>>       loff_t num_pages;
>> -     int ret;
>> +     vm_fault_t ret = VM_FAULT_SIGBUS;
>>
>>       page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
>>       num_pages = DIV_ROUND_UP(obj->gem.size, PAGE_SIZE);
>> @@ -58,7 +58,6 @@ int vkms_gem_fault(struct vm_fault *vmf)
>>       if (page_offset > num_pages)
>>               return VM_FAULT_SIGBUS;
>>
>> -     ret = -ENOENT;
>>       mutex_lock(&obj->pages_lock);
>>       if (obj->pages) {
>>               get_page(obj->pages[page_offset]);
>> --
>> 1.9.1
>>
