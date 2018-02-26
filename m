Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeBZPmf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:42:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51962 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbeBZPmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:42:33 -0500
Date: Mon, 26 Feb 2018 15:42:29 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        yamada.masahiro@socionext.com, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 07/12] arm64: lse: Include compiler_types.h and
 export.h for out-of-line LL/SC
Message-ID: <20180226154229.ms6povjtyv4xt5ru@salmiak>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <1519657500-15094-8-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519657500-15094-8-git-send-email-will.deacon@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 03:04:55PM +0000, Will Deacon wrote:
> When the LL/SC atomics are moved out-of-line, they are annotated as
> notrace and exported to modules. Ensure we pull in the relevant include
> files so that these macros are defined when we need them.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/lse.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
> index eec95768eaad..e612a6be113f 100644
> --- a/arch/arm64/include/asm/lse.h
> +++ b/arch/arm64/include/asm/lse.h
> @@ -4,6 +4,8 @@
>  
>  #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)
>  
> +#include <linux/compiler_types.h>
> +#include <linux/export.h>
>  #include <linux/stringify.h>
>  #include <asm/alternative.h>

I think we should include <asm/cpucaps.h> since we explicitly use
ARM64_HAS_LSE_ATOMICS here.

Otherwise, I don't see that we need anything else here. With that, or if we
decide that <asm/alternative.h> will always include the definition of cpucaps:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
