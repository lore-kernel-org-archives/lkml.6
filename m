Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE8DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE6A2190B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cfvv+S11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394470AbfBOLrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:47:31 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55680 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394446AbfBOLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:47:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190215114728euoutp02ef347599cbe9a5d069ef4d08ae7b3801~DhxuDfEne0653906539euoutp02m
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 11:47:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190215114728euoutp02ef347599cbe9a5d069ef4d08ae7b3801~DhxuDfEne0653906539euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550231249;
        bh=Nvo7v9AvXuEM7KWnnvjrMmAokgA6weQ+AcaUp2z/M48=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cfvv+S115hUXlW9lT1Eu8YgmpHQkn/0Wq5E9dYRRUX9DtPaI5CiBZtrq/Vs6YvQmn
         VkrHW4GV+wPRd+Gdbg4gTzaz0CucRpOAdyf6didxyCBjSV6DBCrxfQevGqa/+9KGo0
         kmwlfdGQ0FFYLL7voPsS+ch8Rgj76ZeoAnq08MrA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190215114728eucas1p1b31b0f1a8d7c861b8a10b88ef9ca6dcd~DhxtNwwzd1244912449eucas1p1g;
        Fri, 15 Feb 2019 11:47:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 64.0A.04806.FC6A66C5; Fri, 15
        Feb 2019 11:47:27 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190215114727eucas1p2bd3afef813fd88b83ff8c53b6fb3567a~Dhxsj8OeE1248612486eucas1p2j;
        Fri, 15 Feb 2019 11:47:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190215114727eusmtrp112e7011599720504597820a3a6e3fbbf~DhxsVJPZ20038000380eusmtrp1C;
        Fri, 15 Feb 2019 11:47:27 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-2c-5c66a6cf7c72
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 95.9F.04128.FC6A66C5; Fri, 15
        Feb 2019 11:47:27 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190215114726eusmtip1745ec0036472faa2b50c915f4155c98c~Dhxr2Af5x3026830268eusmtip1O;
        Fri, 15 Feb 2019 11:47:26 +0000 (GMT)
Subject: Re: [PATCH 2/2] drivers: devfreq: add tracing for scheduling work
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        mingo@redhat.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <07d46246-dfb2-2001-c1b6-b6a54df562df@partner.samsung.com>
Date:   Fri, 15 Feb 2019 12:47:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214140725.307d493c@gandalf.local.home>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7rnl6XFGJzcbmSxccZ6VovrX56z
        WpxtesNucXnXHDaLz71HGC3WHrnLbnHpwAImi88bHjNa3G5cwWaxr+MBk8XhN+2sDtwesxsu
        sni07LvF7vF+31U2j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4Mq4f+cOe8FawYop7w8xNzD+
        5u1i5OSQEDCRWDL5ABuILSSwglGi4ZJbFyMXkP2FUeJq9wNWCOczo8TJ6d2MMB37GmYxQiSW
        M0o0Xn3CAuG8ZZS4NbuXBaRKWMBLYuac+awgtoiAhkTLgudgRcwCfxgljq6ZA5Tg4GAT0JPY
        saoQpIZXwE3i//0N7CA2i4CqxJ8v08G2iQpESBzufccIUSMocXLmE7D5nAKWEg9Wf2MCsZkF
        xCVuPZkPZctLbH87hxlkl4TAJXaJ+ScXMUGc7SKxd/1KNghbWOLV8S3sELaMxOnJPSwQdrHE
        2Y5VUDU1Eu0nd0DVWEscPn4R7GZmAU2J9bv0QUwJAUeJ83+MIEw+iRtvBSEu4JOYtG06M0SY
        V6KjTQhihobElp4LULeISSxfM419AqPSLCR/zULyyywkv8xCWLuAkWUVo3hqaXFuemqxcV5q
        uV5xYm5xaV66XnJ+7iZGYJo6/e/41x2M+/4kHWIU4GBU4uFdkZEaI8SaWFZcmXuIUYKDWUmE
        t3BGWowQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGxsZV
        O3heF1ypdA72U9A0TbzD4WZsHHDTxyZ7weH1ab/6Lr55XVUceHFTXITIJ6ZFbPFZbvlJOZGs
        xxp/iQrKSl/64uEsmaOjIar+UTSxfd/320+tU68nxQVolaluEkp/p7RkRiKXQ/2NtoPnMt3E
        I0zr7y9dGiAlIjzJXIpHaXHilrXujjlKLMUZiYZazEXFiQDYBtQGTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7rnl6XFGJxdx2qxccZ6VovrX56z
        WpxtesNucXnXHDaLz71HGC3WHrnLbnHpwAImi88bHjNa3G5cwWaxr+MBk8XhN+2sDtwesxsu
        sni07LvF7vF+31U2j74tqxg9Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0Mu4f+cOe8FawYop7w8xNzD+5u1i5OSQEDCR2Ncwi7GLkYtD
        SGApo8SrV5/ZIRJiEpP2bYeyhSX+XOtigyh6zSixcvcLRpCEsICXxMw581lBbBEBDYmWBc9Z
        QIqYBf4wSjz+MgEsISTQxyRx6R3QJA4ONgE9iR2rCkHCvAJuEv/vbwBbwCKgKvHny3SwmaIC
        ERIfn+5jgqgRlDg58wkLiM0pYCnxYPU3sDizgJnEvM0PmSFscYlbT+ZDxeUltr+dwzyBUWgW
        kvZZSFpmIWmZhaRlASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMDo3Hbs55YdjF3vgg8x
        CnAwKvHwrshIjRFiTSwrrsw9xCjBwawkwls4Iy1GiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVE
        k/OBiSOvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVANj9fIM1cDb
        L3t4OO79qFq5SO9Q9u7vzaaqkQfrrFdby06Z57JK4ckWw+74/4Jd3xY7Hbqsaq/0N3z+g4hJ
        OdfMVzp9dds1S1lO6lzOpzOKsnUrooOkf10t3G+id0ysZPLF/6terVyc4eCt/c9m/dl80Ymd
        P4SPsBZPjd/F8/2N35n3nUcds7s0lFiKMxINtZiLihMBmMREB+QCAAA=
