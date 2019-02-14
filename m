Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2142CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23B9222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cpnw+G4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392249AbfBNE6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:58:04 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:35121 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfBNE6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:58:03 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190214045800epoutp040e7de015ffa9230ba14da1e7904590cc~DIi6bsnPO0232002320epoutp04q
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 04:58:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190214045800epoutp040e7de015ffa9230ba14da1e7904590cc~DIi6bsnPO0232002320epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550120280;
        bh=0HO1PQiQH2xvFEkmXnfJToRvG1KtTmR163f5bbuWPHE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Cpnw+G4SUQ1JfgPKWjdbpjFgxkMZdeiJtxz6IYpK5mG+IqhUET+ufk4juqSOjlwSw
         xBDm6CfpnrYeJugfGtLJK7eFqBidmQijeSe5mnhpqCNpziDnAnL9hk2pWK5MiPwhve
         5QSkJLVqMaJrENLOAF4nFiaQtN/V85E+OmJRcF4E=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214045757epcas1p1d207c84aed610374a1abc1532da73eca~DIi4Dmd981146411464epcas1p1A;
        Thu, 14 Feb 2019 04:57:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.1D.04288.555F46C5; Thu, 14 Feb 2019 13:57:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190214045757epcas1p24c4ff27abfa240601455e419050be63f~DIi3sLm-C2040820408epcas1p2I;
        Thu, 14 Feb 2019 04:57:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214045757epsmtrp2eda7c16e4e38fb81d564fa37888f5719~DIi3qpSPj1405014050epsmtrp2q;
        Thu, 14 Feb 2019 04:57:57 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-af-5c64f555fed8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.40.03971.555F46C5; Thu, 14 Feb 2019 13:57:57 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190214045755epsmtip27d526fed0cdd5b29b1d71e1f1f3b91a0~DIi1shgeV0843108431epsmtip2j;
        Thu, 14 Feb 2019 04:57:55 +0000 (GMT)
Subject: Re: [PATCH v3 7/7] drivers: devfreq: add tracing for scheduling
 work
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org,
        mingo@redhat.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <971cee25-cb3c-97b0-087e-97551dc066ad@samsung.com>
