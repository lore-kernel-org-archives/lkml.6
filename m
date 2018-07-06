Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB22C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F46221759
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F46221759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933510AbeGFQAK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:00:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39436 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932851AbeGFQAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:00:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C9EC18A;
        Fri,  6 Jul 2018 09:00:09 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D8043F2EA;
        Fri,  6 Jul 2018 09:00:09 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C75A11AE3105; Fri,  6 Jul 2018 17:00:49 +0100 (BST)
Date:   Fri, 6 Jul 2018 17:00:49 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Nikunj Kela <nkela@cisco.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        xe-kernel@external.cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: add ARM64-specific support for flatmem
Message-ID: <20180706160049.GA27483@arm.com>
References: <20180706155627.23937-1-nkela@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706155627.23937-1-nkela@cisco.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please write a commit message for your patch.

On Fri, Jul 06, 2018 at 08:56:27AM -0700, Nikunj Kela wrote:
> Cc: xe-kernel@external.cisco.com
> Cc: Nikunj Kela <nkela@cisco.com>
> Signed-off-by: Nikunj Kela <nkela@cisco.com>
> ---
>  arch/arm64/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090c..5e791f0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -775,6 +775,10 @@ config ARCH_SPARSEMEM_DEFAULT
>  config ARCH_SELECT_MEMORY_MODEL
>  	def_bool ARCH_SPARSEMEM_ENABLE
>  
> +config ARCH_FLATMEM_ENABLE
> +	def_bool y
> +	depends on ARM64 && !NUMA

We don't need ARM64 here. I'm also not sure about the def_bool y, this seems
like a pretty niche thing to enable.

Will
