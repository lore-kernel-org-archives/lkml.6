Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeCIMtp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:49:45 -0500
Received: from foss.arm.com ([217.140.101.70]:51300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbeCIMtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:49:43 -0500
Subject: Re: [PATCH] arm64: defconfig: enable Rockchip io-domain driver
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180308213540.4309-1-enric.balletbo@collabora.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5be003fc-7b86-6d49-278a-1297891212d6@arm.com>
Date: Fri, 9 Mar 2018 12:49:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308213540.4309-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/18 21:35, Enric Balletbo i Serra wrote:
> Heiko Stübner justified pretty well the change in commit e330eb86ba0
> 'ARM: multi_v7_defconfig: enable Rockchip io-domain driver'. This change
> is also needed for arm64 rockchip boards, so, do the same for arm64.
> 
> The io-domain driver is necessary to notify the soc about voltages
> changes happening on supplying regulators. Probably the most important
> user right now is the mmc tuning code, where the soc needs to get
> notified when the voltage is dropped to the 1.8V point.
> 
> As this option is necessary to successfully tune UHS cards etc, it
> should get built in. Otherwise, tunning will fail with,
> 
>     dwmmc_rockchip fe320000.dwmmc: All phases bad!
>     mmc0: tuning execution failed: -5

It also causes ethernet to fail in a rather odd manner if your board 
needs RGMII at <3.3v but you're using firmware which leaves the relevant 
IO domain set inappropriately (I guess the parts expecting to be driven 
by the external phy clock just lock up). Given the several hours I spent 
scratching my head over that one,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Heiko Stübner <heiko@sntech.de>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ba859709c2d4..d65d53b1ff77 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -313,6 +313,8 @@ CONFIG_GPIO_XGENE_SB=y
>   CONFIG_GPIO_PCA953X=y
>   CONFIG_GPIO_PCA953X_IRQ=y
>   CONFIG_GPIO_MAX77620=y
> +CONFIG_POWER_AVS=y
> +CONFIG_ROCKCHIP_IODOMAIN=y
>   CONFIG_POWER_RESET_MSM=y
>   CONFIG_POWER_RESET_XGENE=y
>   CONFIG_POWER_RESET_SYSCON=y
> 
