Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D7BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1734B2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r+IGf/tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfBMNfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:35:07 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45582 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfBMNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:35:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190213133505euoutp02fc45c547e6f825995ff1663546f76fee~C79GR4xGd2170821708euoutp02R
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:35:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190213133505euoutp02fc45c547e6f825995ff1663546f76fee~C79GR4xGd2170821708euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550064905;
        bh=bzKSzLMw6pSTlGTBRr+Rf6uZQpMqycBtRGCFfTkrwnQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=r+IGf/tElOWJdQc73Y57DJQc6jgUD+DllaDf9eHDAqO45+1QLd/5rFbnDhgB1twd6
         e55rUaRUjNsoTfDoaR8vBK+KVgdqZl7fR6aDhiNrpFy6SNsk8yxJN3obFg++SoQ+jZ
         8j/GfmxzDM26LhzCIetmLnNtKrBgJv4rthnkWfbg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190213133504eucas1p206581476b09aa123ac40f23db2275849~C79Fq4bmm2838328383eucas1p2g;
        Wed, 13 Feb 2019 13:35:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F7.B3.04806.80D146C5; Wed, 13
        Feb 2019 13:35:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190213133503eucas1p25932f2dbc4a5d60444ac08aebeea91d6~C79E1LVjD0080700807eucas1p2H;
        Wed, 13 Feb 2019 13:35:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190213133503eusmtrp2db0c811fa055ec26a84fa0c8a6280240~C79EmJUtu1927419274eusmtrp2I;
        Wed, 13 Feb 2019 13:35:03 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-c3-5c641d08a291
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 20.DB.04284.70D146C5; Wed, 13
        Feb 2019 13:35:03 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190213133502eusmtip23512072ac976fa0f95e9aba67daf5341~C79ECUEY40740607406eusmtip2I;
        Wed, 13 Feb 2019 13:35:02 +0000 (GMT)
