Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeFEPuy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:50:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57758 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751652AbeFEPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:50:53 -0400
Date: Tue, 5 Jun 2018 16:50:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Martin <dave.martin@arm.com>,
        Shanker Donthineni <shankerd@codeaurora.org>
Subject: Re: [PATCH] arm64: cpu_errata: include required headers
Message-ID: <20180605155048.zz6zjxpmyeoliflj@armageddon.cambridge.arm.com>
References: <20180605115227.1621618-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605115227.1621618-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 01:50:07PM +0200, Arnd Bergmann wrote:
> Without including psci.h and arm-smccc.h, we now get a build failure in
> some configurations:
> 
> arch/arm64/kernel/cpu_errata.c: In function 'arm64_update_smccc_conduit':
> arch/arm64/kernel/cpu_errata.c:278:10: error: 'psci_ops' undeclared (first use in this function); did you mean 'sysfs_ops'?
> 
> arch/arm64/kernel/cpu_errata.c: In function 'arm64_set_ssbd_mitigation':
> arch/arm64/kernel/cpu_errata.c:311:3: error: implicit declaration of function 'arm_smccc_1_1_hvc' [-Werror=implicit-function-declaration]
>    arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This showed up only recently, but I have not bisected what caused it.

I haven't hit it yet, not sure why. I'm queuing the patch anyway.
Thanks.

-- 
Catalin
