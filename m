Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8A5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FF1222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i8NZ16HU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392286AbfBMOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:37:20 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40877 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfBMOhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:37:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190213143717euoutp02154226c52a8b338982161891e4c72080~C8zaXZ5VF2449224492euoutp027
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:37:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190213143717euoutp02154226c52a8b338982161891e4c72080~C8zaXZ5VF2449224492euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550068637;
        bh=J+eRoyC5+pDoNrW7q16IF/utAX3AR8+wZDp70qUhROk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=i8NZ16HUcgFkds6r+nE1Qir11c312dHu7sneRQ9lWDfiUO/LbhtUkUx2w5NYjFPN0
         5xtsi1r0MvNFktzps7mwNabU9Nxq6rnfk85x9j5uc6ChkjMUn258LU1crRElPqnj8E
         r8Cx8A4CUOeTkZBCPBDd7VxMvQBDSUia/Ex65NmA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213143716eucas1p1ee725ba1c3a3a35af9eaded23bd5c796~C8zZpo-oz0950309503eucas1p1l;
        Wed, 13 Feb 2019 14:37:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6F.B0.04441.C9B246C5; Wed, 13
        Feb 2019 14:37:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190213143715eucas1p1080f2dc061a014fc09673bef3b8d302d~C8zY4Ks-f0945209452eucas1p1u;
        Wed, 13 Feb 2019 14:37:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190213143715eusmtrp1f8e7d733c715dd3f6b144e1e74cbbc3f~C8zYpGT5G0441204412eusmtrp1W;
        Wed, 13 Feb 2019 14:37:15 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-48-5c642b9ce7bb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.B4.04284.B9B246C5; Wed, 13
        Feb 2019 14:37:15 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190213143715eusmtip1be059e203094afcbe9547efc9bfc2da8~C8zYBrYkQ3005230052eusmtip1h;
        Wed, 13 Feb 2019 14:37:15 +0000 (GMT)
Subject: Re: [PATCH v3 6/7] trace: events: add devfreq trace event file
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        mingo@redhat.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <b55633bc-827a-6420-d641-b34bc1a785be@partner.samsung.com>
Date:   Wed, 13 Feb 2019 15:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213085623.660e19da@gandalf.local.home>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7pztFNiDDqmKVpsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8WlAwuYLD5veMxocbtxBZvFvo4HTBaH
        37SzWryfXOzA57Fm3hpGj9kNF1k8WvbdYvdYsKnUY+Gnr6we7/ddZfPo27KK0ePzJrkAjigu
        m5TUnMyy1CJ9uwSujKO/9rAXbJSo2P1+HnsD4x3hLkZODgkBE4klsw6zdzFycQgJrGCUONTa
        xwrhfGGUaL5whwXC+cwocW3KUUaYlgeL5kIlljNKtG6/ywjhvGWUOHfwGgtIlbCAu8TmqwfA
        bBEBDYmWBc/BOpgF9jNJ/D2yD2gJBwebgJ7EjlWFIDW8Am4SXy/8ZgOxWQRUJeb8eQVmiwpE
        SBzufccIUSMocXLmE7CZnAKWEh+PPWEGsZkFxCVuPZnPBGHLS2x/O4cZZJeEwFd2iZsdPewQ
        Z7tITJzcyARhC0u8Or4FKi4jcXpyDwuEXSxxtmMVG4RdI9F+cgdUjbXE4eMXwW5mFtCUWL9L
        H8SUEHCU+Hw0G8Lkk7jxVhDiAj6JSdumM0OEeSU62oQgZmhIbOm5ALVfTGL5mmnsExiVZiH5
        axaSX2Yh+WUWwtoFjCyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAtPb6X/HP+1g/Hop
        6RCjAAejEg9vhVBKjBBrYllxZe4hRgkOZiUR3kB1oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        aoYH0UIC6YklqdmpqQWpRTBZJg5OqQbGylOnJm/srfFtL5S+83CJf/Bsow86M+zL/5oVLrmg
        mWfNdckzYaLJxai5G/8d7tV83Hfv6pf9cvwLMjcua9jXx9n37mRLTH0e0/qQ2TKHBffcOWqn
        q5uiYrN4b0XLPUOv9OWvG7b7lZufKK24GMd+/KtNzKPLTBmu0fMnHlToNZvuZfBx35WdSizF
        GYmGWsxFxYkAWmq2O2sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xu7qztVNiDF491LDYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddotLBxYwWXze8JjR4nbjCjaLfR0PmCwO
        v2lntXg/udiBz2PNvDWMHrMbLrJ4tOy7xe6xYFOpx8JPX1k93u+7yubRt2UVo8fnTXIBHFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GUd/7WEv
        2ChRsfv9PPYGxjvCXYycHBICJhIPFs1lAbGFBJYySjRvZoWIi0lM2redHcIWlvhzrYsNouY1
        o8T8HcwgtrCAu8TmqwfAekUENCRaFjwHsrk4mAX2M0k8Wb+BCcQREuhjkjh64jaQw8HBJqAn
        sWNVIUgDr4CbxNcLv8GGsgioSsz58wrMFhWIkPj4dB8TRI2gxMmZT8AWcApYSnw89gRsMbOA
        mcS8zQ+hbHGJW0/mM0HY8hLb385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5x
        Ym5xaV66XnJ+7iZGYERvO/Zz8w7GSxuDDzEKcDAq8fBWCKXECLEmlhVX5h5ilOBgVhLhDVQH
        CvGmJFZWpRblxxeV5qQWH2I0BXpuIrOUaHI+MNnklcQbmhqaW1gamhubG5tZKInznjeojBIS
        SE8sSc1OTS1ILYLpY+LglGpg1KkTSlZtnRRmySiiacHwt/PqVt6X4bf1pZb7Tpv1MIeRyca6
        wSDjXbzJHfP8XYt2LC894Z1W/N3s/BT2aSmPDVMf71gfsvpq89ILh2UjS2LU/n7/ys3xW3B1
        gmLbC4WInTWzp569qDL1wJLlll9lTUT4FA7ENM14wPL347xlYhVnntsmnI7QU2Ipzkg01GIu
        Kk4EAJeBE+/+AgAA
