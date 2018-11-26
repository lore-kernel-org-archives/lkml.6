Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDE12086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiVblXsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDE12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeKZQ34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:29:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46208 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeKZQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:29:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so12535411lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 21:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOYfmsTMUCX040IxBPPf3uMmxYqreaYoqXMfUqcIyb8=;
        b=EiVblXsb3m85fMv/0LYgOZaUC9IJ/FNH0p2li5G+hwI8Fbu/o/FVdHv8VunAbRzZdo
         bT86pcvUCxiZOfFEWNyHK8aOyF/P9m2ipDYWZyCTAWWi4XsKLNN+8CflpTeOs5m4jrEc
         DrTFv70DjEt0Pn71nM7+UvJ0Y8gRQ+hIIMNkk0KE6OzpftBko9WQoebHyNAzEslG22aJ
         N/YfeQazEzR/kc2M2Q4RfZz2Fs2Mjx5O97r7MtT4b2JWAvmFg2p7TIb3l2ExxcXGjPTg
         5N4C+GWPwHouOY9hS06tv2MZQi6dwMHKIDxOAgt6FWjg8ofZwQx8VkQ1vqWJnPSp04++
         DvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOYfmsTMUCX040IxBPPf3uMmxYqreaYoqXMfUqcIyb8=;
        b=nPFw0avV5UEOa6x38mUye5eLFp4NouwEL3F0GXq+G9qVqnpgL/H5Vay7snRvRZrq3X
         AIU692wiurDBQ9sYJqlU1wipaZ40CbnOBXTa4Np7tL7ULS4PqvLslJO1fxQVGbJAnobq
         ZcsW8Kub0R8h3bwymVAREtVBXEn5znW/abX/MugnRwuh1UIRstJaAdc1CWC5Lii+JX0j
         dZ1SmnTu8j1Fhigl39VPRUNcRPFc5G3NoVKvz+yWIJA0kKa4wkYDxdiJwI2ODzVl8rez
         Ro6rAgt43yqgoAs6n8Gz10qf5XJcj+7F+Nb7spd29SFiohlznY/7LvvBs/YdOky9PlL8
         kHWQ==
X-Gm-Message-State: AGRZ1gKCXpsLib1XdV23hVrxi016b8EyJ5sngmuuySeAGhZ1QMu+55pA
        YxwXL+birPK26aHKpzXU/CTA2jCww9TLtdMsEVM=
X-Google-Smtp-Source: AJdET5ft/JvcapiPkUwZYAong9jmLM+nc22rcri+qhVd1c6+db8zw6TCwA9brJUuFaU0bgp48McqaxHhPEjlRHSm5Og=
X-Received: by 2002:a19:2906:: with SMTP id p6mr14357765lfp.17.1543210615726;
 Sun, 25 Nov 2018 21:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115154826.GA27948@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181115154826.GA27948@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 26 Nov 2018 11:06:42 +0530
Message-ID: <CAFqt6zZy0-dy=a+KDrx7V1-j37pAVmt2r6bOkjgHwiopG-L+xA@mail.gmail.com>
Subject: Re: [PATCH 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use vm_insert_range
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Thu, Nov 15, 2018 at 9:14 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any feedback for this patch ?

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> index a8db758..2cb83bb 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> @@ -221,26 +221,10 @@ static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>                                               struct vm_area_struct *vma)
>  {
>         struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
> -       unsigned int i, count = obj->size >> PAGE_SHIFT;
>         unsigned long user_count = vma_pages(vma);
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned long offset = vma->vm_pgoff;
> -       unsigned long end = user_count + offset;
> -       int ret;
> -
> -       if (user_count == 0)
> -               return -ENXIO;
> -       if (end > count)
> -               return -ENXIO;
>
> -       for (i = offset; i < end; i++) {
> -               ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
> -               if (ret)
> -                       return ret;
> -               uaddr += PAGE_SIZE;
> -       }
> -
> -       return 0;
> +       return vm_insert_range(vma, vma->vm_start, rk_obj->pages,
> +                               user_count);
>  }
>
>  static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
> --
> 1.9.1
>
