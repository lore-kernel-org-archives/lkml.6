Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867EEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA582173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdo6Zk9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBGRXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:23:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35483 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGRXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:23:48 -0500
Received: by mail-it1-f194.google.com with SMTP id r6so1699052itk.0;
        Thu, 07 Feb 2019 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clhLtWnBcok1FmHpjAAYMn6otLqYg8XV8C+zAhPQ1Tw=;
        b=fdo6Zk9g7g7EfVEf/3RIGE04zgWulg0MOtZGm7Nzchn+oHHQyj4gYG05+jEQNaXCrK
         GG51Pdtkqd8UF/PTX+7HJrDOjtbHsOlTivVoW6SaxobTcoQ86VX2WKFSr/Sghr8w80Cq
         +/V6Cs1DHTdqkIMI62WO4wKuKVzMrYfz2YoHsQnDHl49Hl7icLz9Rs4iwOx7gdKQaH2l
         BgVpTYYyC2gcy8gnguDGg9Z1JMYbJFH9V9B/8jVJmXD9D3UbPeWQt320iFA8W1xfGWUm
         tgas69UnvDXQeoqKucZXywn1PYXJf3aVcVNU7085K8n3bDrXjiAaUGfJTKI9zBfgbU2m
         JCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clhLtWnBcok1FmHpjAAYMn6otLqYg8XV8C+zAhPQ1Tw=;
        b=AJ+WdR8RNjEEW6bBQIEBW/wjlK2tMlKz6P/ewxhUVqpiNfVEm/Dhe2PiPI7TyLFdKx
         7oz+Dif6d2eVTlfH2MJRqKojlcHcwYAxbw1MIhJYzlHP6Sh0FIIRuLwTlPDs62Z/9+MZ
         ej8P0iNV3rbACemajxQlzWO6TbSQ3xJ0zTefq1Qg0HGaq0bBbw6gHXDylRXBOD7D0zkR
         6OPZL5+5Mx6QTYbT9ZKy3cZLs65vsOLtpWLKopHro0BgZATPU6sQYJFq41Hi2TxkkBTQ
         JlHJNaOfadNPEGK77HhQ3QH60MlLkpVRaAgP09Xpk70dnTBf+iLTmm0nfFLkA1zLVoaa
         GdiQ==
X-Gm-Message-State: AHQUAuaRBz9eyT0vd+ErSAdu4LpLcrRYEoRNzO+cG3qlInkQSX3iSJvY
        28nGEiWnsUDFa40C4dd/JPkb0WmfQUuEikQ43/g=
X-Google-Smtp-Source: AHgI3IbuU+fmzuD3j99Lt5eBj7G9dN9+JLGjXVuOB5qP5YO3fYuD+NnpB2z2I+pn7j9wuYvgGzlicK2zpWG/IabCtDk=
X-Received: by 2002:a5e:8c14:: with SMTP id n20mr359163ioj.200.1549560226974;
 Thu, 07 Feb 2019 09:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20190204201854.2328-1-nitesh@redhat.com> <20190204201854.2328-5-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-5-nitesh@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 7 Feb 2019 09:23:35 -0800
Message-ID: <CAKgT0Ud0-A8MmbSFQTd81X5-ezwtsi67qPLa0uC_MUs4r+bxqw@mail.gmail.com>
Subject: Re: [RFC][Patch v8 4/7] KVM: Disabling page poisoning to prevent corruption
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>, riel@surriel.com,
        david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        dodgen@google.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 2:11 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> This patch disables page poisoning if guest page hinting is enabled.
> It is required to avoid possible guest memory corruption errors.
> Page Poisoning is a feature in which the page is filled with a specific
> pattern of (0x00 or 0xaa) after arch_free_page and the same is verified
> before arch_alloc_page to prevent following issues:
>     *information leak from the freed data
>     *use after free bugs
>     *memory corruption
> Selection of the pattern depends on the CONFIG_PAGE_POISONING_ZERO
> Once the guest pages which are supposed to be freed are sent to the
> hypervisor it frees them. After freeing the pages in the global list
> following things may happen:
>     *Hypervisor reallocates the freed memory back to the guest
>     *Hypervisor frees the memory and maps a different physical memory
> In order to prevent any information leak hypervisor before allocating
> memory to the guest fills it with zeroes.
> The issue arises when the pattern used for Page Poisoning is 0xaa while
> the newly allocated page received from the hypervisor by the guest is
> filled with the pattern 0x00. This will result in memory corruption errors.
>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>

This seems kind of backwards to me. Why disable page poisoning instead
of just not hinting about the free pages? There shouldn't be that many
instances when page poisoning is enabled, and when it is it would make
more sense to leave it enabled rather than silently disable it.

> ---
>  include/linux/page_hinting.h | 8 ++++++++
>  mm/page_poison.c             | 2 +-
>  virt/kvm/page_hinting.c      | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
> index 2d7ff59f3f6a..e800c6b07561 100644
> --- a/include/linux/page_hinting.h
> +++ b/include/linux/page_hinting.h
> @@ -19,7 +19,15 @@ struct hypervisor_pages {
>  extern int guest_page_hinting_flag;
>  extern struct static_key_false guest_page_hinting_key;
>  extern struct smp_hotplug_thread hinting_threads;
> +extern bool want_page_poisoning;
>
>  int guest_page_hinting_sysctl(struct ctl_table *table, int write,
>                               void __user *buffer, size_t *lenp, loff_t *ppos);
>  void guest_free_page(struct page *page, int order);
> +
> +static inline void disable_page_poisoning(void)
> +{
> +#ifdef CONFIG_PAGE_POISONING
> +       want_page_poisoning = 0;
> +#endif
> +}
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index f0c15e9017c0..9af96021133b 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -7,7 +7,7 @@
>  #include <linux/poison.h>
>  #include <linux/ratelimit.h>
>
> -static bool want_page_poisoning __read_mostly;
> +bool want_page_poisoning __read_mostly;
>
>  static int __init early_page_poison_param(char *buf)
>  {
> diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
> index 636990e7fbb3..be529f6f2bc0 100644
> --- a/virt/kvm/page_hinting.c
> +++ b/virt/kvm/page_hinting.c
> @@ -103,6 +103,7 @@ void guest_free_page(struct page *page, int order)
>
>         local_irq_save(flags);
>         if (page_hinting_obj->kvm_pt_idx != MAX_FGPT_ENTRIES) {
> +               disable_page_poisoning();
>                 page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].pfn =
>                                                         page_to_pfn(page);
>                 page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].zonenum =

At a minimum it seems like you should have some sort of warning
message that you are disabling page poisoning rather than just
silently turning it off.
