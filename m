Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB2AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F6621738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Plxw257f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfBSA0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:26:08 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:30918 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfBSA0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:26:07 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190219002558epoutp01c9867c29a71ff2efe910fe69357b84a3~EnD1W1OXR2025220252epoutp019
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 00:25:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190219002558epoutp01c9867c29a71ff2efe910fe69357b84a3~EnD1W1OXR2025220252epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550535959;
        bh=qC7iJC2HIde6V8Pmd4RzVBfKyMAd5ipCPgkcQSeteSA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Plxw257fLydoiAhjEs0gEzPTGrmAUC6bAYOr5aW/yuYI2pQugbmhmyLg8sLrqdzzs
         F2UhL52hAoyRzGGHZ1fi8PSPvNyiN5Mx4yeGonz/yG/Wcr8FInbqOeRSLs1zbI+AAK
         EyTPMOgu1/EB8+jScjoxUh08ldzIyXmz7AZDX9KE=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190219002554epcas1p111187c547a93cb8911793b5ad8070ca1~EnDxQ88Ks0947409474epcas1p1F;
        Tue, 19 Feb 2019 00:25:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.B4.04173.11D4B6C5; Tue, 19 Feb 2019 09:25:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190219002552epcas1p44a53a3c532069cc1f7fdaf4d9d3d0372~EnDvwcEJ12168021680epcas1p4T;
        Tue, 19 Feb 2019 00:25:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190219002552epsmtrp11caee6d17de12d5d3671117895f60d54~EnDvvE6x50844508445epsmtrp1f;
        Tue, 19 Feb 2019 00:25:52 +0000 (GMT)
X-AuditID: b6c32a36-a2c1c9c00000104d-ad-5c6b4d117762
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.F4.03971.01D4B6C5; Tue, 19 Feb 2019 09:25:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190219002552epsmtip213843b19091e0736e0f14a007f33fc40~EnDvfpjGZ0449204492epsmtip2L;
        Tue, 19 Feb 2019 00:25:52 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] trace: events: add devfreq trace event file
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <aef5a336-779f-3e9d-ec4e-cea1d78f7c09@samsung.com>
Date:   Tue, 19 Feb 2019 09:25:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550514069-9237-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmnq6gb3aMwbx5chYbZ6xntTjb9Ibd
        4laDjMXlXXPYLD73HmG0WHvkLrvFpQMLmCw+b3jMaHG7cQWbxb6OB0wWh9+0szpwe8xuuMji
        0bLvFrvHwXd7mDze77vK5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
        Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUDnKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM+ZOKC+4KFLx5fY3xgbG/wJdjJwcEgImEnOu
        T2fqYuTiEBLYwShx6dM1VgjnE6NE+9EvUM43Rol3E2YwwrRcv/uaGcQWEtjLKNG1xwjCfs8o
        8bjHo4uRg0NYwF1izowEkLCIQJrE2/a7YBuYBQ4wSjxauYIdJMEmoCWx/8UNNhCbX0BR4uqP
        x2DzeQXsJPomPWcCsVkEVCX+vXsPFhcViJA43PsOqkZQ4uTMJywgNqeAl8Srly/A6pkFxCVu
        PZkPZctLNG+dzQyyWEKgn13i//oD7CDHSQi4SMz8VQ7xi7DEq+Nb2CFsKYmX/W1QdrXEypNH
        2CB6Oxgltuy/wAqRMJbYv3QyE8gcZgFNifW79CF28Um8+9rDCjGeV6KjTQiiWlni8oO7TBC2
        pMTi9k42CNtDYtvWy2wTGBVnIflmFpIPZiH5YBbCsgWMLKsYxVILinPTU4sNC4yQo3oTIzjd
        apntYFx0zucQowAHoxIP74LlWTFCrIllxZW5hxglOJiVRHgXeWbHCPGmJFZWpRblxxeV5qQW
        H2I0BQb2RGYp0eR8YC7IK4k3NDUyNja2MDE0MzU0VBLnXe/gHCMkkJ5YkpqdmlqQWgTTx8TB
        KdXAOFX6w4yQUyb+mqwz1ixvYwr3/fMqQ61EyMD7xcPqtOmKAm9370mauaI5wYxNaopW7NRl
        rE8jpk/R9Ap7teYd5xzFn5ZuWcc2f6h58pi7Ilj9nO/L46e5T29q6mF9N8/Ng/VV1bo3hpeu
        WHbcuVZ/SWJbRJ6kga99iWOFd7FG8JqGVq93676LK7EUZyQaajEXFScCAPxpXzzNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvK6Ab3aMwYeJJhYbZ6xntTjb9Ibd
        4laDjMXlXXPYLD73HmG0WHvkLrvFpQMLmCw+b3jMaHG7cQWbxb6OB0wWh9+0szpwe8xuuMji
        0bLvFrvHwXd7mDze77vK5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZcyeUF1wUqfhy+xtj
        A+N/gS5GTg4JAROJ63dfM3cxcnEICexmlNg1u4UZIiEpMe3iUSCbA8gWljh8uBii5i2jxOx/
        d1hB4sIC7hJzZiSAlIsIpEkcarjNDmIzCxxglGi+6QNRf5dR4uuUZkaQBJuAlsT+FzfYQGx+
        AUWJqz8eg8V5Bewk+iY9ZwKxWQRUJf69ew8WFxWIkPj4dB8TRI2gxMmZT1hAbE4BL4lXL18w
        QSxTl/gz7xIzhC0ucevJfKi4vETz1tnMExiFZyFpn4WkZRaSlllIWhYwsqxilEwtKM5Nzy02
        LDDMSy3XK07MLS7NS9dLzs/dxAiOPS3NHYyXl8QfYhTgYFTi4V2wPCtGiDWxrLgy9xCjBAez
        kgjvIs/sGCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoY
        pzRwTzhwTCeBg1HwiVfgy2u8q6Q6j6SZV23fVvH/yYsP3ss8ruw90zmHOWXVhF2nC/zC7Lhy
        Xsh8v3hiiujHaB8N7+nO1obuTlePGp+47G/utWPtD+s9Z2dcqZ/bHx75c+Vso1sKD/vUamQZ
        Ly+TXa2wWfnVrhWd05+Y17+W1bpZIhZwqJJroRJLcUaioRZzUXEiAA2Afpi5AgAA
X-CMS-MailID: 20190219002552epcas1p44a53a3c532069cc1f7fdaf4d9d3d0372
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885
References: <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190218182129eucas1p236fc8ccddd9a8cde25c15f7545276885@eucas1p2.samsung.com>
        <1550514069-9237-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 19. 오전 3:21, Lukasz Luba wrote:
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
> index 0000000..cf5b877
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
> +		__entry->total_time == 0 ? 0 :
> +			(100 * __entry->busy_time) / __entry->total_time)
> +);
> +#endif /* _TRACE_DEVFREQ_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> 

I think that it is necessary for devfreq. Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
