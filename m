Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeEGSco (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:32:44 -0400
Received: from vern.gendns.com ([206.190.152.46]:48861 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeEGScn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:32:43 -0400
Subject: Re: [PATCH v2 1/2] clk: davinci: pll-dm355: fix SYSCLKn parent names
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org
References: <20180507144307.32364-1-david@lechnology.com>
 <5805f462-0cb5-3024-f5af-941db8a46895@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <f41e762d-273a-9e8a-579a-f43e90260020@lechnology.com>
Date: Mon, 7 May 2018 13:32:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5805f462-0cb5-3024-f5af-941db8a46895@ti.com>
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



On 5/7/18 10:21 AM, Sekhar Nori wrote:
> On Monday 07 May 2018 08:13 PM, David Lechner wrote:
>> This fixes the parent clock names of the SYSCLKn clocks for the DM355
>> SoC in the TI DaVinici PLL clock driver.
>>
>> It appears that this name just didn't get updated to the correct name
>> like the other SoCs during the driver's development.
>>
>> Reported-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v2 changes:
>> - add second patch to fix additional problems with DM355
>>
>>   drivers/clk/davinci/pll-dm355.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
>> index 5345f8286c50..1f746d2fc894 100644
>> --- a/drivers/clk/davinci/pll-dm355.c
>> +++ b/drivers/clk/davinci/pll-dm355.c
>> @@ -22,10 +22,10 @@ static const struct davinci_pll_clk_info dm355_pll1_info = {
>>   		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
>>   };
>>   
>> -SYSCLK(1, pll1_sysclk1, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> -SYSCLK(2, pll1_sysclk2, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> -SYSCLK(3, pll1_sysclk3, pll1, 5, SYSCLK_ALWAYS_ENABLED);
>> -SYSCLK(4, pll1_sysclk4, pll1, 5, SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
>>   
>>   int dm355_pll1_init(struct device *dev, void __iomem *base)
>>   {
>> @@ -62,8 +62,8 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
>>   		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
>>   };
>>   
>> -SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV);
>> -SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
>> +SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_FIXED_DIV);
>> +SYSCLK(2, pll2_sysclk2, pll2_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
> 
> Good find with PLL2 SYSCLK2. Can you reverse the patch order so we are
> not fixing up a non-existent clock?
> 

Sure. But it will take me a couple days to get back to it.
