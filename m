Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeCUPWc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:22:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752200AbeCUPWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:22:31 -0400
Date: Wed, 21 Mar 2018 15:22:27 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        ckadabi@codeaurora.org, ard.biesheuvel@linaro.org,
        marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jnair@caviumnetworks.com,
        robin.murphy@arm.com, shankerd@codeaurora.org
Subject: Re: [PATCH v4 21/22] arm64: Delay enabling hardware DBM feature
Message-ID: <20180321152226.GD16308@e103592.cambridge.arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-22-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313115120.17256-22-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:51:19AM +0000, Suzuki K Poulose wrote:
> We enable hardware DBM bit in a capable CPU, very early in the
> boot via __cpu_setup. This doesn't give us a flexibility of
> optionally disable the feature, as the clearing the bit
> is a bit costly as the TLB can cache the settings. Instead,
> we delay enabling the feature until the CPU is brought up
> into the kernel. We use the feature capability mechanism
> to handle it.
> 
> The hardware DBM is a non-conflicting feature. i.e, the kernel
> can safely run with a mix of CPUs with some using the feature
> and the others don't. So, it is safe for a late CPU to have
> this capability and enable it, even if the active CPUs don't.
> 
> To get this handled properly by the infrastructure, we
> unconditionally set the capability and only enable it
> on CPUs which really have the feature. Also, we print the
> feature detection from the "matches" call back to make sure
> we don't mislead the user when none of the CPUs could use the
> feature.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

[...]

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
