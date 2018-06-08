Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lfeJHKrhGVvKIQAAmS7hNA
	; Fri, 08 Jun 2018 01:54:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 15BBE6074D; Fri,  8 Jun 2018 01:54:41 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrWw1t0Q"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7804B601D2;
	Fri,  8 Jun 2018 01:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7804B601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeFHByi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:54:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40592 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbeFHByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:54:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id t12-v6so7264822plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 18:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzCBQlRS35zoCxyTantuxIw/cel5xVtYMq9WSOLRAvs=;
        b=qrWw1t0Qg6nB8IrxGN3Wod85wVMpn9MTg4R2gYtZ7w6m1Zdpcj7W+q9hfZLZwfrGHA
         jHUzWQQ7dYMIPs4YjcXuZkEqgYdsZ2ccMNmAmRc0OP3IKnWxeYiNPntsAj834isaF14P
         l0UGGYG11tDeJtt/D51b7CLKPEEsEqnPZUloDYVmZd6WcJ6t4g97iunKtpgGAOlO2OQL
         +ub0pU+6tdvLY+M9mf3JiLIni03IZZJySDLx5m3PpyAR/pKXUODawb2x+nVziuOf34p+
         dVPBljhHLz0r1/Tlt/KY40yRrwdEkIpAViDV35zh6pWTmmdjurDZu+Z0sRVJ/lWVqNl8
         ifTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzCBQlRS35zoCxyTantuxIw/cel5xVtYMq9WSOLRAvs=;
        b=CWgzF/w5E7QpqmZuSqkFG51xk6rS+zf9yXqFLP+qLdYobBwG2u82OkcndLvq98CsNi
         4N8Mtk4wFulzPikvhVEuVSSVaEgVfhLTO9di3GsKBbXlTmlma9QasUuhBHTfU9+/YC0R
         zOOccyasHiIkGo0QAbcTAowcvQSiVpGmQCwpO+I53MAUEeXkfJBhRDkFjFECjHei5F7r
         T4rKbtwrTWG91+AnoWUhHlg6j0eOerNJRIWz3Xu+NbnJM50oGvrcr2oGzc/mGFTBiG5a
         32aXU5tFoKXzRa29ZfUN5GWhqrE7Y8CPirAvsV5n5S840kSxzyEZpOzXD0ZR7RhfoagA
         +4PQ==
X-Gm-Message-State: APt69E3IwGsfiVihsaxxlCDtVVyM2ur8IQmwzx7cQqnIyb0oTIYU/Hx2
        SE5m025DQM0RAjiFvHwPwPo=
X-Google-Smtp-Source: ADUXVKLnTZl8az232HYTeIJ2mPDDq1OtRav8WIka/tkWfyGct8lp5uoyrdAmIWRtnJfNWkGvFH781g==
X-Received: by 2002:a17:902:7105:: with SMTP id a5-v6mr4468085pll.171.1528422876669;
        Thu, 07 Jun 2018 18:54:36 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
        by smtp.gmail.com with ESMTPSA id s14-v6sm17972676pfh.116.2018.06.07.18.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 18:54:36 -0700 (PDT)
Date: Fri, 8 Jun 2018 11:54:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: make CPU selection logic generic in
 Makefile
Message-ID: <20180608115429.50c8d578@roar.ozlabs.ibm.com>
In-Reply-To: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
References: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jun 2018 10:10:18 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> At the time being, when adding a new CPU for selection, both
> Kconfig.cputype and Makefile have to be modified.
> 
> This patch moves into Kconfig.cputype the name of the CPU to me
> passed to the -mcpu= argument.

Seems like a good cleanup.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Makefile                  |  8 +-------
>  arch/powerpc/platforms/Kconfig.cputype | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 9704ab360d39..9a5642552abc 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -175,13 +175,7 @@ ifdef CONFIG_MPROFILE_KERNEL
>      endif
>  endif
>  
> -CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
> -CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
> -CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
> -CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
> -CFLAGS-$(CONFIG_POWER8_CPU) += $(call cc-option,-mcpu=power8)
> -CFLAGS-$(CONFIG_POWER9_CPU) += $(call cc-option,-mcpu=power9)
> -CFLAGS-$(CONFIG_PPC_8xx) += $(call cc-option,-mcpu=860)
> +CFLAGS-$(CONFIG_SPECIAL_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_SPECIAL_CPU))
>  
>  # Altivec option not allowed with e500mc64 in GCC.
>  ifeq ($(CONFIG_ALTIVEC),y)
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index cc892dcfa114..71ef559cc474 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -140,6 +140,21 @@ config E6500_CPU
>  
>  endchoice
>  
> +config SPECIAL_CPU_BOOL
> +	bool
> +	default !GENERIC_CPU
> +
> +config SPECIAL_CPU
> +	string
> +	depends on SPECIAL_CPU_BOOL
> +	default "cell" if CELL_CPU
> +	default "power5" if POWER5_CPU
> +	default "power6" if POWER6_CPU
> +	default "power7" if POWER7_CPU
> +	default "power8" if POWER8_CPU
> +	default "power9" if POWER9_CPU
> +	default "860" if PPC_8xx
> +
>  config PPC_BOOK3S
>  	def_bool y
>  	depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
