Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2552373-1525774951-2-18403714279756446619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525774950; b=fTY2YG99pAtYhRHNQ/VR+YXaIz6mz94zgHOv/+YBiPVQB1qmSQ
    jI0zpm5XVQiVhyQp/K8W0mQ03c31vb3asFyag7DKxIgX2tN1/h5rN6dPaoCt2xcW
    5Au4TuCOi7pceyKYsMXWtsmlGxDAWGgooXRdyyakl65CcaxEOQIAvToBZirR/Vke
    S/DOqQqPX0Zjhk0AwswiMzMoz7QGwOshHtfuYAk0YD1lVrf7Go06g901TS6kA03q
    AtqYzF2x8+/Z5mspoh+utYUJ6LMmY5ucxVuvku1SsCvBxZOu/1j2iB4YAEP1dTfB
    y/56qI1IMSpiTetWDlrmPP9zeNsPrbtR44sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=fm2; t=1525774950; bh=VoOhvMRqiAs7
    Yw1/zwYAfIngCXcl2+XDJjSspFZ/J0Q=; b=WbXmZ7jdv7/PAtQUM+k3Ij2dlfvz
    hFKqhfks/KBHeJGS5tcIi2M2hTX367EEpwpKRbOvfaP70+R/TU5hbrQJZriPsI67
    +SmcBh3cnmmb8RbAu/2YBFZlcHY/hqzWKomxdAUNx5Y3h1Jx90JSz3C9G5UStOjy
    ZNKwrkm51WlNAw0U2x2bneNXbM3974WslW4tgmGcTv+3Wy9rdVsqnXSLEmduKtmr
    JrKwi2FzReKTDv8coVJNKzNKyoKsUt62N5OXiUgTbBZU0mTQaTHjk+fon+dzOjyj
    A7NV5euKPJipdLRCY1ZQ7vqI8Def7uIDePevB2QglL+pZhjc13tz3F+Enw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com
    header.i=@samsung.com header.b=UHxIc4IO x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com
      header.i=@samsung.com header.b=UHxIc4IO x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=samsung.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGUwrioghxxBBA/1fwLt7kpF6OKYvlWahlJ9/s29Wr4i+Cc6G2QJ+/fURP1o1e1f9is325p+acr3K/Pu8ZnW21xss9YgtAAgyl9sH1rCPBoUq+ayLx67
    KeN9Fhu/2IK5/WY0uzeKWsXRuM02mRZkulIV6vKjdkRJxqmVkksJrtW/PcYwFyeTXIYr6h2Ximtsyquy2kblDwg5J5VPWW9y3LaAd3f5RFDP9WKLcCY/4rKJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=Z0-ysB8EjMlbOY_JyNkA:9
    a=myR77mvPcGtFW2Qc:21 a=k-apXxKib8BruAz5:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeEHKW0 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 06:22:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38516 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754716AbeEHKWW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 06:22:22 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180508102220euoutp02576b6eb9893ef85a0c00e78bd8268d10~spDlp4d6c0711707117euoutp02V
