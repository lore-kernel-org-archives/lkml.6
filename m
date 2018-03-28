Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeC1Lxw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:53:52 -0400
Received: from foss.arm.com ([217.140.101.70]:39788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752762AbeC1Lxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:53:48 -0400
Date: Wed, 28 Mar 2018 12:53:59 +0100
From: Will Deacon <will.deacon@arm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Dave Martin <dave.martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20180328115358.GC30850@arm.com>
References: <20180328160034.61e0e588@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328160034.61e0e588@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Mar 28, 2018 at 04:00:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-arm tree got a conflict in:
> 
>   arch/arm64/kernel/cpu_errata.c
> 
> between commit:
> 
>   c0cda3b8ee6b ("arm64: capabilities: Update prototype for enable call back")
>   followed by a series of patches cleaning up capabilities
> 
> from the arm64 tree and commits:
> 
>   4b472ffd1513 ("arm64: Enable ARM64_HARDEN_EL2_VECTORS on Cortex-A57 and A72")
>   f9f5dc19509b ("arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hardening")
> 
> from the kvm-arm tree.
> 
> I fixed it up (maybe, please check the result and see below) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

This is a really grotty conflict, so Marc and I have decided to revert
f9f5dc19509b ("arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hardening")
from kvm-arm for now. There's a little hack necessary to keep things
building after that, but we can clean that up at -rc1.

Shanker -- I'm still aiming to get your patch into 4.17, either during the
second half of the merge window or at -rc1.

Cheers,

Will
