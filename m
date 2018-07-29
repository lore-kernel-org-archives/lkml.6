Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EDDFF05E2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA71205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7wZHhzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA71205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeG2OJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 10:09:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36937 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeG2OJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 10:09:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so5732498pgq.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gUgjOV2D8iFP9n34w8rmetiXqG0g4HQ677T8ARMWEIc=;
        b=G7wZHhzlN52sXONy25mfbgS2/uJKL/EzcgifhK4OefkFKKvXnqy3AkcPzbBXNkbTIs
         8ikoufyNUaSehHkixx/cbs1UbgNXAOj2NrVfd78RMvVW13IfrXOYTNg65jowZ1teNNTC
         J6ssMmXdfiQ0Up6XvdikDf0jmwgsXs8EmIVggYRTZ1mwwFJNMvl4E4DMXTuUKg0apARP
         3Ryj+79qVaeTEo/9kOu3f5NTQnfWSjaH9n+FzDLYCh1b76gwKM6Op4hxIlD7Z5P70Eoh
         yf9LnY9U0oXNwV9qdZT5hDcCn67Clo/qZ2fqAh7B4jkb22bjlY5YRbhok7y6UpjL+cIf
         kT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gUgjOV2D8iFP9n34w8rmetiXqG0g4HQ677T8ARMWEIc=;
        b=eJOC6m3IGa4kuifAgM9cfPlnrmUjpeyHMmFhQlRaiQyCa9Vp5P713dD6Z5X8hVzv2q
         VyDKCKTx0letmPHNHX5PPay0nZ7K8z5QqwzoKnVnLSkuhzCdoPMHBkAg2HMJsXCJG8ZB
         KiSZ1S003H84Vh/HceZGApr2U6UhCW2FvAK3bPDemgMKw/oX6rR0z6Y3CpXIXV6Na2HW
         YY9mzO53GPkbi1N5j1eHEJ3ka/SwMIFaY+VDFi7VnWIWlp07F2WfnkOe4dZ7o7kykkAk
         DwQeqlcUBjDAyyGwK9UaW0NAvrDUnHbmHqbyv5y0UK4OtYry1iTXLBhsNQyyunkRObqZ
         OqRA==
X-Gm-Message-State: AOUpUlFMpfjeWcsLoQBrbAYW+IxsPMX1x1t04ETYax4tGqOnn3HyS0Wp
        kG2V4mAQ5X1bB+qodEKgyfs=
X-Google-Smtp-Source: AAOMgpfAT1MQevgHck/uewLCDD6vPHUbFsZGAK02FeAZeNAAjJ24rM1DKhLkHIWvvQKMg1RwAxtovw==
X-Received: by 2002:a65:52cc:: with SMTP id z12-v6mr12709978pgp.69.1532867931988;
        Sun, 29 Jul 2018 05:38:51 -0700 (PDT)
Received: from smtp.gmail.com ([140.113.61.252])
        by smtp.gmail.com with ESMTPSA id i25-v6sm21082139pfi.150.2018.07.29.05.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 05:38:51 -0700 (PDT)
Date:   Sun, 29 Jul 2018 09:38:47 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, airlied@linux.ie, daniel.vetter@ffwll.ch,
        gustavo.padovan@collabora.com, hamohammed.sa@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/vkms: Use new return type vm_fault_t
Message-ID: <20180729123847.txpcltjb2k2d6yhb@smtp.gmail.com>
References: <20180726144549.GA9434@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726144549.GA9434@jordon-HP-15-Notebook-PC>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: Updated patch title
> 
>  drivers/gpu/drm/vkms/vkms_drv.h | 2 +-
>  drivers/gpu/drm/vkms/vkms_gem.c | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 07be29f..d5d04a8 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -65,7 +65,7 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
>  				       u32 *handle,
>  				       u64 size);
>  
> -int vkms_gem_fault(struct vm_fault *vmf);
> +vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
>  
>  int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
>  		     struct drm_mode_create_dumb *args);
> diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
> index c7e3836..62e05dc 100644
> --- a/drivers/gpu/drm/vkms/vkms_gem.c
> +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> @@ -43,14 +43,14 @@ void vkms_gem_free_object(struct drm_gem_object *obj)
>  	kfree(gem);
>  }
>  
> -int vkms_gem_fault(struct vm_fault *vmf)
> +vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct vkms_gem_object *obj = vma->vm_private_data;
>  	unsigned long vaddr = vmf->address;
>  	pgoff_t page_offset;
>  	loff_t num_pages;
> -	int ret;
> +	vm_fault_t ret = VM_FAULT_SIGBUS;
>  
>  	page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
>  	num_pages = DIV_ROUND_UP(obj->gem.size, PAGE_SIZE);
> @@ -58,7 +58,6 @@ int vkms_gem_fault(struct vm_fault *vmf)
>  	if (page_offset > num_pages)
>  		return VM_FAULT_SIGBUS;
>  
> -	ret = -ENOENT;
>  	mutex_lock(&obj->pages_lock);
>  	if (obj->pages) {
>  		get_page(obj->pages[page_offset]);
> -- 
> 1.9.1
>

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
