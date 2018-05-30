Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968571AbeE3IEw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:04:52 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:64173 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937195AbeE3IET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:04:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180530080417epoutp03edc6786a1213e1a92cde018dd0edaabc~zXXVcgfiC2112321123epoutp03g
X-AuditID: b6c32a36-bd1ff70000000fe4-68-5b0e5afe9259
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5B0E5AFE.8090703@samsung.com>
Date: Wed, 30 May 2018 17:04:14 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?B?w5hyamFuIEVpZGU=?= <orjan.eide@arm.com>,
        John Einar Reitan <john.reitan@arm.com>
Subject: Re: [PATCH 02/11] PM / devfreq: Fix handling of min/max_freq == 0
In-reply-to: <20180529185758.GG168650@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01SW0wTQRTNsNvdBSmsFXACPupGE8WA3ZbCCtS3pgIfGD8kJQZXOgGUtqTb
        EvFDEaIoPqIYolQB8QFIiGJRU02QCPWJSERRo9EEUUQjihYBRYjdrka/5twz596Zc3IpTFFB
        hFM5ZhuymvlchgjAr7YvUEVNGoLSVRMl8dxE2W2Sc379IuOq3Q9lXGftTYIrPnOR4EYbxLLo
        E8k9vn6S4DwH3YA79+yRH+dp6gPcy131BHejuR3ndre4yWVB+saqRqAf/1kG9CcKH+F6Z8M+
        Qt9a2UjqD11uAHqPc1YqaUCJ2Yg3IqsSmTMtxhxzlo5JXp+xMkMbq2Kj2MVcHKM08yakY1al
        pEatycn1/plR5vO5di+VygsCs2hJotVityFltkWw6Zh0llVHs6q4aLXae2o2xqu1XskmlL2r
        bkPeh6htJW3FoBC0zi0F/hSkY2BNTS9RCgIoBe0C8GXHoEy8UNCjAFZ1hJUCyicqd22Q6CYA
        K9+liVhOT4VjR1/jogSjZ0N391aRxugFcGC4DJdGvgKwv74Vl/SRsPmGixD1OD0PHqjViTTh
        pVsHnhMiDqbnwJ6xPiDiUDoNXqseIUUcQs+Hb8e7gDgToycx+Otgu2/mNDoJnns+7mv2p1l4
        rKnW9zCk95PwrusBKZlcBcvLz/pJeBr8eOcyKfmKgN23dJK+BMDhgWKZVBwGcOh+858GDeyv
        KfWTrAXBz98PyKRmOdy7RyFJ9HC8pRtIjicAfFvhwQ+DmY7/QnL8C8nxX0inANYAwlCeYMpC
        ApunjhZ4k2A3Z0VnWkxO4FvLyFgXOP0wpQ3QFGAC5ao0ebpCxucLBaY2ACmMCZHbWwLTFXIj
        X7AdWS0ZVnsuEtqA1pvxESw8NNPiXXKzLYPVqjUaDRfDxmpZlpku3xM3aVDQWbwNbUUoD1n/
        9vlR/uGFIHFeYkdKcv6bmMcJ1gtjdZGbZwQ7V/x8/4TawhXXOKYIvS86Sb56Y1dP8L0p8cEF
        3QHrCp7OnWHAHdURg0NpQxWm5caWCFdVc4zRcHf1TnRpR4+CORQ4WjZWt9uztKj+yfEVFSFX
        1jW9TsifPH9pbfnNHwZABC1M6hw59k0Z5lY9Y3Ahm2cjMavA/wb1hI6qrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e+xoO6/KL5og4Zl6hZ/Jx1jt9j08T2r
        xfwj51gtzi47yGbRvHg9m8X3VSBu0xt2i8u75rBZfO49wmix9PpFJovPGx4zWtxuXMFmsW/z
        YRaL1r1H2B34PNbMW8Po8fvXJEaP2Q0XWTw2repk89g/dw27R9+WVYwenzfJBbBHcdmkpOZk
        lqUW6dslcGU0Lg8veKlb0X6ombGBcb9KFyMHh4SAicTUHeFdjFwcQgLrGCVOdGxn7GLk5OAV
        EJT4MfkeC0gNs4C8xJFL2RCmusSUKbkQ5fcZJR7P/MMCUa4lsXnfDjaQGhYBVYmeZbYgYTag
        8P4XN9hAbH4BRYmrPx4zgpSICkRIdJ+oBAmLCGhIPPl9nhFkJLNAA4vEqptHWUESwgJeEktv
        /GaD2PWXUWLyiVVggzgFDCWmb1jGMoFRYBaSS2chXDoL4dIFjMyrGCVTC4pz03OLjQoM81LL
        9YoTc4tL89L1kvNzNzECo2fbYa2+HYz3l8QfYhTgYFTi4TWI4I0WYk0sK67MPcQowcGsJMJb
        upcnWog3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQbGipU9
        u3mq/gUe/9ZfL7EmIkelkV95Zb/miisvdvr8WqHEOjHxn0Fa15ctnSf+cE5eLmhxiEvNxqSV
        y/tW2ZujybkTjYrt1d0fGutsf7YxLm71eocn2384fuqu8fplvr3p/9ZMOzaXJTWMcbNezUtw
        OXj3/nKpv0Uh17puvdnk/UXDOCRZYfVvJZbijERDLeai4kQAwg75FJoCAAA=
