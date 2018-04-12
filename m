Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753693AbeDLUDK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:03:10 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:49666 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeDLUDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:03:09 -0400
Subject: Re: [PATCH 11/14] gpio: omap: Restore power_mode configuration at
 resume time
To: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
CC: <linus.walleij@linaro.org>, <t-kristo@ti.com>, <Russ.Dill@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ssantosh@kernel.org>, <haojian.zhuang@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <d-gerlach@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-12-git-send-email-j-keerthy@ti.com>
 <20180412143932.GA5700@atomide.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <b7e2119e-7bf4-a275-be66-0a83705d807e@ti.com>
Date: Thu, 12 Apr 2018 15:02:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412143932.GA5700@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/12/2018 09:39 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [180412 03:56]:
>> From: Dave Gerlach <d-gerlach@ti.com>
>>
>> Commit 2dc983c565e0 ("gpio/omap: cleanup prepare_for_idle and
>> resume_after_idle") introduces omap2_gpio_prepare_for_idle and
>> omap2_gpio_resume_after_idle to properly configure gpios that are used
>> as wake sources. When entering off mode, omap2_gpio_prepare_for_idle
>> can set a flag indicating off-mode entry is desired, however once this
>> flag is set it is never cleared, so any additional calls to this
>> function, regardless of the mode, have this flag set.
>>
>> This patch restores the pwr_mode flag to 0 in
>> omap2_gpio_resume_after_idle to ensure the flag is not misconfigured
>> during non off-mode operation.
> 
> Seems like this should be applied as a fix, can you please add
> a proper Fixes tag?

Correct. And please send it separate. 
But not sure about fixes (to many changes) - it has to manually checked for the lowest
kernel version to apply.

-- 
regards,
-grygorii
