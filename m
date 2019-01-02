Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12F5218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eHVGWa5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfABPIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:08:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53767 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfABPIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:08:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190102150846euoutp014e0b8718b4a453ad539b57440e764670~2EI51wAks3275232752euoutp01k
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jan 2019 15:08:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190102150846euoutp014e0b8718b4a453ad539b57440e764670~2EI51wAks3275232752euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1546441726;
        bh=Dauv+FCCkr7n/ZSEz6jvJVwA7TRT6PBibnYObEabNWs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eHVGWa5zCHpH9HFlV7VqFSOJbvXJfCdxn8CnOY5cYkrbsdJeiHRycQ0EmcBvVL27s
         cRk0+lzGZat6nHS8fKgaQZqsk/IR5Qac+r5t0fc6vzTCuXRLTgjId/SeFH45/ihRIT
         hIVoCtRRc0jG7RVJC9KWH4pvHZ4k3vL0lGMSwqb4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190102150844eucas1p1a38cad87181f71021188f438eb16e4bf~2EI3_eHLs2902929029eucas1p1m;
        Wed,  2 Jan 2019 15:08:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EC.EB.04294.BF3DC2C5; Wed,  2
        Jan 2019 15:08:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190102150843eucas1p178b4aa4faf0243a2c28236d54b402c2c~2EI3AX_kg2902329023eucas1p1n;
        Wed,  2 Jan 2019 15:08:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190102150842eusmtrp1ee3aa15b03dd0597f07f305d39becc8c~2EI2wssyf1315313153eusmtrp1o;
        Wed,  2 Jan 2019 15:08:42 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-66-5c2cd3fb658b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 45.6A.04128.AF3DC2C5; Wed,  2
        Jan 2019 15:08:42 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190102150841eusmtip2e53560e132d75204eeba41493dd8ddb4~2EI13KSHp2438424384eusmtip2D;
        Wed,  2 Jan 2019 15:08:41 +0000 (GMT)
Subject: Re: [PATCH v3 4/5] drivers: power: suspend: call devfreq
 suspend/resume
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     myungjoo.ham@samsung.com,
        "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <eda2b1f2-ed6f-b75f-f582-761c2a48c0cd@partner.samsung.com>