Subject: Re: [PATCH v3 6/7] trace: events: add devfreq trace event file
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        mingo@redhat.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <fb5d5359-7663-f119-f28f-7be820e1108d@partner.samsung.com>
Date:   Wed, 13 Feb 2019 14:35:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212181415.1156e542@gandalf.local.home>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe7f75drW29I82YcwmFTgTDK7UYhF1KB/pA/6EmzlZUqb1q4z
        rQizSLNcX2S5LJdRrrGwlplFraGWiVhZrsIZCUlSaJIzxHSZd9fI/37nPc95znngZaSqDjKK
        yczK4cxZeqOakhF1L0ZexzLz01OXjDjk7L3LNSRbNviOYD8M9ZLsrQIN21bYR7PvHldQbKC0
        CbF3mj7R7FuvXcIG7n5BrP+og2I9xd0StrGviGQHLvDJSp3rmgvprhS0E7rjnk5aZ3dbdNcH
        f5G6AY+P0llrnUgXcC9IYXbIVqVzxsxczhyXtEuW8duq3BeMyrv63kEUoI6IEhTGAE6AU1Wv
        6RIkY1TYgcB1rWayGEIwOFBJikUAwXCLjSpBTGik+icrTKtwNYLOVrWo6UcwVuUkhcYsvB7u
        +7yEwOF4IRy39xKCSIqfSSDY5CEFIwprod65X9Ao8DqwVjfTAhNYA09Kb4R8IvA2aCz9gUTN
        TGgp7wl5huEVcO6mnxJYiiOhs6dSInI0POyvkAq7AAdpaPKXkeLRa6Ht9nYx8iz43lxLizwP
        xh+Js4B5aCt2UiIfhqKW+knNSmhsbg/ZSPEiqHkcJzquhsDzvSIq4WP/TPEAJZyvuyQVnxVQ
        fEIleiyE2tNvJvfMhmpXGX0WqW1TYtmmRLFNiWL7v9aOCCeK5Cy8ycDxS7O4A1peb+ItWQbt
        nmyTG038tdY/zb/qkWdsdwPCDFLLFXmq9FQVqc/l800NCBipOlxxGCaeFOn6/IOcOTvNbDFy
        fAOayxDqSMWhad07Vdigz+H2ctw+zvyvK2HCogoQ1f5wKGnbibo1ET6tL7k8Odre6iv8ORrc
        M0MzHL9mY0zaoW+J9y9VJG5+ML3DahqThxc9Wp5z1Tt+cYHV6G6kCwMxNk3CK7/d8FQy58jS
        rp2fsytTYLzPFd+7bGvXy3N9X5U2m8KdGevz/omhNp7Bxxa1b9kkP+nbEDc6n0bDL9QEn6GP
        Xyw18/q/FHeymmcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7rssikxBlfOCVlsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8WlAwuYLD5veMxocbtxBZvFvo4HTBaH
        37SzWryfXOzA57Fm3hpGj9kNF1k8WvbdYvdYsKnUY+Gnr6we7/ddZfPo27KK0ePzJrkAjig9
        m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jF99fAV/
        pSrmXlvB0sB4RbSLkYNDQsBEYvlHiy5GTg4hgaWMEj27ikFsCQExiUn7trND2MISf651sXUx
        cgHVvGaU6F/bwgiSEBZwl9h89QALiC0ioCHRsuA5C0gRs8B+Jokn6zcwQXT0MUmcfHKQCWQb
        m4CexI5VhSANvAJuEn3Lj4NtYBFQldjTu5gVxBYViJD4+HQfE0SNoMTJmU/AFnAKWEpMXHqb
        DcRmFjCTmLf5ITOELS5x68l8JghbXmL72znMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5N
        zy021CtOzC0uzUvXS87P3cQIjOdtx35u3sF4aWPwIUYBDkYlHt4KoZQYIdbEsuLK3EOMEhzM
        SiK8NRJAId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4Hppq8knhDU0NzC0tDc2NzYzMLJXHe
        8waVUUIC6YklqdmpqQWpRTB9TBycUg2M6vv/xUxr429c4WhknvVXMc6DyW9z5ccTTK35wk7O
        Qi9eTtY2y+/421rDy379SY+K9ddu5m2qYlkb1ffO1fbQ6/u5d6ZByo/zE9Vz5OeFtk/6mMYw
        V5XpqarO8QKrt+bx29R+LIgXunlRoXQV0z1hyY/Bl3h4Ii+XzFH8zm8uExFiNPXNtlwlluKM
        REMt5qLiRADrqAuf/QIAAA==
X-CMS-MailID: 20190213133503eucas1p25932f2dbc4a5d60444ac08aebeea91d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222437eucas1p198db6fca1f1ba3056d93c57327dd48ed@eucas1p1.samsung.com>
        <1550010238-24002-7-git-send-email-l.luba@partner.samsung.com>
        <20190212181415.1156e542@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2/13/19 12:14 AM, Steven Rostedt wrote:
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
> 
> How critical is the code that this trace event is called in. If it is
> not that critical (it is a slow path), then this is fine, but if this
> is not a slow path (something triggered 100 HZ or less), then I would
> recommend moving the above calculation to TP_printk(). A divide is a
> slow operation, and is best to do that in the post processing. The
> current location does the divide at the time of the tracepoint is
> called.
I wasn't aware of these two stages, good to know.
I will move it to TP_printk().
> 
> I would also have a check to make sure that total_time is not zero
> here, otherwise that could be bad.
> 
> 		__entry->busy_time = busy_time;
> 		__entry->total_time = total_time;
> 

>> +	),
>> +
>> +	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%u",
> 
> 
>> +		__get_str(dev_name), __entry->freq, __entry->polling_ms,
> 
> 		__entry->total_time == 0 ? 100 :
> 			__entry->busy_time / __entry->total_time)
Thank you for the review.
I will add this check.

Regards,
Lukasz
> 
> -- Steve
> 
>> +		__entry->load)
>> +);
>> +#endif /* _TRACE_DEVFREQ_H */
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
> 
> 
> 
