Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeDMGQ3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 02:16:29 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:30553 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDMGQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 02:16:27 -0400
Subject: Re: [PATCH 08/14] ARM: OMAP2: Add functions to save and restore
 pinctrl context.
To: Tony Lindgren <tony@atomide.com>
CC: <linus.walleij@linaro.org>, <grygorii.strashko@ti.com>,
        <t-kristo@ti.com>, <Russ.Dill@ti.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ssantosh@kernel.org>,
        <haojian.zhuang@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <d-gerlach@ti.com>, Russ Dill <Russ.Dill@gmail.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-9-git-send-email-j-keerthy@ti.com>
 <20180412141639.GV5700@atomide.com>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <26b80d50-efe1-196a-85b0-4ab22f9bda1c@ti.com>
Date: Fri, 13 Apr 2018 11:46:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180412141639.GV5700@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 12 April 2018 07:46 PM, Tony Lindgren wrote:
> Hi,
> 
> * Keerthy <j-keerthy@ti.com> [180412 03:56]:
>> From: Russ Dill <Russ.Dill@gmail.com>
>>
>> This adds a pair of context save/restore functions to save/restore the
>> state of a set of pinctrl registers. This simplifies some of the AM33XX
>> PM code as some of the pinctrl registers are lost when the per power
>> domain loses power. The pincrtl code can perform the necessary
>> save/restore.
> 
> So where's the patch adding callers to this code?

This series was to get all the additional save/restores needed for the
rtc+ddr mode. Caller patch is in the main patch that implements that
mode that i will be posting once the ground is set.

Based on enable_off_mode being set this function was called only for
rtc+ddr mode.

> 
> If this cannot be done from regular driver suspend/resume calls,
> this probably should be done from cpu_pm notifiers CPU_PM_ENTER and
> CPU_PM_EXIT. We should also do the same for GPIO BTW.

I will look into that. Thanks for suggestion.

> 
> BTW, the subject line is wrong here, it should be "pinctrl" :)

Oops yes that should be pinctrl.

> 
> Regards,
> 
> Tony
> 
