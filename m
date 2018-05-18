Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbeERJT2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:19:28 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42819 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeERJTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:19:24 -0400
X-Google-Smtp-Source: AB8JxZoswDiczvODAQsk1cYi/uVpEElg8xALrg1H6xEVRuTGBPgP/V/kNCMW+SIbQhTUuDOztxeU3Q==
Subject: Re: [PATCH v1 10/11] cpufreq: tegra20: Wrap cpufreq into platform
 driver
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-11-digetx@gmail.com> <20180518090755.GJ14500@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <4ed2535c-651a-2bb1-c9bc-0550bca3d292@gmail.com>
Date: Fri, 18 May 2018 12:19:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518090755.GJ14500@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2018 12:07, Thierry Reding wrote:
> On Thu, May 17, 2018 at 09:00:55PM +0300, Dmitry Osipenko wrote:
>> Currently tegra20-cpufreq kernel module isn't getting autoloaded because
>> there is no device associated with the module, this is one of two patches
>> that resolves the module autoloading. This patch adds a module alias that
>> will associate the tegra20-cpufreq kernel module with the platform device,
>> other patch will instantiate the actual platform device. And now it makes
>> sense to wrap cpufreq driver into a platform driver for consistency.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/cpufreq/tegra20-cpufreq.c | 116 +++++++++++++++++++-----------
>>  1 file changed, 73 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
>> index c0a7b5a78aa6..f9d02a28df9e 100644
>> --- a/drivers/cpufreq/tegra20-cpufreq.c
>> +++ b/drivers/cpufreq/tegra20-cpufreq.c
>> @@ -19,7 +19,7 @@
>>  #include <linux/clk.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/module.h>
>> -#include <linux/of.h>
>> +#include <linux/platform_device.h>
>>  
>>  static struct cpufreq_frequency_table freq_table[] = {
>>  	{ .frequency = 216000 },
>> @@ -33,15 +33,19 @@ static struct cpufreq_frequency_table freq_table[] = {
>>  	{ .frequency = CPUFREQ_TABLE_END },
>>  };
>>  
>> -static struct clk *cpu_clk;
>> -static struct clk *pll_x_clk;
>> -static struct clk *pll_p_clk;
>> -static bool pll_x_prepared;
>> +struct tegra20_cpufreq_data {
> 
> Nit: I'm not a big fan of _data suffixes because they are completely
> redundant. Any data structure by definition hosts data, so I'd just drop
> that.

Okay, I'll drop it in v2.

> [...]
>> @@ -152,55 +161,76 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
>>  	.suspend		= cpufreq_generic_suspend,
>>  };
>>  
>> -static int __init tegra_cpufreq_init(void)
>> +static int tegra20_cpufreq_probe(struct platform_device *pdev)
>>  {
>> +	struct tegra20_cpufreq_data *data;
>>  	int err;
>>  
>> -	if (!of_machine_is_compatible("nvidia,tegra20"))
>> -		return -ENODEV;
>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>>  
>> -	cpu_clk = clk_get_sys(NULL, "cclk");
>> -	if (IS_ERR(cpu_clk))
>> -		return PTR_ERR(cpu_clk);
>> +	data->cpu_clk = clk_get_sys(NULL, "cclk");
>> +	if (IS_ERR(data->cpu_clk))
>> +		return PTR_ERR(data->cpu_clk);
>>  
>> -	pll_x_clk = clk_get_sys(NULL, "pll_x");
>> -	if (IS_ERR(pll_x_clk)) {
>> -		err = PTR_ERR(pll_x_clk);
>> +	data->pll_x_clk = clk_get_sys(NULL, "pll_x");
>> +	if (IS_ERR(data->pll_x_clk)) {
>> +		err = PTR_ERR(data->pll_x_clk);
>>  		goto put_cpu;
>>  	}
>>  
>> -	pll_p_clk = clk_get_sys(NULL, "pll_p");
>> -	if (IS_ERR(pll_p_clk)) {
>> -		err = PTR_ERR(pll_p_clk);
>> +	data->pll_p_clk = clk_get_sys(NULL, "pll_p");
>> +	if (IS_ERR(data->pll_p_clk)) {
>> +		err = PTR_ERR(data->pll_p_clk);
>>  		goto put_pll_x;
>>  	}
>>  
>> +	data->dev = &pdev->dev;
>> +
>> +	tegra_cpufreq_driver.driver_data = data;
> 
> Couldn't this be embedded into struct tegra20_cpufreq_data? Moving
> everything but this into a per-device data structure seems half-baked.

That's a good suggestions, thank you.
