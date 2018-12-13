Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B213C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D4120849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TB+LFfwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D4120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeLMOfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:35:32 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40352 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbeLMOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:35:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181213143530euoutp02657e355baedf4839fff0046431c8ed40~v6yJlk_CD2910729107euoutp02B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 14:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181213143530euoutp02657e355baedf4839fff0046431c8ed40~v6yJlk_CD2910729107euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544711730;
        bh=tplgx2aXfwY2BsZ5Q93KNjQ0ntUlma7cEBkjWvpTmZE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TB+LFfwovYe2fIQCwUz5ve/K4MOdSs0EUqhaErXW1P/zNp3F7/h/JYYNKUbXpGqNG
         pbKhdT+A+G+gt4gAK4O2+OXHJ0sVD/2rX8kyHNh+BnuP0y0kCSc5toc88FgVcwaeE/
         d7XcPQQLDSNtsUM07qbpgDImM4HOZMvQNJELeAUs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181213143528eucas1p16df29a8c12ec932ebff0755325ed0814~v6yIKz3li1206612066eucas1p1h;
        Thu, 13 Dec 2018 14:35:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A1.B6.04294.03E621C5; Thu, 13
        Dec 2018 14:35:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181213143527eucas1p26f095744959e561c2c89f0a2cc1a6018~v6yHRX9Ct3165531655eucas1p2n;
        Thu, 13 Dec 2018 14:35:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181213143527eusmtrp244357e2af604938842afa8843befcae8~v6yHPAoxP1700917009eusmtrp2j;
        Thu, 13 Dec 2018 14:35:27 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c9-5c126e3084f9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.3D.04284.F2E621C5; Thu, 13
        Dec 2018 14:35:27 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181213143526eusmtip2f09d476a50ab5153444e3901e99df4ee~v6yGXvjfr0258702587eusmtip2N;
        Thu, 13 Dec 2018 14:35:26 +0000 (GMT)
