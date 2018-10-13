Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA2DC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF5020659
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOlRCVqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF5020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJNAge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:36:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41499 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeJNAge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:36:34 -0400
Received: by mail-oi1-f196.google.com with SMTP id l197-v6so12140710oib.8;
        Sat, 13 Oct 2018 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/ReSYIuFOFaRJhbbz3/wwsKBIHKrTWE6n3IfmclR94=;
        b=MOlRCVqx2Y+1giGNbcCrP/xUK8phJjVp+aM+gjXCsTuBn8PDNwbDPJ+vuPSg4MhM9S
         ynAS9qEs+8cjQZs54KUKRB7TR1N3F/CuNRB5CE8bOMEiJj3lcUMHfPotttIHJm+mb/zJ
         gE/q7VHKaFIAgoo92UGnQQ2UYC+8s51hGOy6uSlOhUf+JYQKu4YSSxBGCQ3dCZDHS48U
         h1eZqDSX7lp99MrHR045X5HZLBs299lovrbOPWgt2R9eXDDXxFtXJT/aT4pC2aYhTS5Z
         p+khnx7sotroVN8FE3deykrx/azq6qgR0a/OP98uxeRzXoVdan5k2h5TqejIDzh5jv3K
         XcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/ReSYIuFOFaRJhbbz3/wwsKBIHKrTWE6n3IfmclR94=;
        b=iEfw43lQ0NaqagypN5Kc7dmMsspme9NKjVCoDrHwOFib1uyWJAMOiDuuoqUZNuhwYF
         h33jlaIQ+fQK3+6OictCgG0ND8hiBsqNTG/PgWXbjP1P/rYXXk02GJNMIoZolY8HjN/Q
         XOJRhyEh0Ibp5c/ESsGGM0Y1gmmegXxq+K3EIYH9yn+PnBcj7vTakSitN5ar84lVo9QO
         4GbTjeDWsoL/gdaT6BPFyCM5Mtr8ePZo2zDdar9fpsdUmS++lXAg9ek/xLCesJWbJ4xv
         u5nWCmKTmrDPRHZUqok9Zza8QHCQoMFBK/Q6FUlbX9F8C9+68LLfx7oIoa9YCKc9fR6t
         568Q==
X-Gm-Message-State: ABuFfogI39PmRjUIFCJ9VItyVl6+Q0MDMFi3ZpjCaZPnjyBBtio5DHql
        JPPJR9Pjo9xhh9Vfoyus1t/wQ/ydKU9n12AQNRo=
X-Google-Smtp-Source: ACcGV63COr6BtiejFrSjVhlgKO13u271ANuhQiqviC7cJts//xF2z9gen884pTdR1tBxjJv+yxEjy4CPNEuBykH2upw=
X-Received: by 2002:aca:d4d3:: with SMTP id l202-v6mr5440360oig.15.1539449919711;
 Sat, 13 Oct 2018 09:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181011221237.1925.85591.stgit@localhost.localdomain> <20181011221334.1925.31961.stgit@localhost.localdomain>
In-Reply-To: <20181011221334.1925.31961.stgit@localhost.localdomain>
From:   Pavel Tatashin <pasha.tatashin@gmail.com>
Date:   Sat, 13 Oct 2018 12:58:03 -0400
Message-ID: <CAGM2rebWT43mTrpsbiwqpioNa=K68OQp=fstBmgov3tdkXjPiQ@mail.gmail.com>
Subject: Re: [mm PATCH v2 1/6] mm: Use mm_zero_struct_page from SPARC on all
 64b architectures
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>, dave.jiang@intel.com,
        LKML <linux-kernel@vger.kernel.org>, willy@infradead.org,
        davem@davemloft.net, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org,
        dan.j.williams@intel.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am worried about this change. I added SPARC optimized
mm_zero_struct_page() specifically to SPARC because it has a poor
performance with small memset()s, since it uses STBI instructions.
However, other architectures might not suffer with small memset()s,
and have hardware optimized memset variants for small sizes. Don't
forget, this is a leaf routine on most arches, so the function call
should be cheap. Also, the macro itself is not very flexible: when
size of struct page is changed, it also must be modified (we could add
fall throughs though), I would add this macro only to those arches
that benefit from this change, in other words, I would like to see
performance data.

I will review the rest of the patches in this series on Monday.

