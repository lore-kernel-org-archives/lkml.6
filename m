Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E5C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189DB21723
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaJRAVVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189DB21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbeHGMHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:07:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37446 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbeHGMHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:07:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so15153803wrr.4;
        Tue, 07 Aug 2018 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/O7TdJoP7N2FoanRdi/G7kqSl9vXm6WcMt5chEXnx7o=;
        b=UaJRAVVxSRKur9MPSQZ2Uo1UPET3Ydprsp8o02JewUQdbAbU5swUsE/EtjBuJ+wBCu
         bRaIRPHGCjcdgEe6ndp0SglDIDwXcPYvN+NXRGLT+NtBZmXKEZvWA1BdoLuKL9XZDjbm
         /PZyst4k+bIEQwLprjwghKwuoaIVN+4UTceo717pqO9kH0hQpDIQ0zo9oJCYDB4SXJ1d
         s6QNdxil1HXONF+/YuiosHH+JfCzExrzWaFK2CY3MUHTY0hFubz4KI5suvZHvEskxgP5
         y5tTRnFhu8jvukI6O53DhECjO5Bqjt+5EuE2ukxKPtEkdFPQ8ZZlZ83aUzTDcaARZOuU
         Gf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/O7TdJoP7N2FoanRdi/G7kqSl9vXm6WcMt5chEXnx7o=;
        b=pFbKIS+6Y8UonCxh2FJLogWYVeuKMfd6qKnpQyqO8H3cwuwrJ1BP5ZUiHBvFnh59w8
         l6lQHsnLrnnawK7UU8SVZ315K/oBOuelXb1rGigjhhu/CxAEDciyrRx/1B4a0KX7hZr8
         T1AqEUBgyJ8yCt9u0VH4uOIrb6sABN5svlUotxQiJp2ptq74zSYcXxpRNH6jdRgg0vHU
         3eyuyQ/uJtW4oA4ogNn3lViD2T4WryOqi8teZbBIsJkK2e2QpyONy1PU4rsTG5sMLez8
         OZmYeSAAcDxtzCHY1fcZb6odTHN+r7d/uTO6jLl1s3ghIgbIp1YK+HJPb4+Z3sNYws9x
         0kQQ==
X-Gm-Message-State: AOUpUlHA9FG7SGZN2IUtzpE0o7wPO/wtEkAy8i0XT7FjyVA3wt47wwEI
        ykTi1xvn070bx/zu9CO7UT0=
X-Google-Smtp-Source: AAOMgpeEgHwxMnWaxx9fhC80pBwiUFSRP0teJEeBR4iDRGlYK4soV0+oSVPH/N/ZXm0P0N5shdrNzg==
X-Received: by 2002:adf:f210:: with SMTP id p16-v6mr12506702wro.184.1533635645712;
        Tue, 07 Aug 2018 02:54:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1404825wmg.45.2018.08.07.02.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 02:54:05 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:54:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180807095402.GA12200@gmail.com>
References: <20180806175711.24438-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806175711.24438-1-alex@ghiti.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexandre Ghiti <alex@ghiti.fr> wrote:

> [CC linux-mm for inclusion in -mm tree]                                          
>                                                                                  
> In order to reduce copy/paste of functions across architectures and then         
> make riscv hugetlb port (and future ports) simpler and smaller, this             
> patchset intends to factorize the numerous hugetlb primitives that are           
> defined across all the architectures.                                            
>                                                                                  
> Except for prepare_hugepage_range, this patchset moves the versions that         
> are just pass-through to standard pte primitives into                            
> asm-generic/hugetlb.h by using the same #ifdef semantic that can be              
> found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.                            
>                                                                                  
> s390 architecture has not been tackled in this serie since it does not           
> use asm-generic/hugetlb.h at all.                                                
>                                                                                  
> This patchset has been compiled on all addressed architectures with              
> success (except for parisc, but the problem does not come from this              
> series).                                                                         
>                                                                                  
> v6:                                                                              
>   - Remove nohash/32 and book3s/32 powerpc specific implementations in
>     order to use the generic ones.                                                        
>   - Add all the Reviewed-by, Acked-by and Tested-by in the commits,              
>     thanks to everyone.                                                          
>                                                                                  
> v5:                                                                              
>   As suggested by Mike Kravetz, no need to move the #include                     
>   <asm-generic/hugetlb.h> for arm and x86 architectures, let it live at          
>   the top of the file.                                                           
>                                                                                  
> v4:                                                                              
>   Fix powerpc build error due to misplacing of #include                          
>   <asm-generic/hugetlb.h> outside of #ifdef CONFIG_HUGETLB_PAGE, as              
>   pointed by Christophe Leroy.                                                   
>                                                                                  
> v1, v2, v3:                                                                      
>   Same version, just problems with email provider and misuse of                  
>   --batch-size option of git send-email
> 
> Alexandre Ghiti (11):
>   hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
>   hugetlb: Introduce generic version of hugetlb_free_pgd_range
>   hugetlb: Introduce generic version of set_huge_pte_at
>   hugetlb: Introduce generic version of huge_ptep_get_and_clear
>   hugetlb: Introduce generic version of huge_ptep_clear_flush
>   hugetlb: Introduce generic version of huge_pte_none
>   hugetlb: Introduce generic version of huge_pte_wrprotect
>   hugetlb: Introduce generic version of prepare_hugepage_range
>   hugetlb: Introduce generic version of huge_ptep_set_wrprotect
>   hugetlb: Introduce generic version of huge_ptep_set_access_flags
>   hugetlb: Introduce generic version of huge_ptep_get
> 
>  arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
>  arch/arm/include/asm/hugetlb.h               | 30 ----------
>  arch/arm64/include/asm/hugetlb.h             | 39 +++---------
>  arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
>  arch/mips/include/asm/hugetlb.h              | 40 +++----------
>  arch/parisc/include/asm/hugetlb.h            | 33 +++--------
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  6 --
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
>  arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
>  arch/powerpc/include/asm/nohash/32/pgtable.h |  6 --
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
>  arch/sh/include/asm/hugetlb.h                | 54 ++---------------
>  arch/sparc/include/asm/hugetlb.h             | 40 +++----------
>  arch/x86/include/asm/hugetlb.h               | 69 ----------------------
>  include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
>  15 files changed, 135 insertions(+), 394 deletions(-)

The x86 bits look good to me (assuming it's all tested on all relevant architectures, etc.)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