Date:   Thu, 14 Feb 2019 13:57:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1550010238-24002-8-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmrm7o15QYg+l9OhYbZ6xntZj26TKL
        xbIGVYuzTW/YLW41yFhc3jWHzeJz7xFGi7VH7rJbXDqwgMni84bHjBa3G1ewWezreMBkcfhN
        O6sDr8eaeWsYPWY3XGTxaNl3i91j4aevrB4H3+1h8ni/7yqbR9+WVYwenzfJBXBEZdtkpCam
        pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2spFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjOOHB8NXPB
        Gb6KE3+qGxhfcncxcnJICJhILJyxjK2LkYtDSGAHo8S1/ptQzidGiUN/7rJDON8YJV6uucQI
        03Lw43JGiMReRone35tZIJz3jBLLN39iAakSFvCXODxrOhOILSKQJvG2/S4TSBGzwEdGiY0H
        2sGK2AS0JPa/uMEGYvMLKEpc/fEYbAWvgJ3E7ueL2UFsFgFViYX/r7KC2KICERKHe99B1QhK
        nJz5BGwOp4C3xNM7E8FqmAXEJW49mc8EYctLNG+dzQyyWEJgE7vEx+4dUD+4SDw59owdwhaW
        eHV8C5QtJfH53V42CLtaYuXJI2wQzR2MElv2X2CFSBhL7F86GWgDB9AGTYn1u/QhlvFJvPva
        wwoSlhDglehoE4KoVpa4/OAuE4QtKbG4vRNqvIfE645l7BMYFWcheWcWkhdmIXlhFsKyBYws
        qxjFUguKc9NTiw0LTJCjexMjODlrWexg3HPO5xCjAAejEg9vhVBKjBBrYllxZe4hRgkOZiUR
        XsWPQCHelMTKqtSi/Pii0pzU4kOMpsDQnsgsJZqcD8wceSXxhqZGxsbGFiaGZqaGhkrivOsd
        nGOEBNITS1KzU1MLUotg+pg4OKUaGJ3Dj/i/4xJdJfmoV8DlrGbJfatoa5fgBuX/E375b7kZ
        NDnlx1qRdUv5J92SDJyc23q4KivVPp5jzRW1gui3JZniLbem6u/yYcz/5c2i/+eAf+HJdzkL
        n579t8X39SmzG+JPWE0Ycps7OFOOOnv3aW05o15xq/TVy9a1/TUN8U/1BGP4z8tsVmIpzkg0
        1GIuKk4EANZ6CHjkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvG7o15QYg9NP+Cw2zljPajHt02UW
        i2UNqhZnm96wW9xqkLG4vGsOm8Xn3iOMFmuP3GW3uHRgAZPF5w2PGS1uN65gs9jX8YDJ4vCb
        dlYHXo8189YwesxuuMji0bLvFrvHwk9fWT0OvtvD5PF+31U2j74tqxg9Pm+SC+CI4rJJSc3J
        LEst0rdL4Mo4cHw1c8EZvooTf6obGF9ydzFyckgImEgc/LicsYuRi0NIYDejRMPN74wQCUmJ
        aRePMncxcgDZwhKHDxdD1LxllLjw5xgrSI2wgK/E6b2tYPUiAmkShxpus4MUMQt8ZJQ49OwA
        O0hCSOA+o8SJA1IgNpuAlsT+FzfYQGx+AUWJqz8egzXzCthJ7H6+GKyeRUBVYuH/q2ALRAUi
        JD4+3ccEUSMocXLmExYQm1PAW+LpnYlgNcwC6hJ/5l1ihrDFJW49mc8EYctLNG+dzTyBUXgW
        kvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4BjV0tzBeHlJ
        /CFGAQ5GJR7eCqGUGCHWxLLiytxDjBIczEoivIofgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUw8vYUaBT8XK8aeiZAR3TVtym/JrlMFemv/KO4i+10
        4qzy7MiADxX5D122fxb8USRyT9c18MuuXyGrtySZ737/3f3f1V2vTRi+tr3Ovyji0Tr9354A
        gWN1wnErGy6ebA16a3XTJXnb7JLiCdelmTV2r1RfIqlzv9tOXWpBffqF7wJKotkSt7/KK7EU
        ZyQaajEXFScCAIxR6yrNAgAA
X-CMS-MailID: 20190214045757epcas1p24c4ff27abfa240601455e419050be63f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222438eucas1p27e020c2b36f2e5a2188e4df6fb18488b@eucas1p2.samsung.com>
        <1550010238-24002-8-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> This patch add basic tracing of the devfreq workqueue and delayed work.
> It aims to capture changes of the polling intervals and device state.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 29e99ce..c1d0d8c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -29,6 +29,9 @@
>  #include <linux/of.h>
>  #include "governor.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/devfreq.h>
> +
>  /* The ~30% load threshold used for load calculation (due to fixed point
>   * arithmetic) */
>  #define LOAD_THRESHOLD_IN_DEVICE_USAGE (300)
> @@ -418,6 +421,7 @@ static void devfreq_monitor(struct work_struct *work)
>  	struct devfreq *devfreq = container_of(work,
>  					struct devfreq, work.work);
>  	unsigned int polling_ms;
> +	const char *df_name = dev_name(&devfreq->dev);

nit: You can use 'dev_name(&devfreq->dev)' directly
without defining the separate df_name.

>  
>  	mutex_lock(&devfreq->lock);
>  	polling_ms = devfreq_get_polling_delay(devfreq);
> @@ -429,6 +433,10 @@ static void devfreq_monitor(struct work_struct *work)
>  	schedule_delayed_work(&devfreq->work,
>  			      msecs_to_jiffies(polling_ms));
>  	mutex_unlock(&devfreq->lock);
> +
> +	trace_devfreq_monitor(df_name, devfreq->previous_freq, polling_ms,
> +			      devfreq->last_status.busy_time,
> +			      devfreq->last_status.total_time);

Regardless of type of work,
I think that trace point is necessary for devfreq framework.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

>  }
>  
>  /**
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