Date:   Wed, 2 Jan 2019 16:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221003305epcms1p756d76191d5f233c6e3238400d233b3c6@epcms1p7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTVxz29D6BlRyLs7/Aoqbuj2EcjG1ZzuKyaEbmTSTL4qLZg8xVuQEz
        iq4X2GTLRHl1lZesMOzqgyCPXLoU266QCjI7RmUVkJnJHNORQMQpXcxKAIWwcbmQ8d93vkd+
        35ccntI52Hj+cE6uaM4xZhvYaNrX93jw+fmb29NfcE0mk6vfJ5JL9S6GdFyaYcjI9CRDzvcO
        MqSo0cWS66dMpGr8IUWGhto5MnByiiN2W7eGuMdvMeSm38GSSEUvIvVDVzTku947HGkaGdaQ
        0ROtLLnz809L+dAvDCnp7uVIadsjhkzduEvv1Au+yz5GcJ5zIuHbwmFaqK76BwmNXX9pBLf8
        FSv0nHVyguficWGxjxO8v5bRQqVXRkJr2ywnRNyb3ta+H/1ahph9OF80J7/+UXTWqOcsdTSs
        /WzmdJguRHKMFUXxgF8G70Q1a0XRvA63IuiamuMUQYenEcz6E1QhgqCq5BpaTbSX+RjV1ILg
        dvtB1RRGcMZ1kVaEOLwXguUuRhE24EUN2GYuLD8oXMzCYOgyZUU8z+Ik6JQ/UQJa/CYE624t
        h2n8LFiuhCgFP43fBcufbazqWQ/9ZyZoJRqF34K7A68qNIX18PvEeY2KN0NH2EEppwD/wUNF
        f4RRW6dCpS+wsiAOHgS9nIqfgdDX5bSKJRiwyKyKv4Cy/s4Vzw74MTjMKHcpnAguf7JK74Lr
        /h+W6wCOhd/C69UKsVDj+4ZSaS1YSnWq+znwlt/QqHgjtDjruGpksK/ZZV8zxr5mjP3/uxcQ
        LSO9mCeZMkXpxRzx0yTJaJLycjKTDh0xudHSnw0tBqc7kX/hYABhHhme0lqubk/XMcZ86Zgp
        gICnDBu0G6UlSpthPFYgmo8cMOdli1IAJfC0Qa/9fN3YBzqcacwVPxbFo6J5VdXwUfGFqHBk
        T27avZ7ml2rmndV4/+OGeG+LITUi/73vkJwytqV5a5b/vnUiQ4gKcTsigd3veFizfp2j0dIU
        fBLc/W9tvocS3st0PLk25qFcRfpZ+UH6GG9bKLYf//AVd0xtzMMvm2zD9XuLTpVZIwMNW8ZH
        bXOPit7QxRU0ZHO30zpiewy0lGVM2UaZJeN/mJd/068DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sa0hTYRgHcN6dq+niNC97G3ZhCJXU0Wnqu7Lhh4hDHyy6SvdRRzfanJ0z
        o9WHVlLmssyS0JlT6IIsy5o2o1LRTDHTZZpGkVEZIToxNSMxaXMFfvu/z/P8XnjgoTGZi1DQ
        +kwzL2RqDUpyAd4x2zawZrpn9b5Yr3MVanq0Cj0sriZQ3cMpAvVPfidQeUsXgXJuVpPo1UUj
        Kvg6jCGP5wGFOs+OUMheVC9Brq99BOp5coNEE5daACr2NEjQvZaPFLrd3y1BH85Ukujjyxc+
        3/GGQOfqWyh0/u4YgUZeD+Apcs791E1wVY4qwJVau3HuSsE44G4+G5JwLmceyTWWVVFcza3T
        3GwrxdW+zcW5y7VOwFXe/UVxE66lW6V72GTBlG3ml+tMonmDcq8KxbEqNWLj1qpZVXzS/nVx
        CcoYTfIR3qA/zgsxmkOs7kNNGZbllZ6YKvTiVuAMtoEgGjJr4YNcN2EDC2gZcxvAL6V2KtCI
        gFcb6v7lUDjTZyMDQ8MAvpsaxPyNUGYbbMuvntNhjBWDP8crMP8DY2wkfFJZQAVIrwR6263A
        BmiaZFj42HnMr6XMJth2vQ/3Z5yJghcaOuZ+DWfSYOfQfRCYWQTbSwZxPw1iUuFAp9pfxphE
        6Kj5jAWyHL4fLJcE8jJY572BXQEy+zxtn0fs84h9HqkAuBOE8dmiMcMoxrGi1ihmZ2awh01G
        F/Ddi7v1d+1jYBvd3gwYGihDpLGNq/fJCO1x0WJsBpDGlGHSCNFXkh7RWk7ygumgkG3gxWaQ
        4NutEFOEHzb5ri/TfFCVoEpCalVSfFJ8IlLKpZ5Yyx4Zk6E180d5PosX/jsJHaSwgpDEXZbU
        XsVuKiV3mG+a3lg6qXGQ8gN2W63QmIeCC9jo5+uGBpktsrS3UeklRTnBTxPkCw+MhurvWEYG
        5Nd0eeoVHo08sjzIoI4YWy+986c33dG1I2RzyadIPZdWvVXR/D2qTCZ07zLkb/sWs7NtY8+p
        3+nRmiU/VkZXjC+eyVHiok6risYEUfsX6Nm8GUUDAAA=
X-CMS-MailID: 20190102150843eucas1p178b4aa4faf0243a2c28236d54b402c2c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f
References: <ce1d415d-2a00-ef0e-6b58-23d16cffee4a@partner.samsung.com>
        <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <1544007956-28889-5-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f@epcms1p7>
        <20181221003305epcms1p756d76191d5f233c6e3238400d233b3c6@epcms1p7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Gentle ping...
Please take this patch, it got ACK.
The other patches have been taken through MyungJoo's
tree, but this one is actually enabling the feature.

Regards,
Lukasz


On 12/21/18 1:33 AM, MyungJoo Ham wrote:
>> On 2018-12-05 12:05, Lukasz Luba wrote:
>>> Devfreq framework supports suspend of its devices.
>>> Call the the devfreq interface and allow devfreq devices preserve/restore
>>> their states during suspend/resume.
>>>
>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> 
> This looks all good to me.
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
>>> ---
>>>   drivers/base/power/main.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> index a690fd4..0992e67 100644
>>> --- a/drivers/base/power/main.c
>>> +++ b/drivers/base/power/main.c
>>> @@ -32,6 +32,7 @@
>>>   #include <trace/events/power.h>
>>>   #include <linux/cpufreq.h>
>>>   #include <linux/cpuidle.h>
>>> +#include <linux/devfreq.h>
>>>   #include <linux/timer.h>
>>>   
>>>   #include "../base.h"
>>> @@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
>>>   	dpm_show_time(starttime, state, 0, NULL);
>>>   
>>>   	cpufreq_resume();
>>> +	devfreq_resume();
>>>   	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>>>   }
>>>   
>>> @@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
>>>   	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>>>   	might_sleep();
>>>   
>>> +	devfreq_suspend();
>>>   	cpufreq_suspend();
>>>   
>>>   	mutex_lock(&dpm_list_mtx);
> 
> 
