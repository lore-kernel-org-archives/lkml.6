Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D58C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD49920870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD49920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbeGaKU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:20:57 -0400
Received: from foss.arm.com ([217.140.101.70]:50098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbeGaKU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:20:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 600037A9;
        Tue, 31 Jul 2018 01:41:42 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DE113F5BA;
        Tue, 31 Jul 2018 01:41:42 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 0C24F1AE2F57; Tue, 31 Jul 2018 09:41:43 +0100 (BST)
Date:   Tue, 31 Jul 2018 09:41:43 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alexei Colin <acolin@isi.edu>
Cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180731084143.GA4680@arm.com>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730225035.28365-7-acolin@isi.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
> Platforms with a PCI bus will be offered the RapidIO menu since they may
> be want support for a RapidIO PCI device. Platforms without a PCI bus
> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> 
> Tested that kernel builds for arm64 with RapidIO subsystem and
> switch drivers enabled, also that the modules load successfully
> on a custom Aarch64 Qemu model.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org,
> Signed-off-by: Alexei Colin <acolin@isi.edu>
> ---
>  arch/arm64/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

Thanks, this looks much cleaner than before:

Acked-by: Will Deacon <will.deacon@arm.com>

The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
unconditionally in the arm64 Kconfig. Does selecting only that option
actually pull in new code to the build?

Will

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a8f0c74e6f7f..5e8cf90505ec 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -308,6 +308,8 @@ config PCI_SYSCALL
>  
>  source "drivers/pci/Kconfig"
>  
> +source "drivers/rapidio/Kconfig"
> +
>  endmenu
>  
>  menu "Kernel Features"
> -- 
> 2.18.0
> 