X-AuditID: cbfec7f5-b45ff700000028a9-e0-5af17a599c4d
Subject: Re: [PATCH 1/3] dma-debug: move initialization to common code
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Michal Simek <monstr@monstr.eu>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        nios2-dev@lists.rocketboards.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d2ea505f-ef18-bed1-23b5-dad81032e775@samsung.com>
Date: Tue, 8 May 2018 12:22:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424140235.9125-2-hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe885Ox611XFae7IbzJCuTqngJdMCJQ4FFX0oHFEd82SSm7Kj
        lkq2yERHRaR2WZYVyTSbxsxrdJuWqdky08wSoxTEtCWmJmmX7Vj57fdc/8//5WVIxXHal4nR
        JQh6HR+roj2oiqfj9lURKUOawDOFnrjz+wDCoxVvZbio+AmBrz0Mxl+66hDOrBmhsPVTuwzX
        XT5LYEd6FY1ba/JobO6xkPhj40sC503kkPjkewuBi5otbrhnqInCRlMvja1ZrTQ2NBTKNnpz
        1aYuN67K+png+h5XklzZzWNc6Z0KxGV3mBHXcHKU4trMNwnu3lsDzU0ac0hu2Lpou6fGY32U
        EBuTJOjVofs8DqbfeEbGt2mPjDd2EwaUFWFE7gywa8A6bKGMyINRsIUISvOzp4JvCKy547QU
        DCM4XdxLGBHjGukyRUp5M4KL3X0yKXAgePqjn3Lu9WY3ge15uYt92HAwf2hxMcnepmCgYJGT
        aTYIjING2slyNhSqDdmuHopdAvaJMRfPYXfD+atvCKnHCxou9VDOI9xZNbRfWSqtXAyVg3mk
        xEro7MknnPcAW8VAU3kXLfkMh7z+11PsDf31d90kXgC/qvMJiY/BmbG6qeFTCO6n504VgqG2
        vkXmFCbZZVBao5bSIfDiajklPcos6Bj0km6YBecqLpBSWg6ZGQqp2x9M9SX/VB+/fEWeRX6m
        acZM09yYprkx/de9hqhbSCkkitpoQVytEw4HiLxWTNRFB+yP01rRn4/Z9LN+pAo9mIi0IZZB
        qpny7/FfNQoZnyQma20IGFLlI/dbOKRRyKP45BRBH7dXnxgriDY0n6FUSvmepWkaBRvNJwiH
        BCFe0P+tEoy7rwFt2NrsecEeJba3zg1bWfI5v3PF8ghvxSNFskNf4NMxp6yxP/LAzsiV27JG
        0kp8j2psxfw5e1ha1K3rFnsmP8OdE9iB7Z9UtbrAzenGtbMdvUW5ji19Ld2550+oB6lOWS1x
        WmlI1QSnFGJlRgET8m7dpP+8HS92qVPDfMt068XZKko8yActJ/Ui/xu648pmlAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUgTcRjH+93drtMcnVPzh73ZEgqj6U2Xv6mNqIijvwLBcBZ25TElt9nd
        ZilEI9R0UGma5NLSmC4zsSb5FhEty6zMXkhSGpkpVr6URb6AVs4V+N+H5/l+Hp4HHgqXXZSE
        UOkGEy8YuAw56Us8+93p3pqYM6mNPD+iQv0zYwBNNfdJUF39IwxV3Y9DE+4OgArafxHI+alX
        gjouF2HoW24rid60V5DIMdSAo8GnLzFUMVeKo7z3DRiq625YjoYmnxHIahsmkbPwDYksXdcl
        OwLYNpt7OdvqHMXYzw9acLbJfoptvNUM2JJ3DsB25U0R7FuHHWPv9llIdt5airM/nev2rdAq
        4gWj2cSHphlF03Z5MoOUCkaNFMpotYKJijkYq1TJIzTxqXxGehYvRGgOKdJyrz3BM9/qT8w+
        /YBZQGGSFVAUpKOh23bYCnwpGV0D4GDbD8wKfBbqa2BXmUXi5QA412slvaFxAGuH+wlPI4De
        A13P7yxyIL0bOgZeEZ4QTt8koH3CjXkNB4ADp92LY0magdZxzygfSkprYJulZNEm6DDYMze9
        yEH0ATjzyEp4M/6wq3yI8KzqQ0fA3srNnjJOb4NXmj7iXl4PW8Yr/nEw7B+6ihUBmW2JbVui
        2JYotiVKFSBugEDeLOp1epFRiJxeNBt0iiNGvRMsvETz49mmVvD6doIL0BSQ+0lnMr9rZRIu
        S8zWuwCkcHmgdOPaSa1Mmspl5/CCMUUwZ/CiC6gWbivGQ4KOGBcezGBKYVRMDFIzMVExUduQ
        PFjaE5mtldE6zsQf5flMXvjvYZRPiAWEGmM3TdTcUaevr239s/ro8+7BhOrwaN1x9XxY2KV6
        w/b6ntTbQtJ3+zE21I/THXg4R7l2OsxkR3nmhnz4wr5SP9bZeSZj70hyeGLxLnWPdlYsiyvf
        r1nlX1mN93Wfm29UXiho49h700LJlrPJldOKL19Ptp93IZVt2XRc/qhFTohpHBOOCyL3F+0s
        0fIoAwAA
X-CMS-MailID: 20180508102215eucas1p13bf142bbf47e484eebff063c92fce569
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180508102215eucas1p13bf142bbf47e484eebff063c92fce569
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180424140315epcas1p260a93a22d2b78db49274ec5c07664efe
X-RootMTR: 20180424140315epcas1p260a93a22d2b78db49274ec5c07664efe
References: <20180424140235.9125-1-hch@lst.de>
        <CGME20180424140315epcas1p260a93a22d2b78db49274ec5c07664efe@epcas1p2.samsung.com>
        <20180424140235.9125-2-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Christoph,

