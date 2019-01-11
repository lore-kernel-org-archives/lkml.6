Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D57C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA2C21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyUdRY77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391899AbfAKPKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:10:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41780 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbfAKPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:10:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so13197800ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ayka7Sh3aQlBgO/wDrEiHMv9aQQ0JWeEDtgdlGLEXKQ=;
        b=fyUdRY77N1/CFuA54mNf9PsA8YNDmorB9kqtctzsXuCQXNYltn2bl5oULAhUFMkt4R
         3uDlw9VIrP/rL9CKNIGhV7stgWqJhzxnCa0Q8B46WL2rAeaCb356GkSVdWbJWUq0zJyz
         S3j7IxOG+n1CJHQWXCOFT2aunZJ87gkDWJREu9l4tuEBJREGRPxk06tN5TGIU2Eaqsh6
         QiWqD6RZG505P087/cS17lPOyCneNu8aOxFsWTtftfRw6zNXD4xX/rmR0juXA/NT6PS5
         FQjGb8yVq9YTlNqxFqE8VIdARK+zHwPWx0FR2Rr/q9D3VGxUjONDlhXMqRuA9b+1sTCY
         +1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ayka7Sh3aQlBgO/wDrEiHMv9aQQ0JWeEDtgdlGLEXKQ=;
        b=Ah1+w+bZJtIe7GxP98xoLazkAxiEVuOTRds+y8zUPeoMu+xXgzfjAXGV7WdMdNGDKE
         bI13koNAQU2V9RHESu26uK+6Vn1fWYXogphRCfV7+cmehOR8ajfRoM7hiBydW3GcvQhP
         iD4jxbgxGvZur8qygPuGACYFLEd7Q9Oha/FiF3EaGLe6a1frMY7aL487WLH/T4yCxBqI
         K9egATMZWU8BQx/bWROieKO/Os74QXkCfG2Pq7ei5vjyAr2KEB/687vAA4xQOj2KeEAG
         DbreyfIn+h7G4e0ZMukwJCBrXuDXqXOfZFtREqUWD6AdGr0HSbIUf0oXslgk98ehoi2H
         b+3Q==
X-Gm-Message-State: AJcUukdC1lCVZZX7sLNtLwIm+MXlQ3xzoKiNh4FRHL5C/iU1eRNlqH+p
        7SqFAqVkgX+eI6Ku9Z/KXRxL0ojK
X-Google-Smtp-Source: ALg8bN6iwtzlJsM4v7xbMiZG3OECiJeAkNcKvI4OcW5ddQcDJYe6fzblqJtGoZMS2lxGE3AeLMY1Dg==
X-Received: by 2002:a2e:8045:: with SMTP id p5-v6mr8525037ljg.87.1547219403389;
        Fri, 11 Jan 2019 07:10:03 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id s3-v6sm16010590lje.73.2019.01.11.07.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 07:10:02 -0800 (PST)
Subject: Re: [PATCH 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org,
        willy@infradead.org, mhocko@suse.com, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>
References: <20190111151037.GA2781@jordon-HP-15-Notebook-PC>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <1ce5287f-22d1-3704-1e81-a44b2c63cbd8@gmail.com>
Date:   Fri, 11 Jan 2019 17:10:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111151037.GA2781@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 5:10 PM, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---
>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> index 47ff019..9990c2f 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
> @@ -225,8 +225,7 @@ struct drm_gem_object *
>   static int gem_mmap_obj(struct xen_gem_object *xen_obj,
>   			struct vm_area_struct *vma)
>   {
> -	unsigned long addr = vma->vm_start;
> -	int i;
> +	int ret;
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
> +	ret = vm_insert_range(vma, xen_obj->pages, xen_obj->num_pages);
> +	if (ret < 0)
> +		DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
>   
> -		addr += PAGE_SIZE;
> -	}
> -	return 0;
> +	return ret;
>   }
>   
>   int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)

