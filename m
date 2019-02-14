Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1393C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95780222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EVwaLG5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfBNFCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:02:02 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:49257 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfBNFCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 00:02:01 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214050159epoutp03d065b057c75abf020ead34c168287f9c~DImY0FfAa0034100341epoutp03a
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:01:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214050159epoutp03d065b057c75abf020ead34c168287f9c~DImY0FfAa0034100341epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550120519;
        bh=jDA70eQaicai9JsUYh1vmLN778BbVHBl4FFTfnLvFIU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EVwaLG5kks70UlFpXcsoZLUc/zS66uuUq9rmxiQolLBcnA68i3BZfw72IzbeJ0Zdb
         4jU80aeZK2AINv5jfDFP9l1htle+r6QZ0H+8ScCmhHydLngAWOb12zuLs6nnDuBoxB
         cK83uKBg0O5VZWmdmSZ0oEaPXbgk5KHrCEvjRluk=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214050155epcas1p26aef811aa934bb0fe2452a7d704e052f~DImVItCNd1566315663epcas1p2H;
        Thu, 14 Feb 2019 05:01:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.4E.04288.346F46C5; Thu, 14 Feb 2019 14:01:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190214050154epcas1p2d03b2794217738362b46666e83871dda~DImUnOABF3136831368epcas1p22;
        Thu, 14 Feb 2019 05:01:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214050154epsmtrp2516c24b920786fa7b6d900a6a7707c62~DImUchtzR1630016300epsmtrp2B;
        Thu, 14 Feb 2019 05:01:54 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-4c-5c64f643f7e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.8D.03601.246F46C5; Thu, 14 Feb 2019 14:01:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214050154epsmtip2b03a2c499f8857cf51770278e8b5226d~DImUIwFqv0808008080epsmtip2W;
        Thu, 14 Feb 2019 05:01:54 +0000 (GMT)
Subject: Re: [PATCH v3 6/7] trace: events: add devfreq trace event file
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org, mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3e44ca8a-a72b-8bdd-e702-00c927bd3c06@samsung.com>
Date:   Thu, 14 Feb 2019 14:01:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fb5d5359-7663-f119-f28f-7be820e1108d@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmnq7zt5QYg+/HWSw2zljPajHt02UW
        i2UNqhZnm96wW9xqkLG4vGsOm8Xn3iOMFmuP3GW3uHRgAZPF5w2PGS1uN65gs9jX8YDJ4vCb
        dlYHXo8189YwesxuuMji0bLvFrvHwk9fWT0OvtvD5PF+31U2j74tqxg9Pm+SC+CIyrbJSE1M
        SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpYSaEsMacUKBSQ
        WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCd0bTuL0vB
        HdmKj98WsDUw/hPvYuTkkBAwkWg78ZWpi5GLQ0hgB6NE381F7BDOJ0aJuds/QznfGCVezvjH
        DNNyfcMlJhBbSGAvo8SbT24QRe8ZJW693wpWJCzgLrH56gEWEFtEIESi+f9ENhCbWWAak8Ss
        CYkgNpuAlsT+FzfA4vwCihJXfzxmBLF5Bewkbj+aBBTn4GARUJWY9MgRJCwqECFxuPcdVImg
        xMmZT8DGcwKt+nVoOtR4cYlbT+YzQdjyEs1bZzOD3CYhsIldYsecSYwgMyUEXCSaV4dC/CIs
        8er4FnYIW0ri87u9bBB2tcTKk0fYIHo7GCW27L/ACpEwlti/dDITyBxmAU2J9bv0IXbxSbz7
        2sMKMZ5XoqNNCKJaWeLyg7tMELakxOL2TqjxHhIbjn9mncCoOAvJN7OQfDALyQezEJYtYGRZ
        xSiWWlCcm55abFhgghzXmxjBaVnLYgfjnnM+hxgFOBiVeHgrhFJihFgTy4orcw8xSnAwK4nw
        Kn4ECvGmJFZWpRblxxeV5qQWH2I0BYb1RGYp0eR8YM7IK4k3NDUyNja2MDE0MzU0VBLnXe/g
        HCMkkJ5YkpqdmlqQWgTTx8TBKdXAWJyjLmN8/1Y99+fJh8p71L8ebZktp1pyiP3rPwU2MZuH
        JscU22f5bQ9Ya7GZOfPw5//3Wy7tWHKlt3s1c/X3Vdb7zO8vzQiafUvK1v/Xohcvz9wpuN50
        YZbGodPGLuc8pqVyV9S8T2D3+L9smuzH+bz1G8xvnt3w1DNrWnBT3PudIUVcX+dv6lZiKc5I
        NNRiLipOBAAa99k/4QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWy7bCSvK7Tt5QYgxcdYhYbZ6xntZj26TKL
        xbIGVYuzTW/YLW41yFhc3jWHzeJz7xFGi7VH7rJbXDqwgMni84bHjBa3G1ewWezreMBkcfhN
        O6sDr8eaeWsYPWY3XGTxaNl3i91j4aevrB4H3+1h8ni/7yqbR9+WVYwenzfJBXBEcdmkpOZk
        lqUW6dslcGU0rfvLUnBHtuLjtwVsDYz/xLsYOTkkBEwkrm+4xNTFyMUhJLCbUWLhhwOsEAlJ
        iWkXjzJ3MXIA2cIShw8XQ9S8ZZR4+uY/C0iNsIC7xOarB8BsEYEQie3/OsAGMQtMY5I4e3E9
        K0THaSaJKz++MYFUsQloSex/cYMNxOYXUJS4+uMxI4jNK2AncfvRJDaQbSwCqhKTHjmChEUF
        IiQ+Pt3HBFEiKHFy5hOwZZxAi38dmg42hllAXeLPvEvMELa4xK0n85kgbHmJ5q2zmScwCs9C
        0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHKVaWjsYT5yI
        P8QowMGoxMOrIJASI8SaWFZcmXuIUYKDWUmEV/EjUIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv
        fP6xSCGB9MSS1OzU1ILUIpgsEwenVAOjGvc5U60uvRnt3okav3o3cFl1xx/Oyf3TXXDN6nDS
        k0eHK3f1JR7QTZqqYXRjnu7aeUcXtR5s1hS5mNwj3s3wxlBTf4WMUgDvVoaQf4YyZk3b/A5z
        8zRdCwqY387RddLo4ZPKspu9f5uW75WICrp/pCN+D6P5z/OO7UsMGWdXeT/yur7L54cSS3FG
        oqEWc1FxIgAQTd5RzgIAAA==