Thank you,
Pavel
On Thu, Oct 11, 2018 at 6:17 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This change makes it so that we use the same approach that was already in
> use on Sparc on all the archtectures that support a 64b long.
>
> This is mostly motivated by the fact that 8 to 10 store/move instructions
> are likely always going to be faster than having to call into a function
> that is not specialized for handling page init.
>
> An added advantage to doing it this way is that the compiler can get away
> with combining writes in the __init_single_page call. As a result the
> memset call will be reduced to only about 4 write operations, or at least
> that is what I am seeing with GCC 6.2 as the flags, LRU poitners, and
> count/mapcount seem to be cancelling out at least 4 of the 8 assignments on
> my system.
>
> One change I had to make to the function was to reduce the minimum page
> size to 56 to support some powerpc64 configurations.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  arch/sparc/include/asm/pgtable_64.h |   30 ------------------------------
>  include/linux/mm.h                  |   34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 30 deletions(-)
>
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 1393a8ac596b..22500c3be7a9 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -231,36 +231,6 @@
>  extern struct page *mem_map_zero;
>  #define ZERO_PAGE(vaddr)       (mem_map_zero)
>
> -/* This macro must be updated when the size of struct page grows above 80
> - * or reduces below 64.
> - * The idea that compiler optimizes out switch() statement, and only
> - * leaves clrx instructions
> - */
> -#define        mm_zero_struct_page(pp) do {                                    \
> -       unsigned long *_pp = (void *)(pp);                              \
> -                                                                       \
> -        /* Check that struct page is either 64, 72, or 80 bytes */     \
> -       BUILD_BUG_ON(sizeof(struct page) & 7);                          \
> -       BUILD_BUG_ON(sizeof(struct page) < 64);                         \
> -       BUILD_BUG_ON(sizeof(struct page) > 80);                         \
> -                                                                       \
> -       switch (sizeof(struct page)) {                                  \
> -       case 80:                                                        \
> -               _pp[9] = 0;     /* fallthrough */                       \
> -       case 72:                                                        \
> -               _pp[8] = 0;     /* fallthrough */                       \
> -       default:                                                        \
> -               _pp[7] = 0;                                             \
> -               _pp[6] = 0;                                             \
> -               _pp[5] = 0;                                             \
> -               _pp[4] = 0;                                             \
> -               _pp[3] = 0;                                             \
> -               _pp[2] = 0;                                             \
> -               _pp[1] = 0;                                             \
> -               _pp[0] = 0;                                             \
> -       }                                                               \
> -} while (0)
> -
>  /* PFNs are real physical page numbers.  However, mem_map only begins to record
>   * per-page information starting at pfn_base.  This is to handle systems where
>   * the first physical page in the machine is at some huge physical address,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 273d4dbd3883..dee407998366 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -102,8 +102,42 @@ static inline void set_max_mapnr(unsigned long limit) { }
>   * zeroing by defining this macro in <asm/pgtable.h>.
>   */
>  #ifndef mm_zero_struct_page
> +#if BITS_PER_LONG == 64
> +/* This function must be updated when the size of struct page grows above 80
> + * or reduces below 64. The idea that compiler optimizes out switch()
> + * statement, and only leaves move/store instructions
> + */
> +#define        mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
> +static inline void __mm_zero_struct_page(struct page *page)
> +{
> +       unsigned long *_pp = (void *)page;
> +
> +        /* Check that struct page is either 56, 64, 72, or 80 bytes */
> +       BUILD_BUG_ON(sizeof(struct page) & 7);
> +       BUILD_BUG_ON(sizeof(struct page) < 56);
> +       BUILD_BUG_ON(sizeof(struct page) > 80);
> +
> +       switch (sizeof(struct page)) {
> +       case 80:
> +               _pp[9] = 0;     /* fallthrough */
> +       case 72:
> +               _pp[8] = 0;     /* fallthrough */
> +       default:
> +               _pp[7] = 0;     /* fallthrough */
> +       case 56:
> +               _pp[6] = 0;
> +               _pp[5] = 0;
> +               _pp[4] = 0;
> +               _pp[3] = 0;
> +               _pp[2] = 0;
> +               _pp[1] = 0;
> +               _pp[0] = 0;
> +       }
> +}
> +#else
>  #define mm_zero_struct_page(pp)  ((void)memset((pp), 0, sizeof(struct page)))
>  #endif
> +#endif
>
>  /*
>   * Default maximum number of active map areas, this limits the number of vmas
>
