Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeDMCcQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 22:32:16 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:48899 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbeDMCcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 22:32:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180413023211epoutp034755ac6bb6c6e9bd33dc44a047b7a818~k3g9lqx9t0314603146epoutp03j
X-AuditID: b6c32a36-f57ff70000000fc2-63-5ad0160f88e9
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5AD0160E.7050601@samsung.com>
Date: Fri, 13 Apr 2018 11:29:34 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: arvindY <arvind.yadav.cs@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: use put_device() instead of kfree()
In-reply-to: <5AD012CB.7030003@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nlKC1P89LboponAxWcnqPTGS4qRQZZCBGYUXbSDxV3a2dK
        1o9MKmu18BIIy2v1Q1ZiyZRSMpiWf8qi8BKlhJZkihCaWdnlbMfIf8/78Dzf870PL0mopmVq
        stjiwHYLZ6LlwdLu/pj4uJCIl7kJ3qUI/YirldA/r5xT6F/3NMj1C64BpH97rk2+W2Z86B5X
        GK95Pci40Lk1m8jFaUWYK8B2DbbkWwuKLYUGet/BvPQ8XXICE8ek6lNojYUzYwOdkZUdl1ls
        EiJpTRlnKhWobI7n6fhdaXZrqQNriqy8w0AfYRhWyySkaFmW1SYlHt3J6gTJcVzkm2RsK5tO
        tQ+3SCrQWJgTBZFAJYHrXLPCiYJJFfUAQfX87OrwDcFgV6f8n+p2zX2FH6uoXgTf58r9WElt
        gOW6CakTkSRBbYOBVyV+mqBi4NNirVR8ZxxBZd+KTNTHQuPiR+THUmoHNN3xEn4sF/jHn8YC
        WSFUJAwvTwU04VQOPGxeCuSGUceg2lcrEQN2Qs/ktYAmlMqE5XFXwBskBI++/RVYAKg2OXja
        55G4QAZ0Nz6ViTgUPg96Ff5PA7UZXj0xiPoqBFWPmghxuI5gaHRCIhoSYbrVuZq8Hua/XpWJ
        ZiVcuqgSJUaYbnpHiHgPVLS3rrZYK4F77vOSarTVvaYw9//C3GsKa0GEB0VgG28uxDxjY7U8
        Z+ZLLYXafKu5EwVuLDb5Abo5lOVDFInodUpN+YtclYwr48vNPgQkQYcp66cESlnAlZ/Gdmue
        vdSEeR/SCX3XEOrwfKtwsRZHHpOUmpCUzArXlcow9Eblx6xnuSqqkHPgEoxt2P7PJyGD1BXI
        hGFL/Intd3X1p+bpmcvescSO6DctDS1MzJvJTiK6LgT68cp7Y/MFdWTcz7N7hz7c2p/y64wj
        qv0W3GBr1PVG5axBmllype8LiWyWywsNz/+8PGEamfmR5bqaM3PIWXFSt91zOD3990X7UNTs
        AU8P22voICa6ohWJu2aq6rbQUr6IY2IJO8/9BbcrBl15AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsVy+t9jAV0+sQtRBkcu6Fpc613IbHG26Q27
        xeVdc9gsPvceYbS43biCzYHVY+esu+wefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlXHokWHB
        H8mKtVcXMDUw3hDpYuTkkBAwkVgycSN7FyMXh5DATkaJVz8esoAkeAUEJX5Mvgdkc3AwC8hL
        HLmUDWGqS0yZkgtRfp9R4v7Fl8wQ5VoSc788ZQSxWQRUJeat3gIWZwOK739xgw3E5hdQlLj6
        4zEjyBxRgQiJ7hOVIKaIQJxE0+JMkApmASuJXY/6wKYIC7hJ/LjbywaxagqTRFf3LbAxnAKa
        Etdv/2WfwCgwC8mhsxAOnYVw6AJG5lWMkqkFxbnpucVGBYZ5qeV6xYm5xaV56XrJ+bmbGIGh
        u+2wVt8OxvtL4g8xCnAwKvHwKlSejxJiTSwrrsw9xCjBwawkwjv9MVCINyWxsiq1KD++qDQn
        tfgQozQHi5I47+28Y5FCAumJJanZqakFqUUwWSYOTqkGRvvj3Im/4rY/qbqTYaOo3PrAbd6j
        TXK+11yebVvy2yKp4xDPlfNCZVNuhubveu978HyjaWGdXUGE8rQ7ZX9rzq64yGrTuTS+erWW
        mPWfR7u+73ueYu7tkLL20orW1s6eKg3NkldvWDiiJr8s2ZZfn7lri8mi0H3++jMm8rmmXXvb
        P6Gew/bsCiWW4oxEQy3mouJEAIDgPilZAgAA
