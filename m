Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeDXJIo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:08:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753256AbeDXJIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:08:37 -0400
Date: Tue, 24 Apr 2018 10:08:35 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Alison Wang <alison.wang@nxp.com>
Cc: airlied@linux.ie, brian.starkey@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: mali-dp: Enable Global SE interrupts mask for DP500
Message-ID: <20180424090835.GH14661@e110455-lin.cambridge.arm.com>
References: <20180424024232.37687-1-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180424024232.37687-1-alison.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 10:42:32AM +0800, Alison Wang wrote:
> In the situation that DE and SE aren’t shared the same interrupt number,
> the Global SE interrupts mask bit MASK_IRQ_EN in MASKIRQ must be set, or
> else other mask bits will not work and no SE interrupt will occur. This
> patch enables MASK_IRQ_EN for SE to fix this problem.
> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for catching this! I'll pull the patch into the mali-dp tree.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/malidp_hw.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index d789b46..069783e 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -634,7 +634,8 @@ static int malidp650_query_hw(struct malidp_hw_device *hwdev)
>  				.vsync_irq = MALIDP500_DE_IRQ_VSYNC,
>  			},
>  			.se_irq_map = {
> -				.irq_mask = MALIDP500_SE_IRQ_CONF_MODE,
> +				.irq_mask = MALIDP500_SE_IRQ_CONF_MODE |
> +					    MALIDP500_SE_IRQ_GLOBAL,
>  				.vsync_irq = 0,
>  			},
>  			.dc_irq_map = {
> -- 
> 1.7.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
