Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbeFAV0Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 17:26:25 -0400
Received: from foss.arm.com ([217.140.101.70]:58420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeFAV0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 17:26:24 -0400
Date: Fri, 1 Jun 2018 22:26:19 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.or, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: linux-next-20180601: build error in
 arch/arm64/kvm/hyp/hyp-entry.S
Message-ID: <20180601212619.6trmvqrgmbczekkt@armageddon.cambridge.arm.com>
References: <457305318.78169.1527883507093@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457305318.78169.1527883507093@email.1und1.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Fri, Jun 01, 2018 at 10:05:07PM +0200, Stefan Wahren wrote:
> i can't build todays linux-next-20180601 and get the following error message:
> 
> arch/arm64/kvm/hyp/hyp-entry.S: Assembler messages:
> arch/arm64/kvm/hyp/hyp-entry.S:128: Error: constant expression required at operand 3 -- `bfi x0,x1,#VCPU_WORKAROUND_2_FLAG_SHIFT,#1'
> 
> Related commit:
> arm64: KVM: Handle guest's ARCH_WORKAROUND_2 requests
> 
> Toolchain: gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu
> Kernel config: arm64/defconfig

Thanks for reporting this.

I can hit this as well. It looks like an #ifndef __ASSEMBLY__ in the
wrong place in arch/arm64/include/asm/kvm_asm.h. I can't tell whether it
was caused by a merge conflict resolution or just some unfortunate
interaction between the security fixes going via the arm64 tree and the
other arm64 KVM patches.

I'll have a proper look tomorrow.

-- 
Catalin
