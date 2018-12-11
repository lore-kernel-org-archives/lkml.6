Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919B3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440D12081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 05:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IqnSvyEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440D12081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbeLKFfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 00:35:31 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22865 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbeLKFfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 00:35:30 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181211053527epoutp020bba3f6358aeffcde7b37d4b81a74cfd~vMIDQRsNV2519025190epoutp02a;
        Tue, 11 Dec 2018 05:35:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181211053527epoutp020bba3f6358aeffcde7b37d4b81a74cfd~vMIDQRsNV2519025190epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544506527;
        bh=EcF85MChmvwzMR8GFteo3el4IKv0xhHrykgFxC1chKc=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=IqnSvyEW9L6aFnDXfctQxbSjugqnEIZ2ikzzphYX2JsbEvY7ljp0c0do8TzAyB3Co
         cNyRT6xabJnXRqkv7nyUe35y55WKEMQqAVMdlHSNYVCEbtlIBzRkDgcc+BvzMuH0pp
         RMc5Umu/aanXkMSms65Cgle68LbnRJyHgjfsWjPo=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181211053524epcas1p4798ee97c57d006a411e75248c6f7e4da~vMIA5chNb0651206512epcas1p4b;
        Tue, 11 Dec 2018 05:35:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.0F.04060.B9C4F0C5; Tue, 11 Dec 2018 14:35:23 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181211053522epcas1p186d000de8c948a699df4d7cb7eec614b~vMH-UJMjn0889308893epcas1p13;
        Tue, 11 Dec 2018 05:35:22 +0000 (GMT)
X-AuditID: b6c32a37-87ddc9c000000fdc-12-5c0f4c9bf3a4
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 0F.75.03601.A9C4F0C5; Tue, 11 Dec
        2018 14:35:22 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJK005NI4UY1W40@mmp2.samsung.com>; Tue, 11 Dec 2018 14:35:22 +0900 (KST)
Message-id: <5C0F4C9A.8030607@samsung.com>
Date:   Tue, 11 Dec 2018 14:35:22 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PM / devfreq: Restart previous governor if new
 governor fails to start
