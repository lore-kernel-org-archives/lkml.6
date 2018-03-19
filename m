Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934846AbeCSQAY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:00:24 -0400
Received: from vern.gendns.com ([206.190.152.46]:39518 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934790AbeCSP7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:46 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v8_00/42]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-clk@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Adam Ford <aford173@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <CAMpxmJX-AxhpPpCnWoaSGYmNh3o8iRjdKacnmozsPWmhpcGdTg@mail.gmail.com>
From: David Lechner <david@lechnology.com>
Message-ID: <af89be8d-04dd-e845-1d5b-afdd7e55629f@lechnology.com>
Date: Mon, 19 Mar 2018 10:59:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJX-AxhpPpCnWoaSGYmNh3o8iRjdKacnmozsPWmhpcGdTg@mail.gmail.com>
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

On 03/19/2018 08:17 AM, Bartosz Golaszewski wrote:
> 2018-03-16 3:52 GMT+01:00 David Lechner <david@lechnology.com>:
>> This series converts mach-davinci to use the common clock framework.
>>
>> The series works like this, the first 19 patches create new clock drivers
>> using the common clock framework. There are basically 3 groups of clocks -
>> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
>> unique init data, which is the reason for so many patches.
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
>> The final three patches add device tree clock support to the one SoC that
>> supports it.
>>
>> This series has been tested on LEGO MINDSTORMS EV3 (device tree) and TI
>> OMAP-L138 LCDK (both device tree and legacy board file).
>>
> 
> Hi David,
> 
> thanks, with the u-boot fix everything seems to work fine. I tested
> da850-lcdk and da850-evm boards in DT and board file modes.
> 
> I'll be working with this series in the following days and will do
> some thorough testing and rebase my aemif series on top of it. I'll
> also use the recently merged reset support for board files to get rid
> of the exported reset functions.
> 
> Thanks for your work!
> 
> Best regards,
> Bartosz Golaszewski
> 

Sounds like a good plan to me. FYI, I've started a common-clk-v9 branch
on my GitHub already with a few minor fixes.
