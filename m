Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1148220855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rOY8UICN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1148220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeLJPPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:15:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36938 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeLJPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:15:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so8266816lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E5xm7eH52Fy6OJNbIJDutqhE46UBtijO2dHJCxBrof4=;
        b=rOY8UICNhwgenMQ974wdzmyfQp3RMk4pfA4G90T6YXz4bNiCBoITjKkVPjP8oMcCON
         uHUOoz0prTIV9VETT8vOEQqGkwYD3k7h8BC0YPUSjIa51YDC02AJdYRompscCVlPIq5a
         0DIZdEI1azzblOZp1L+ueNUczetC6OH4t/4JjOSECJ83RzrKi8ighmib2MFtofFZHY/y
         yAShWskIH8VJgeH6RnKnCMlZ4c7cYrMzJYLscx2WUl4nXZy4600eOfuD63Swyx7UL2bp
         khabEgtpfrDVZAFhikxK7/cDnuHIXoi6vwJYKriH+XcnLaTgnA7m3vvf5XDgt70EHnbU
         lMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E5xm7eH52Fy6OJNbIJDutqhE46UBtijO2dHJCxBrof4=;
        b=U5XEpVlysX+KmWop6dPCHI7zhfc9/0h4w3pspePU1rsTioqNieaTkXei2Q7o2epWrb
         MokUoa0zjXSgrTHVtPyc+0mgiO3azSGYWB5JB3MtFmekCQMj0gyyHmfUvRNUXO54gMzP
         we6fp+3nB3767WTXnhiy/Dd/pPdZUDDtvptjggSYjQMtDD0p9hQIo2d3Yu2RiH+syJp5
         XxlOXvPKFWxm7ilHrJ39Yj80T6v3nO7CtQ7YuS4XeVO2k3QHWuRiv6OjcGwSST2dYUdd
         7aNDwPoYZ+uP/HdH1D+NAYyPbBz60C+dJ59i6ySvj6bXYpuwz/PuW7wHoyV1h06Qq+ct
         wLag==
X-Gm-Message-State: AA+aEWbxVTO/Vu21vV/sTmuBK9U1SlTVVAI9LfvizyHM3fJdc8tSY1by
        Q+0B8p2ud8M6qB9aHL5KCaOk7g==
X-Google-Smtp-Source: AFSGD/X7lJuM1kAIPu8kAyzpO2/5GH0DL/7RY2tdW0r70cn17ZYoIEjBj5YaEZKPstRbOKVPX/N/ag==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr6814620lfk.151.1544454909175;
        Mon, 10 Dec 2018 07:15:09 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-113-209-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.209.113])
        by smtp.gmail.com with ESMTPSA id b128sm2162380lfe.91.2018.12.10.07.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:15:08 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id D049130155D; Mon, 10 Dec 2018 18:15:06 +0300 (+03)
Date:   Mon, 10 Dec 2018 18:15:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
Message-ID: <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210142105.6750-1-rafael.tinoco@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 12:21:05PM -0200, Rafael David Tinoco wrote:
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 84bd9bdc1987..d808cfde3d19 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -64,8 +64,6 @@ extern unsigned int ptrs_per_p4d;
>  #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
>  #define P4D_MASK		(~(P4D_SIZE - 1))
>  
> -#define MAX_POSSIBLE_PHYSMEM_BITS	52
> -
>  #else /* CONFIG_X86_5LEVEL */
>  
>  /*
> @@ -154,4 +152,6 @@ extern unsigned int ptrs_per_p4d;
>  
>  #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
>  
> +#define MAX_POSSIBLE_PHYSMEM_BITS (pgtable_l5_enabled() ? 52 : 46)
> +

...

>  #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 0787d33b80d8..132c20b6fd4f 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c

...

> @@ -116,6 +100,25 @@
>   */
>  #define OBJ_ALLOCATED_TAG 1
>  #define OBJ_TAG_BITS 1
> +
> +/*
> + * MAX_POSSIBLE_PHYSMEM_BITS should be defined by all archs using zsmalloc:
> + * Trying to guess it from MAX_PHYSMEM_BITS, or considering it BITS_PER_LONG,
> + * proved to be wrong by not considering PAE capabilities, or using SPARSEMEM
> + * only headers, leading to bad object encoding due to object index overflow.
> + */
> +#ifndef MAX_POSSIBLE_PHYSMEM_BITS
> + #define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
> + #error "MAX_POSSIBLE_PHYSMEM_BITS HAS to be defined by arch using zsmalloc";
> +#else
> + #ifndef CONFIG_64BIT
> +  #if (MAX_POSSIBLE_PHYSMEM_BITS >= (BITS_PER_LONG + PAGE_SHIFT - OBJ_TAG_BITS))
> +   #error "MAX_POSSIBLE_PHYSMEM_BITS is wrong for this arch";
> +  #endif
> + #endif
> +#endif
> +
> +#define _PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
>  #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>  #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)

Have you tested it with CONFIG_X86_5LEVEL=y?

ASAICS, the patch makes OBJ_INDEX_BITS and what depends from it dynamic --
it depends what paging mode we are booting in. ZS_SIZE_CLASSES depends
indirectly on OBJ_INDEX_BITS and I don't see how struct zs_pool definition
can compile with dynamic ZS_SIZE_CLASSES.

Hm?

-- 
 Kirill A. Shutemov
