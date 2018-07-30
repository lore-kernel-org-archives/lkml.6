Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F94C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB3720840
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB3720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=padovan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeG3ULT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:11:19 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44474 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbeG3ULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:11:19 -0400
Received: by mail-qt0-f194.google.com with SMTP id b15-v6so13173832qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kQi1TM0lpCOqOZYKHd8ujoQLm/MKQK2jUpVDMZLURq0=;
        b=REoh2SMdu7YUzirr9DAZTPFYUeIOhbJhAwtE3mR5tkdgXQ3iXGCG/TXBLGyyaxfwHF
         oNxW0TiMqOPLNEiY6P3uWakBtvlJCPw1gKQccERVp3nxg2105lNbKptAAXxGJNtyuJ/t
         q8wg3yH3UPNURq1WbwfTWIrQ1JXv+lzi29IwGlMTGVveIFF8i4P5Yu0HszfvqOtFe19/
         ZkiYvpjT4x5sZjHMrfGjfcY/4WkouqTjbco2U8X+BjCU+TzxS0CQSKu+egcQ68MOUE5J
         AU65gSQBbXEsxeEg42YQfwizpZCREvztQ7wKPIlYKsuJo8nq4m3zZaDGfrIcw+ngwqC1
         /8IQ==
X-Gm-Message-State: AOUpUlGxUD3bP56NjZx0H67bp90e19Iy8zZZ1UmA4gkdwWf9sMfrCclO
        6/vzkYB07wAbyrnvPKRqWZo=
X-Google-Smtp-Source: AAOMgpfcEr1eoPWcZvcGsFBCDvtYfB4LllfReOl9L6TkrPYwyu5gYYkiauT0k9B3MA0jM79Lck9AqQ==
X-Received: by 2002:a0c:b24c:: with SMTP id k12-v6mr16287919qve.152.1532975701848;
        Mon, 30 Jul 2018 11:35:01 -0700 (PDT)
Received: from juma ([177.73.70.202])
        by smtp.gmail.com with ESMTPSA id t127-v6sm3789656qkd.1.2018.07.30.11.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 11:35:01 -0700 (PDT)
Date:   Mon, 30 Jul 2018 15:34:54 -0300
From:   Gustavo Padovan <gustavo@padovan.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     willy@infradead.org, airlied@linux.ie, daniel.vetter@ffwll.ch,
        rodrigosiqueiramelo@gmail.com, gustavo.padovan@collabora.com,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/vkms: Use new return type vm_fault_t
Message-ID: <20180730183454.GA5400@juma>
References: <20180726144549.GA9434@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726144549.GA9434@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souptick,

On Thu, Jul 26, 2018 at 08:15:49PM +0530, Souptick Joarder wrote:
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

Patch pushed to drm-misc-next. vkms is still experimental so I'm not
queueing this for 4.19. Thanks.

Gustavo

