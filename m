Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C428FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DC02082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DC02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeLKKhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:37:08 -0500
Received: from foss.arm.com ([217.140.101.70]:43974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKKhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:37:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B23E1596;
        Tue, 11 Dec 2018 02:37:07 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B1723F6A8;
        Tue, 11 Dec 2018 02:37:07 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 545491AE0B6A; Tue, 11 Dec 2018 10:37:30 +0000 (GMT)
Date:   Tue, 11 Dec 2018 10:37:30 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kexec_file: include linux/vmalloc.h
Message-ID: <20181211103730.GB12006@edgewater-inn.cambridge.arm.com>
References: <20181211100603.625505-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211100603.625505-1-arnd@arndb.de>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:05:46AM +0100, Arnd Bergmann wrote:
> This is needed for compilation in some configurations that don't
> include it implicitly:
> 
> arch/arm64/kernel/machine_kexec_file.c: In function 'arch_kimage_file_post_load_cleanup':
> arch/arm64/kernel/machine_kexec_file.c:37:2: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
> 
> Fixes: 52b2a8af7436 ("arm64: kexec_file: load initrd and device-tree")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/machine_kexec_file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 3c2c8a687149..10e33860e47a 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -19,6 +19,7 @@
>  #include <linux/random.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/vmalloc.h>
>  #include <asm/byteorder.h>
>  
>  /* relevant device tree properties */

Cheers Arnd, I'll pick this up today.

Will
