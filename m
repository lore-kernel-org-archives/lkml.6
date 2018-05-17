Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEQXUi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:20:38 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13573 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:20:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180517232034epoutp029cf59d0a6f103d32ceeb4d8a14b26baa~vkepdgWyy0564905649epoutp02Q
X-AuditID: b6c32a37-511ff70000001030-96-5afe0e3f56cd
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AFE0E3E.7070307@samsung.com>
Date: Fri, 18 May 2018 08:20:30 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] PM / devfreq: Init user limits from OPP limits, not
 viceversa
In-reply-to: <20180517163543.GO19594@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmga49378og+uPpSw2fXzPanF22UE2
        i7NNb9gtLu+aw2bxufcIo8XnDY8ZLW43rmBzYPeY3XCRxaNvyypGj8+b5AKYo1JtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslaINDY30DA3M9YyMgLRxrJWRKVBJQmrGvL9KBRflK74dP8jawNgi
        1cXIySEhYCLxaNttRhBbSGAHo0T7MrEuRi4g+zujxMoDuxlhilae+cYEkdjNKLF2+QxWkASv
        gKDEj8n3WLoYOTiYBeQljlzKBgkzC2hKvPgyiQWi/i7Q0N0L2SDqtSTefDkN1ssioCpxs60D
        zGYDiu9/cQOshl9AUeLqj8dgi0UFIiR2zv/GDmKLCGhIPPl9nhFkKLPAc0aJt02fwRqEBUIk
        +r89ZAKxOQUMJE4vfQO2WUJgD5vE9pdNUC+4SEzsOMUOYQtLvDq+hR3kagkBaYlLR20h6tuB
        Lt07jxnCmcIoce76PSaIBmOJZwu7mCB+45N497WHFaKZV6KjTQiixEPixdS9UOWOEk8nNEG9
        f55Roq3zN/sERrlZSCE2CxFis5BCbAEj8ypGsdSC4tz01GLDAmO94sTc4tK8dL3k/NxNjODk
        pmW+g3HDOZ9DjAIcjEo8vC8m/o0SYk0sK67MPcQowcGsJMLrVwkU4k1JrKxKLcqPLyrNSS0+
        xGgKDPCJzFKiyfnAxJtXEm9oamRsbGxhYmhmamioJM47R+lrlJBAemJJanZqakFqEUwfEwen
        VAOjeK2Wtc3/1Tti59oGJz75YStwzfde1HLhOXsiw+fVucxiuJH99HlGf8j/4ov5a0tEJwvy
        xpfe8OjJWNf0iumIwDHDP9OzZm54OvHG542+W6XOlxz4sFXaZtOVDXMsdf7smeTTs7AygaP5
        0/vDV/5Mlon94Mrjz7tqh8Lq5yWlly4vf7Q1yoe1VomlOCPRUIu5qDgRABegnhqEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsVy+t9jAV07vn9RBg9OK1hs+vie1eLssoNs
        Fmeb3rBbXN41h83ic+8RRovPGx4zWtxuXMHmwO4xu+Eii0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBlzPurVHBRvuLb8YOsDYwtUl2MnBwSAiYSK898Y+pi5OIQEtjJKHGi4ycLSIJXQFDi
        x+R7QDYHB7OAvMSRS9kQprrElCm5EOX3GSVeXp7EClGuJfHmy2kwm0VAVeJmWweYzQYU3//i
        BhuIzS+gKHH1x2NGkDmiAhES3ScqQcIiAhoST36fZwSZySzwnFFiyd7JTCAJYYEQic0fPzND
        LLvIKNHx6SvYbZwCBhKnl75hmcAoMAvJqbMQTp2FcOoCRuZVjJKpBcW56bnFRgWGeanlesWJ
        ucWleel6yfm5mxiBIb3tsFbfDsb7S+IPMQpwMCrx8L6Y+DdKiDWxrLgy9xCjBAezkgivXyVQ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBkaxuwZ10XdO
        9ydZNe2T3yUs6fWeI/9/1O65Dk2z01oXXt785C/3/Nx1zLp7ml9s28Fn80LT/DPz7/OOzc/D
        f2QusS9muL7psMvt1Ga1yTOrN/W/32g4/5HSK4WJ7b3tC3/tct88W2j6Mbuwhb133r/8mf/U
        4/rR1fZHp+SEB/Jx/pj61964eDaTEktxRqKhFnNRcSIA/TfXGGUCAAA=
