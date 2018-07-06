Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D2BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA4D2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA4D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeGFRFi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:05:38 -0400
Received: from foss.arm.com ([217.140.101.70]:40402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932776AbeGFRFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:05:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E98618A;
        Fri,  6 Jul 2018 10:05:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4C503F2EA;
        Fri,  6 Jul 2018 10:05:36 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7F3FA1AE37F8; Fri,  6 Jul 2018 18:06:17 +0100 (BST)
Date:   Fri, 6 Jul 2018 18:06:17 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Nikunj Kela <nkela@cisco.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        xe-kernel@external.cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: add ARM64-specific support for flatmem
Message-ID: <20180706170617.GB4961@arm.com>
References: <20180706170215.56116-1-nkela@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706170215.56116-1-nkela@cisco.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 10:02:15AM -0700, Nikunj Kela wrote:
> Flatmem is useful in reducing kernel memory usage.
> One usecase is in kdump kernel. We are able to save
> ~14M by moving to flatmem scheme.
> 
> Cc: xe-kernel@external.cisco.com
> Cc: Nikunj Kela <nkela@cisco.com>
> Signed-off-by: Nikunj Kela <nkela@cisco.com>
> ---
>  arch/arm64/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090c..96ab9a7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -775,6 +775,10 @@ config ARCH_SPARSEMEM_DEFAULT
>  config ARCH_SELECT_MEMORY_MODEL
>  	def_bool ARCH_SPARSEMEM_ENABLE
>  
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +	depends on !NUMA

I still don't understand what this has to do with NUMA. SPARSEMEM is still
going to be what you want on a non-NUMA system with large holes in the
physical memory map, no?

Will
