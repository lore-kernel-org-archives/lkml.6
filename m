Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758772AbeBPRCr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:02:47 -0500
Received: from foss.arm.com ([217.140.101.70]:42012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755857AbeBPRCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:02:45 -0500
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix misplaced __iomem annotations
To: Robin Murphy <robin.murphy@arm.com>, tglx@linutronix.de,
        jason@lakedaemon.net
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <af3a8a44f6693f6293de49a1c2910a57ba12e208.1518800276.git.robin.murphy@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <221594bd-313d-9b62-e0b3-abe1f5adbf8a@arm.com>
Date: Fri, 16 Feb 2018 17:02:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <af3a8a44f6693f6293de49a1c2910a57ba12e208.1518800276.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/18 16:57, Robin Murphy wrote:
> Save 26 lines worth of Sparse complaints by fixing up this minor
> mishap. The pointee lies in the __iomem space; the pointer does not.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 06f025fd5726..3a38b4e8685e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2495,7 +2495,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
>  
>  static void its_vpe_schedule(struct its_vpe *vpe)
>  {
> -	void * __iomem vlpi_base = gic_data_rdist_vlpi_base();
> +	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
>  	u64 val;
>  
>  	/* Schedule the VPE */
> @@ -2527,7 +2527,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
>  
>  static void its_vpe_deschedule(struct its_vpe *vpe)
>  {
> -	void * __iomem vlpi_base = gic_data_rdist_vlpi_base();
> +	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
>  	u32 count = 1000000;	/* 1s! */
>  	bool clean;
>  	u64 val;
> 

Ah! Too bad you missed the pull request by a few hours... I'll stash
that for -rc3.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
