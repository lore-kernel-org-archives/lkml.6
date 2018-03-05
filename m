Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeCEP4D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:56:03 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52554 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeCEP4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:56:02 -0500
Date: Mon, 5 Mar 2018 15:55:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Timur Tabi <timur@codeaurora.org>
Cc: Shanker Donthineni <shankerd@codeaurora.org>,
        Thomas Speier <tspeier@codeaurora.org>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP
 hardening
Message-ID: <20180305155557.2iidi6346zcwz6r2@lakrids.cambridge.arm.com>
References: <1520027418-10646-1-git-send-email-shankerd@codeaurora.org>
 <CAOZdJXV3QE2mKSf3GvTSdoVmfjJ1UEXPY8OJfW=-9E1dN1TeZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZdJXV3QE2mKSf3GvTSdoVmfjJ1UEXPY8OJfW=-9E1dN1TeZA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 09:52:19AM -0600, Timur Tabi wrote:
> On Fri, Mar 2, 2018 at 3:50 PM, Shanker Donthineni
> <shankerd@codeaurora.org> wrote:
> > diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> > index bb26382..6ecc249 100644
> > --- a/arch/arm64/include/asm/cpucaps.h
> > +++ b/arch/arm64/include/asm/cpucaps.h
> > @@ -43,7 +43,7 @@
> >  #define ARM64_SVE                              22
> >  #define ARM64_UNMAP_KERNEL_AT_EL0              23
> >  #define ARM64_HARDEN_BRANCH_PREDICTOR          24
> > -#define ARM64_HARDEN_BP_POST_GUEST_EXIT                25
> > +/* #define ARM64_UNALLOCATED_ENTRY                     25 */
> 
> Why not just delete the entry?  

Deleting the entry, and renumbering subsequent entries is the right
thing to do.

> Is ARM64_NCAPS never supposed to get smaller?

It's internal to the kernel, and it makes sense to keep it as small as
possible. There are datastructures allocated for each entry, like the
static key array.

Thanks,
Mark.
