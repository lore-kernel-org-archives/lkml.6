Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABC4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B742173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B6CmERWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391686AbfBRR5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:57:43 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34021 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389053AbfBRR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:57:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190218175741euoutp0294bf9d2e969866d1687ef1b11a6b1b65~Ehwznuoag2184521845euoutp02Z
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 17:57:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190218175741euoutp0294bf9d2e969866d1687ef1b11a6b1b65~Ehwznuoag2184521845euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550512661;
        bh=gw3DcwaeINo88FaMLJkPfk+38srHZtsCHy/RLo6sZfU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B6CmERWskAjLD8N9WKDLSjlKn05Ennj3a1G1f+6lexNhrCxiWB6OcjdmzAM6D0mn4
         jMNlqckushWLyN1vaHjX8Cs337I0ROxrEJ/Y5txDF/WAdN1TQnBqeoxNgpqrJv/5v5
         LbtpMlYbc8c9BeLgO0f3qfzTY5wbpD3U2LbLsxIk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190218175740eucas1p247f812fa0301d3cbe49c771b47ad274c~EhwyjR-A80718307183eucas1p2Z;
        Mon, 18 Feb 2019 17:57:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 10.A6.04294.312FA6C5; Mon, 18
        Feb 2019 17:57:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190218175739eucas1p11d649d5bfb2ef69e3043e894cc4dc94b~EhwxzArI01355813558eucas1p1a;
        Mon, 18 Feb 2019 17:57:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190218175739eusmtrp1e25a3334c7864a7663f0b4b6b56b0d7f~Ehwxkafyp1675516755eusmtrp1z;
        Mon, 18 Feb 2019 17:57:39 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-02-5c6af2138c36
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 36.90.04284.212FA6C5; Mon, 18
        Feb 2019 17:57:38 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190218175738eusmtip1577b7403d17bcf3ec481c4d595184a05~EhwxGlV1w0804408044eusmtip10;
        Mon, 18 Feb 2019 17:57:38 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] trace: events: add devfreq trace event file
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <bd9bfc80-0589-ea1e-1115-ca7fc9225990@partner.samsung.com>
Date:   Mon, 18 Feb 2019 18:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bfe5eced-712e-774a-a5d9-3649e276e848@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURTGu/PmzXuOjlxH04NFwURRYZrVHw+UMpIaqEgEadNyzIfrjDpP
        LbVCS3Q0rVAqN9Ryl8JcsknNXGcYxFwiNC0xF9q0MhcQxPL5lPzvd77z3XPOB5cm5E2kPR2k
        iWS1GlWoQiIV1xsWe/ZZ/wn23m9YdGCqs6pIZmDuC8l035qimHcNeRJmNr0DMc86PlFMf0uh
        iJl9Po6Y4YRyCdOsGxUx7VPJpJu5Mje+T6xMbB6ilL+a30uUd+sqkXK2ZpsHeUHq6s+GBkWz
        WqfDvtLA+Q86Mrzc7trCzD0qHt2xTkVmNOBDMFwySKYiKS3H5QhahvPXijkERdWvkVDMIuia
        6yPWnxj79RKe5bgMwQ9TiGCaRvC5J1nMN6zxCZgozlgZRdM22A+y/rryHgK3IBirKKd4XYId
        QV8Zwdtl+DjMPK4leRbjnVA80E3xvBmfg/b0n0jwWIEpe2J1vBk+AiP1k6t+AtvB0ESBSODt
        cPtFLsHvAtxPwcfUNiQc7Q7jCfq1ANbw3VhHCbwVujLTxAJz0K2rlAh8HZJN+jWPC7Qb+1az
        EHgPVDU4CfJReDs5IuJlwJYwOG0lnGAJGfWPCEGWgS5JLrh3Q11ar0hgWyh7+pC6jxQ5G4Ll
        bAiTsyFMzv+9hUhciezYKE4dwHIHNOxVR06l5qI0AY5XwtQ1aOVPdS0b5/SoYcmvDWEaKSxk
        hWXB3nJSFc3FqNsQ0ITCRmYYXJFk/qqYWFYbdlkbFcpybWgLLVbYyeI2jV6U4wBVJBvCsuGs
        dr0ros3s41HCk7HMLquDrSVn4kq5r4zJQ68xjUVO5nd/K7D0TfIwnHV3qPW6aU5YNZ2Pl2o6
        vRp9qo4tR6RYjJ62VNPtnkt0aZHF/MsH6Z3oRsYpH29yyVPX2lRg/iq7RxXb6ejK7XijcbHJ
        IyuMC27FJ3+nXGrc5dxrbptYah/S6OdfOhGpEHOBKue9hJZT/QN03Ig2TwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7pCn7JiDLbdsLbYOGM9q8X1L89Z
        Lc42vWG3uLxrDpvF594jjBZrj9xlt7h0YAGTxecNjxktbjeuYLPY1/GAyeLwm3ZWB26P2Q0X
        WTxa9t1i93i/7yqbR9+WVYwenzfJBbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqb
        x1oZmSrp29mkpOZklqUW6dsl6GV8vdnBWrBCvOLbx372BsZu4S5GTg4JAROJ45d2sHUxcnEI
        CSxllLh9eSYjREJMYtK+7ewQtrDEn2tdUEWvGSUefvrDBJIQFnCXeLJkEiuILSKQJDHl+AM2
        EJtZ4ACjRPNNH4iGSUwSE3bdYOli5OBgE9CT2LGqEKSGV8BN4uPCzWC9LAKqEkuunwVbJioQ
        IfHx6T4miBpBiZMzn7CA2JwC9hL3tj1lhZhvJjFv80NmCFtc4taT+UwQtrxE89bZzBMYhWYh
        aZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzObcd+bt7BeGlj8CFG
        AQ5GJR7eBcuzYoRYE8uKK3MPMUpwMCuJ8B67ARTiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHk
        fGDiyCuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwNh0jmflQuf3
        QqFzZ+vqH9pePaO1bKrm1qQCUfcwJisGBnletTzvpCX8bA8qtf/usLmi+froZ+flL07UVjoe
        MXxfnSo8RTakecvWx2cOvmo8MT1x9+6vRXFHLAy6NirmxRdeEon+qxiheUJb/NbS+KtJ29Mm
        LV6g2bQzU3sh289J54v0grY4dymxFGckGmoxFxUnAgCK6E3A5AIAAA==
