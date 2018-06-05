Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeFEJkq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:40:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21920 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeFEJkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:40:18 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180605094016epoutp020f313ded3b1086ef1baf3413bd899b49~1Oi2zawkX2220422204epoutp020
X-AuditID: b6c32a36-bd1ff70000000fe4-65-5b165a7eb3d6
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5B165A7D.90004@samsung.com>
Date: Tue, 05 Jun 2018 18:40:13 +0900
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
In-reply-to: <20180530211301.GA194977@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zk7m+Xqa6Z+GNo6XUjD5dncOkWLoLB1AyEKc8Q66dcmujPZ
        mZVRYVdtbZV2oVZmVwkTk2lm0c1LGUaaRtk9wijpaiyzsqRtx6hf3/s97/O8vM/DKyeUXipG
        nsU7sYPncmhqGFnXFJ+UuCk9ypT040A4+7vkloz1ffksZcua26Ts3fIGit166jzF9lcEv1s+
        yNj7l49SrN/TDNgzXR0S1l/dDdinm89S7LWaJpLdfrVZNnuEsfJYJTAO/CwBxiMFHaTRV7GT
        Ml4vrZQZd9dWAKPfF5cqS8czrZjLxA4V5jPsmVm8xUAvXGKeY9bpk5hEZjo7jVbxnA0b6LmL
        UhNTsnICO9OqNVxOXgBK5QSBnjprpsOe58Qqq11wGmgTw2jUTNI0tUYTeLUrZmh0AcpKbL39
        is+9OGVd+aUboADUjXcBuRzBZNTaYnWBYXIlrAdoW1+DVPz0A9TlriJdICxE2t3dDsRGNUAP
        jnVRwYYCjkLf970gg5MIOBY1d2YHYQLGo56vJaTIfw7QwwtthMifjO48KZUE+SSciJ55I4Iw
        BRPQ9Z5HoZEj4Tj04Hs3CNaRMA1dKvsmC9ajA9LXA+IOBBwk0C9PU2i5CLgAnXk0EBKHQQb5
        jreHHCC4S4belrtkos25qP6uRTQTgd611A7BY1DnTYNILwToa8/WIe1egHpbaySiQIvenHBJ
        RGcj0Kc+t1QUK1DRDqVIMaKBq51DATVJkPulR7oXxHr/y8j7LyPvfxkdB0QFiMK5gs2CBSZX
        oxY4m5DHW9QZdpsPhO4yQV8PTrYtagRQDuhwxeQZkSallFsj5NsaAZIT9GhF+Lwok1KRyeWv
        xw672ZGXg4VGoAtEXEzERGbYA1fOO82MTqPVatlkRq9jGDpase4xNCmhhXPibIxzseOvTiIP
        iykAhwsNrb1xKc+L/YNxY17Mjo7W5xe5YZp6/54TKbHMYOHCsn6hLdnfv5qfVLZ8gmfOl3NT
        re/R6VVL55tj2aVr77WYf/epivdg8kN7Q1Xylh8b3J/0Xs8RVdH4ZZ7ujsWFPb1V765U1x1S
        XrxXNUWx5Pw1teVt6ceNHRHDD6ZJ9dlZNClYOSaBcAjcH72q2r6tAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e+xoG5tlFi0wdsPehZ/Jx1jt9j08T2r
        xfwj51gtzi47yGbRvHg9m8X3VSBu0xt2i8u75rBZfO49wmix9PpFJovPGx4zWtxuXMFmsW/z
        YRaL1r1H2B34PNbMW8Po8fvXJEaP2Q0XWTw2repk89g/dw27R9+WVYwenzfJBbBHcdmkpOZk
        lqUW6dslcGWceJhXsF27YtnOA4wNjNuUuxg5OSQETCT6Hp9n7GLk4hASWMcosXTLR2aQBK+A
        oMSPyfdYuhg5OJgF5CWOXMqGMNUlpkzJBakQErjPKPFxURJEtYbE6VtzmUBKWARUJe7MEgYJ
        swloSex/cYMNxOYXUJS4+uMxI0iJqECERPeJSpCwCFDnk98QBzALNLBIrLp5lBUkISzgJbH0
        xm82iMsOM0nMfvMcLMEpYCixacF51gmMArOQHDoL4dBZCIcuYGRexSiZWlCcm55bbFRgmJda
        rlecmFtcmpeul5yfu4kRGD3bDmv17WC8vyT+EKMAB6MSD2+DjWi0EGtiWXFl7iFGCQ5mJRFe
        HnexaCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8t/OORQoJpCeWpGanphakFsFkmTg4pRoYRexM
        lH29FSIrbcy1w6SPLCliWfU4XFqKp6/8xvL4JPd381mT3gYrf/Q34r7lzSRgorXT969g39Og
        xSf231NfVv5Xpe8G39PctY5p05wvLvZ9bKhy4IhmhI2PdZrZ7pK+0Cv7X666cnGDY2GdxoRi
        oSVP1X99qxW1vSPR6B66zvboywlujw4psRRnJBpqMRcVJwIADzs57ZoCAAA=