X-CMS-MailID: 20180517232030epcas1p3392a159e55d126f1508fd46716016aac
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180516225800epcas5p188094c0edfe8a9c3ffd3bfb9e48ce87c
X-RootMTR: 20180516225800epcas5p188094c0edfe8a9c3ffd3bfb9e48ce87c
References: <CGME20180516225800epcas5p188094c0edfe8a9c3ffd3bfb9e48ce87c@epcas5p1.samsung.com>
        <20180516225709.153138-1-mka@chromium.org> <5AFCD5EC.5080200@samsung.com>
        <20180517163543.GO19594@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 18일 01:35, Matthias Kaehlcke wrote:
> On Thu, May 17, 2018 at 10:07:56AM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018년 05월 17일 07:57, Matthias Kaehlcke wrote:
>>> Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
>>> the devfreq device") introduced the initialization of the user
>>> limits min/max_freq from the lowest/highest available OPPs. Later
>>> commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
>>> frequency") added scaling_min/max_freq, which actually represent
>>> the frequencies of the lowest/highest available OPP. scaling_min/
>>> max_freq are initialized with the values from min/max_freq, which
>>> is totally correct in the context, but a bit awkward to read.
>>>
>>> Swap the initialization and assign scaling_min/max_freq with the
>>> OPP freqs and then the user limts min/max_freq with scaling_min/
>>> max_freq.
>>>
>>> Needless to say that this change is a NOP, intended to improve
>>> readability.
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>> Additional context: I'm considering to introduce the concept of
>>> a devfreq policy, which would probably move min/max_freq inside
>>> of a struct policy, this would make the initialization even
>>> more awkward to read. If this moves forward I might also propose
>>> to rename scaling_min/max_freq to something like min/max_opp_freq
>>> to avoid confusion with the frequencies in the policy (cpufreq uses
>>> scaling_min/max_freq for the sysfs attributes of the policy
>>> limits).
>>>
>>>  drivers/devfreq/devfreq.c | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index fe2af6aa88fc..0057ef5b0a98 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -604,21 +604,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  		mutex_lock(&devfreq->lock);
>>>  	}
>>>  
>>> -	devfreq->min_freq = find_available_min_freq(devfreq);
>>> -	if (!devfreq->min_freq) {
>>> +	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>>> +	if (!devfreq->scaling_min_freq) {
>>>  		mutex_unlock(&devfreq->lock);
>>>  		err = -EINVAL;
>>>  		goto err_dev;
>>>  	}
>>> -	devfreq->scaling_min_freq = devfreq->min_freq;
>>> +	devfreq->min_freq = devfreq->scaling_min_freq;
>>>  
>>> -	devfreq->max_freq = find_available_max_freq(devfreq);
>>> -	if (!devfreq->max_freq) {
>>> +	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
>>> +	if (!devfreq->scaling_max_freq) {
>>>  		mutex_unlock(&devfreq->lock);
>>>  		err = -EINVAL;
>>>  		goto err_dev;
>>>  	}
>>> -	devfreq->scaling_max_freq = devfreq->max_freq;
>>> +	devfreq->max_freq = devfreq->scaling_max_freq;
>>>  
>>>  	dev_set_name(&devfreq->dev, "devfreq%d",
>>>  				atomic_inc_return(&devfreq_no));
>>>
>>
>> This patch just clean-up codes related to min/max_freq and scaling_min/max_freq.
>> It seems be good.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Thanks for the review!
> 
>> But, I don't want to change the name from 'scaling_min/max_freq'
>> to 'min/max_opp_freq'.
> 
> It's obviously up to you in the end, and I won't insist if you are
> convinced that scaling_min/max_freq is the better name (I suggest to
> make this judgement after a new revision of the policy patch [1],
> which likely will introduce another pair of frequencies, and naming
> can help to clearly differentiate between them).
> 
>> You can check the meaning of variables in comment of struct devfreq.
> 
> This is true, but ideally code should be as self-explaining as
> possible (without becoming too verbose ;-), and variable/function
> names are a key element for that.

I don't want to use the framework name for specific variable.

> 
> Best regards
> 
> Matthias
> 
> [1] https://patchwork.kernel.org/patch/10401999/
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
