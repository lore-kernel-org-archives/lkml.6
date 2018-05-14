Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeENBuK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 21:50:10 -0400
Received: from vern.gendns.com ([206.190.152.46]:33771 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbeENBuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 21:50:08 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v10_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
To: Adam Ford <aford173@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180509172606.29387-1-david@lechnology.com>
 <CAHCN7xJ6+vmyrTQGYH=pKz5GRf7rLT4otreNgu6TJi_3UAEX5w@mail.gmail.com>
From: David Lechner <david@lechnology.com>
Message-ID: <ba7da252-20be-590b-74fb-0ca4a04beba7@lechnology.com>
Date: Sun, 13 May 2018 20:50:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7xJ6+vmyrTQGYH=pKz5GRf7rLT4otreNgu6TJi_3UAEX5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/2018 07:40 PM, Adam Ford wrote:
> On Wed, May 9, 2018 at 12:25 PM, David Lechner <david@lechnology.com> wrote:
>> This series converts mach-davinci to use the common clock framework.
>>
>> The series works like this, the first 3 patches fix some issues with the clock
>> drivers that have already been accepted into the mainline kernel.
>>
>> Then, starting with "ARM: davinci: pass clock as parameter to
>> davinci_timer_init()", we get the mach code ready for the switch by adding the
>> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
>> around the legacy clocks so that we can switch easily between the old and the
>> new.
>>
>> "ARM: davinci: switch to common clock framework" actually flips the switch
>> to start using the new clock drivers. Then the next 8 patches remove all
>> of the old clock code.
>>
>> The final four patches add device tree clock support to the one SoC that
>> supports it.
>>
>> This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
>> board file).
>>
> 
> I am not sure if I did something wrong, but I attempted to build and I
> wasn't able to boot the da850-evm.dtb your repo common-clk-v11,
> however the legacy board file boot was OK.
> 
> make davinci_all_defconfig ARCH=arm
> make zImage modules da850-evm.dtb ARCH=arm CROSS_COMPILE=arm-linux- -j8
> 
> 3140416 bytes read in 1464 ms (2 MiB/s)
> 20353 bytes read in 15 ms (1.3 MiB/s)
> ## Flattened Device Tree blob at c0600000
>     Booting using the fdt blob at 0xc0600000
>     Loading Device Tree to c7e57000, end c7e5ef80 ... OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> 
> (and hang)
> 
> If you have some suggestions, I am try them as I get time.
> 

As with each revision of this series, I have included debugging tips
in the cover letter, e.g. earlyprink and not disabling unused clocks.
