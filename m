Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeEWJat (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:30:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33633 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbeEWJan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:30:43 -0400
X-Google-Smtp-Source: AB8JxZr6ogLzKZhHOf4CyRRAMIX9rmSIMnrSyaYPKR7NvnqYTSeKhH+Ek6uGYvO7W1COW+SpbNPfcw==
Subject: Re: [PATCH v1] cpufreq: tegra20: Fix imbalanced clock enable count
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180522211420.2006-1-digetx@gmail.com>
 <20180523055817.subrv6oeckfecpcp@vireshk-i7>
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
Message-ID: <db300fa3-ae83-059f-eae0-0808c3cb33fb@gmail.com>
Date: Wed, 23 May 2018 12:30:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523055817.subrv6oeckfecpcp@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2018 08:58, Viresh Kumar wrote:
> On 23-05-18, 00:14, Dmitry Osipenko wrote:
>> Tegra20-cpufreq driver missed enabling the CPU clocks. This results in a
>> clock-enable refcount disbalance on PLL_P <-> PLL_X reparent, causing
>> PLL_X to get disabled while it shouldn't. Fix this by enabling the clocks
>> on the driver probe.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> CPUFreq maintainers,
>>
>> Please take into account that this patch is made on top of my recent
>> series of patches [0] "Clean up Tegra20 cpufreq driver" that was fully
>> reviewed, but seems not applied yet. Let me know if you prefer to re-spin
>> the [0], including this patch into the series.
>>
>> [0] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=45321
> 
> This is already picked by Rafael and is sitting in pm/bleeding-edge
> branch. Should get merged into linux-next in a day or two.

Neat, thank you for letting me know.

>>  drivers/cpufreq/tegra20-cpufreq.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
>> index 05f57dcd5215..ca5229265b60 100644
>> --- a/drivers/cpufreq/tegra20-cpufreq.c
>> +++ b/drivers/cpufreq/tegra20-cpufreq.c
>> @@ -176,6 +176,14 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>>  		goto put_pll_x;
>>  	}
>>  
>> +	err = clk_prepare_enable(cpufreq->pll_x_clk);
>> +	if (err)
>> +		goto put_pll_p;
>> +
>> +	err = clk_prepare_enable(cpufreq->pll_p_clk);
>> +	if (err)
>> +		goto disable_pll_x;
>> +
>>  	cpufreq->dev = &pdev->dev;
>>  	cpufreq->driver.get = cpufreq_generic_get;
>>  	cpufreq->driver.attr = cpufreq_generic_attr;
>> @@ -192,12 +200,16 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
>>  
>>  	err = cpufreq_register_driver(&cpufreq->driver);
>>  	if (err)
>> -		goto put_pll_p;
>> +		goto disable_pll_p;
>>  
>>  	platform_set_drvdata(pdev, cpufreq);
>>  
>>  	return 0;
>>  
>> +disable_pll_p:
>> +	clk_disable_unprepare(cpufreq->pll_p_clk);
>> +disable_pll_x:
>> +	clk_disable_unprepare(cpufreq->pll_x_clk);
>>  put_pll_p:
>>  	clk_put(cpufreq->pll_p_clk);
>>  put_pll_x:
>> @@ -214,6 +226,8 @@ static int tegra20_cpufreq_remove(struct platform_device *pdev)
>>  
>>  	cpufreq_unregister_driver(&cpufreq->driver);
>>  
>> +	clk_disable_unprepare(cpufreq->pll_p_clk);
>> +	clk_disable_unprepare(cpufreq->pll_x_clk);
>>  	clk_put(cpufreq->pll_p_clk);
>>  	clk_put(cpufreq->pll_x_clk);
>>  	clk_put(cpufreq->cpu_clk);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