X-CMS-MailID: 20180413022934epcas1p3b4cbf4b7e86f81e590e4755436afd4f1
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
X-RootMTR: 20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be
References: <CGME20180330114418epcas5p1affd1c3d97e7422dd33e6d3ca73073be@epcas5p1.samsung.com>
        <d8d8708d2283349c2c4f3e9f3c9fd5f47126d2bc.1522410143.git.arvind.yadav.cs@gmail.com>
        <5AD001C5.2040406@samsung.com> <5AD0041D.2050506@samsung.com>
        <5AD012CB.7030003@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 04월 13일 11:15, arvindY wrote:
> Hi Chanwoo,
> 
> On Friday 13 April 2018 06:43 AM, Chanwoo Choi wrote:
>> On 2018년 04월 13일 10:03, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> I'm sorry for the late reply.
>>>
>>> On 2018년 03월 30일 20:44, Arvind Yadav wrote:
>>>> Never directly free @dev after calling device_register() or
>>>> device_unregister(), even if device_register() returned an error.
>>>> Always use put_device() to give up the reference initialized.
>>>>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>>> ---
>>>>   drivers/devfreq/devfreq.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index fe2af6a..a225b94 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -625,7 +625,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>       err = device_register(&devfreq->dev);
>>>>       if (err) {
>>>>           mutex_unlock(&devfreq->lock);
>>>> -        goto err_dev;
>>>> +        put_device(&devfreq->dev);
>>>> +        goto err_out;
>>> why do you change the goto postion?
>>> err_out is correct to free the memory of devfreq instance.
>> Sorry. err_dev is correct instead of err_out.
> 
> If you will see the comment for device_register(drivers/base/core.c)
> there is mentioned that 'NOTE: _Never_ directly free @dev
> after calling this function, even if it returned an error!
> Always use put_device() to give up the reference initialized
> in this function instead. Here  put_device() will decrement
> the last reference and then free the memory by calling dev->release.
> Internally put_device() -> kobject_put() -> kobject_cleanup() which
> is responsible to call 'dev -> release' and also free other kobject resources.
> 
> We are releasing devfreq in devfreq_dev_release(). So no need
> to call kfree() again. It'll be redundant.  'err_out' is correct.

You're right. err_out is correct.
put_device() -> dev->release() -> devfreq_dev_release() -> kfree(devfreq)

>>
>>>>       }
>>>>         devfreq->trans_table =    devm_kzalloc(&devfreq->dev,
>>>> @@ -671,6 +672,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>       mutex_unlock(&devfreq_list_lock);
>>>>         device_unregister(&devfreq->dev);
>>>> +    devfreq = NULL;
>>> It is wrong. If you initialize the devfreq as NULL,
>>> never free the 'devfreq' instance.
> 
> No need to release memory after device_unregister().
> driver core will take care of this. It will release memory
> So no need to call free again.

If you have to initialize the devfreq instance as NULL,
I think that you better to init in the devfreq_dev_release()
as following:

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fe2af6aa88fc..8c52a13d3887 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -543,6 +543,7 @@ static void devfreq_dev_release(struct device *dev)
 
        mutex_destroy(&devfreq->lock);
        kfree(devfreq);
+       devfreq = NULL;
 }


>>>
>>>>   err_dev:
>>>>       if (devfreq)
>>>>           kfree(devfreq);
>>>>
>>>
>>
> 
> ~arvind
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
