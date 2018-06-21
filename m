Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B86C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961D720837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961D720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933149AbeFUL1Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:27:25 -0400
Received: from ozlabs.org ([203.11.71.1]:47963 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932936AbeFUL1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:27:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41BKDR2cmsz9s19;
        Thu, 21 Jun 2018 21:27:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/32: Remove left over function prototypes
In-Reply-To: <20180620190038.3250-1-malat@debian.org>
References: <20180408194821.19682-1-malat@debian.org> <20180620190038.3250-1-malat@debian.org>
Date:   Thu, 21 Jun 2018 21:27:18 +1000
Message-ID: <87602cfkh5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:

> In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")

I don't have that commit ^ ?

That might be because I squashed some of your fixes together or something?

> diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
> index 35ca309848d7..829ed66f0a40 100644
> --- a/arch/powerpc/kernel/setup.h
> +++ b/arch/powerpc/kernel/setup.h
> @@ -19,9 +19,6 @@ void irqstack_early_init(void);
>  void setup_power_save(void);
>  unsigned long __init early_init(unsigned long dt_ptr);
>  void __init machine_init(u64 dt_ptr);
> -int __init ppc_setup_l2cr(char *str);
> -int __init ppc_setup_l3cr(char *str);
> -int __init ppc_init(void);
>  #else
>  static inline void setup_power_save(void) { };
>  #endif

I have:

#ifdef CONFIG_PPC32
void setup_power_save(void);
#else
static inline void setup_power_save(void) { };
#endif


cheers
