Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756034AbeEHVjx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:39:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:10544 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755739AbeEHVju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:39:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39462231"
Subject: Re: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
 <20180504134956.36dc72a253d03e94a517a867@linux-foundation.org>
 <20180505070147.epsrglnypm72jr5u@pengutronix.de>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <c1f2e09d-f64b-afe6-59bf-c0742409e4d6@intel.com>
Date: Tue, 8 May 2018 23:39:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180505070147.epsrglnypm72jr5u@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2018 9:01 AM, Oleksij Rempel wrote:
> Moving Rafael from Cc to To.
>
> Hi Rafael,
>
> can you please help here?
> I need your ACK or NACK for this patch.

Sorry for the delay, I'll have a closer look at it in the next couple of 
days.

Thanks,
Rafael


> On Fri, May 04, 2018 at 01:49:56PM -0700, Andrew Morton wrote:
>> On Fri, 4 May 2018 20:50:52 +0200 Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>
>>> Hallo Andrew,
>>> I need your ACK or NACK for this patch.
>>>
>>> This function is used to configure external PMIC to interpret
>>> signal which will be triggered by pm_power_off as power off.
>>> Since same signal can be used for stand by, I linked PMIC configuration
>>> with pm_power_off_prepare to avoid possible conflicts.
>>>
>>> ...
>>>
>>>> --- a/kernel/reboot.c
>>>> +++ b/kernel/reboot.c
>>>> @@ -49,6 +49,7 @@ int reboot_force;
>>>>    */
>>>>   
>>>>   void (*pm_power_off_prepare)(void);
>>>> +EXPORT_SYMBOL(pm_power_off_prepare);
>>>>   
>> OK by me, but it's more of a Rafael thing.
>>
