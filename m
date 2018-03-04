Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeCDJ3d (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 04:29:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751839AbeCDJ3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 04:29:31 -0500
Date: Sun, 4 Mar 2018 10:29:18 +0100
From: Borislav Petkov <bp@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        r.marek@assembler.cz, ricardo.neri-calderon@linux.intel.com,
        rkrcmar@redhat.com, Janakarajan.Natarajan@amd.com, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] clarify how insecure CPU is
Message-ID: <20180304092918.GA1142@pd.tnic>
References: <20180108201017.GA20588@amd>
 <alpine.DEB.2.20.1801082125530.2253@nanos>
 <20180108230355.GA25349@amd>
 <alpine.DEB.2.20.1801090043160.2253@nanos>
 <20180303210653.GB22392@amd>
 <alpine.DEB.2.21.1803040825130.1654@nanos.tec.linutronix.de>
 <20180304085159.GB7931@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180304085159.GB7931@amd>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 09:51:59AM +0100, Pavel Machek wrote:
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index f41079d..4901742 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -341,7 +341,7 @@
>  #define X86_BUG_FDIV			X86_BUG(1) /* FPU FDIV */
>  #define X86_BUG_COMA			X86_BUG(2) /* Cyrix 6x86 coma */
>  #define X86_BUG_AMD_TLB_MMATCH		X86_BUG(3) /* "tlb_mmatch" AMD Erratum 383 */
> -#define X86_BUG_AMD_APIC_C1E		X86_BUG(4) /* "apic_c1e" AMD Erratum 400 */
> +#define X86_BUG_AMD_APIC_C1E		X86_BUG(4) /* System is affected AMD Erratum 400, special idle routine is needed */
>  #define X86_BUG_11AP			X86_BUG(5) /* Bad local APIC aka 11AP */
>  #define X86_BUG_FXSAVE_LEAK		X86_BUG(6) /* FXSAVE leaks FOP/FIP/FOP */
>  #define X86_BUG_CLFLUSH_MONITOR		X86_BUG(7) /* AAI65, CLFLUSH required before MONITOR */
> @@ -356,7 +356,7 @@
>  #define X86_BUG_NULL_SEG		X86_BUG(10) /* Nulling a selector preserves the base */
>  #define X86_BUG_SWAPGS_FENCE		X86_BUG(11) /* SWAPGS without input dep on GS */
>  #define X86_BUG_MONITOR			X86_BUG(12) /* IPI required to wake up remote CPU */
> -#define X86_BUG_AMD_E400		X86_BUG(13) /* CPU is among the affected by Erratum 400 */
> +#define X86_BUG_AMD_E400		X86_BUG(13) /* System may be affected by Erratum 400, X86_BUG_AMD_APIC_C1E might be needed  */

Not "might be needed" - "X86_BUG_AMD_APIC_C1E will be set if platform is
affected".

And then you don't need the above comment change. And you can't remove
"apic_c1e" there because it is magical.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
