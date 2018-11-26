Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E1DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278DF2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiUI50V2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278DF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeKZQat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:30:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34467 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeKZQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:30:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so15347115ljd.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 21:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sLa0Ig3eh5lukfpMTTSP9jF6XoAsKLwtbSOlqEeHX0=;
        b=AiUI50V2ETkH2H5D8avHs0q7xSSLH/QAZF6cYkZC9w6PoQCfw8C/Yq5ofM8q3mQxuW
         X2O3174afkclJ6IK60My6qa2P7AkH7krPQ6nvC7M/vNhtrEZYx7KaFvDva1TvzGn155f
         Xm4AF6PHRKpoG4/IlSAO5kfCliHdd+DnqA/geIhACuaFSvYA5CbwK+5LCR1AQYaKKLMO
         hXxSG3Sk/4XeRfEgN38Pi0dTdTvy/Pl2ZV+bTu5bPLHZGtrd9iPzgUl9EGZuqR5ky1Re
         yfu1Gt92/6DBbjBsuF7Mz40IqkEJ+3R0tJHkpEzABmU0yWeDHORVnoEiGbtSiNgE+/Re
         GCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sLa0Ig3eh5lukfpMTTSP9jF6XoAsKLwtbSOlqEeHX0=;
        b=KKBtZabL8ZNMn066yHiIp83hbcItiSzWVXsycSNlV3h3tmgmQQXkcOrgzCZ//bL/Iw
         A2JgtXw3HvbeDIlf6Q0SmS57gBaUwUuUoo9abA61g60tBM4K3M8HStREjKT0sc1jEOSJ
         Caj6ZAPj0J4+QLx1wySd+oUyvITg+kI0gCsjvmn68VXxdpNAyxZleGbyX4pdLUKLjhMA
         pZcin46Y13bAzPTS3aOq5P5h/wf7iePDrrfiDkvvqtIL2t6nrLsfWmX5a+vHx+KXyAU3
         oCRSDujlBBaEBbeY9R474SbzSXV32Nw0odAN+5gMvEgj7gsmVIugaroJb0chzyAonjbp
         vW8Q==
X-Gm-Message-State: AA+aEWYJxyar26Qbk4EVA/VM8FxvVkPApjv5QacGS0M1FlLKc/WSkKou
        6qAobHyAjDJsx/Dx+zUbeIv1Ku500OBH+U0dGt0=
X-Google-Smtp-Source: AFSGD/V+ReBIKDsh9lpIXBmTvP3n/DapCt2D7UQMUTlX28jILfbkGEeAcPzv7gGIlZkUZLqiQokIYbLdW6iO17SXliU=
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr15119125ljb.11.1543210668882;
 Sun, 25 Nov 2018 21:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20181115154645.GA27912@jordon-HP-15-Notebook-PC>
In-Reply-To: <20181115154645.GA27912@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 26 Nov 2018 11:07:36 +0530
Message-ID: <CAFqt6zYgzRUAisxAjFcuO_QZ3FnX+Yuhndjz9=Dx7Edx6M91xQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] arch/arm/mm/dma-mapping.c: Convert to use vm_insert_range
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Thu, Nov 15, 2018 at 9:13 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  arch/arm/mm/dma-mapping.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 661fe48..4eec323 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1582,31 +1582,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
>                     void *cpu_addr, dma_addr_t dma_addr, size_t size,
>                     unsigned long attrs)
>  {
> -       unsigned long uaddr = vma->vm_start;
> -       unsigned long usize = vma->vm_end - vma->vm_start;
> +       unsigned long page_count = vma_pages(vma);
>         struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>         unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>         unsigned long off = vma->vm_pgoff;
> +       int err;
>
>         if (!pages)
>                 return -ENXIO;
>
> -       if (off >= nr_pages || (usize >> PAGE_SHIFT) > nr_pages - off)
> +       if (off >= nr_pages || page_count > nr_pages - off)
>                 return -ENXIO;
>
>         pages += off;
> +       err = vm_insert_range(vma, vma->vm_start, pages, page_count);
> +       if (err)
> +               pr_err("Remapping memory failed: %d\n", err);
>
> -       do {
> -               int ret = vm_insert_page(vma, uaddr, *pages++);
> -               if (ret) {
> -                       pr_err("Remapping memory failed: %d\n", ret);
> -                       return ret;
> -               }
> -               uaddr += PAGE_SIZE;
> -               usize -= PAGE_SIZE;
> -       } while (usize > 0);
> -
> -       return 0;
> +       return err;
>  }
>  static int arm_iommu_mmap_attrs(struct device *dev,
>                 struct vm_area_struct *vma, void *cpu_addr,
> --
> 1.9.1
>
