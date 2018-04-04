Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeDDP4L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:56:11 -0400
Received: from thoth.sbs.de ([192.35.17.2]:58531 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752070AbeDDP4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:56:10 -0400
Subject: Re: [PATCH] arm: Initialize hrtimer-based broadcast clockevent
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <86a7e675-11bd-3b8b-22a0-8f440db96293@siemens.com>
 <8f2fd3b9-416a-992e-5ca6-fc83aad5700d@siemens.com>
Openpgp: preference=signencrypt
Message-ID: <35966a15-8312-5ba9-ef76-33a6cfda1f32@siemens.com>
Date: Wed, 4 Apr 2018 17:54:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <8f2fd3b9-416a-992e-5ca6-fc83aad5700d@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-01 07:04, Jan Kiszka wrote:
> On 2018-01-22 07:06, Jan Kiszka wrote:
>> Analogously to 9358d755bd5c, this registers a broadcast clockevent in
>> case no hardware broadcast timer is available and the per-CPU timers can
>> be stopped in deep power states.
>>
>> Partitions of the Jailhouse hypervisor fall in this category.
>> Registering the workaround timer allows to enter high-resolution mode in
>> that case.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm/kernel/time.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
>> index 629f8e9981f1..0a45d861ef8e 100644
>> --- a/arch/arm/kernel/time.c
>> +++ b/arch/arm/kernel/time.c
>> @@ -12,6 +12,7 @@
>>   *  reading the RTC at bootup, etc...
>>   */
>>  #include <linux/clk-provider.h>
>> +#include <linux/clockchips.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/errno.h>
>>  #include <linux/export.h>
>> @@ -121,5 +122,7 @@ void __init time_init(void)
>>  		of_clk_init(NULL);
>>  #endif
>>  		timer_probe();
>> +
>> +		tick_setup_hrtimer_broadcast();
>>  	}
>>  }
>>
> 
> Gentle ping, just to avoid that this falls through the cracks because
> it's so small.
> 

2nd ping. Should this patch be routed via ARM or rather some tip/timers
tree?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
