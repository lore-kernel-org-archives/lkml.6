Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbeEVUqn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:46:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33884 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeEVUql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:46:41 -0400
X-Google-Smtp-Source: AB8JxZrhWFzIxcD5SAmBOFOIgPV/nocJP9apV15wGR4f/0m/IWH1C8IF7CGj7LlGD+qsh7njWUt/kA==
Subject: Re: [PATCH] clk/driver/hisi: Consolidate the Kconfig for the
 CLOCK_STUB
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com
Cc: leo.yan@linaro.org, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <1527021018-31698-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <8fd2b13f-bd72-20bf-1745-878dc23969ef@linaro.org>
Date: Tue, 22 May 2018 22:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527021018-31698-1-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2018 22:30, Daniel Lezcano wrote:
> The current defconfig is inconsistent as it selects the mailbox and
> the clock for the hi6220 and the hi3660 without having their Kconfigs
> making sure the dependencies are correct. It ends up when selecting
> different versions for the kernel (for example when git bisecting)
> those options disappear and they don't get back, leading to unexpected
> behaviors. In our case, the cpufreq driver does no longer work because
> the clock fails to initialize due to the clock stub and the mailbox
> missing.
> 
> In order to have the dependencies correctly set when defaulting, let's
> do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
> automatically") where we select automatically the driver when the
> parent driver is selected. With sensible defaults in place, we can leave
> other choices for EXPERT.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
> 
> Split the patch into the clk specific and resent as requested by Olof
> Johansson.
> ---
>  arch/arm64/configs/defconfig  |  1 -
>  drivers/clk/hisilicon/Kconfig | 13 ++++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ecf6137..1d9d8b9 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -549,7 +549,6 @@ CONFIG_HWSPINLOCK_QCOM=y
>  CONFIG_ARM_MHU=y
>  CONFIG_PLATFORM_MHU=y
>  CONFIG_BCM2835_MBOX=y
> -CONFIG_HI6220_MBOX=y
>  CONFIG_QCOM_APCS_IPC=y
>  CONFIG_ROCKCHIP_IOMMU=y
>  CONFIG_TEGRA_IOMMU_SMMU=y

Oups, sorry I missed to remove this change. Resending a V2.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