X-CMS-MailID: 20190218175739eucas1p11d649d5bfb2ef69e3043e894cc4dc94b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d
References: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d@eucas1p2.samsung.com>
        <1550235913-5189-2-git-send-email-l.luba@partner.samsung.com>
        <bfe5eced-712e-774a-a5d9-3649e276e848@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2/18/19 6:40 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 2. 15. 오후 10:05, Lukasz Luba wrote:
>> The patch adds a new file for with trace events for devfreq
>> framework. They are used for performance analysis of the framework.
>> It also contains updates in MAINTAINERS file adding new entry for
>> devfreq maintainers.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                    |  1 +
>>   include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>   create mode 100644 include/trace/events/devfreq.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 41ce5f4..9c44076 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4447,6 +4447,7 @@ S:	Maintained
>>   F:	drivers/devfreq/
>>   F:	include/linux/devfreq.h
>>   F:	Documentation/devicetree/bindings/devfreq/
>> +F:	include/trace/events/devfreq.h
>>   
>>   DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
>>   M:	Chanwoo Choi <cw00.choi@samsung.com>
>> diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
>> new file mode 100644
>> index 0000000..ce83dba
>> --- /dev/null
>> +++ b/include/trace/events/devfreq.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM devfreq
>> +
>> +#if !defined(_TRACE_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_DEVFREQ_H
>> +
>> +#include <linux/devfreq.h>
>> +#include <linux/tracepoint.h>
>> +
>> +TRACE_EVENT(devfreq_monitor,
>> +	TP_PROTO(struct devfreq *devfreq),
>> +
>> +	TP_ARGS(devfreq),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, freq)
>> +		__field(unsigned long, busy_time)
>> +		__field(unsigned long, total_time)
>> +		__field(unsigned int, polling_ms)
>> +		__string(dev_name, dev_name(&devfreq->dev))
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->freq = devfreq->previous_freq;
>> +		__entry->busy_time = devfreq->last_status.busy_time;
>> +		__entry->total_time = devfreq->last_status.total_time;
>> +		__entry->polling_ms = devfreq->profile->polling_ms;
>> +		__assign_str(dev_name, dev_name(&devfreq->dev));
>> +	),
>> +
>> +	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%lu",
>> +		__get_str(dev_name), __entry->freq, __entry->polling_ms,
>> +		__entry->total_time == 0 ? 100 :
> 
> I case of __entry->total_time is zero,
> why do you show '100' instead of '0'(zero)?
> I think that it might make the some confusion for user.
> 
> If it show the '100' in case of "__entry->total_time is zero",
> it cannot distinguish between the real 100% utilization
> and "total_time is zero".
Good point, I will change it.

Regards,
Lukasz
> 
>> +			(100 * __entry->busy_time) / __entry->total_time)
>> +);
>> +#endif /* _TRACE_DEVFREQ_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>>
> 
> 