In-reply-to: <5164dea6-ad0c-d817-eb0d-36d9f4a718d4@codeaurora.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmnu5sH/4YgwdnWSzONr1ht7i8aw6b
        xefeI4wWtxtXsFmcOX2J1eLAxYlsDmwel/t6mTy2XG1n8ejbsorR4/MmuQCWqGybjNTElNQi
        hdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDlSgpliTmlQKGAxOJi
        JX07m6L80pJUhYz84hJbpdSClJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjEWvAwsWa1Vs
        +v2aqYFxmVIXIyeHhICJxOWJ3WxdjFwcQgI7GCVmzzrLDuF8Z5Tovt7HDlM1b0YXI4gtJLCB
        UWLtGm8Qm1dAUOLH5HssXYwcHMwC8hJHLmWDhJkFNCVefJnEAjHnLqPEhdkvGCHqtSQ625Yw
        gdgsAqoS9y+3gc1nA4rvf3GDDcTmF1CUuPrjMVi9qECExM7538BqRAR0JP7+uQ42lFlgN6PE
        hJnnmEESwgIJEodnP2MBsTkFnCROv1rCCFIkIbCHTWLPrd8sEB+4SJw6dpkRwhaWeHV8CzvI
        1RIC0hKXjtpC1LczSnx50cwK4UxglPhwajMTRIOxxLOFXUwQv/FJvPvawwrRzCvR0SYEUeIh
        sW/PD6iXe1gkXv66wDqBUXYWUijNQoTSLKRQWsDIvIpRLLWgODc9tdiwwBg59jYxghOalvkO
        xg3nfA4xCnAwKvHwKrTwxQixJpYVV+YeYpTgYFYS4dVN440R4k1JrKxKLcqPLyrNSS0+xGgK
        DOSJzFKiyfnAZJtXEm9oamRsbGxhYmhmamioJM77RGputJBAemJJanZqakFqEUwfEwenVAPj
        rGRH33PsrH2HH2il2YZZ7X71/J287pyw6B8T/k/Z57fyvawpx0lx/kA/lhtxaryWSfNS05IW
        3J7OcExyS7TInCe5nBMX3+uKejtJW77Jo4pLosY599KdqWc2T70+85u0j/D8rVNt69ftflC6
        KKJu6/fZltMXrPt+8fy8Z7aOL2piDebn9fbuVmIpzkg01GIuKk4EAA3BBkp+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsVy+t9jQd1ZPvwxBvfW6lqcbXrDbnF51xw2
        i8+9RxgtbjeuYLM4c/oSq8WBixPZHNg8Lvf1MnlsudrO4tG3ZRWjx+dNcgEsUVw2Kak5mWWp
        Rfp2CVwZi14HFizWqtj0+zVTA+MypS5GTg4JAROJeTO6GEFsIYF1jBK/b0mC2LwCghI/Jt9j
        6WLk4GAWkJc4cikbwlSXmDIlt4uRC6j6PqPEnFuXmCHKtSQ625YwgdgsAqoS9y+3sYPYbEDx
        /S9usIHY/AKKEld/PGYEmSMqECHRfaISJCwioCPx9891FpCZzAJ7GSWWvlkE1isskCDR0HaM
        GWJZH4vE34ajrCAJTgEnidOvljBOYBSYheTUWQinzkI4dQEj8ypGydSC4tz03GKjAsO81HK9
        4sTc4tK8dL3k/NxNjMCA3nZYq28H4/0l8YcYBTgYlXh4K9r4YoRYE8uKK3MPMUpwMCuJ8Oqm
        8cYI8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwKjlaVEe
        XlJ8UNYt4+YttUARxk7tbQIbFlgpGP2Rjf/0dt3FO+vqfv3/9vdGSL7r3feif7zOyMbq7mif
        8Lur2kDM5yj/ksJHHGqu/moOp7Zxi2xZmX4//ukcXR4e1hVnVI+80P9oXRR0w3tdw8JS2yPi
        S/tT+I94hyUzT2o+GuXO+dBX0LNKSYmlOCPRUIu5qDgRAJCN8OlkAgAA
X-CMS-MailID: 20181211053522epcas1p186d000de8c948a699df4d7cb7eec614b
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20161026191715epcas1p311c2c626563a736e14c83fb0504c099e
References: <CGME20161026191715epcas1p311c2c626563a736e14c83fb0504c099e@epcas1p3.samsung.com>
        <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
        <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com>
        <5820CE7E.40802@codeaurora.org> <5821948B.2010907@samsung.com>
        <58223AF1.2030605@codeaurora.org> <58227CDB.6050907@samsung.com>
        <58228B9E.2090108@samsung.com> <58228C10.3070502@samsung.com>
        <58238840.90802@codeaurora.org> <5823BB01.3090502@samsung.com>
        <5164dea6-ad0c-d817-eb0d-36d9f4a718d4@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

The devfreq git repo is maintained by Myungjoo Ham.
you can check it on MAINTAINERS file.

I think that you better to resend mail to mainline
with my reviewed tag because the devfreq core could be modified
and then merge conflict might be happen when apply this patch.

Regards,
Chanwoo Choi

