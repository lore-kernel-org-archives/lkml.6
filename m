Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB40C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DC821919
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDqodEhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfBHSIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:08:02 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55388 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfBHSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:08:02 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so10896550ith.5;
        Fri, 08 Feb 2019 10:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ha8tiaDoQDUW/w4Eg9NVxaHOTac5NWivcizqdQ179M=;
        b=VDqodEhzP/xST8wGK5OrHBtM0hJWOrVvpmcLj+dps2H5Tz8/68X4XeqbZi0gXJMI7n
         RYSiWoeoEyXX5sEEWBE7kypMtrsCfWXjm/ZPFtsENx5tK0Q9XvdF4pBVJ9sbAj/3Neei
         S9Z8uEcMgTO6BMnlkRW8ykgwKF7yIRZ1QPlkN/d9S6cuvOI+nUk09dGohOENjaitI05K
         xU9+8cJS/7n0d+kldh2g16SEBDL1XaG1+kbd/3pqBIg42swbygzie6lyYFfR++ctwRb6
         3VsL21eR+CyMO36j+HtTGlkKVGPRoti8euAnVPGBtc4RZOelxqzE9dX81l+Ra9SIlRY3
         8WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ha8tiaDoQDUW/w4Eg9NVxaHOTac5NWivcizqdQ179M=;
        b=PKaVwKNNmM2X9kHWirYPpI4PDoYReLNCl2ysdsxVKJhkdrTHf1zSu+WlqKyERTZJ5t
         Xsxri1Mu1Gv84u8ygW7wlFxZZKb5jYX2mm7A6fPBvLFhB9ZVjfV/P/r7Z+8FUV1FKPj5
         VP1DMPnLb9XyQSbfDRbMLRxFNFat/Xjh8oGS7P4pi5wgfCtrftpF3lXKgAFdKanKLTsx
         he9fEV7xTGW6LBjiSvNL4dS6PAIea3GmIrtb8a2u1QrTRVm4NYXHvrsVjcZLY4MRd2Fj
         fsSaqrlU28bhOLFH5XRie09/Oe2z51g1T89BBAeqyPfMMrWnWtMfGpxPeJlpYuNOCWe2
         ZxXw==
X-Gm-Message-State: AHQUAuazJYzHnhk9X/lpRIhDIvsXfJrD3obo/OkrLdsvr2sczbPoMavg
        IghQ4YoVoBr0Zhy0C2w+C2aGZ3rrW3Z1R41crog=
X-Google-Smtp-Source: AHgI3IaVb9P4AyOT8Be58qgdkvNb/UFAUSpF6SKVEawnVPDnIerwXJ7pAU5kcqBHpaMdjbrM61NnLgM0vP0EsJp3hWE=
X-Received: by 2002:a5e:8c14:: with SMTP id n20mr3449441ioj.200.1549649280774;
 Fri, 08 Feb 2019 10:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <20190204201854.2328-3-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-3-nitesh@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 8 Feb 2019 10:07:49 -0800
Message-ID: <CAKgT0UfqtRigPwUaN=H_MrLgeXErkeOcpuPy6ys6A3UCLnMBPg@mail.gmail.com>
Subject: Re: [RFC][Patch v8 2/7] KVM: Enabling guest free page hinting via
 static key
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, david@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 2:11 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> This patch enables the guest free page hinting support
> to enable or disable based on the STATIC key which
> could be set via sysctl.
>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  include/linux/gfp.h          |  2 ++
>  include/linux/page_hinting.h |  5 +++++
>  kernel/sysctl.c              |  9 +++++++++
>  virt/kvm/page_hinting.c      | 23 +++++++++++++++++++++++
>  4 files changed, 39 insertions(+)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index e596527284ba..8389219a076a 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -461,6 +461,8 @@ static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
>  #define HAVE_ARCH_FREE_PAGE
>  static inline void arch_free_page(struct page *page, int order)
>  {
> +       if (!static_branch_unlikely(&guest_page_hinting_key))
> +               return;
>         guest_free_page(page, order);
>  }
>  #endif
> diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
> index b54f7428f348..9bdcf63e1306 100644
> --- a/include/linux/page_hinting.h
> +++ b/include/linux/page_hinting.h
> @@ -14,4 +14,9 @@ struct hypervisor_pages {
>         unsigned int order;
>  };
>
> +extern int guest_page_hinting_flag;
> +extern struct static_key_false guest_page_hinting_key;
> +
> +int guest_page_hinting_sysctl(struct ctl_table *table, int write,
> +                             void __user *buffer, size_t *lenp, loff_t *ppos);
>  void guest_free_page(struct page *page, int order);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ba4d9e85feb8..5d53629c9bfb 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1690,6 +1690,15 @@ static struct ctl_table vm_table[] = {
>                 .extra1         = (void *)&mmap_rnd_compat_bits_min,
>                 .extra2         = (void *)&mmap_rnd_compat_bits_max,
>         },
> +#endif
> +#ifdef CONFIG_KVM_FREE_PAGE_HINTING
> +       {
> +               .procname       = "guest-page-hinting",
> +               .data           = &guest_page_hinting_flag,
> +               .maxlen         = sizeof(guest_page_hinting_flag),
> +               .mode           = 0644,
> +               .proc_handler   = guest_page_hinting_sysctl,
> +       },
>  #endif
>         { }
>  };

Since you are adding a new sysctl shouldn't you also be updating
Documentation/sysctl/vm.txt?

> diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
> index 818bd6b84e0c..4a34ea8db0c8 100644
> --- a/virt/kvm/page_hinting.c
> +++ b/virt/kvm/page_hinting.c
> @@ -1,6 +1,7 @@
>  #include <linux/gfp.h>
>  #include <linux/mm.h>
>  #include <linux/kernel.h>
> +#include <linux/kvm_host.h>
>
>  /*
>   * struct kvm_free_pages - Tracks the pages which are freed by the guest.
> @@ -31,6 +32,28 @@ struct page_hinting {
>
>  DEFINE_PER_CPU(struct page_hinting, hinting_obj);
>
> +struct static_key_false guest_page_hinting_key  = STATIC_KEY_FALSE_INIT;
> +EXPORT_SYMBOL(guest_page_hinting_key);
> +static DEFINE_MUTEX(hinting_mutex);
> +int guest_page_hinting_flag;
> +EXPORT_SYMBOL(guest_page_hinting_flag);

I'm not entirely sure this flag makes sense to me. What is to prevent
someone from turning this on when there is no means of actually using
the hints. I understand right now that guest_free_page doesn't
actually do anything, but when it does I would assume it has to
interact with a device. If that device is not present would it still
make sense for us to be generating hints?

> +
> +int guest_page_hinting_sysctl(struct ctl_table *table, int write,
> +                             void __user *buffer, size_t *lenp,
> +                             loff_t *ppos)
> +{
> +       int ret;
> +
> +       mutex_lock(&hinting_mutex);
> +       ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +       if (guest_page_hinting_flag)
> +               static_key_enable(&guest_page_hinting_key.key);
> +       else
> +               static_key_disable(&guest_page_hinting_key.key);
> +       mutex_unlock(&hinting_mutex);
> +       return ret;
> +}
> +
>  void guest_free_page(struct page *page, int order)
>  {
>  }
> --
> 2.17.2
>