X-CMS-MailID: 20190214050154epcas1p2d03b2794217738362b46666e83871dda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed@eucas1p1.samsung.com>
        <1550010238-24002-7-git-send-email-l.luba@partner.samsung.com>
        <20190212181415.1156e542@gandalf.local.home>
        <fb5d5359-7663-f119-f28f-7be820e1108d@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 13. 오후 10:35, Lukasz Luba wrote:
> Hi Steven,
> 
> On 2/13/19 12:14 AM, Steven Rostedt wrote:
>> On Tue, 12 Feb 2019 23:23:57 +0100
>> Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>>> The patch adds a new file for with trace events for devfreq
>>> framework. They are used for performance analysis of the framework.
>>> It also contains updates in MAINTAINERS file adding new entry for
>>> devfreq maintainers.
>>>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   MAINTAINERS                    |  1 +
>>>   include/trace/events/devfreq.h | 39 +++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 40 insertions(+)
>>>   create mode 100644 include/trace/events/devfreq.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 9919840..c042fda 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -4447,6 +4447,7 @@ S:	Maintained
>>>   F:	drivers/devfreq/
>>>   F:	include/linux/devfreq.h
>>>   F:	Documentation/devicetree/bindings/devfreq/
>>> +F:	include/trace/events/devfreq.h
>>>   
>>>   DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
>>>   M:	Chanwoo Choi <cw00.choi@samsung.com>
>>> diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
>>> new file mode 100644
>>> index 0000000..fec9304
>>> --- /dev/null
>>> +++ b/include/trace/events/devfreq.h
>>> @@ -0,0 +1,39 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#undef TRACE_SYSTEM
>>> +#define TRACE_SYSTEM devfreq
>>> +
>>> +#if !defined(_TRACE_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
>>> +#define _TRACE_DEVFREQ_H
>>> +
>>> +#include <linux/devfreq.h>
>>> +#include <linux/tracepoint.h>
>>> +
>>> +TRACE_EVENT(devfreq_monitor,
>>> +	TP_PROTO(const char *dev_name, unsigned long freq,
>>> +		 unsigned int polling_ms, unsigned long busy_time,
>>> +		 unsigned long total_time),
>>> +
>>> +	TP_ARGS(dev_name, freq, polling_ms, busy_time, total_time),
>>> +
>>> +	TP_STRUCT__entry(
>>> +		__string(dev_name, dev_name)
>>> +		__field(unsigned long, freq)
>>> +		__field(unsigned int, polling_ms)
>>> +		__field(unsigned int, load)
>>> +	),
>>> +
>>> +	TP_fast_assign(
>>> +		__assign_str(dev_name, dev_name);
>>> +		__entry->freq = freq;
>>> +		__entry->polling_ms = polling_ms;
>>> +		__entry->load = (100 * busy_time) / total_time;
>>
>> How critical is the code that this trace event is called in. If it is
>> not that critical (it is a slow path), then this is fine, but if this
>> is not a slow path (something triggered 100 HZ or less), then I would
>> recommend moving the above calculation to TP_printk(). A divide is a
>> slow operation, and is best to do that in the post processing. The
>> current location does the divide at the time of the tracepoint is
>> called.
> I wasn't aware of these two stages, good to know.
> I will move it to TP_printk().
>>
>> I would also have a check to make sure that total_time is not zero
>> here, otherwise that could be bad.
>>
>> 		__entry->busy_time = busy_time;
>> 		__entry->total_time = total_time;
>>
> 
>>> +	),
>>> +
>>> +	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%u",
>>
>>
>>> +		__get_str(dev_name), __entry->freq, __entry->polling_ms,
>>
>> 		__entry->total_time == 0 ? 100 :
>> 			__entry->busy_time / __entry->total_time)
> Thank you for the review.
> I will add this check.
> 
> Regards,
> Lukasz
>>
>> -- Steve
>>
>>> +		__entry->load)
>>> +);
>>> +#endif /* _TRACE_DEVFREQ_H */
>>> +
>>> +/* This part must be outside protection */
>>> +#include <trace/define_trace.h>
>>
>>
>>
> 
> 

I agree that trace point is necessary for devfreq framework.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
