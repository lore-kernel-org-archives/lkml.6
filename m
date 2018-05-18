Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeERB7m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:59:42 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32790 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeERB7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:59:40 -0400
X-Google-Smtp-Source: AB8JxZovMaIDtGS90i944FM+CWhYLn+fBX6Y10XQgtIvUsMEfAqtR3+RVlS2fDL5BOPDouoBuAfUeQ==
Date: Fri, 18 May 2018 07:29:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 07/11] cpufreq: tegra20: Check if this is Tegra20
 machine
Message-ID: <20180518015937.kcu3ltv3kb3nvoli@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-8-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Don't even try to request the clocks during of module initialization on
> non-Tegra20 machines (this is the case for a multi-platform kernel) for
> consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 147ae3e14f18..797c61c74b65 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  
>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ .frequency = 216000 },
> @@ -155,6 +156,9 @@ static int __init tegra_cpufreq_init(void)
>  {
>  	int err;
>  
> +	if (!of_machine_is_compatible("nvidia,tegra20"))
> +		return -ENODEV;
> +
>  	cpu_clk = clk_get_sys(NULL, "cclk");
>  	if (IS_ERR(cpu_clk))
>  		return PTR_ERR(cpu_clk);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
