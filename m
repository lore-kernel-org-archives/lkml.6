Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E092083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxzh5pUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E092083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeGZMwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:52:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38606 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbeGZMwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:52:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id a4-v6so962187lff.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 04:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fUDT5pQUMQVAJsuJwimgpvIug1q7uJenzzj9J9WtPJ4=;
        b=Qxzh5pUAZX9MVFlPaP6pBGy10Ya9jcGdLZP8/ip+Gnj2KBbKLSWSKFeAvs8AfN0Jnf
         J3+p4YB9PYCAI9mq9WWS2E6OjxSx23Qr/vTS8JRRhKBoBKeTEne+7VLR1M5PBk4LtlzW
         78d+2w+dJDiOwMyY+CgSFLQZHSmUsFd3STtU0CJPuIFm6LnXcidMhbwmZiJLlQz5X3CM
         JHjQB2M6G6LmtghTSkl5vEipFeWVZeC0+P9FSL/mnB/7J5b8cA/9+Vk9I5nEv66cBM+G
         twDrhYoPGL7lOKinkWzwHiVGLrqpwoW0cVJ9VJwIf2TkWaxyRVuzURcQ7R7EPmNZ9Bw/
         Holw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fUDT5pQUMQVAJsuJwimgpvIug1q7uJenzzj9J9WtPJ4=;
        b=MrJqzYv18i7vkjCo+R269y5Sy6STa8I3brwcWYvjMxKcu9zgLmIMHZK+/QVQsVvVQ5
         8nAErvj2pTtlv5HBhRYI/nsDRoZ7/XzoTZII9fH8gIDhu+umABI62kit4smtuIPC6RXm
         uQ/HpP1hhLYJuev9Q4uK+QDtrFoO8/KjDbs/yFyR6DH5gzAtHcRlL4lhbNGnbHApSPkU
         rvFQU7kx+jcYm+Gvoi4qDPeFoGemrou1ML2KAV2a/vct/ZA9fgCVIskTui3NJjRnpoU/
         forp0el1riVDE7m4FGKxoIVOMg6noDGp9XQOhm6sbJPefNr0GHgkXyoUReprjeRYfva9
         p6Jw==
X-Gm-Message-State: AOUpUlH/rVzsiQWsbWe2rGPjb8pduXsroV09ydHUtZzQf+Mg+khXiyDn
        3tdp0zI9nZij9spGAJ79AH2djIBQmhYc0Mlgjl4=
X-Google-Smtp-Source: AAOMgpd8zesnlDfqJg4yuEVbr/sRRRIVbFx5wHMcArKEYym6zEGE80232zlrRxrE3hez4hEsdogbKwNHS3mjbmQ3oHY=
X-Received: by 2002:a19:d942:: with SMTP id q63-v6mr1132148lfg.39.1532604950635;
 Thu, 26 Jul 2018 04:35:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 04:35:50
 -0700 (PDT)
In-Reply-To: <20180703123910.2180-3-willy@infradead.org>
References: <20180703123910.2180-1-willy@infradead.org> <20180703123910.2180-3-willy@infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 26 Jul 2018 17:05:50 +0530
Message-ID: <CAFqt6zbcxiY4trW2p3sqtfUGDBSqYrXwzDoydvgap2TCRf8D_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: Make vm_insert_pfn_prot static
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 6:09 PM, Matthew Wilcox <willy@infradead.org> wrote:
> Now this is no longer used outside mm/memory.c, make it static.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---

Any comment on this patch ?

>  include/linux/mm.h |  2 --
>  mm/memory.c        | 50 +++++++++++++++++++++++-----------------------
>  2 files changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3cb763a38642..703a9962103e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2439,8 +2439,6 @@ int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
>  int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
>  int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>                         unsigned long pfn);
> -int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> -                       unsigned long pfn, pgprot_t pgprot);
>  vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>                         unsigned long pfn, pgprot_t pgprot);
>  int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index caecb4d995ac..73c5682310c7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1828,31 +1828,7 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>         return retval;
>  }
>
> -/**
> - * vm_insert_pfn - insert single pfn into user vma
> - * @vma: user vma to map to
> - * @addr: target user address of this page
> - * @pfn: source kernel pfn
> - *
> - * Similar to vm_insert_page, this allows drivers to insert individual pages
> - * they've allocated into a user vma. Same comments apply.
> - *
> - * This function should only be called from a vm_ops->fault handler, and
> - * in that case the handler should return NULL.
> - *
> - * vma cannot be a COW mapping.
> - *
> - * As this is called only for pages that do not currently exist, we
> - * do not need to flush old virtual caches or the TLB.
> - */
> -int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
> -                       unsigned long pfn)
> -{
> -       return vm_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
> -}
> -EXPORT_SYMBOL(vm_insert_pfn);
> -
> -int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> +static int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>                         unsigned long pfn, pgprot_t pgprot)
>  {
>         int ret;
> @@ -1879,6 +1855,30 @@ int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>         return ret;
>  }
>
> +/**
> + * vm_insert_pfn - insert single pfn into user vma
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pfn: source kernel pfn
> + *
> + * Similar to vm_insert_page, this allows drivers to insert individual pages
> + * they've allocated into a user vma. Same comments apply.
> + *
> + * This function should only be called from a vm_ops->fault handler, and
> + * in that case the handler should return NULL.
> + *
> + * vma cannot be a COW mapping.
> + *
> + * As this is called only for pages that do not currently exist, we
> + * do not need to flush old virtual caches or the TLB.
> + */
> +int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
> +                       unsigned long pfn)
> +{
> +       return vm_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
> +}
> +EXPORT_SYMBOL(vm_insert_pfn);
> +
>  /**
>   * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
>   * @vma: user vma to map to
> --
> 2.18.0
>
