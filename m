Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeBVO7n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:59:43 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:33759 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753858AbeBVO7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:59:42 -0500
Subject: Re: [PATCH] cpufreq: tegra186: Break after initialization is done for
 policy->cpu
To: Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <77d470741dab32c2076a35253b9c0c2f0136583b.1519293292.git.viresh.kumar@linaro.org>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <f8bf4df3-6bf4-dc01-4445-33abec1ad6f9@kapsi.fi>
Date: Thu, 22 Feb 2018 16:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <77d470741dab32c2076a35253b9c0c2f0136583b.1519293292.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.248.219.42
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 11:54 AM, Viresh Kumar wrote:
> There are two clusters (2 + 4 CPUs) on this platform and a separate
> cpufreq policy is available for each of the CPUs. The loop in
> tegra186_cpufreq_init() tries to find the structure for the right CPU
> and finish initialization. But it is missing a `break` statement at the
> end, which forces it to restart the loop even when the CPU already
> matched and initialization is done.
> 
> Fix that by adding the missing `break` statement.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/tegra186-cpufreq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index fe7875311d62..771df649ceb9 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -79,6 +79,7 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
>   		policy->driver_data =
>   			data->regs + info->offset + EDVD_CORE_VOLT_FREQ(core);
>   		cpufreq_table_validate_and_show(policy, cluster->table);
> +		break;
>   	}
>   
>   	policy->cpuinfo.transition_latency = 300 * 1000;
> 

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
