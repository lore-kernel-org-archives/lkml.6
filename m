Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D9AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1448120C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="LIFk/LVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfB0RJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:09:17 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:36179 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbfB0RHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=JOhr/jpCfbmaSpgtBES0X/hOo5M8zsbb0qkOwjsmMok=;
        b=LIFk/LVkZph1Qzw5NOtZ7K+BjGlFQ5gaUd4P1Yjwqpsu1N+soAcX/AQjjTu3D7VyMJQ0AEHLIjpwO8CiAwyGLe9N+qcvwWqLhj2fFazr0dJ1+Q5NF4uNhxLcl/wD/VsKjupTNna3TJVENilIh9ddJPYOPxE+C7cbayg8i1IIH4P0/OZ2hW559tjWPBe3IGCPx7oe/6z5qh4XBA+hzKC58QEPLu6yCRAfqPesaOwauDqW2KuOcVkspaDIr75nxpSGtqCqjr7PSewQz4mxDDqSvGglK2u2EEDUPKadnvQgr+GuYcSGh3oQGWaYlOofYgzSDf0uvzZS48a6AH2UkH2lug==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:58440 helo=[192.168.10.175])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gz2gH-00024C-9O; Wed, 27 Feb 2019 18:07:41 +0100
Subject: Re: [PATCH 2/3] drm/virtio: implement prime pin/unpin
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190227144441.6755-1-kraxel@redhat.com>
 <20190227144441.6755-3-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <f74d6ae1-126d-8708-96a0-31ce9e62bf55@tronnes.org>
Date:   Wed, 27 Feb 2019 18:07:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227144441.6755-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 27.02.2019 15.44, skrev Gerd Hoffmann:
> virtio-gpu objects never move around, so effectively they are pinned
> all the time.  This makes the the implementation pretty easy ;)
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index b4c9199349e7..0fcae0e46abd 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -30,13 +30,13 @@
>  
>  int virtgpu_gem_prime_pin(struct drm_gem_object *obj)
>  {
> -	WARN_ONCE(1, "not implemented");
> -	return -ENODEV;
> +	/* nothing: all virtio-gpu objects are pinned all the time */
> +	return 0;
>  }
>  
>  void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
>  {
> -	WARN_ONCE(1, "not implemented");
> +	/* nothing */
>  }

You can just remove these dummies the callbacks are optional. See
drm_gem_pin().

With that:

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

>  
>  void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
> 
