Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CDAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C322087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C322087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeH1Pfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:35:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35292 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeH1Pff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:35:35 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7SBi7FJ015356;
        Tue, 28 Aug 2018 06:44:07 -0500
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7SBi7i6000300;
        Tue, 28 Aug 2018 06:44:07 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 28
 Aug 2018 06:44:06 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 28 Aug 2018 06:44:06 -0500
Received: from [172.22.217.254] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7SBi19u031702;
        Tue, 28 Aug 2018 06:44:02 -0500
Subject: Re: [PATCH v2] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <lokeshvutla@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <baolin.wang@linaro.org>,
        <d-gerlach@ti.com>, <tony@atomide.com>, <grygorii.strashko@ti.com>,
        <t-kristo@ti.com>
References: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <12b80b5f-3dd8-793e-75b2-94d2a0248d3e@ti.com>
Date:   Tue, 28 Aug 2018 17:14:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2018 6:44 PM, Keerthy wrote:
> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
> add the flag for all the other SoCs.

A gentle ping on this one.

> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes in v2:
> 
>    * Changed am43 compatible to more generic ti,am43 to cover epos boards.
>    * Added Tony's Ack.
> 
>   drivers/clocksource/timer-ti-32k.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
> index 29e2e1a..dd09171 100644
> --- a/drivers/clocksource/timer-ti-32k.c
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
>   		return -ENXIO;
>   	}
>   
> +	if (!of_machine_is_compatible("ti,am43"))
> +		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> +
>   	ti_32k_timer.counter = ti_32k_timer.base;
>   
>   	/*
> 