On 2018년 12월 08일 05:29, Saravana Kannan wrote:
> 
> On 11/9/16 4:10 PM, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2016년 11월 10일 05:34, Saravana Kannan wrote:
>>> On 11/08/2016 06:38 PM, Chanwoo Choi wrote:
>>>> On 2016년 11월 09일 11:36, Chanwoo Choi wrote:
>>>>> Hi,
>>>>>
>>>>> On 2016년 11월 09일 10:33, Chanwoo Choi wrote:
>>>>>> On 2016년 11월 09일 05:52, Saravana Kannan wrote:
>>>>>>> On 11/08/2016 01:02 AM, Chanwoo Choi wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 2016년 11월 08일 03:57, Saravana Kannan wrote:
>>>>>>>>> On 10/26/2016 05:06 PM, Chanwoo Choi wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 2016년 10월 27일 04:17, Saravana Kannan wrote:
>>>>>>>>>>> If the new governor fails to start, switch back to old governor so that the
>>>>>>>>>>> devfreq state is not left in some weird limbo.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>>>>>>>>>> ---
>>>>>>>>>>> * Fix NULL deref for real this time.
>>>>>>>>>>> * Addressed some style preferences.
>>>>>>>>>>>
>>>>>>>>>>>      drivers/devfreq/devfreq.c | 13 +++++++++++--
>>>>>>>>>>>      1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>>>>>>> index bf3ea76..77c41a5 100644
>>>>>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>>>>>> @@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>>>>>>>>          struct devfreq *df = to_devfreq(dev);
>>>>>>>>>>>          int ret;
>>>>>>>>>>>          char str_governor[DEVFREQ_NAME_LEN + 1];
>>>>>>>>>>> -    struct devfreq_governor *governor;
>>>>>>>>>>> +    const struct devfreq_governor *governor, *prev_governor;
>>>>>>>>>>>
>>>>>>>>>>>          ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>>>>>>>>>>>          if (ret != 1)
>>>>>>>>>>> @@ -944,12 +944,21 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>>>>>>>>>>                  goto out;
>>>>>>>>>>>              }
>>>>>>>>>>>          }
>>>>>>>>>>> +    prev_governor = df->governor;
>>>>>>>>>>>          df->governor = governor;
>>>>>>>>>>>          strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>>>>>>>>>>>          ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>>>>>>>>>>> -    if (ret)
>>>>>>>>>>> +    if (ret) {
>>>>>>>>>>>              dev_warn(dev, "%s: Governor %s not started(%d)\n",
>>>>>>>>>>>                   __func__, df->governor->name, ret);
>>>>>>>>>>> +        if (prev_governor) {
>>>>>>>>>> I think that prev_governor is always set. You don't need to check it.
>>>>>>>>>> Why do check it?
>>>>>>>>> Not true. Even higher up in this function, we check if df->governor != NULL. Simple example would be that the default governor passed in while adding the device isn't compiled in.
>>>>>>>> I don't understand. If device is not registered by devfreq_add_device(),
>>>>>>>> you don't change the governor by using governor_store().
>>>>>>>>
>>>>>>>> If you can change the governor through governor_store(),
>>>>>>>> it means that the devfreq instance was added without any problem.
>>>>>>>> The added devfreq instance must have the sepecific governor
>>>>>>>> on df->governor variable.
>>>>>>>>
>>>>>>>> So, I think that df->governor is always set and then prev_governor is always set.
>>>>>>> Read the code more closely. add_device doesn't (and shouldn't) fail if the governor isn't present. After that, the governor could be changed from user space.
>>>>>> If governor is not present during devfreq_add_device(),
>>>>>> the devfreq instance is not able to register the devfreq framework.
>>>>>> So, the user never touch the sysfs[1] to change the governor
>>>>>> because the sysfs[1] is not created by devfreq framework.
>>>>>> [1] /sys/class/devfreq/[device name]/governor
>>>>>>
>>>>>> In summary, if governor is not present during devfreq_add_device(),
>>>>>> the devfreq framework doesn't create tye sysfs[1] for governor.
>>>>>>
>>>>>> The user-space never change the governor through sysfs[1]
>>>>>> because there is no any sysfs entry[1].
>>>>> I checked the code of devfreq_add_device().
>>>>> As you mentioned, if there is no governor,
>>>>> devfreq_add_device() don't pass wihtout calling the devfreq->governor->even_handler().
>>>> Wrong expression / don't pass -> pass
>>>>
>>> I think it's correct as is. Just because the governor isn't there (or hasn't registered yet) doesn't mean the device add should fail.
>>>
>>> That aside, do you care to ack this patch for the way the code is currently?
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> After fixing the bug of devfreq_add_device(),
>> I'll remove the unneeded 'if statement' of prev_governor in governor_store.
> 
> It's been 2 years and this patch still hasn't been picked up. Can we please pick this up and get this into the next kernel release?
> 
> Thanks,
> 
> Saravana
> 

