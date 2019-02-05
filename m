Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C644DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AF22083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kuRqOSgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfBEJBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:01:33 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43421 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:01:32 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so2165642eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zd9NiqnrVtmTS7TeFCzrg9TI+td3l5rl5pIJPtIgm+w=;
        b=kuRqOSgz0QABVeog67VJ+ENXk1MkXHlJj7+f908nb3re7WtgCqVJYjyGH+AtCiLnfW
         w03OB9q3Cnd9aKkuEm6TDE5SEYjwZp+HZlDgaslWnOTIN0duEZBtBDIw76JU5+ZAOj/b
         PWSxoqo8+jgYLleqLyGumCpqb+7Xv/LDU6DiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Zd9NiqnrVtmTS7TeFCzrg9TI+td3l5rl5pIJPtIgm+w=;
        b=ZBNDQeCsDsyB+OV6vS0r2cZHOTJxDR/pgw2AAVPw1AnqcacmXW4e2OPn9ZdMlGhnQi
         LxXC1o97W/Ywy3v46yeEm+YCteK0Na3Mz9YbiizJZxeSUSGtt4F0/Nt86SLiHO3lGjKw
         tV/6JdnMphxyabVI6E+3IIghPnIdnDsYsnQU9g6ycTf+8pYBlO6rA5Azwn3dR8a6Nnag
         IPtra7H0xHZx+76g2IqUPbnDrH1tc/j3f4o3LWBJk1btbr1TroRV1zYZFHSSnEajc7be
         7uW3XrvcLmBCVbwXSu0p/q0nOBoO1VEUZ49DShR+cEcJNUdpi+4Sl7Uyk3s9U6GTsOr2
         FQ+g==
X-Gm-Message-State: AHQUAuaQ+v03HwEnAC81GmjZfissiJwozsZV6KEvvySObIFKlGfJOkoO
        6uZinK6vy/ZJlNKvc6AAelH52w==
X-Google-Smtp-Source: AHgI3IYQqqMo567bFZQ7+fCbqzPIL70wFACFS4gNBO73qzDrL4MzI8jGkDpYmhWJ1PsJI+k+QhnmiA==
X-Received: by 2002:a17:906:66db:: with SMTP id k27mr2716348ejp.50.1549357291015;
        Tue, 05 Feb 2019 01:01:31 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p36sm4856982edc.78.2019.02.05.01.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 01:01:30 -0800 (PST)
Date:   Tue, 5 Feb 2019 10:01:28 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bochs: fix bochs_gem_prime_mmap
Message-ID: <20190205090128.GA3271@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190204183858.8976-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204183858.8976-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 07:38:58PM +0100, Gerd Hoffmann wrote:
> ttm_fbdev_mmap() just doesn't work.  It appears to work fine, mmap()
> returns success, but any attempt to actually access the mapping causes a
> SIGBUS.
> 
> We can just use drm_gem_prime_mmap() instead.  Almost.  We have to copy
> over the start offset from the ttm_buffer_object vm_node to the
> drm_gem_object vm_node so the offset math in drm_gem_prime_mmap() works
> correctly for us even though we use ttm to manage our objects.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Would be kinda neat if we could teach ttm to not have it's own vma node
...

Anyway, lgtm.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/bochs/bochs_mm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
> index 641a33f134..49463348a0 100644
> --- a/drivers/gpu/drm/bochs/bochs_mm.c
> +++ b/drivers/gpu/drm/bochs/bochs_mm.c
> @@ -442,5 +442,6 @@ int bochs_gem_prime_mmap(struct drm_gem_object *obj,
>  {
>  	struct bochs_bo *bo = gem_to_bochs_bo(obj);
>  
> -	return ttm_fbdev_mmap(vma, &bo->bo);
> +	bo->gem.vma_node.vm_node.start = bo->bo.vma_node.vm_node.start;
> +	return drm_gem_prime_mmap(obj, vma);
>  }
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
