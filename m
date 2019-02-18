Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D0EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF93218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 05:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kye1UkiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfBRFlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 00:41:07 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59393 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfBRFlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 00:41:07 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190218054103epoutp03f123b782d2c1b0ee5115eebb4b086632~EXtpHOoQo2176621766epoutp03O
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 05:41:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190218054103epoutp03f123b782d2c1b0ee5115eebb4b086632~EXtpHOoQo2176621766epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550468463;
        bh=nnmNNttPtuN6se7xv1VYYxQmNoYsrYbagrHYgLCaDP8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kye1UkiMQjKCuSasLabGj68mGI6F3jpYBaarmQik90i+C4XvlR9x8kcdvmexMR+6y
         UH07W7QbgQaJ1NiLMOPswQmTKuvL3n5ntjt3zSWr7u6ifSv0Wr/tXPBGZnjsyTBrOn
         o7zbRTqwFZWokALOEghSCgcKhG0tT+gAKe1g0in8=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190218054100epcas1p25e53070440ea98d558c2c9ffb2bd5f1a~EXtmDy4cf2979529795epcas1p2m;
        Mon, 18 Feb 2019 05:41:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.E6.04288.B654A6C5; Mon, 18 Feb 2019 14:40:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190218054059epcas1p18d05c5bf923bc990aab78586080f1a61~EXtlQfqAA0085200852epcas1p15;
        Mon, 18 Feb 2019 05:40:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190218054059epsmtrp24fe16f5ec6dd1f2d4202251d9f175259~EXtlPQFWB2618626186epsmtrp26;
        Mon, 18 Feb 2019 05:40:59 +0000 (GMT)
X-AuditID: b6c32a38-bf7ff700000010c0-d4-5c6a456b6879
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.B4.03601.B654A6C5; Mon, 18 Feb 2019 14:40:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190218054058epsmtip29c3304a26b14906df774bb1f3a2bac3e~EXtlBcaIq3262932629epsmtip2t;
        Mon, 18 Feb 2019 05:40:58 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] trace: events: add devfreq trace event file
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <bfe5eced-712e-774a-a5d9-3649e276e848@samsung.com>
Date:   Mon, 18 Feb 2019 14:40:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550235913-5189-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmnm62a1aMwcmVFhYbZ6xntTjb9Ibd
        4laDjMXlXXPYLD73HmG0WHvkLrvFpQMLmCw+b3jMaHG7cQWbxb6OB0wWh9+0szpwe8xuuMji
        0bLvFrvHwXd7mDze77vK5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM/7NW8RW0CVW0XfgH0sD4wShLkYODgkBE4ld
        U2O7GLk4hAR2MEo8mHuUFcL5xCixb85XJgjnG6PE5KcPgBxOsI45Jz+wQST2MkrsbLgM5bxn
        lDi7ppURpEpYwF3iyZJJrCC2iECaxNv2u2CjmAUOMEo8WrmCHSTBJqAlsf/FDTYQm19AUeLq
        j8dgzbwCdhJXvs8HW8cioCoxdddnFhBbVCBC4nDvO6gaQYmTM5+AxTkFvCRubVgLtoxZQFzi
        1hOIXmYBeYnmrbOZQRZLCExmlzjwdg4jxA8uEh8OrYWyhSVeHd/CDmFLSXx+t5cNwq6WWHny
        CBtEcwejxJb9F1ghEsYS+5dOZgIFH7OApsT6XfoQy/gk3n3tYYWEKq9ER5sQRLWyxOUHd6FB
        JymxuL2TDaLEQ+JMm+sERsVZSL6ZheSDWUg+mIWwawEjyypGsdSC4tz01GLDAhPk2N7ECE66
        WhY7GPec8znEKMDBqMTD+6EsM0aINbGsuDL3EKMEB7OSCO8ux6wYId6UxMqq1KL8+KLSnNTi
        Q4ymwMCeyCwlmpwPzAh5JfGGpkbGxsYWJoZmpoaGSuK86x2cY4QE0hNLUrNTUwtSi2D6mDg4
        pRoYJy8WUcxyXTQ399VE50MLVzxUnL3ZxfgJz9RndrGVtu5HV7/4ViVvGTXtsx6zQOi3QI5l
        s/TUD79u41JImH66N+zO1s2Cvvn6Tls1L6qc8sw5Xe7g/msmT4ndSV+11YwCW+d7MDjW3RD4
        qHq+2uXDprfrPxzxaNI4Mjnvz2pHBuPDGVp632YIKbEUZyQaajEXFScCAKP41F3QAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvG62a1aMwaP/TBYbZ6xntTjb9Ibd
        4laDjMXlXXPYLD73HmG0WHvkLrvFpQMLmCw+b3jMaHG7cQWbxb6OB0wWh9+0szpwe8xuuMji
        0bLvFrvHwXd7mDze77vK5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZ/+YtYivoEqvoO/CP
        pYFxglAXIyeHhICJxJyTH9hAbCGB3YwSx/v8IeKSEtMuHmXuYuQAsoUlDh8u7mLkAip5yyjR
        M6GRBaRGWMBd4smSSawgtohAmsShhtvsIDazwAFGieabPhANdxkl3j7aAZZgE9CS2P/iBtgy
        fgFFias/HjOC2LwCdhJXvs9nArFZBFQlpu76DLZAVCBC4uPTfUwQNYISJ2c+AYtzCnhJ3Nqw
        lhVimbrEn3mXmCFscYlbTyDmMAvISzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz0
        3GLDAqO81HK94sTc4tK8dL3k/NxNjODo09LawXjiRPwhRgEORiUe3g9lmTFCrIllxZW5hxgl
        OJiVRHh3OWbFCPGmJFZWpRblxxeV5qQWH2KU5mBREueVzz8WKSSQnliSmp2aWpBaBJNl4uCU
        amCMeXRoWszH/5acswN5PjnG7We776bn29NoX+YUdWTrUx3FlZPb8g+t829/VlD5VP5aeid3
        ms5qs+kffk6I3cDIodC5YUGP3dsrb60D3Hd/Xy85u7aB60tH3Bv9T8JBX/k3V2pa+WRPmJie
        9p2J+dhhiemKfWz/eNs+li5wsjwVZNv6UHLCIU8lluKMREMt5qLiRAClANh0ugIAAA==
