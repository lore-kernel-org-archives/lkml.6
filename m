Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966564AbeEYLld (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:41:33 -0400
Received: from ozlabs.org ([203.11.71.1]:53223 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965906AbeEYLl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:41:27 -0400
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7cf76a68f1bcf69214da2812e8f615e36e16e60e
In-Reply-To: <20180328185531.10945-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        Matt Brown <matthew.brown.dev@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3] powerpc/altivec: Add missing prototypes for altivec
Message-Id: <40skq96GJMz9s4w@ozlabs.org>
Date: Fri, 25 May 2018 21:41:25 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-28 at 18:55:25 UTC, Mathieu Malaterre wrote:
> Some functions prototypes were missing for the non-altivec code. Add the
> missing prototypes in a new header file, fix warnings treated as errors
> with W=1:
> 
>   arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype for ‘xor_altivec_2’ [-Werror=missing-prototypes]
>   arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype for ‘xor_altivec_3’ [-Werror=missing-prototypes]
>   arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype for ‘xor_altivec_4’ [-Werror=missing-prototypes]
>   arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype for ‘xor_altivec_5’ [-Werror=missing-prototypes]
> 
> The prototypes were already present in <asm/xor.h> but this header file is
> meant to be included after <include/linux/raid/xor.h>. Trying to re-use
> <asm/xor.h> directly would lead to warnings such as:
> 
>   arch/powerpc/include/asm/xor.h:39:15: error: variable ‘xor_block_altivec’ has initializer but incomplete type
> 
> Trying to re-use <asm/xor.h> after <include/linux/raid/xor.h> in
> xor_vmx_glue.c would in turn trigger the following warnings:
> 
>   include/asm-generic/xor.h:688:34: error: ‘xor_block_32regs’ defined but not used [-Werror=unused-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7cf76a68f1bcf69214da2812e8f615

cheers
