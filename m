Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69AD2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo52YPgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfAKLDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:03:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33442 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfAKLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:03:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so12583505ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 03:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/w5gvclLd1jkuIiTozfSyJ/5AuGznvuoyQdobchRqls=;
        b=fo52YPgWngnx00UJM6usLj3gPuJ69kNJmsWE0hVaLL19f+kRWvqOYM2kuIJI/WvxH6
         Vp7Bq96VRWPq8hPgSlzQoFf+uSpsukVLL1LON2QydcbRk5U2jHrhwPJkRuDplxAbX35N
         ALAlYuu3ht5sxpAambPyR09ogcifS2f/mjtIIXloLy5AfWG546KThoh4FFc7gvGtpuTb
         HCtkk5KUV9WTXPuZ/d6Ycr0Kw69Q/MBOTzhGyIVR5Xg/Tb0XB72zpzqvdL3LQTerHXno
         3XvOrkg8M0oKO6rSLkcqjwV0YQXZ4Ur6GIovwY/l2I9IbHhj2Mhpsr2YdHJIimz2odCN
         1/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/w5gvclLd1jkuIiTozfSyJ/5AuGznvuoyQdobchRqls=;
        b=jMQQ6ztDeGclzsJpDyf2cUrs3xMfzWreaXeby9I+vOptnIXtmiDQ0Jv2QefJ7n8mYV
         KfHvyT/MhwkZIJfFFCa3BYsQJ2ShobQyIMBFxh8nVKt0N6lMj0y8L/i4UtJ3XeJJe+gA
         pxgjCCyEn5X1QaQMFauMY6i34gtgg6ZtuWNm1xC8lJpK2kl4A4oax6Sd24tMqJMO7pS/
         6jXJ1oUzhD849nrCBydV0vOSgOD8h58EZc8klWKFgSaXwqqTXOzS5I9/HI9J/N+CZZ68
         EdRMj1N83WMGWVc2b74AIOt5j+e1nSYz+R+md+4P019Uk1EHW8Sr0L7izr4GdsnGBu7N
         3dvg==
X-Gm-Message-State: AJcUukcMWvmjoV5VLyoxDfzH2D1QVgtGfYob3bUUIVXc+V8ehrSnXpi2
        nYS6w2mlvEgcyICw0n6cOuc=
X-Google-Smtp-Source: ALg8bN4BRAOgX6fnopgXclXi4z+337xjruc6qKWpkvze+clkmj6If7X1D0TCFjpsaCuKaz7JiopqHw==
X-Received: by 2002:a2e:4218:: with SMTP id p24-v6mr8118016lja.58.1547204621355;
        Fri, 11 Jan 2019 03:03:41 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id s17sm8543204lfk.9.2019.01.11.03.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 03:03:40 -0800 (PST)
Subject: Re: [PATCH] drm/virtio: drop prime import/export callbacks
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190110111545.26768-1-kraxel@redhat.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <1465b863-8ea4-9200-3332-11777f537390@gmail.com>
Date:   Fri, 11 Jan 2019 13:03:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190110111545.26768-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/19 1:15 PM, Gerd Hoffmann wrote:
> Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> userspace.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ----
>   drivers/gpu/drm/virtio/virtgpu_drv.c   |  4 ----
>   drivers/gpu/drm/virtio/virtgpu_prime.c | 14 --------------
>   3 files changed, 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index cf896d8793..4f2f3c43a4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -354,10 +354,6 @@ int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
>   /* virtgpu_prime.c */
>   int virtgpu_gem_prime_pin(struct drm_gem_object *obj);
>   void virtgpu_gem_prime_unpin(struct drm_gem_object *obj);
> -struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
> -struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
> -	struct drm_device *dev, struct dma_buf_attachment *attach,
> -	struct sg_table *sgt);
>   void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj);
>   void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
>   int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index af92964b68..b996ac1d4f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -205,14 +205,10 @@ static struct drm_driver driver = {
>   #if defined(CONFIG_DEBUG_FS)
>   	.debugfs_init = virtio_gpu_debugfs_init,
>   #endif
> -	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>   	.gem_prime_export = drm_gem_prime_export,
>   	.gem_prime_import = drm_gem_prime_import,
>   	.gem_prime_pin = virtgpu_gem_prime_pin,
>   	.gem_prime_unpin = virtgpu_gem_prime_unpin,
> -	.gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
> -	.gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
>   	.gem_prime_vmap = virtgpu_gem_prime_vmap,
>   	.gem_prime_vunmap = virtgpu_gem_prime_vunmap,
>   	.gem_prime_mmap = virtgpu_gem_prime_mmap,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index 86ce0ae93f..c59ec34c80 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -39,20 +39,6 @@ void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
>   	WARN_ONCE(1, "not implemented");
>   }
>   
> -struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
> -{
> -	WARN_ONCE(1, "not implemented");
> -	return ERR_PTR(-ENODEV);
> -}
> -
> -struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
> -	struct drm_device *dev, struct dma_buf_attachment *attach,
> -	struct sg_table *table)
> -{
> -	WARN_ONCE(1, "not implemented");
> -	return ERR_PTR(-ENODEV);
> -}
> -
>   void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
>   {
>   	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);

