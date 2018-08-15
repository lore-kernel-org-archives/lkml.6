Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B55C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E01521581
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 10:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVM6tw7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E01521581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeHONRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 09:17:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37277 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeHONRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 09:17:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so352858pfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 03:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YdJvfaMH8RaI82H4Lv5OZlfPffJZ1TBdMj3VUGFxCfg=;
        b=kVM6tw7JK5P0Hvz8s7Btr7DP87Gz1V5FylG5s8Ku0w3eKmsG8+rASQPL2bpLca7Pdu
         +iGiYbr19mSPZKnxe7ya5eEgtim0/S8HvLAfZCq05QcpVVlF/9yI5Cklk0YRm5r6O2Fv
         vHpVcRHo51e4x+daRPmwTB2n/ZACRMvl/y1db51AOmd6FPKuCU4UraCGXoIA/3cst+KK
         iq0xoE3hKM9cnhyHiUgv6MzR3edKdHBANEl2Mi5/iVqJECHni45c0/JhbEU7M6sYE5Df
         mw+p2dix+AdXu1E4Gz/ImqdcOiebXiljRIKleV1E4tXh7U20moa0qsbyjsAW8bBB3Nem
         GJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YdJvfaMH8RaI82H4Lv5OZlfPffJZ1TBdMj3VUGFxCfg=;
        b=jY1/v2f8IDX+LdqWFoDJIQ4clrU1Q0F2RhPBtZmYqK8k5ILqGrzenhiM1NpRh3TRs6
         ETcvB/hp6SnawRm7T51PXUwSJXpM7Z07UMv5cbcYL4tGhscHN5BS073cLCIhxdZJpZZb
         kSh87NH6JfY2IZbS2SrHrJyFGurJxGp/rMTOsBfzGKaW71H50cAnlA1awcpimDFqSoDi
         fJSMFbtyskipiCteI1bsYzkevlq0wVctYFUirLfRx5sqDLSibll7JkHupVLyPJDhXYa8
         3EdZIPVt3O0oTX9lurpFD2gG2yGCSQYGDF9SZR4KAcWa0WB3Pjpvhsc/Kyk49W8i6UeD
         g2Sg==
X-Gm-Message-State: AOUpUlGW8qgS5Ilnol/xAbe7Ys87TPG99oBAZxMipRxbEeh5Rt/x8opB
        7jbmoCxNMzFURA38jnNemqZVLyAp
X-Google-Smtp-Source: AA+uWPwwYd5XiQLXULM25XMMxh+eEcVbWgJpe26DgW2bymzGXioaEEeni8MK1UNQgbxrly2kCZDv6Q==
X-Received: by 2002:a63:4450:: with SMTP id t16-v6mr24743756pgk.102.1534328771677;
        Wed, 15 Aug 2018 03:26:11 -0700 (PDT)
Received: from toy ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id r81-v6sm32353292pfa.18.2018.08.15.03.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 03:26:11 -0700 (PDT)
Date:   Wed, 15 Aug 2018 18:26:06 +0800
From:   Jun Yao <yaojun8558363@gmail.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] arm64/mm: Create initial page tables in
 init_pg_dir
Message-ID: <20180815102606.GA2274@toy>
Mail-Followup-To: James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-4-yaojun8558363@gmail.com>
 <3977afaa-63ae-e390-7660-4d25146140b8@arm.com>
 <41a18121-c91d-f9ec-87c3-8dba7931b517@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a18121-c91d-f9ec-87c3-8dba7931b517@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Jul 06, 2018 at 03:41:07PM +0100, James Morse wrote:
> I missed one: head.S has a call to kasan_early_init() before start_kernel(),
> this goes messing with the page tables, and calls pgd_offset_k(), which pulls in
> swapper_pg_dir. This one is enabled by CONFIG_KASAN.
> 
> Something like that same hunk [0] in kasan_early_init() fixes it. This is still
> within arch/arm64, so I still think we should get away without some #ifdeffery
> to override the core-code's initial setup of swapper_pg_dir...

I'm sorry to reply you so late, I missed this email before.

In order to ensure that pgd_offset_k() works properly, I update
init_mm.pgd by introducing set_init_mm_pgd(). And its implementation is
like this:

>diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>index 65f86271f02b..e4f0868b4cfd 100644
>--- a/arch/arm64/mm/mmu.c
>+++ b/arch/arm64/mm/mmu.c
>@@ -623,6 +623,19 @@ static void __init map_kernel(pgd_t *pgdp)
>        kasan_copy_shadow(pgdp);
> }
>
>+void __init set_init_mm_pgd(pgd_t *pgd)
>+{
>+       pgd_t **addr = &(init_mm.pgd);
>+
>+       asm volatile("str %x0, [%1]\n"
>+                   : : "r" (pgd), "r" (addr) : "memory");
>+}
> /*
>  * paging_init() sets up the page tables, initialises the zone memory
>  * maps and sets up the zero page.

The purpose of using assembly is to prevent KASAN instrumentation, as
KASAN has not been initialized when this function is called:

>diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>index c3e4b1886cde..ede2e964592b 100644
>--- a/arch/arm64/kernel/head.S
>+++ b/arch/arm64/kernel/head.S
>@@ -439,6 +438,9 @@ __primary_switched:
>        bl      __pi_memset
>        dsb     ishst                           // Make zero page visible to PTW
>
>+       adrp    x0, init_pg_dir
>+       bl      set_init_mm_pgd
>+
> #ifdef CONFIG_KASAN
>        bl      kasan_early_init
> #endif

What do you think?
