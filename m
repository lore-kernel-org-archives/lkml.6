Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeBWEJp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 23:09:45 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:47123 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBWEJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 23:09:43 -0500
Subject: Re: [PATCH v11 04/10] clocksource: timer-ti-dm: Replace architecture
To: Tony Lindgren <tony@atomide.com>,
        Ladislav Michl <ladis@linux-mips.org>
CC: <daniel.lezcano@linaro.org>, <thierry.reding@gmail.com>,
        <aaro.koskinen@iki.fi>, <Claudiu.Beznea@microchip.com>,
        <narmstrong@baylibre.com>, <linux-pwm@vger.kernel.org>,
        <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <sebastian.reichel@collabora.co.uk>, <linux-omap@vger.kernel.org>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>, <grygorii.strashko@ti.com>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
 <1518674511-26421-5-git-send-email-j-keerthy@ti.com>
 <20180222105713.GA30885@lenoch> <20180222184541.GB5184@atomide.com>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <44e7cb7c-aafa-ad10-fc11-6417066fb6e9@ti.com>
Date: Fri, 23 Feb 2018 09:38:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180222184541.GB5184@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 23 February 2018 12:15 AM, Tony Lindgren wrote:
> * Ladislav Michl <ladis@linux-mips.org> [180222 10:58]:
>> On Thu, Feb 15, 2018 at 11:31:45AM +0530, Keerthy wrote:
>>> Replace architecture specific guard with clocksource guard.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> Replace architecture specific defines with clocksource
>>
>> This looks like a bit unussual commit log. Also, what about merging
>> it with previous patch?
> 
> I'll just remove that line locally to avoid yet another set
> of patches being posted :)

Thanks!

> 
>> Btw, I tested whole serie again on the top of today's -next and it is
>> still working fine. What is preventing these patches from being merged?

Ladis,

Thanks once again.


> 
> Well I noticed we need a fix for omap1 that I just posted.
> And patch 4/10 needs the following select for omap16xx that
> I'll fold in.
> 
> I'll push it all to omap-for-v4.17/timer and will merge into
> my for-next after some more testing. It seems any further
> patching can be done after move to drivers.

Yes that would be great.

> 
> Regards,
> 
> Tony
> 
> 8< -----------------
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -30,6 +30,7 @@ config ARCH_OMAP16XX
>  	bool "OMAP16xx Based System"
>  	select ARCH_OMAP_OTG
>  	select CPU_ARM926T
> +	select OMAP_DM_TIMER
>  
>  config OMAP_MUX
>  	bool "OMAP multiplexing support"
> 
