Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeEFMCN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 08:02:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33087 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbeEFMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 08:02:10 -0400
X-Google-Smtp-Source: AB8JxZoBgva8nmfVwUGk066NpoDLlOVDtV1EfuOXUAs2pdrqbvn/eRjG5RtLUMgYkaabq7j1l4R6lg==
Subject: Re: [PATCH v2 0/4] Restore ULPI USB on Tegra20
To: Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Dietrich <marvin24@gmx.de>
Cc: linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180503225537.20748-1-digetx@gmail.com>
 <1525440829.6296.22.camel@ziswiler.com>
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
Message-ID: <ca6ec165-9d63-69cd-27a1-051c1be9f35a@gmail.com>
Date: Sun, 6 May 2018 15:01:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525440829.6296.22.camel@ziswiler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.05.2018 16:33, Marcel Ziswiler wrote:
> Hi Dmitry
> 
> On Fri, 2018-05-04 at 01:55 +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series of patches fixes ULPI USB on Tegra20. The original
>> problem
>> was reported by Marcel Ziswiler, he found that "ulpi-link" clock was
>> incorrectly set to CDEV2 instead of PLL_P_OUT4. Marcel made a patch
>> that changed the "ulpi-link" clock to PLL_P_OUT4 and that fixed issue
>> with the USB for the devices that have CDEV2 being enabled by
>> bootloader.
>> The patch got into the kernel and later Marc Dietrich found that USB
>> stopped working on the "paz00" Tegra20 board. After a bit of
>> discussion
>> was revealed that PLL_P_OUT4 is the parent clock of the CDEV2 and
>> clock
>> driver was setting CDEV2's parent incorrectly. The parent clock is
>> actually
>> determined by the pinmuxing config of CDEV2 pingroup. This patchset
>> fixes
>> the parent of CDEV2 clock by making Tegra's pinctrl driver a clock
>> provider,
>> providing CDEV1/2 clock muxes (thanks to Peter De Schrijver for the
>> suggestion), and then setting these clock muxes as parents for the
>> CDEV1/2
>> clocks. In the end Marcel's CDEV2->PLL_P_OUT4 change is reverted
>> since CDEV2
>> (aka MCLK2) is the actual clock source for "ulpi-link".
>>
>> Changelog:
>>
>> v2:
>> 	- Added new patch "Add quirk for getting CDEV1/2 clocks",
>> assuring
>> 	  that clk user won't get CDEV1/2 clocks until parent clk muxes
>> 	  are available, i.e. resolves potential issue with CDEV-user
>> driver
>> 	  vs pinctrl driver probe order.
>>
>> 	- Factored out "pinctrl" patch from the patchset as was
>> requested by
>> 	  Linus Walleij.
>>
>> 	- Addressed v1 review comments: fixed swapped DEV1/2 clk div
>> bits,
>> 	  made DEV1/2 divs read-only, etc minor changes.
>>
>> Dmitry Osipenko (4):
>>   clk: tegra20: Add DEV1/DEV2 OSC dividers
>>   clk: tegra20: Correct parents of CDEV1/2 clocks
>>   clk: tegra: Add quirk for getting CDEV1/2 clocks
>>   ARM: dts: tegra20: Revert "Fix ULPI regression on Tegra20"
>>
>>  arch/arm/boot/dts/tegra20.dtsi  |  2 +-
>>  drivers/clk/tegra/clk-tegra20.c | 20 +++++++++++++++----
>>  drivers/clk/tegra/clk.c         | 34
>> ++++++++++++++++++++++++++++++++-
>>  3 files changed, 50 insertions(+), 6 deletions(-)
> 
> Beautiful (;-p).
> 
> root@colibri-t20:~# cat /sys/kernel/debug/clk/clk_summary | grep -E
> 'pll_p_out4|cdev2'
>           pll_p_out4_div              1        1        0    24000000  
>         0 0  
>              pll_p_out4               2        2        0    24000000  
>         0 0  
>                 cdev2_mux             1        1        0    24000000  
>         0 0  
>                    cdev2              1        1        0    24000000  
>         0 0  
> 
> You may add my reviewed and tested bys to the remaining patches as
> well.
> 
> Thanks!
Awesome, thank you!
