Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeDKQTU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:19:20 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43574 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753402AbeDKQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:19:17 -0400
X-Google-Smtp-Source: AIpwx492BUpwFVPDipOkpPctCI6yeLIxrpv8IEUj8A8114pmPCr8A/6fZ3buLQvZPQI3eQqvUNjEBw==
Subject: Re: [PATCH] net: dsa: b53: Replace mdelay with msleep in
 b53_switch_reset_gpio
To: Jia-Ju Bai <baijiaju1990@gmail.com>,
        Phil Reid <preid@electromag.com.au>, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523411485-2030-1-git-send-email-baijiaju1990@gmail.com>
 <11d079ab-3c07-a10d-c321-f873c53e9690@electromag.com.au>
 <7c9dffb7-d55a-98f5-4024-7e2f0c704a56@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <7d376874-8078-0252-ed7e-29392a519fc8@gmail.com>
Date: Wed, 11 Apr 2018 09:19:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7c9dffb7-d55a-98f5-4024-7e2f0c704a56@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 12:14 AM, Jia-Ju Bai wrote:
> 
> 
> On 2018/4/11 13:30, Phil Reid wrote:
>> On 11/04/2018 09:51, Jia-Ju Bai wrote:
>>> b53_switch_reset_gpio() is never called in atomic context.
>>>
>>> The call chain ending up at b53_switch_reset_gpio() is:
>>> [1] b53_switch_reset_gpio() <- b53_switch_reset() <-
>>>     b53_reset_switch() <- b53_setup()
>>>
>>> b53_switch_reset_gpio() is set as ".setup" in struct dsa_switch_ops.
>>> This function is not called in atomic context.
>>>
>>> Despite never getting called from atomic context,
>>> b53_switch_reset_gpio()
>>> calls mdelay() to busily wait.
>>> This is not necessary and can be replaced with msleep() to
>>> avoid busy waiting.
>>>
>>> This is found by a static analysis tool named DCNS written by myself.
>>> And I also manually check it.
>>>
>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>> ---
>>>   drivers/net/dsa/b53/b53_common.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/dsa/b53/b53_common.c
>>> b/drivers/net/dsa/b53/b53_common.c
>>> index 274f367..e070ff6 100644
>>> --- a/drivers/net/dsa/b53/b53_common.c
>>> +++ b/drivers/net/dsa/b53/b53_common.c
>>> @@ -597,10 +597,10 @@ static void b53_switch_reset_gpio(struct
>>> b53_device *dev)
>>>       /* Reset sequence: RESET low(50ms)->high(20ms)
>>>        */
>>>       gpio_set_value(gpio, 0);
>>> -    mdelay(50);
>>> +    msleep(50);
>>>         gpio_set_value(gpio, 1);
>>> -    mdelay(20);
>>> +    msleep(20);
>>>         dev->current_page = 0xff;
>>>   }
>>>
>> Would that also imply gpio_set_value could be gpio_set_value_cansleep?
>>
> 
> Yes, I think gpio_set_value_cansleep() is okay here?
> Do I need to send a V2 patch to replace gpio_set_value()?

Yes, I would lump these two changes in the same patch since this is
effectively about solving sleeping vs. non sleeping operations.

Thanks!
-- 
Florian