Subject: Re: [PATCH v3 4/5] drivers: power: suspend: call devfreq
 suspend/resume
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <ce1d415d-2a00-ef0e-6b58-23d16cffee4a@partner.samsung.com>
Date:   Thu, 13 Dec 2018 15:35:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544007956-28889-5-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUxTWRj19q2g1Utd+olrqiZiIm4k3oz7Rl40Zmb8gUaNWuUFjW3FPnCP
        oo4WShE0BLVWMHFUUjCFWkutIojFuhQLEldSN4zGQRJjUaMSlefDDP/OOd8593xfcnlKU8zG
        8xtMGaLZpDfo2Fjae+NLePxEk2blRJ9NS65dTCCVx1wMqar8xJCHHW8YUhK4y5D9p10sCeUa
        SX5rG0XC4QqONOx7xxF7YbWKuFsfMKTZ72BJNC+AyLHwVRU5H4hw5MzDJhVp2VvKksjt+q78
        nXsMOVAd4MjBsvcMedf4lJ6tFbyXvYxQXlyOhBNZTbRQkP8BCaevvFUJbmcOK9ScLOeEC//u
        Eb7f4ATPfQstHPI4kVBa9pkTou7hf6mXx05PFQ0btojmCTPXxK7PcXbS6S29t50tbKOz0PUY
        K4rhASfBWftr1opieQ0uRfC5yIoU0oHgWmerSiFRBC/qCtHvSPEhD60MziEIFp3sJu0IHufm
        sbKrP14CQZuLkQcDcAiB94fvF6FwMQVPP0S63uJ5FieCz7lZDqhxMkQabJyMaTwGTuVXMzIe
        iJdB9rMyVvHEwa3jr2g5GoMXwcevM2SZwlp48qpEpeARUNXuoOQqwM95iETPsMra86GttpJR
        cH/4L+jhFDwUflxSwoAlaMh2dvt3geWWr9szDa4Hmxi5l8IJ4PJPUOQ5EPLX/loHcF941B6n
        rNAXjniPUoqshuyDGsU9Fjy2xu6iQXCuvIgrQDp7j7vsPY6x9zjG/n/vKUQ7kVbMlIxpojTZ
        JG5NlPRGKdOUlrhuk9GNun7tne/BDh/yd66tQ5hHuj7q2mFxKzWMfou03ViHgKd0A9Sty7sk
        dap++w7RvGm1OdMgSnVoCE/rtOqdvZ6v0OA0fYa4URTTRfPvqYqPic9Co6yWfnerHbkDdaND
        lxrX0FV/7O/n3ZhqMbnz/v4z+VFC4YLb0/nBQ0KHXUutzTUXP9Yw2yxxqSX1u8dVmAzLXub4
        dzoyXoiropNSZln+Ofp2cM7IWUkFAYM2aeG3YMqgKdK8mzZOc2Hm1Oa5I9Ir701uSX49P7vC
        H+9zfFu8O1zPpuhoab1+0jjKLOl/AqIMZ9WxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+XbO2Tlao+PU/LSwHJZZdPR426dptx9xoD9RQbFKXXpQyW12
        zmZZP9Iiw2lZEWUrp2AXWZZ5ScUrecXUlpYKmXZRMJtWaCaFSVsj8N/zXp735YWXwuQVhA+V
        otXzgladqpC64j1LXWNbg7Tyo8G5X/3R82eBqKKgnEC1FT8JNPxjkkBF7S8JdKGkXIp6czUo
        f9yGIav1KYn6zk+TyHSjSYIqx4cI9Lr+rhTNXW4HqMDaLEGP20dJdH+4X4JGskqlaPRFh93v
        GSDQxaZ2EmU/+k6g6Vdj+E4vrqahhuDKzGWAu5PZj3NX82cBV9I4JeEqLTlSrqWwjOSq7p3j
        ljpJrnrwEs5dqbYArvTRAsnNVfruk6mYaEFn0PPrk3WiPkZxhEUhDBuJmJCwSIYNVR6LCglX
        BG2PTuRTU9J5IWh7PJOcY1nE00ZWnH5ww4ZngjYXI3ChIB0GzVeqcSNwpeT0fQDb2m4SzsJq
        eL25lnSyO1wcMkodLKdtAH7KZR3sTu+HXXnlhEP2oHsBNHbfIh0BRpsxOGmeAc6x7wFsePhS
        YgQUJaUZWGc56bBl9B442pf3bwNOb4DF+U3/NnvSh2Hf1BPg7HGD3bcncIfqQu+F879jHGmM
        joDmqo+Yk73g24kiiZPXwdqZu9hVIDcts03LFNMyxbRMKQa4BXjwBlGTpBFZRlRrRIM2iUnQ
        aSqB/V1qOn9V1YGBigOtgKaAYqUseY3bUTmhThczNK0AUpjCQzausqdkieqMM7ygixMMqbzY
        CsLtt13DfDwTdPbn0+rj2HBWiSJZZagyNAIpvGTW4AyVnE5S6/kTPJ/GC/89CeXikwkCmOkX
        a1W7jpcWevd+SIw1tPzpP7Xr7J8et1LzG/JLmHd0ib77W8O1LI3vRBTL1g8GWpsUHREBn1Ez
        bjAevlDybn2jYCvY4RciHtyW6jf/JD57lS7Af9bre80mdkG1JXZgk7u/aPPJ3r1z0c9bCTcW
        HnLdE2t8OiF5IAT5ftvboMDFZDW7GRNE9V8MsBMORAMAAA==
X-CMS-MailID: 20181213143527eucas1p26f095744959e561c2c89f0a2cc1a6018
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110623eucas1p120f9d8b38822bf856a5b7d427d00e49f@eucas1p1.samsung.com>
        <1544007956-28889-5-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

I see that you have pulled 3 patches.
Please take also this patch, which is actually enabling the feature.

Regards,
Lukasz

On 12/5/18 12:05 PM, Lukasz Luba wrote:
> Devfreq framework supports suspend of its devices.
> Call the the devfreq interface and allow devfreq devices preserve/restore
> their states during suspend/resume.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>   drivers/base/power/main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index a690fd4..0992e67 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -32,6 +32,7 @@
>   #include <trace/events/power.h>
>   #include <linux/cpufreq.h>
>   #include <linux/cpuidle.h>
> +#include <linux/devfreq.h>
>   #include <linux/timer.h>
>   
>   #include "../base.h"
> @@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
>   	dpm_show_time(starttime, state, 0, NULL);
>   
>   	cpufreq_resume();
> +	devfreq_resume();
>   	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
>   }
>   
> @@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
>   	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
>   	might_sleep();
>   
> +	devfreq_suspend();
>   	cpufreq_suspend();
>   
>   	mutex_lock(&dpm_list_mtx);
> 
