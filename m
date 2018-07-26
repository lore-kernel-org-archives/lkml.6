Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B274C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BF22083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jODM/0TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BF22083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbeGZMvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 08:51:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34056 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbeGZMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 08:51:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id n96-v6so962558lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=86LCqdCeFPip5xh2JOfmHYWqB9F5pVQqR1T0tN0hHIw=;
        b=jODM/0TEht5BiGLc2/txw67xgadh4enYw5l8tYSDqLkexYL8puSNMzQlHV5eBkCxfs
         WmAvVTmjTkWxBKrL9Aov0VCURj1DTTOBINQHdhIdB4iJlmKla4PbFmEo/rmFzLf0AwG/
         vfHf+xhowb24zzXIZmlYDBbJXQhH42KSt0jWtbYLgWJbxiAK+72Ekk/sn2M89TI1cQk7
         WIqP/uflfdyr15yB3QCvh7F7Y7PZiqCcbVm1XHLrcwFck0p2ZY61tO1q8dH0qo3hZdAb
         ALxtCROV2rKNVidr+Zu6GwwK6zSj/ZtEDs1IyXTco1bE1FQy8AqumV3yHuFglPdAba5z
         58ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=86LCqdCeFPip5xh2JOfmHYWqB9F5pVQqR1T0tN0hHIw=;
        b=sZ1haj9Achy6e2u2hypXpL+upgHqJI/u8eB5fxgJ1sobvL5RIEONZUChpBBxeDuNX1
         vBlAzgZ8KRqGqG98ZTW+njdSxFeBiDWiHoXG7e5eULXz58WDMi5NZBqziQnuPSUR1CIT
         u1Gt2ZKkDwhBYU/1+SnoXYmtJaiQ9ZoXv9bkxXEVq4VaNe49VmzTSudc5georfVC4Fiv
         T/o78othOHaz+UI5+impvM1yX0B1Pane3lngQAkz/0RcThKXQTYuYrbZT8jldqdAcTaY
         cSWz/Mkjl+8GV7XaXQJ1Hs2nhrkH8RhNyHyXdlKMm1NYMJL1AaS7VDXc4hzxpOHXlJ+D
         SRnA==
X-Gm-Message-State: AOUpUlG1cQkiQ0eBBR/qCOrPEOnqV7KXQsiEM+c8mZm4mSXC2DL6p6l0
        ZlBC0cwqQm+JlspctCMJn9o7HCqcpBep2QisdBggXg==
X-Google-Smtp-Source: AAOMgpcGqADpHRQCvKbhULrR87spnTm715S6oaS5dcLHrgvvpKzeT7eTiGK/MdykMsdJ7ukUXR4nterf78gjVebniqw=
X-Received: by 2002:a19:1604:: with SMTP id m4-v6mr1143748lfi.120.1532604885292;
 Thu, 26 Jul 2018 04:34:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 04:34:44
 -0700 (PDT)
In-Reply-To: <20180703123910.2180-1-willy@infradead.org>
References: <20180703123910.2180-1-willy@infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 26 Jul 2018 17:04:44 +0530
Message-ID: <CAFqt6zbBHBCXO6qhYp3aSYj-zXSH8T=DDOd9gVY88K93qMgGvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Introduce vmf_insert_pfn_prot
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
> Like vm_insert_pfn_prot(), but returns a vm_fault_t instead of an errno.
> Also unexport vm_insert_pfn_prot as it has no modular users.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---

Any comment on this patch ?

>  include/linux/mm.h |  2 ++
>  mm/memory.c        | 47 ++++++++++++++++++++++++++++++----------------
>  2 files changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1a9d6bd97f00..3cb763a38642 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2441,6 +2441,8 @@ int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>                         unsigned long pfn);
>  int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>                         unsigned long pfn, pgprot_t pgprot);
> +vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> +                       unsigned long pfn, pgprot_t pgprot);
>  int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
>                         pfn_t pfn);
>  vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
> diff --git a/mm/memory.c b/mm/memory.c
> index b9ebd883e27c..caecb4d995ac 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1852,21 +1852,6 @@ int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vm_insert_pfn);
>
> -/**
> - * vm_insert_pfn_prot - insert single pfn into user vma with specified pgprot
> - * @vma: user vma to map to
> - * @addr: target user address of this page
> - * @pfn: source kernel pfn
> - * @pgprot: pgprot flags for the inserted page
> - *
> - * This is exactly like vm_insert_pfn, except that it allows drivers to
> - * to override pgprot on a per-page basis.
> - *
> - * This only makes sense for IO mappings, and it makes no sense for
> - * cow mappings.  In general, using multiple vmas is preferable;
> - * vm_insert_pfn_prot should only be used if using multiple VMAs is
> - * impractical.
> - */
>  int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>                         unsigned long pfn, pgprot_t pgprot)
>  {
> @@ -1893,7 +1878,37 @@ int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
>
>         return ret;
>  }
> -EXPORT_SYMBOL(vm_insert_pfn_prot);
> +
> +/**
> + * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pfn: source kernel pfn
> + * @pgprot: pgprot flags for the inserted page
> + *
> + * This is exactly like vmf_insert_pfn(), except that it allows drivers to
> + * to override pgprot on a per-page basis.
> + *
> + * This only makes sense for IO mappings, and it makes no sense for
> + * COW mappings.  In general, using multiple vmas is preferable;
> + * vm_insert_pfn_prot should only be used if using multiple VMAs is
> + * impractical.
> + *
> + * Return: vm_fault_t value.
> + */
> +vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> +                       unsigned long pfn, pgprot_t pgprot)
> +{
> +       int err = vm_insert_pfn_prot(vma, addr, pfn, pgprot);
> +
> +       if (err == -ENOMEM)
> +               return VM_FAULT_OOM;
> +       if (err < 0 && err != -EBUSY)
> +               return VM_FAULT_SIGBUS;
> +
> +       return VM_FAULT_NOPAGE;
> +}
> +EXPORT_SYMBOL(vmf_insert_pfn_prot);
>
>  static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
>  {
> --
> 2.18.0
>
