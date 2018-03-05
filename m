Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934769AbeCEMnZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:43:25 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933014AbeCEMnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:43:24 -0500
Date: Mon, 5 Mar 2018 12:43:27 +0000
From: Will Deacon <will.deacon@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH] scripts/kallsyms: filter arm64's __efistub_ symbols
Message-ID: <20180305124327.GE8571@arm.com>
References: <20180301171901.1134-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301171901.1134-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 05:19:01PM +0000, Ard Biesheuvel wrote:
> On arm64, the EFI stub and the kernel proper are essentially the same
> binary, although the EFI stub executes at a different virtual address
> as the kernel. For this reason, the EFI stub is restricted in the
> symbols it can link to, which is ensured by prefixing all EFI stub
> symbols with __efistub_ (and emitting __efistub_ prefixed aliases for
> routines that may be shared between the core kernel and the stub)
> 
> These symbols are leaking into kallsyms, polluting the namespace, so
> let's filter them explicitly.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  scripts/kallsyms.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, I'll take this via arm64.

Will

> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 9ee9bf7fd1a2..1dd24c5b9b47 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -221,6 +221,7 @@ static int symbol_valid(struct sym_entry *s)
>  
>  	static char *special_prefixes[] = {
>  		"__crc_",		/* modversions */
> +		"__efistub_",		/* arm64 EFI stub namespace */
>  		NULL };
>  
>  	static char *special_suffixes[] = {
> -- 
> 2.11.0
> 
