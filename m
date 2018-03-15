Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCOBIG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:08:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35658 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeCOBIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:08:05 -0400
Date: Thu, 15 Mar 2018 02:07:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: York Sun <york.sun@nxp.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Message-ID: <20180315010728.GF11061@pd.tnic>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 05:17:46PM -0700, York Sun wrote:
> Add error detection for A53 and A57 cores. Hardware error injection
> is supported on A53. Software error injection is supported on both.
> For hardware error injection on A53 to work, proper access to
> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
> is done by making an SMC call in the driver. Failure to enable access
> disables hardware error injection. For error interrupt to work,
> another SMC call enables access to L2ECTLR_EL1. Failure to enable
> access disables interrupt for error reporting.
> 
> Signed-off-by: York Sun <york.sun@nxp.com>
> ---
>  .../devicetree/bindings/edac/cortex-arm64-edac.txt |  37 +
>  arch/arm64/include/asm/cacheflush.h                |   1 +
>  arch/arm64/mm/cache.S                              |  35 +
>  drivers/edac/Kconfig                               |   6 +
>  drivers/edac/Makefile                              |   1 +
>  drivers/edac/cortex_arm64_l1_l2.c                  | 741 +++++++++++++++++++++

I don't want per-functional unit EDAC drivers. Also, what happened to
talking to ARM people about designing a generic ARM64 EDAC driver?

If this is going to be it, then it should be called edac_arm64.c and it
should contain all the architectural RAS functionality in it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
