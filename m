Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F352C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCADD20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dThrgHry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCADD20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeISI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:29:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38171 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:29:27 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so3729121oix.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqwAAe3KltX6Xv440+VGTFuSyWLCaFUZhxTW1dV6+A8=;
        b=dThrgHryqpv/JTdePERs9TrSPsrkKO2oJVP59im0ZC7FQdbR+TtGr+GXkQ9+BvfzXs
         e+1LqJlo+rCV9CyVxjS2JzFHlaGqLfX1H4g1FNH1zFvaTkgseW8iGt2ZzEiVz0jC/tjc
         GYkGAS1PJEnD/p56OO6QDADKqJl5nwxQ9ipfKTNoNowPG7ZVmzFMLZs3MWe4YcdijWuW
         1lPkF4DvqiZxmK3yPmgfd0+hUGpShhxlhogy7/4Mc0VKsxJlogdzGudK6z/O+Uo8rdIn
         v30dBImKbFP5viHYLdgoaC3dLVyMDD44K5uqeU+IJICTKlaWumIMgCjyvs45BttMwwWQ
         6mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqwAAe3KltX6Xv440+VGTFuSyWLCaFUZhxTW1dV6+A8=;
        b=XdaxOEMmSodF7drAFr1j3hieGpdYq+GTduJB1zyBvohgpE1CpIUgE0HZlHZeSR8JXz
         MfHe6UuMWODdcfdaUcyjMlBuMxpHtTzZMY5G9GtQ5HXSnbGZg9xyI4ZE6dVNk7/QsqaU
         ihulymCWT5KE5mTf+r4UjtLGJ9bf1doXrMs4JP/A/88Hg9uh8vBZoJP1ZPfTUVWbrDfa
         +nfGfmAstNhOq0cyPgrwBADFPXkfJE9TYgNNG2QF4S4t+dJwQRS0OgjMO7JfLF3CH68U
         OSNdgtaJd1OEm4uejf23fCGz8n3boOURsL75O4nH4q2KirE6nqBKwzlykDDaqnijojuJ
         H+Kg==
X-Gm-Message-State: APzg51C8Yg8DGVptrWUaD1ntNpdTeGrHyKaNnJ7vVLHd4eqae5Bsxooy
        t5n+yLu5Xz8L2irrdxD2BkpaCH4J0CEUz/sLoairXw==
X-Google-Smtp-Source: ANB0VdbtBjeL44Y2smAgUI6ZAS4oSNiBDmedmgnNZe7Y4UjS4gvsnZs4Syi7x1mh2fIXqFAWoXbrbM+tSaUDfi11+Ws=
X-Received: by 2002:aca:b355:: with SMTP id c82-v6mr414213oif.9.1537325624178;
 Tue, 18 Sep 2018 19:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com> <4e8c2e0facd46cfaf4ab79e19c9115958ab6f218.1536342881.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <4e8c2e0facd46cfaf4ab79e19c9115958ab6f218.1536342881.git.yi.z.zhang@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 18 Sep 2018 19:53:32 -0700
Message-ID: <CAPcyv4ifg2BZMTNfu6mg0xxtPWs3BVgkfEj51v1CQ6jp2S70fw@mail.gmail.com>
Subject: Re: [PATCH V5 4/4] kvm: add a check if pfn is from NVDIMM pmem.
To:     Zhang Yi <yi.z.zhang@linux.intel.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 2:25 AM Zhang Yi <yi.z.zhang@linux.intel.com> wrote:
>
> For device specific memory space, when we move these area of pfn to
> memory zone, we will set the page reserved flag at that time, some of
> these reserved for device mmio, and some of these are not, such as
> NVDIMM pmem.
>
> Now, we map these dev_dax or fs_dax pages to kvm for DIMM/NVDIMM
> backend, since these pages are reserved, the check of
> kvm_is_reserved_pfn() misconceives those pages as MMIO. Therefor, we
> introduce 2 page map types, MEMORY_DEVICE_FS_DAX/MEMORY_DEVICE_DEV_DAX,
> to identify these pages are from NVDIMM pmem and let kvm treat these
> as normal pages.
>
> Without this patch, many operations will be missed due to this
> mistreatment to pmem pages, for example, a page may not have chance to
> be unpinned for KVM guest(in kvm_release_pfn_clean), not able to be
> marked as dirty/accessed(in kvm_set_pfn_dirty/accessed) etc.
>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Acked-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c44c406..9c49634 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -147,8 +147,20 @@ __weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>
>  bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
>  {
> -       if (pfn_valid(pfn))
> -               return PageReserved(pfn_to_page(pfn));
> +       struct page *page;
> +
> +       if (pfn_valid(pfn)) {
> +               page = pfn_to_page(pfn);
> +
> +               /*
> +                * For device specific memory space, there is a case
> +                * which we need pass MEMORY_DEVICE_FS[DEV]_DAX pages
> +                * to kvm, these pages marked reserved flag as it is a
> +                * zone device memory, we need to identify these pages
> +                * and let kvm treat these as normal pages
> +                */
> +               return PageReserved(page) && !is_dax_page(page);

Should we consider just not setting PageReserved for
devm_memremap_pages()? Perhaps kvm is not be the only component making
these assumptions about this flag?

Why is MEMORY_DEVICE_PUBLIC memory specifically excluded?

This has less to do with "dax" pages and more to do with
devm_memremap_pages() established ranges. P2PDMA is another producer
of these pages. If either MEMORY_DEVICE_PUBLIC or P2PDMA pages can be
used in these kvm paths then I think this points to consider clearing
the Reserved flag.

That said I haven't audited all the locations that test PageReserved().

Sorry for not responding sooner I was on extended leave.
