Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934036AbeE2MUE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:20:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42546 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934008AbeE2MTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:19:52 -0400
X-Google-Smtp-Source: ADUXVKIElF+mQlYQocilmxNPBEESNHEJ0cTV7f57xBcc7iHUb+5qxbAsDfezdLbDcoVLX3teQZRMIQ==
Subject: Re: [PATCH v2 4/6] clk: tegra20: init NDFLASH clock to sensible rate
To: Stefan Agner <stefan@agner.ch>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20180527215442.14760-5-stefan@agner.ch>
 <20180528075510.GQ6835@tbergstrom-lnx.Nvidia.com>
 <5665b799f763daa82dced238fb494863@agner.ch>
 <20180529074804.GA6708@tbergstrom-lnx.Nvidia.com>
 <90180dd9fc6e60175c54b9d70e50f0e5@agner.ch>
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
Message-ID: <04cdfdf5-33c5-b569-9cd7-dda1b9ea0baf@gmail.com>
Date: Tue, 29 May 2018 15:19:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <90180dd9fc6e60175c54b9d70e50f0e5@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.2018 15:12, Stefan Agner wrote:
> On 29.05.2018 09:48, Peter De Schrijver wrote:
>> On Mon, May 28, 2018 at 05:53:08PM +0200, Stefan Agner wrote:
>>> On 28.05.2018 09:55, Peter De Schrijver wrote:
>>>> On Sun, May 27, 2018 at 11:54:40PM +0200, Stefan Agner wrote:
>>>>> From: Lucas Stach <dev@lynxeye.de>
>>>>>
>>>>> Set up the NAND Flash controller clock to run at 150MHz
>>>>> instead of the rate set by the bootloader. This is a
>>>>> conservative rate which also yields good performance.
>>>>>
>>>>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>>> ---
>>>>>  drivers/clk/tegra/clk-tegra20.c | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
>>>>> index 0ee56dd04cec..dff8c425cd28 100644
>>>>> --- a/drivers/clk/tegra/clk-tegra20.c
>>>>> +++ b/drivers/clk/tegra/clk-tegra20.c
>>>>> @@ -1049,6 +1049,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
>>>>>  	{ TEGRA20_CLK_GR2D, TEGRA20_CLK_PLL_C, 300000000, 0 },
>>>>>  	{ TEGRA20_CLK_GR3D, TEGRA20_CLK_PLL_C, 300000000, 0 },
>>>>>  	{ TEGRA20_CLK_VDE, TEGRA20_CLK_CLK_MAX, 300000000, 0 },
>>>>> +	{ TEGRA20_CLK_NDFLASH, TEGRA20_CLK_PLL_P, 150000000, 0 },
>>>>>  	/* must be the last entry */
>>>>>  	{ TEGRA20_CLK_CLK_MAX, TEGRA20_CLK_CLK_MAX, 0, 0 },
>>>>>  };
>>>>> --
>>>>> 2.17.0
>>>>>
>>>>
>>>> Maybe better to specify this in the Tegra20 dtsi? See
>>>> "Assigned clock parents and rates" in
>>>> Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>
>>> assigned-clocks indeed works just fine for this case. Thanks for
>>> bringing this up, will drop this patch and add the device tree
>>> properties in v3.
>>>
>>> Hm, interesting that none of the Tegra device tree make use of the
>>> feature so far. I guess there would be other cases where this would be
>>> useful as well (the one just above, VDE?).
>>>
>>
>> Yes, historically this feature wasn't available, so we used these init tables.
>> Unfortunately it's not easy to get rid of them for parent and rate
>> configuration, because new kernels should also work with existing DTBs, so we
>> can't just add assigned-clock properties and remove the existing table
>> entries. What we could do is use the CLK_IS_CRITICAL flag for all clocks which
>> are only enabled by the init table. For not yet merged blocks, this is
>> ofcourse not a concern.
> 
> Sure I understand.
> 
> Was just somewhat surprised that it isn't used at all yet (grep -r -e
> assigned-clock arch/arm/boot/dts/tegra* returns nothing). After all,
> assigned clocks bindings have been merged in 2014 :-)
> 
> At least "clk: tegra: Specify VDE clock rate" merged earlier this year
> would have been a candidate already.

I wasn't even aware of existence of the assigned-clock properties, probably just
like others.
