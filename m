Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544A8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDA42088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSFB4xpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDA42088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeGYO30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:29:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44950 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbeGYO30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:29:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so3289941pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=niJb2veS3MeGNKE6rC0w8/XDdjdsqnSK/SWHduEDlbA=;
        b=SSFB4xpL3pG8nl0iFP38XJ8hZkkeoVOqgvE9J64eAuay4XurASx9AUbBImdKf8ptul
         S8aIYIkoEhSS0C0r3/OikIVyNzCsnxFjj8d5ZIE83mWzsbNqLHrbNmTIy/spluzQtJ3v
         RSbxOSxy4msCfoLLQTXjNfHRiPRrl+2XF/eq1dHV1L1CAOpJX3Bj6PSTMNY9LuTExGok
         gZ70R2io3Bawg7ALCXHoxwm/cwjD/13BLRFsX8p+8vhzKgP1jD4MScRaVeLsvOegps5b
         QdN5lDTAi2MME6FYOMY0wP6pVdfPgvmeGl0+4m39W3gq+F9bEARyBjtJ59xCNafkOqiB
         CEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=niJb2veS3MeGNKE6rC0w8/XDdjdsqnSK/SWHduEDlbA=;
        b=fLW/0u/iXuQDLFpuzoHLPLBZ0610Y/NDhobH6Ug816zPk4gIdg1gPjDFXkolH3ivub
         QbDDCM+HdM6Hq0GtdiawRfxkfDZcVT7xUf6L+tCvta3IF2OWF7dyGhTzuP80ShvcAm/S
         JFJo4ALHlJWEwVieBOhIfzaEQVen6Fskku1QnMvgFT69rhpmXg+Q6FI4h2doxVtIFH+F
         RbH9jFvD6zfAJseDRx9j+AoX+1nyjPy2WBAIoh3tyFnawHHmSJHJQcw9mwPFTnK8hRSJ
         Oz5bNgx0GObIzqBhYIMOoq+9jHIyU8dpVlO4JPf3pSo58guCK4pA/vVVTQIxTymYP4KT
         K+Hw==
X-Gm-Message-State: AOUpUlG/z+3eu/xHOD3D6nCRDhhTboeMYRJ5YifqnXEoC4GmWDJtO21/
        LQ9aVhi1idProAIC4jZGKkA=
X-Google-Smtp-Source: AAOMgpe91SXYnYI0mTEWzYo4WyKShMeUiX48y7qRo0fYfG55GbmQTlAzMOEGBOg/RJGIcxoXudf1Bw==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr20898726plf.320.1532524667202;
        Wed, 25 Jul 2018 06:17:47 -0700 (PDT)
Received: from smtp.gmail.com ([140.113.169.102])
        by smtp.gmail.com with ESMTPSA id m4-v6sm10440606pgn.82.2018.07.25.06.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 06:17:46 -0700 (PDT)
Date:   Wed, 25 Jul 2018 10:17:42 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, airlied@linux.ie, daniel.vetter@ffwll.ch,
        gustavo.padovan@collabora.com, hamohammed.sa@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu/drm/vkms: Use new return type vm_fault_t
Message-ID: <20180725131742.knj2udm5aydxqrkg@smtp.gmail.com>
References: <20180723170418.GA6417@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723170418.GA6417@jordon-HP-15-Notebook-PC>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch,

I reviewed and tested it; everything is fine. I only suggest removing
the "gpu" part from the patch title (i.e., "drm/vkms: Use new return
type vm_fault_t").

On 07/23, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
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
