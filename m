Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeEQX0p (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:26:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46722 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbeEQX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:26:41 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180517232639epoutp016e8ccbbb07b92f8c614e8f0f7889c115~vkj9mzW1W2841228412epoutp013
X-AuditID: b6c32a35-9e3ff70000001024-4f-5afe0fa7cd86
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AFE0FA6.4020101@samsung.com>
Date: Fri, 18 May 2018 08:26:30 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH] PM / devfreq: Add policy notifier
In-reply-to: <20180517230728.GQ19594@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmnu5y/n9RBnevKVts+vie1eJs0xt2
        i8u75rBZfO49wmjxecNjRovbjSvYHNg8ZjdcZPHo27KK0ePzJrkA5qhUm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6VoQ0MjPUMDcz0jIyBtHGtlZApUkpCa8efLB6aC3XwVjz+cYmxgvMzdxcjJ
        ISFgInH7xFMmEFtIYAejxMqWrC5GLiD7O6PEk+uvmGCKvkzcwAyR2M0oce7ODDaQBK+AoMSP
        yfdYuhg5OJgF5CWOXMoGCTMLaEq8+DKJBaL+LqNE0/8Z7BD1WhIHnu4G62URUJW4NaGLEcRm
        A4rvf3EDLM4voChx9cdjsLioQITEzvnfwHpFBDQknvw+zwgylBnkiKU7/oEVCQtYSdyYt44V
        xOYUMJD4OOk2O0iRhMAONonZ/w6wQLzgIjH91HZ2CFtY4tXxLewgV0sISEtcOmoLUd/OKNG+
        dx4zhDMF6M3r96D+N5Z4trCLCeI3Pol3X3tYIZp5JTrahCBKPCT+3p/ICmE7Snz5dpAR4v2z
        jBJP37cyT2CUm4UUYrMQITYLKcQWMDKvYhRLLSjOTU8tNiww1CtOzC0uzUvXS87P3cQITmpa
        pjsYp5zzOcQowMGoxMM7of9vlBBrYllxZe4hRgkOZiURXr9KoBBvSmJlVWpRfnxRaU5q8SFG
        U2CAT2SWEk3OBybcvJJ4Q1MjY2NjCxNDM1NDQyVx3jlKX6OEBNITS1KzU1MLUotg+pg4OKUa
        GA1qjCWFkyc3Pfi9327Zl7wTJZJpCU7z16+9xSchdmVX1Kqakp9PLI7b3ymwuajE0vydIUIi
        /nxZU8A1rud8M0/GHnCe3sK6rv2S0pw3wh0ZSsvdCvJ73+iY7opc7Me+YYn8brYp0abc/1Nf
        /z/ocODZo7+b4vKffU54aHnn4MyAIBuz/UyKtUosxRmJhlrMRcWJAJI2nMiAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAd3l/P+iDB4fZLHY9PE9q8XZpjfs
        Fpd3zWGz+Nx7hNHi84bHjBa3G1ewObB5zG64yOLRt2UVo8fnTXIBzFFcNimpOZllqUX6dglc
        GX++fGAq2M1X8fjDKcYGxsvcXYycHBICJhJfJm5g7mLk4hAS2MkoMXvCGnaQBK+AoMSPyfdY
        uhg5OJgF5CWOXMqGMNUlpkzJBakQErjPKPHwjRVEtZbEgae72UBsFgFViVsTuhhBbDag+P4X
        N8Di/AKKEld/PGYEGSMqECHRfaISJCwioCHx5Pd5sHJmgd2MEmtWaIPYwgJWEjfmrWOFWHWe
        UWJHkzeIzSlgIPFx0m32CYwCs5DcOQvhzlkIdy5gZF7FKJlaUJybnltsVGCYl1quV5yYW1ya
        l66XnJ+7iREYxNsOa/XtYLy/JP4QowAHoxIP74uJf6OEWBPLiitzDzFKcDArifD6VQKFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ897OOxYpJJCeWJKanZpakFoEk2Xi4JRqYOyXZ3kcsD117cyp
        n2cdShd5ZjN9dsBu04a0H7PuLF543OWM5t/L61jOL9V4pcxY9C47QcY2mi120yzWfKFHGaGz
        PPKfvj4SUV4246DhJJNOkXfzDEIEHCTWHuPr7e9NX+UrLjvXxe8PS/TfT4vTygVVhHknzr2V
        J5i+XP2i7WPGwl888xJufVJiKc5INNRiLipOBACGzV2JXgIAAA==
X-CMS-MailID: 20180517232631epcas1p405e6b7ea3590cc51ef35ea77e0930624
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180515212545epcas1p2bdfd9c90f2ce6b74ac0fdd8cd9f9f63b
X-RootMTR: 20180515212545epcas1p2bdfd9c90f2ce6b74ac0fdd8cd9f9f63b
References: <CGME20180515212545epcas1p2bdfd9c90f2ce6b74ac0fdd8cd9f9f63b@epcas1p2.samsung.com>
        <20180515212447.180595-1-mka@chromium.org> <5AFCE27E.20803@samsung.com>
        <20180517230728.GQ19594@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 05월 18일 08:07, Matthias Kaehlcke wrote:
> Hi,
> 
> On Thu, May 17, 2018 at 11:01:34AM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> Could you give some use-case of DEVFREQ_POLICY_NOTIFIER
>> or send use-case patch with this patch?
> 
> This is a WIP patch that makes use of the DEVFREQ_POLICY_NOTIFIER:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1065122
> 
>> I already knew the CPUFREQ_POLICY_NOTIFIER.
>> But, until now, there are no any requirements of DEVFREQ_POLICY_NOTIFIER.
>> If there are no any use-case, it is not necessary codes.
> 
> Sure, I intend to land the above driver upstream if devfreq can
> provide the necessary interfaces.

I recommend that you should send the patch with the use-case patch.

> 
>> On 2018년 05월 16일 06:24, Matthias Kaehlcke wrote:
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index fe2af6aa88fc..a7294c056f65 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -273,6 +273,9 @@ int update_devfreq(struct devfreq *devfreq)
>>>  	if (err)
>>>  		return err;
>>>  
>>> +	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
>>> +			DEVFREQ_ADJUST, &freq);
>>
>> It is not proper to used 'freq' as the passed data.
>> In current step,'freq' is not adjusted and is not final decided
>> frequency.
> 
> Right, the next revision will pass a struct devfreq_policy instead,
> where the notifiers can adjust the min/max values, similar to what
> cpufreq does.

Actually, I don't know the devfreq_policy(?). As I already commented,
it is not proper to discuss it because there is no any real code and patches.
It is difficult to understand for me.

> 
> Thanks
> 
> Matthias
> 
> 
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