X-CMS-MailID: 20190213143715eucas1p1080f2dc061a014fc09673bef3b8d302d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed@eucas1p1.samsung.com>
        <1550010238-24002-7-git-send-email-l.luba@partner.samsung.com>
        <20190213085623.660e19da@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2/13/19 2:56 PM, Steven Rostedt wrote:
> On Tue, 12 Feb 2019 23:23:57 +0100
> Lukasz Luba <l.luba@partner.samsung.com> wrote:
> 
>> The patch adds a new file for with trace events for devfreq
>> framework. They are used for performance analysis of the framework.
>> It also contains updates in MAINTAINERS file adding new entry for
>> devfreq maintainers.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                    |  1 +
>>   include/trace/events/devfreq.h | 39 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>   create mode 100644 include/trace/events/devfreq.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9919840..c042fda 100644
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
>> index 0000000..fec9304
>> --- /dev/null
>> +++ b/include/trace/events/devfreq.h
>> @@ -0,0 +1,39 @@
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
>> +	TP_PROTO(const char *dev_name, unsigned long freq,
>> +		 unsigned int polling_ms, unsigned long busy_time,
>> +		 unsigned long total_time),
>> +
>> +	TP_ARGS(dev_name, freq, polling_ms, busy_time, total_time),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name)
> 
> I would also put the string at the end. Strings are stored as a dynamic
> array in the event, where the position of __string() holds a 32 bit
> number. The 16 MSBs is the length of the string and the 16 LSBs is the
> offset into the trace event (after the TP_STRUCT__entry).
That's a nice engineering. Thank you for sharing this knowledge.
> 
> That means on a 64 bit machine, there's a chance that this struct will
> have a 4 byte "hole" between the __string() meta data and the freq
> field.
I will put the string at the end.

Regards,
Lukasz
> 
> -- Steve
> 
>> +		__field(unsigned long, freq)
>> +		__field(unsigned int, polling_ms)
>> +		__field(unsigned int, load)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name);
>> +		__entry->freq = freq;
>> +		__entry->polling_ms = polling_ms;
>> +		__entry->load = (100 * busy_time) / total_time;
>> +	),
>> +
>> +	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%u",
>> +		__get_str(dev_name), __entry->freq, __entry->polling_ms,
>> +		__entry->load)
>> +);
>> +#endif /* _TRACE_DEVFREQ_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
> 
> 
> 
