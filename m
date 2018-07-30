Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA6C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512F720873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 04:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+WKoRAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512F720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeG3GSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:18:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41525 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeG3GSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:18:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so9239757ljy.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 21:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yg4tOQHw9m+GDMaUVZxRkpjk+T5rVYvhEPuujl6xswE=;
        b=E+WKoRAcGXKfGKs1EX6kHJntS0hBg2gkHa6zM+EAWI1sb1inRF+32ldQKnOsLcTgJp
         Z2QVC70hxOKaRFRxH0XJKDxxGXHHlxzu91zc9ezw041pz47Ci4Qvu94VVqcybc0zLDpC
         msE2u3lJEtZI8Z9DGdWJUR6GQ7PX6XVz0Ydw5mEQoa1sQCu4SjZD/y6eJP+On+h9HK8P
         7uuk5eh8cmnlwThGFaYK7YrOyDc3Ko4564feaB439qn0gvkMtk7IIslAUwY6e5aU0a18
         P6OtSMWyvqc8mxuDFG6fCEhmnuJh8zuFayevULJ5cFyo0SANKoZOXMyIXSAW/39rUDoQ
         wE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yg4tOQHw9m+GDMaUVZxRkpjk+T5rVYvhEPuujl6xswE=;
        b=ZvDbZx56iHSLHCSL2jRt7A9b6WB2FCABlh1uAjJ0zimnMo93EZOB7KtGFWh4wh/jHn
         Tn5pYfpCpA+JafFJgDlxWRf1RV8FXm67H19kywd6dEg321oe4NqjP8aXuXhCRvzEinZn
         YLTV96lPK2iz+n8Gj0hKYzZhu7VueLSaJB82adojphQ/x90ATPxb4ApH5ZlcS84yRzuW
         HeX+Mx9ZIdtU5W9dGN1FnK/HLX2IqoRuGi9GxmMH6GfrCnf9lbZ3nx2qPLhFvlw3u7PF
         dUdKTpZqIzVxPIuL8kc5Nw1quTpsDRXiyXPY4cWqHJ3rmdUyzwkIW3Ak87VHE9T1pjnb
         vl9w==
X-Gm-Message-State: AOUpUlHLmCv4GZru6XD7rzrjNRLLGAEw+fHNbDFcXIBrcm+6xlP02wHN
        8p75StLse2IU7I5QsRHusnAMR1DczwBi8YpIJlo=
X-Google-Smtp-Source: AAOMgpc9hPhMP7+JaSAkcX+Az/qkgwiAvHg+83JcqEZ2nqTHImghlWiuI7xjeJQbQ4uwS7DOJ5tMig7nQmJKm/vq9bk=
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr10929872ljf.36.1532925912372;
 Sun, 29 Jul 2018 21:45:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 21:45:11
 -0700 (PDT)
In-Reply-To: <20180729123847.txpcltjb2k2d6yhb@smtp.gmail.com>
References: <20180726144549.GA9434@jordon-HP-15-Notebook-PC> <20180729123847.txpcltjb2k2d6yhb@smtp.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 30 Jul 2018 10:15:11 +0530
Message-ID: <CAFqt6zbNuNsUse=5XSfE0_L6nmgmtGgFqAMMrf+v8rDh8JSYjQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/vkms: Use new return type vm_fault_t
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

On Sun, Jul 29, 2018 at 6:08 PM, Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
> On 07/26, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>> v2: Updated patch title
>>
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
>
> Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

Rodrigo, can we get this patch in queue for 4.19 ?