X-CMS-MailID: 20180605094013epcas1p16262c28c94da0db1cf8a2b452064198c
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180525203323epcas4p45ba35c38413e227f76f68fe331011b19
References: <20180525203043.249193-1-mka@chromium.org>
        <CGME20180525203323epcas4p45ba35c38413e227f76f68fe331011b19@epcas4p4.samsung.com>
        <20180525203043.249193-3-mka@chromium.org> <5B0BA3BB.8060505@samsung.com>
        <20180529185758.GG168650@google.com> <5B0E5AFE.8090703@samsung.com>
        <20180530211301.GA194977@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 31일 06:13, Matthias Kaehlcke wrote:
> On Wed, May 30, 2018 at 05:04:14PM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018년 05월 30일 03:57, Matthias Kaehlcke wrote:
>>> On Mon, May 28, 2018 at 03:37:47PM +0900, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 2018년 05월 26일 05:30, Matthias Kaehlcke wrote:
>>>>> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
>>>>> devfreq device") initializes df->min/max_freq with the min/max OPP when
>>>>> the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
>>>>> available min/max frequency") adds df->scaling_min/max_freq and the
>>>>> following to the frequency adjustment code:
>>>>>
>>>>>   max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>>>>>
>>>>> With the current handling of min/max_freq this is incorrect:
>>>>>
>>>>> Even though df->max_freq is now initialized to a value != 0 user space
>>>>> can still set it to 0, in this case max_freq would be 0 instead of
>>>>> df->scaling_max_freq as intended. In consequence the frequency adjustment
>>>>> is not performed:
>>>>>
>>>>>   if (max_freq && freq > max_freq) {
>>>>> 	freq = max_freq;
>>>>>
>>>>> To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
>>>>> when the user passes a value of 0. This also prevents df->max_freq from
>>>>> being set below the min OPP when df->min_freq is 0, and similar for
>>>>> min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
>>>>> checks for this case can be removed.
>>>>>
>>>>> Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
>>>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>>>> ---
>>>>>  drivers/devfreq/devfreq.c | 30 ++++++++++++++++++------------
>>>>>  1 file changed, 18 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index 0057ef5b0a98..67da4e7b486b 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
>>>>>  	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
>>>>>  	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
>>>>>  
>>>>> -	if (min_freq && freq < min_freq) {
>>>>> +	if (freq < min_freq) {
>>>>>  		freq = min_freq;
>>>>>  		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
>>>>>  	}
>>>>> -	if (max_freq && freq > max_freq) {
>>>>> +	if (freq > max_freq) {
>>>>>  		freq = max_freq;
>>>>>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>>>>  	}
>>>>> @@ -1123,17 +1123,20 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
>>>>>  	struct devfreq *df = to_devfreq(dev);
>>>>>  	unsigned long value;
>>>>>  	int ret;
>>>>> -	unsigned long max;
>>>>>  
>>>>>  	ret = sscanf(buf, "%lu", &value);
>>>>>  	if (ret != 1)
>>>>>  		return -EINVAL;
>>>>>  
>>>>>  	mutex_lock(&df->lock);
>>>>> -	max = df->max_freq;
>>>>> -	if (value && max && value > max) {
>>>>> -		ret = -EINVAL;
>>>>> -		goto unlock;
>>>>> +
>>>>> +	if (value) {
>>>>> +		if (value > df->max_freq) {
>>>>> +			ret = -EINVAL;
>>>>> +			goto unlock;
>>>>> +		}
>>>>> +	} else {
>>>>> +		value = df->profile->freq_table[df->profile->max_state - 1];
>>>>>  	}
>>>>
>>>> If you want to prevent that df->min_freq is zero, 
>>>> you should reinitialize 'value' as following.
>>>> Because freq_table must be in ascending order.
>>>> 	value = df->profile->freq_table[0];
>>>
>>> Thanks for pointing this out!
>>>
>>> The devfreq device I tested with (a Mali GPU) uses descending order
>>> for some reason, and I assumed that's the usual order.
>>>
>>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/arm/midgard/backend/gpu/mali_kbase_devfreq.c#208
>>>
>>> It seems the ordering doesn't have any impact beyond this patch. If
>>> the order isn't mandatory for drivers that set up their own freq_table
>>> we should probably support both cases to be safe.
>>
>> Prior to that 'freq_table' is optional. So, patch[1] initialize the 'freq_table'
>> by using OPP interface if 'freq_table' is NULL.
>> [1] commit 0ec09ac2cebe ("PM / devfreq: Set the freq_table of devfreq device")
>>
>> Current devfreq recommend the ascending order for 'freq_table'.
>> But, as you know, it might be not enough to support them.
>>
>> I agree that we should support the both cases (ascending or descending order).
>>
>> Maybe, it might be not proper to access the freq_table[] directly
>> because we don't know the ordering style of 'freq_table'
>> if 'freq_table' is made by devfreq user instead of devfreq core.
> 
> If we can assume that it is either ascending or descending, but not
> random order than a simple check if freq_table[0] <
> freq_table[max_state - 1] would be sufficient.

Also, we should consider the order way of freq_table on available_frequency
because available_frequency have to show the frequency as the ascending order
even if freq_table uses the descending order.

> 
> Otherwise we could also determine the min/max after initialization and
> save the result, though that would leave us with yet another frequency
> pair, which might be confusing, especially if we don't come up with
> good names to distinguish between them.

IMO, it might make the confusion if devfreq device has the two frequency
table.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
