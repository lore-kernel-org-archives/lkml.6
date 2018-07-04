Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A2DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2931D2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="VvDzDuep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2931D2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeGDOuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:50:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40280 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbeGDOuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:50:16 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so11198446oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5ixtoC4W5ckvAB7DeXyyQnePpHsgpwvXLVECrdllidU=;
        b=VvDzDuepE1huhwzxZhXpjKgvljPgxcNsWwMxnJPs9Yg4qGxMfUTzGyWFzupluP46VA
         x5/Da8dTN/gOR2NwMPBRiRjCUYaCiwkwt8nE9CICEZORW+iWurNUA2LMMweTjTxpaVOe
         k71OlcXhE+xmYIZktnfBb+3iUggN9HWXGSGVCPAzXkAbvdTOtPfHCikxz5+DxLDxdyJk
         JpJ5ne7e/JFg33pPlmFivNvBROIjgvOkc3n3uyHBlIbNI+J2YFZpwsdRUKxMjFm6wOPq
         P+hFqxtWIM4o4lRKtlCe2RFzf1malq3LgFemg7jtHqeqHfB/aVYm0/Pz4K3kOWy/EFog
         GVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5ixtoC4W5ckvAB7DeXyyQnePpHsgpwvXLVECrdllidU=;
        b=YcD4Rq8+LQ3Oh+J6q8W1EeIY9Wj0UwMM08geumfpNWM+8W4EJ6AX0nF+AXC8rAXlJC
         Pw/crdkinsKFXyRRVIdEZCCefZimPhnJSa6V5Nof4PpwQvJzBO/EjO+tvL5wJHniOrw/
         tLka9UABEqjS0sFIotDXNs4Vvp5k32WxihkqHGyBDbrUzz0dK3i2lcLBarJJhdmqD2Vz
         /3Jo5ECSwn9Yt37/2mVmcIC/9G2w1dSPQYRRs/7Czp2pvmhr/8UPdrFNjcOmdlPHgFRw
         3RCMLx9Msuo5L6BqzbsvA+Ob+KhHitH2KI1kuYkxV/qNdDBMiRxDPgY58qGHZsBD5RX9
         /hlQ==
X-Gm-Message-State: APt69E2ffbrJ+t31piNPhIejE2cIg4onB/PsGrFiZ5oGgYPoM3tweGj+
        TtHKGjvdZO3AcphY1v+HoWT/opoF7yLc6s9tyY90+w==
X-Google-Smtp-Source: AAOMgpeEy0fuJ0RJHvXT9WT1EbkOCfn8AM0pjBHiJRJwvFXHvXysyQSLGO7WH6Cf+vl9cliIxzjvoHAs1XIkkzW+Q7s=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr2702617oib.115.1530715815871;
 Wed, 04 Jul 2018 07:50:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:50:15 -0700 (PDT)
In-Reply-To: <359fdf0103b61014bf811d88d4ce36bc793d18f2.1530716899.git.yi.z.zhang@linux.intel.com>
References: <cover.1530716899.git.yi.z.zhang@linux.intel.com> <359fdf0103b61014bf811d88d4ce36bc793d18f2.1530716899.git.yi.z.zhang@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Jul 2018 07:50:15 -0700
Message-ID: <CAPcyv4is0T1SjsaC4Z80ND9Q_032_Tsa0hQwkO84T0FCRj5MkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] kvm: add a function to check if page is from NVDIMM pmem.
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Linux MM <linux-mm@kvack.org>, rkrcmar@redhat.com,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ adding Jerome ]

On Wed, Jul 4, 2018 at 8:30 AM, Zhang Yi <yi.z.zhang@linux.intel.com> wrote:
> For device specific memory space, when we move these area of pfn to
> memory zone, we will set the page reserved flag at that time, some of
> these reserved for device mmio, and some of these are not, such as
> NVDIMM pmem.
>
> Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
> backend, since these pages are reserved. the check of
> kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
> introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
> to indentify these pages are from NVDIMM pmem. and let kvm treat these
> as normal pages.
>
> Without this patch, Many operations will be missed due to this
> mistreatment to pmem pages. For example, a page may not have chance to
> be unpinned for KVM guest(in kvm_release_pfn_clean); not able to be
> marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
> ---
>  virt/kvm/kvm_main.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index afb2e6e..1365d18 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -140,10 +140,23 @@ __weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>  {
>  }
>
> +static bool kvm_is_nd_pfn(kvm_pfn_t pfn)
> +{
> +       struct page *page = pfn_to_page(pfn);
> +
> +       return is_zone_device_page(page) &&
> +               ((page->pgmap->type == MEMORY_DEVICE_FS_DAX) ||
> +                (page->pgmap->type == MEMORY_DEVICE_DEV_DAX));

Jerome, might there be any use case to pass MEMORY_DEVICE_PUBLIC
memory to a guest vm?

> +}
> +
>  bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
>  {
> -       if (pfn_valid(pfn))
> -               return PageReserved(pfn_to_page(pfn));
> +       struct page *page;
> +
> +       if (pfn_valid(pfn)) {
> +               page = pfn_to_page(pfn);
> +               return kvm_is_nd_pfn(pfn) ? false : PageReserved(page);
> +       }
>
>         return true;
>  }
> --
> 2.7.4
>