X-CMS-MailID: 20190215114727eucas1p2bd3afef813fd88b83ff8c53b6fb3567a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0
References: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0@eucas1p1.samsung.com>
        <1550170676-14173-3-git-send-email-l.luba@partner.samsung.com>
        <20190214140725.307d493c@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2/14/19 8:07 PM, Steven Rostedt wrote:
> On Thu, 14 Feb 2019 19:57:56 +0100
> Lukasz Luba <l.luba@partner.samsung.com> wrote:
> 
>> This patch add basic tracing of the devfreq workqueue and delayed work.
>> It aims to capture changes of the polling intervals and device state.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0ae3de7..c9714fd 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -29,6 +29,9 @@
>>   #include <linux/of.h>
>>   #include "governor.h"
>>   
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/devfreq.h>
>> +
>>   static struct class *devfreq_class;
>>   
>>   /*
>> @@ -394,6 +397,11 @@ static void devfreq_monitor(struct work_struct *work)
>>   	queue_delayed_work(devfreq_wq, &devfreq->work,
>>   				msecs_to_jiffies(devfreq->profile->polling_ms));
>>   	mutex_unlock(&devfreq->lock);
>> +
>> +	trace_devfreq_monitor(dev_name(&devfreq->dev), devfreq->previous_freq,
>> +			      devfreq->profile->polling_ms,
>> +			      devfreq->last_status.busy_time,
>> +			      devfreq->last_status.total_time);
> 
> I would pass just devfreq into the tracepoint (it will be less work by
> gcc in this code path), and do all this work in the TP__fast_assign()
> 
> The string can still handle this with:
> 
> 		__string(dev_name, dev_name(&devfreq->dev))
> 
> And assigned:
> 
> 		__assign_str(dev_name, dev_name(&devfreq->dev))
> 
> But the rest of fast assign should be:
> 
> 	TP_fast_assign(
> 		__entry->freq = devfreq->previous_freq;
> 		__entry->busy_time = devfreq->last_status.busy_time;
> 		__entry->total_time = devfreq->last_status.total_time;
> 		__entry->polling_ms = devfreq->profile->polling_ms;
> 		__assign_str(dev_name, dev_name(&deqfreq->dev));
> 	}
I agree, it makes sense. Let me test this approach and then send v3
patches. Thank you for the review.

Regards,
Lukasz
> 
> -- Steve
> 
>>   }
>>   
>>   /**
> 
> 
> 
