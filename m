Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeEVQJK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:09:10 -0400
Received: from foss.arm.com ([217.140.101.70]:40886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeEVQJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:09:09 -0400
Date: Tue, 22 May 2018 17:08:57 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: John Garry <john.garry@huawei.com>
Cc: will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] drivers/perf: Remove ARM_SPE_PMU explicit PERF_EVENTS
 dependency
Message-ID: <20180522160857.43a4ktp65inpotfr@lakrids.cambridge.arm.com>
References: <1527004444-239462-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527004444-239462-1-git-send-email-john.garry@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:54:04PM +0800, John Garry wrote:
> Since commit bddb9b68d3fb ("drivers/perf: commonise PERF_EVENTS
> dependency"), all perf drivers depend on PERF_EVENTS config under a
> common menu.
> 
> Config ARM_SPE_PMU still declares explicitly a dependency on
> PERF_EVENTS, which is unneeded, so remove it.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Will, I assume that you will queue this.

Mark.

> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 28bb5a0..90ce4da 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -94,7 +94,7 @@ config XGENE_PMU
>  
>  config ARM_SPE_PMU
>  	tristate "Enable support for the ARMv8.2 Statistical Profiling Extension"
> -	depends on PERF_EVENTS && ARM64
> +	depends on ARM64
>  	help
>  	  Enable perf support for the ARMv8.2 Statistical Profiling
>  	  Extension, which provides periodic sampling of operations in
> -- 
> 1.9.1
> 
