Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeCEPwa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:52:30 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCEPwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:52:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EE0E6043F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
X-Google-Smtp-Source: AG47ELsjkHiV26/OOBPUfAzBfKBNcFTCREIkmtQAL+PrVRP26HHvQVdJLI6lcpOrZjlyukwmuI4ie97f3b/yrHsCoSQ=
MIME-Version: 1.0
In-Reply-To: <1520027418-10646-1-git-send-email-shankerd@codeaurora.org>
References: <1520027418-10646-1-git-send-email-shankerd@codeaurora.org>
From: Timur Tabi <timur@codeaurora.org>
Date: Mon, 5 Mar 2018 09:52:19 -0600
X-Gmail-Original-Message-ID: <CAOZdJXV3QE2mKSf3GvTSdoVmfjJ1UEXPY8OJfW=-9E1dN1TeZA@mail.gmail.com>
Message-ID: <CAOZdJXV3QE2mKSf3GvTSdoVmfjJ1UEXPY8OJfW=-9E1dN1TeZA@mail.gmail.com>
Subject: Re: [PATCH] arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hardening
To: Shanker Donthineni <shankerd@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Thomas Speier <tspeier@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Sean Campbell <scampbel@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 3:50 PM, Shanker Donthineni
<shankerd@codeaurora.org> wrote:
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index bb26382..6ecc249 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -43,7 +43,7 @@
>  #define ARM64_SVE                              22
>  #define ARM64_UNMAP_KERNEL_AT_EL0              23
>  #define ARM64_HARDEN_BRANCH_PREDICTOR          24
> -#define ARM64_HARDEN_BP_POST_GUEST_EXIT                25
> +/* #define ARM64_UNALLOCATED_ENTRY                     25 */

Why not just delete the entry?  Is ARM64_NCAPS never supposed to get smaller?
