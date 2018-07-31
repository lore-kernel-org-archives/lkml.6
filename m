Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0D2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D4B208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D4B208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbeGaLZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:25:15 -0400
Received: from ozlabs.org ([203.11.71.1]:60309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731119AbeGaLZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:25:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fs4m1ZFyz9ryn;
        Tue, 31 Jul 2018 19:45:43 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Alexei Colin <acolin@isi.edu>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Alexei Colin <acolin@isi.edu>,
        John Paul Walters <jwalters@isi.edu>
Subject: Re: [PATCH 3/6] powerpc: factor out RapidIO Kconfig menu entry
In-Reply-To: <20180730225035.28365-4-acolin@isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu> <20180730225035.28365-4-acolin@isi.edu>
Date:   Tue, 31 Jul 2018 19:45:42 +1000
Message-ID: <87pnz3hh6h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexei Colin <acolin@isi.edu> writes:

> The menu entry is now defined in the rapidio subtree.  Also, re-order
> the bus menu so tha the platform-specific RapidIO controller appears
> after the entry for the RapidIO subsystem.
>
> Platforms with a PCI bus will be offered the RapidIO menu since they may
> be want support for a RapidIO PCI device. Platforms without a PCI bus
> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexei Colin <acolin@isi.edu>
> ---
>  arch/powerpc/Kconfig | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Looks good.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 25d005af0a5b..17ea8a5f90a0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -993,16 +993,7 @@ source "drivers/pci/Kconfig"
>  
>  source "drivers/pcmcia/Kconfig"
>  
> -config HAS_RAPIDIO
> -	bool
> -	default n
> -
> -config RAPIDIO
> -	tristate "RapidIO support"
> -	depends on HAS_RAPIDIO || PCI
> -	help
> -	  If you say Y here, the kernel will include drivers and
> -	  infrastructure code to support RapidIO interconnect devices.
> +source "drivers/rapidio/Kconfig"
>  
>  config FSL_RIO
>  	bool "Freescale Embedded SRIO Controller support"
> @@ -1012,8 +1003,6 @@ config FSL_RIO
>  	  Include support for RapidIO controller on Freescale embedded
>  	  processors (MPC8548, MPC8641, etc).
>  
> -source "drivers/rapidio/Kconfig"
> -
>  endmenu
>  
>  config NONSTATIC_KERNEL
> -- 
> 2.18.0