X-CMS-MailID: 20190218054059epcas1p18d05c5bf923bc990aab78586080f1a61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d
References: <1550235913-5189-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190215130555eucas1p219217e3f1d0901f61be78870df0ecf6d@eucas1p2.samsung.com>
        <1550235913-5189-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 15. 오후 10:05, Lukasz Luba wrote:
> The patch adds a new file for with trace events for devfreq
> framework. They are used for performance analysis of the framework.
> It also contains updates in MAINTAINERS file adding new entry for
> devfreq maintainers.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                    |  1 +
>  include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>  create mode 100644 include/trace/events/devfreq.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41ce5f4..9c44076 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4447,6 +4447,7 @@ S:	Maintained
>  F:	drivers/devfreq/
>  F:	include/linux/devfreq.h
>  F:	Documentation/devicetree/bindings/devfreq/
> +F:	include/trace/events/devfreq.h
>  
>  DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
>  M:	Chanwoo Choi <cw00.choi@samsung.com>
> diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
> new file mode 100644
> index 0000000..ce83dba
> --- /dev/null
> +++ b/include/trace/events/devfreq.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM devfreq
> +
> +#if !defined(_TRACE_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_DEVFREQ_H
> +
> +#include <linux/devfreq.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(devfreq_monitor,
> +	TP_PROTO(struct devfreq *devfreq),
> +
> +	TP_ARGS(devfreq),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, freq)
> +		__field(unsigned long, busy_time)
> +		__field(unsigned long, total_time)
> +		__field(unsigned int, polling_ms)
> +		__string(dev_name, dev_name(&devfreq->dev))
> +	),
> +
> +	TP_fast_assign(
> +		__entry->freq = devfreq->previous_freq;
> +		__entry->busy_time = devfreq->last_status.busy_time;
> +		__entry->total_time = devfreq->last_status.total_time;
> +		__entry->polling_ms = devfreq->profile->polling_ms;
> +		__assign_str(dev_name, dev_name(&devfreq->dev));
> +	),
> +
> +	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%lu",
> +		__get_str(dev_name), __entry->freq, __entry->polling_ms,
> +		__entry->total_time == 0 ? 100 :

I case of __entry->total_time is zero,
why do you show '100' instead of '0'(zero)?
I think that it might make the some confusion for user.

If it show the '100' in case of "__entry->total_time is zero",
it cannot distinguish between the real 100% utilization
and "total_time is zero".

> +			(100 * __entry->busy_time) / __entry->total_time)
> +);
> +#endif /* _TRACE_DEVFREQ_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