On 2018-04-24 16:02, Christoph Hellwig wrote:
> Most mainstream architectures are using 65536 entries, so lets stick to
> that.  If someone is really desperate to override it that can still be
> done through <asm/dma-mapping.h>, but I'd rather see a really good
> rationale for that.
>
> dma_debug_init is now called as a core_initcall, which for many
> architectures means much earlier, and provides dma-debug functionality
> earlier in the boot process.  This should be safe as it only relies
> on the memory allocator already being available.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice! Unification of this is definitely needed and solves the issues
reported some time ago:

https://patchwork.kernel.org/patch/9429637/ (arm)
https://patchwork.kernel.org/patch/9431161/ (arm64, rejected)

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/mm/dma-mapping-nommu.c |  9 ---------
>   arch/arm/mm/dma-mapping.c       |  9 ---------
>   arch/arm64/mm/dma-mapping.c     | 10 ----------
>   arch/c6x/kernel/dma.c           | 11 -----------
>   arch/ia64/kernel/dma-mapping.c  | 10 ----------
>   arch/microblaze/kernel/dma.c    | 11 -----------
>   arch/mips/mm/dma-default.c      | 10 ----------
>   arch/openrisc/kernel/dma.c      | 11 -----------
>   arch/powerpc/kernel/dma.c       |  3 ---
>   arch/s390/pci/pci_dma.c         |  9 ---------
>   arch/sh/mm/consistent.c         |  9 ---------
>   arch/sparc/kernel/Makefile      |  2 --
>   arch/sparc/kernel/dma.c         | 13 -------------
>   arch/x86/kernel/pci-dma.c       |  4 ----
>   arch/xtensa/kernel/pci-dma.c    |  9 ---------
>   include/linux/dma-debug.h       |  6 ------
>   lib/dma-debug.c                 | 21 ++++++++++++++-------
>   17 files changed, 14 insertions(+), 143 deletions(-)
>   delete mode 100644 arch/sparc/kernel/dma.c
>
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index 619f24a42d09..f448a0663b10 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -241,12 +241,3 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   void arch_teardown_dma_ops(struct device *dev)
>   {
>   }
> -
> -#define PREALLOC_DMA_DEBUG_ENTRIES	4096
> -
> -static int __init dma_debug_do_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -	return 0;
> -}
> -core_initcall(dma_debug_do_init);
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 8c398fedbbb6..c26bf83f44ca 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1165,15 +1165,6 @@ int arm_dma_supported(struct device *dev, u64 mask)
>   	return __dma_supported(dev, mask, false);
>   }
>   
> -#define PREALLOC_DMA_DEBUG_ENTRIES	4096
> -
> -static int __init dma_debug_do_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -	return 0;
> -}
> -core_initcall(dma_debug_do_init);
> -
>   #ifdef CONFIG_ARM_DMA_USE_IOMMU
>   
>   static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long attrs)
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index a96ec0181818..db01f2709842 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -508,16 +508,6 @@ static int __init arm64_dma_init(void)
>   }
>   arch_initcall(arm64_dma_init);
>   
> -#define PREALLOC_DMA_DEBUG_ENTRIES	4096
> -
> -static int __init dma_debug_do_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -	return 0;
> -}
> -fs_initcall(dma_debug_do_init);
> -
> -
>   #ifdef CONFIG_IOMMU_DMA
>   #include <linux/dma-iommu.h>
>   #include <linux/platform_device.h>
> diff --git a/arch/c6x/kernel/dma.c b/arch/c6x/kernel/dma.c
> index 9fff8be75f58..31e1a9ec3a9c 100644
> --- a/arch/c6x/kernel/dma.c
> +++ b/arch/c6x/kernel/dma.c
> @@ -136,14 +136,3 @@ const struct dma_map_ops c6x_dma_ops = {
>   	.sync_sg_for_cpu	= c6x_dma_sync_sg_for_cpu,
>   };
>   EXPORT_SYMBOL(c6x_dma_ops);
> -
> -/* Number of entries preallocated for DMA-API debugging */
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -
> -static int __init dma_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -
> -	return 0;
> -}
> -fs_initcall(dma_init);
> diff --git a/arch/ia64/kernel/dma-mapping.c b/arch/ia64/kernel/dma-mapping.c
> index f2d57e66fd86..7a471d8d67d4 100644
> --- a/arch/ia64/kernel/dma-mapping.c
> +++ b/arch/ia64/kernel/dma-mapping.c
> @@ -9,16 +9,6 @@ int iommu_detected __read_mostly;
>   const struct dma_map_ops *dma_ops;
>   EXPORT_SYMBOL(dma_ops);
>   
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -
> -static int __init dma_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -
> -	return 0;
> -}
> -fs_initcall(dma_init);
> -
>   const struct dma_map_ops *dma_get_ops(struct device *dev)
>   {
>   	return dma_ops;
> diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
> index c91e8cef98dd..3145e7dc8ab1 100644
> --- a/arch/microblaze/kernel/dma.c
> +++ b/arch/microblaze/kernel/dma.c
> @@ -184,14 +184,3 @@ const struct dma_map_ops dma_nommu_ops = {
>   	.sync_sg_for_device	= dma_nommu_sync_sg_for_device,
>   };
>   EXPORT_SYMBOL(dma_nommu_ops);
> -
> -/* Number of entries preallocated for DMA-API debugging */
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -
> -static int __init dma_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -
> -	return 0;
> -}
> -fs_initcall(dma_init);
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index dcafa43613b6..f9fef0028ca2 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -402,13 +402,3 @@ static const struct dma_map_ops mips_default_dma_map_ops = {
>   
>   const struct dma_map_ops *mips_dma_map_ops = &mips_default_dma_map_ops;
>   EXPORT_SYMBOL(mips_dma_map_ops);
> -
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -
> -static int __init mips_dma_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -
> -	return 0;
> -}
> -fs_initcall(mips_dma_init);
> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index a945f00011b4..ec7fd45704d2 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -247,14 +247,3 @@ const struct dma_map_ops or1k_dma_map_ops = {
>   	.sync_single_for_device = or1k_sync_single_for_device,
>   };
>   EXPORT_SYMBOL(or1k_dma_map_ops);
> -
> -/* Number of entries preallocated for DMA-API debugging */
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -
> -static int __init dma_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -
> -	return 0;
> -}
> -fs_initcall(dma_init);
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index da20569de9d4..138157deeadf 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -309,8 +309,6 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
>   }
>   EXPORT_SYMBOL(dma_set_coherent_mask);
>   
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -
>   int dma_set_mask(struct device *dev, u64 dma_mask)
>   {
>   	if (ppc_md.dma_set_mask)
> @@ -361,7 +359,6 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>   
>   static int __init dma_init(void)
>   {
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
>   #ifdef CONFIG_PCI
>   	dma_debug_add_bus(&pci_bus_type);
>   #endif
> diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
> index 2d15d84c20ed..5dee7a922589 100644
> --- a/arch/s390/pci/pci_dma.c
> +++ b/arch/s390/pci/pci_dma.c
> @@ -668,15 +668,6 @@ void zpci_dma_exit(void)
>   	kmem_cache_destroy(dma_region_table_cache);
>   }
>   
> -#define PREALLOC_DMA_DEBUG_ENTRIES	(1 << 16)
> -
> -static int __init dma_debug_do_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -	return 0;
> -}
> -fs_initcall(dma_debug_do_init);
> -
>   const struct dma_map_ops s390_pci_dma_ops = {
>   	.alloc		= s390_dma_alloc,
>   	.free		= s390_dma_free,
> diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
> index 8ce98691d822..35ea3099a3b6 100644
> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -20,18 +20,9 @@
>   #include <asm/cacheflush.h>
>   #include <asm/addrspace.h>
>   
> -#define PREALLOC_DMA_DEBUG_ENTRIES	4096
> -
>   const struct dma_map_ops *dma_ops;
>   EXPORT_SYMBOL(dma_ops);
>   
> -static int __init dma_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -	return 0;
> -}
> -fs_initcall(dma_init);
> -
>   void *dma_generic_alloc_coherent(struct device *dev, size_t size,
>   				 dma_addr_t *dma_handle, gfp_t gfp,
>   				 unsigned long attrs)
> diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
> index 76cb57750dda..84cfc5a428d6 100644
> --- a/arch/sparc/kernel/Makefile
> +++ b/arch/sparc/kernel/Makefile
> @@ -74,8 +74,6 @@ obj-$(CONFIG_SPARC64)	+= pcr.o
>   obj-$(CONFIG_SPARC64)	+= nmi.o
>   obj-$(CONFIG_SPARC64_SMP) += cpumap.o
>   
> -obj-y                     += dma.o
> -
>   obj-$(CONFIG_PCIC_PCI)    += pcic.o
>   obj-$(CONFIG_LEON_PCI)    += leon_pci.o
>   obj-$(CONFIG_SPARC_GRPCI2)+= leon_pci_grpci2.o
> diff --git a/arch/sparc/kernel/dma.c b/arch/sparc/kernel/dma.c
> deleted file mode 100644
> index f73e7597c971..000000000000
> --- a/arch/sparc/kernel/dma.c
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/kernel.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/dma-debug.h>
> -
> -#define PREALLOC_DMA_DEBUG_ENTRIES       (1 << 15)
> -
> -static int __init dma_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -	return 0;
> -}
> -fs_initcall(dma_init);
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 77625b60a510..bcbaa2e8031e 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -55,9 +55,6 @@ struct device x86_dma_fallback_dev = {
>   };
>   EXPORT_SYMBOL(x86_dma_fallback_dev);
>   
> -/* Number of entries preallocated for DMA-API debugging */
> -#define PREALLOC_DMA_DEBUG_ENTRIES       65536
> -
>   void __init pci_iommu_alloc(void)
>   {
>   	struct iommu_table_entry *p;
> @@ -189,7 +186,6 @@ EXPORT_SYMBOL(arch_dma_supported);
>   static int __init pci_iommu_init(void)
>   {
>   	struct iommu_table_entry *p;
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
>   
>   #ifdef CONFIG_PCI
>   	dma_debug_add_bus(&pci_bus_type);
> diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
> index 732631ce250f..392b4a80ebc2 100644
> --- a/arch/xtensa/kernel/pci-dma.c
> +++ b/arch/xtensa/kernel/pci-dma.c
> @@ -261,12 +261,3 @@ const struct dma_map_ops xtensa_dma_map_ops = {
>   	.mapping_error = xtensa_dma_mapping_error,
>   };
>   EXPORT_SYMBOL(xtensa_dma_map_ops);
> -
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -
> -static int __init xtensa_dma_init(void)
> -{
> -	dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
> -	return 0;
> -}
> -fs_initcall(xtensa_dma_init);
> diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> index c7d844f09c3a..a785f2507159 100644
> --- a/include/linux/dma-debug.h
> +++ b/include/linux/dma-debug.h
> @@ -30,8 +30,6 @@ struct bus_type;
>   
>   extern void dma_debug_add_bus(struct bus_type *bus);
>   
> -extern void dma_debug_init(u32 num_entries);
> -
>   extern int dma_debug_resize_entries(u32 num_entries);
>   
>   extern void debug_dma_map_page(struct device *dev, struct page *page,
> @@ -100,10 +98,6 @@ static inline void dma_debug_add_bus(struct bus_type *bus)
>   {
>   }
>   
> -static inline void dma_debug_init(u32 num_entries)
> -{
> -}
> -
>   static inline int dma_debug_resize_entries(u32 num_entries)
>   {
>   	return 0;
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 7f5cdc1e6b29..712a897174e4 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -41,6 +41,11 @@
>   #define HASH_FN_SHIFT   13
>   #define HASH_FN_MASK    (HASH_SIZE - 1)
>   
> +/* allow architectures to override this if absolutely required */
> +#ifndef PREALLOC_DMA_DEBUG_ENTRIES
> +#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> +#endif
> +
>   enum {
>   	dma_debug_single,
>   	dma_debug_page,
> @@ -1004,18 +1009,16 @@ void dma_debug_add_bus(struct bus_type *bus)
>   	bus_register_notifier(bus, nb);
>   }
>   
> -/*
> - * Let the architectures decide how many entries should be preallocated.
> - */
> -void dma_debug_init(u32 num_entries)
> +static int dma_debug_init(void)
>   {
> +	u32 num_entries;
>   	int i;
>   
>   	/* Do not use dma_debug_initialized here, since we really want to be
>   	 * called to set dma_debug_initialized
>   	 */
>   	if (global_disable)
> -		return;
> +		return 0;
>   
>   	for (i = 0; i < HASH_SIZE; ++i) {
>   		INIT_LIST_HEAD(&dma_entry_hash[i].list);
> @@ -1026,17 +1029,19 @@ void dma_debug_init(u32 num_entries)
>   		pr_err("DMA-API: error creating debugfs entries - disabling\n");
>   		global_disable = true;
>   
> -		return;
> +		return 0;
>   	}
>   
>   	if (req_entries)
>   		num_entries = req_entries;
> +	else
> +		num_entries = PREALLOC_DMA_DEBUG_ENTRIES;
>   
>   	if (prealloc_memory(num_entries) != 0) {
>   		pr_err("DMA-API: debugging out of memory error - disabled\n");
>   		global_disable = true;
>   
> -		return;
> +		return 0;
>   	}
>   
>   	nr_total_entries = num_free_entries;
> @@ -1044,7 +1049,9 @@ void dma_debug_init(u32 num_entries)
>   	dma_debug_initialized = true;
>   
>   	pr_info("DMA-API: debugging enabled by kernel config\n");
> +	return 0;
>   }
> +core_initcall(dma_debug_init);
>   
>   static __init int dma_debug_cmdline(char *str)
>   {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
