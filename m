Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeDZHY6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:24:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48114 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752964AbeDZHYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:24:55 -0400
Date: Thu, 26 Apr 2018 08:25:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Rohit Khanna <rokhanna@nvidia.com>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>, Bo Yan <byan@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH] arm64: skip cpu nodes marked as disabled in DT
Message-ID: <20180426072514.GA33476@MBP.local>
References: <1524697712-20208-1-git-send-email-rokhanna@nvidia.com>
 <1524699380207.85374@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524699380207.85374@nvidia.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 11:36:06PM +0000, Rohit Khanna wrote:
> Adding few other folks.

It looks fine to me but cc'ing Mark and Lorenzo (and it should have been
posted on linux-arm-kernel@lists.infradead.org).

> From: Rohit Khanna
> Sent: Wednesday, April 25, 2018 4:08 PM
> To: catalin.marinas@arm.com; will.deacon@arm.com
> Cc: linux-kernel@vger.kernel.org; Rohit Khanna
> Subject: [PATCH] arm64: skip cpu nodes marked as disabled in DT
> 
> Skip the CPU nodes that are marked as disabled in DT.
> 
> Bug 1828570
> 
> Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
> Reviewed-on: http://git-master/r/1245333
> Reviewed-by: Alexander Van Brunt <avanbrunt@nvidia.com>
> ---
>  arch/arm64/kernel/smp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index f3e2e3aec0b0..2b4371b0948d 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -578,6 +578,10 @@ static void __init of_parse_and_init_cpus(void)
>         for_each_node_by_type(dn, "cpu") {
>                 u64 hwid = of_get_cpu_mpidr(dn);
> 
> +               /* Check to see if the cpu is disabled */
> +               if (!of_device_is_available(dn))
> +                       goto next;
> +
>                 if (hwid == INVALID_HWID)
>                         goto next;
> 
> --
> 2.1.4
