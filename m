Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCIBvl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 20:51:41 -0500
Received: from regular1.263xmail.com ([211.150.99.132]:60130 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeCIBvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 20:51:40 -0500
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: alexandre.belloni@bootlin.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <8476abcfc93184479494c5a8d2569914>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AA1E89F.2020500@rock-chips.com>
Date: Fri, 09 Mar 2018 09:51:27 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] rtc: at91sam9: Pass pdev->dev to regmap_init_mmio()
References: <20180308102154.25686-1-jeffy.chen@rock-chips.com> <20180308102154.25686-3-jeffy.chen@rock-chips.com> <20180308204941.GK20370@piout.net>
In-Reply-To: <20180308204941.GK20370@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 03/09/2018 04:49 AM, Alexandre Belloni wrote:
> On 08/03/2018 at 18:21:52 +0800, Jeffy Chen wrote:
>> Otherwise it would use "dummy*" to create regmap debugfs dir.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> ---
>>
>> Changes in v3: None
>>
>>   drivers/rtc/rtc-at91sam9.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
>> index 7418a763ce52..0d6a17a77841 100644
>> --- a/drivers/rtc/rtc-at91sam9.c
>> +++ b/drivers/rtc/rtc-at91sam9.c
>> @@ -402,7 +402,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
>>   		if (IS_ERR(gpbr))
>>   			return PTR_ERR(gpbr);
>>
>> -		rtc->gpbr = regmap_init_mmio(NULL, gpbr,
>> +		rtc->gpbr = regmap_init_mmio(&pdev->dev, gpbr,
>>   					     &gpbr_regmap_config);
>
> This would be misleading as the gpbr is not directly related to the rtc.
ok, will fix that, thanks.
>
