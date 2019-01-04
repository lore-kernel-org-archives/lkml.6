Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DEFC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001A221872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfADN3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:29:40 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:54730 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbfADN3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:29:40 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x04DTUUv031620;
        Fri, 4 Jan 2019 07:29:30 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2pp7777tc5-1;
        Fri, 04 Jan 2019 07:29:30 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 82DFE611C8AC;
        Fri,  4 Jan 2019 07:32:32 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 13:29:29 +0000
Received: from [198.90.251.142] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.142])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x04DTSYM017654;        Fri, 4 Jan 2019 13:29:28 GMT
Subject: Re: [PATCH] irqchip: madera: Drop GPIO includes
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20190103102623.29685-1-linus.walleij@linaro.org>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <0e99200a-7a4f-17e7-aec6-a84dfed268ea@opensource.cirrus.com>
Date:   Fri, 4 Jan 2019 13:29:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190103102623.29685-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=762 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901040119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/19 10:26, Linus Walleij wrote:
> This irqchip does not use anything GPIO-related so drop
> the GPIO includes.
> 

An older version did some stuff with GPIOs but when that code was removed
this include obviously was forgotten.

> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/irqchip/irq-madera.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
> index e9256dee1a45..8b81271c823c 100644
> --- a/drivers/irqchip/irq-madera.c
> +++ b/drivers/irqchip/irq-madera.c
> @@ -7,7 +7,6 @@
>    */
>   
>   #include <linux/module.h>
> -#include <linux/gpio.h>
>   #include <linux/interrupt.h>
>   #include <linux/irq.h>
>   #include <linux/irqdomain.h>
> @@ -16,7 +15,6 @@
>   #include <linux/slab.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>   #include <linux/of_irq.h>
>   #include <linux/irqchip/irq-madera.h>
>   #include <linux/mfd/madera/core.h>
> 

Acked-by: Richard Fitzgerald <rf@opensource.cirrus.com>
