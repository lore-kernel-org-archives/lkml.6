Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2467FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EB920871
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrM7GlI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EB920871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeKSUPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:15:31 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43180 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:15:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id f4so12075311edq.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bG/lcGNedpT7YEQkY2/pbpK/AzC7fBGIzAcpqfCmg8A=;
        b=RrM7GlI8clUBozfdC/tuZYYQ2a7JwM2r9cUK8yCtkaBL4U1oC4lKPOADSepjN1Tn2a
         3kC/TkZKbfk8gUZKl1zkud9JXOzIJqq0WUjHgUpwbv3ALz/F4ZO+pW9T3nXv8t7Nwtk6
         /wTwORTkyluhqsF+g2BdYK3yIOOn2dDPZL8NuW1/H0hBMtY6wP86rrV2bqUjcDGK85ZT
         nHyw/0jLr0qTdGeIwoDX7OmIEG/0RVmf3WBAj42gZiQF+epODwXLhFm0Az6nl0rRypU/
         BJQh/3KXAgq0w86akDY3S6rt3EY5oZ4ZGNVeCA3wTu09nVw04o9OVlcGCWWkVhoZn1Lf
         Xl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bG/lcGNedpT7YEQkY2/pbpK/AzC7fBGIzAcpqfCmg8A=;
        b=n5GPEmTVdYtUtNTFxzK5iYkDrcNyHpOQtkd/ZMSTuWqG6DJ2H+k7NBMldqZLtiCIR7
         uj/nvsJWu66BV/nJFpPR8Z1cnTc/hB9Rw/I68SjdozCZU8VbQs+I8B4uB5o40S1p3fDZ
         uID+tvQyT9AZHDD4trZ7kwjD2tuMCurekKdg4tDvSm6Zgsjit2Y+wjd4ITxeDrO9qKDf
         VXBu9h0qmS406Ss1r3qwU25OBFYve/fJYefVOBOj1LVOaknkkOnRhHLKrZYsnctXxWWk
         Du2Hhpp2iHBLR5/X1i8CH/LyVOKxVFma3wIjDCSIH/JUpRos34SPh7GYFtaPJkyWYlaG
         540A==
X-Gm-Message-State: AGRZ1gLA2SCXvegIB6eew1TgkHueIHA4mHsQEiCpYjBEE5Q60nBtQQ4c
        0xig3A8zWPuf5cPwRsUIAqc=
X-Google-Smtp-Source: AJdET5dNjb41ojrlFq3N6keteiv8EqjBKC4tg0AmVMbVwaWqrm617zAm+x5BRfpexUL9JajN6R6AJA==
X-Received: by 2002:a50:b1db:: with SMTP id n27mr12035000edd.65.1542621142346;
        Mon, 19 Nov 2018 01:52:22 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id z2sm6568806edd.4.2018.11.19.01.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 01:52:21 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH 5/9] drm/xen/xen_drm_front_gem.c: Convert to
 use vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
References: <20181115154912.GA27969@jordon-HP-15-Notebook-PC>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <ed294bea-bf07-6a4d-51ec-9e7082703b61@gmail.com>
Date:   Mon, 19 Nov 2018 11:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115154912.GA27969@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 5:49 PM, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> ---
>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> index 47ff019..a3eade6 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> @@ -225,8 +225,7 @@ struct drm_gem_object *
>   static int gem_mmap_obj(struct xen_gem_object *xen_obj,
>   			struct vm_area_struct *vma)
>   {
> -	unsigned long addr = vma->vm_start;
> -	int i;
> +	int err;
I would love to keep ret, not err
>   
>   	/*
>   	 * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
> @@ -247,18 +246,11 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
>   	 * FIXME: as we insert all the pages now then no .fault handler must
>   	 * be called, so don't provide one
>   	 */
> -	for (i = 0; i < xen_obj->num_pages; i++) {
> -		int ret;
> -
> -		ret = vm_insert_page(vma, addr, xen_obj->pages[i]);
> -		if (ret < 0) {
> -			DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
> -			return ret;
> -		}
> -
> -		addr += PAGE_SIZE;
> -	}
> -	return 0;
> +	err = vm_insert_range(vma, vma->vm_start, xen_obj->pages,
> +				xen_obj->num_pages);
> +	if (err < 0)
> +		DRM_ERROR("Failed to insert pages into vma: %d\n", err);
> +	return err;
>   }
>   
>   int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)

With the above fixed,

Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

