Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeERB7W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:59:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40279 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeERB7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:59:19 -0400
X-Google-Smtp-Source: AB8JxZp/4eUV3705F418rWhORVH5s8jwbF/IbZh5bygXc099j+FWKkoRoiE17Bmv5DeUeAHNFqCh3A==
Date: Fri, 18 May 2018 07:29:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 06/11] cpufreq: tegra20: Remove unneeded check in
 tegra_cpu_init
Message-ID: <20180518015916.u3i6ts4hwqbws6ma@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-7-digetx@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Remove checking of the CPU number for consistency as it won't ever fail
> unless there is a severe bug in the cpufreq core.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 61f00d1cba26..147ae3e14f18 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -32,8 +32,6 @@ static struct cpufreq_frequency_table freq_table[] = {
>  	{ .frequency = CPUFREQ_TABLE_END },
>  };
>  
> -#define NUM_CPUS	2
> -
>  static struct clk *cpu_clk;
>  static struct clk *pll_x_clk;
>  static struct clk *pll_p_clk;
> @@ -119,9 +117,6 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int ret;
>  
> -	if (policy->cpu >= NUM_CPUS)
> -		return -EINVAL;
> -
>  	clk_prepare_enable(cpu_clk);
>  
>  	/* FIXME: what's the actual transition time? */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