X-CMS-MailID: 20180530080414epcas1p4ca5af170cd872fac629c0d809a8181b3
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203323epcas4p45ba35c38413e227f76f68fe331011b19
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203323epcas4p45ba35c38413e227f76f68fe331011b19@epcas4p4.samsung.com>
        <20180525203043.249193-3-mka@chromium.org> <5B0BA3BB.8060505@samsung.com>
        <20180529185758.GG168650@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 30일 03:57, Matthias Kaehlcke wrote:
> On Mon, May 28, 2018 at 03:37:47PM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
>>> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
>>> devfreq device") initializes df->min/max_freq with the min/max OPP when
>>> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
>>> available min/max frequency") adds df->scaling_min/max_freq and the
>>> following to the frequency adjustment code:
>>>
>>>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>>>
>>> With the current handling of min/max_freq this is incorrect:
>>>
>>> Even though df->max_freq is now initialized to a value != 0 user space
>>> can still set it to 0, in this case max_freq would be 0 instead of
>>> df->scaling_max_freq as intended. In consequence the frequency adjustment
>>> is not performed:
>>>
>>>   if (max_freq && freq > max_freq) {
>>> 	freq = max_freq;
>>>
>>> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
>>> when the user passes a value of 0. This also prevents df->max_freq from
>>> being set below the min OPP when df->min_freq is 0, and similar for
>>> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
>>> checks for this case can be removed.
>>>
>>> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>  drivers/devfreq/devfreq.c | 30 ++++++++++++++++++------------
>>>  1 file changed, 18 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 0057ef5b0a98..67da4e7b486b 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
>>>  	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>>>  	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
>>>  
>>> -	if (min_freq && freq < min_freq) {
>>> +	if (freq < min_freq) {
>>>  		freq = min_freq;
>>>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>>>  	}
>>> -	if (max_freq && freq > max_freq) {
>>> +	if (freq > max_freq) {
>>>  		freq = max_freq;
>>>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>>  	}
>>> @@ -1123,17 +1123,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>  	struct devfreq *df = to_devfreq(dev);
>>>  	unsigned long value;
>>>  	int ret;
>>> -	unsigned long max;
>>>  
>>>  	ret = sscanf(buf, "%lu", &value);
>>>  	if (ret != 1)
>>>  		return -EINVAL;
>>>  
>>>  	mutex_lock(&df->lock);
>>> -	max = df->max_freq;
>>> -	if (value && max && value > max) {
>>> -		ret = -EINVAL;
>>> -		goto unlock;
>>> +
>>> +	if (value) {
>>> +		if (value > df->max_freq) {
>>> +			ret = -EINVAL;
>>> +			goto unlock;
>>> +		}
>>> +	} else {
>>> +		value = df->profile->freq_table[df->profile->max_state - 1];
>>>  	}
>>
>> If you want to prevent that df->min_freq is zero, 
>> you should reinitialize 'value' as following.
>> Because freq_table must be in ascending order.
>> 	value = df->profile->freq_table[0];
> 
> Thanks for pointing this out!
> 
> The devfreq device I tested with (a Mali GPU) uses descending order
> for some reason, and I assumed that's the usual order.
> 
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/arm/midgard/backend/gpu/mali_kbase_devfreq.c#208
> 
> It seems the ordering doesn't have any impact beyond this patch. If
> the order isn't mandatory for drivers that set up their own freq_table
> we should probably support both cases to be safe.

Prior to that 'freq_table' is optional. So, patch[1] initialize the 'freq_table'
by using OPP interface if 'freq_table' is NULL.
[1] commit 0ec09ac2cebe ("PM / devfreq: Set the freq_table of devfreq device")

Current devfreq recommend the ascending order for 'freq_table'.
But, as you know, it might be not enough to support them.

I agree that we should support the both cases (ascending or descending order).

Maybe, it might be not proper to access the freq_table[] directly
because we don't know the ordering style of 'freq_table'
if 'freq_table' is made by devfreq user instead of devfreq core.


> 
>>> @@ -1158,17 +1161,20 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
>>>  	struct devfreq *df = to_devfreq(dev);
>>>  	unsigned long value;
>>>  	int ret;
>>> -	unsigned long min;
>>>  
>>>  	ret = sscanf(buf, "%lu", &value);
>>>  	if (ret != 1)
>>>  		return -EINVAL;
>>>  
>>>  	mutex_lock(&df->lock);
>>> -	min = df->min_freq;
>>> -	if (value && min && value < min) {
>>> -		ret = -EINVAL;
>>> -		goto unlock;
>>> +
>>> +	if (!value) {
>>> +		value = df->profile->freq_table[0];
>>
>> ditto.
>> 	value = df->profile->freq_table[df->profile->max_state - 1];
>>
>>> +	} else {
>>> +		if (value < df->min_freq) {
>>> +			ret = -EINVAL;
>>> +			goto unlock;
>>> +		}
>>>  	}
>>>  
>>>  	df->max_freq = value;
>>>
>>
>> Actually, min_freq_store() and max_freq_store() are very similar.
>> But, this patch changed the order of conditional statement as following:
>> If there is no special reason, you better to keep the same format
>> for the readability.
>>
>>
>> min_freq_store()
>> 	if (value) {
>> 		...
>> 	} else {
>> 		value = df->profile->freq_table[df->profile->max_state - 1];
>> 	}
>>
>>
>> max_freq_store()
>> 	if (!value) {
>> 		value = df->profile->freq_table[0];
>> 	} else {
>> 		...
>>
> 
> Agreed, better use the same format, I'll update it in the next revision.
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
