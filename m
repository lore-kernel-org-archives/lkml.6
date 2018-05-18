Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbeERCH4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 22:07:56 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44957 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeERCHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 22:07:54 -0400
X-Google-Smtp-Source: AB8JxZoryqmjSvFi6f6BqvUFrPPaeOTdNBaxMeRAw0f+aV1YE6K89t4vep8ykAXEh3aoKIJmguj+jw==
Date: Fri, 18 May 2018 07:37:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 11/11] ARM: tegra: Create platform device for
 tegra20-cpufreq driver
Message-ID: <20180518020751.og5ov7lfrplj5dqo@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-12-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Tegra20-cpufreq driver require a platform device in order to be loaded,
> instantiate a simple platform device for the driver during of the machines
> late initialization.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/tegra.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> index 02e712d2ea30..f9587be48235 100644
> --- a/arch/arm/mach-tegra/tegra.c
> +++ b/arch/arm/mach-tegra/tegra.c
> @@ -97,6 +97,10 @@ static void __init tegra_dt_init_late(void)
>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>  	    of_machine_is_compatible("compal,paz00"))
>  		tegra_paz00_wifikill_init();
> +
> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
> +	    of_machine_is_compatible("nvidia,tegra20"))
> +		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>  }
>  
>  static const char * const tegra_dt_board_compat[] = {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
