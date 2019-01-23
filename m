Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF26C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1933F21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P29qBb29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfAWKcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:32:47 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52590 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:32:47 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0NAWfgQ042397;
        Wed, 23 Jan 2019 04:32:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548239561;
        bh=P84rh3Cwz7OaTIl6biLAW6jVY5R58OzZM/jIRFwaXs4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=P29qBb29YoChMFaPRUWeFO32xD/5WMvDsNL9khLN8u5BtM3zs6jynKlnkYwUz/tTq
         zfVjkwPTTIdC8/Gby4petxKSNieGgJIoEdOkOuGRhMzA+G6tzvgZSJ8C7BVVv+yUu7
         7O2CYKkUV36p+H4bfetD7qaYxCGaeBN3WIvBImb8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0NAWeN4075587
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 04:32:40 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 23
 Jan 2019 04:32:40 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 23 Jan 2019 04:32:40 -0600
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0NAWcNV010195;
        Wed, 23 Jan 2019 04:32:39 -0600
Subject: Re: [PATCH -next] gpio: davinci: drop pointless static qualifier
To:     YueHaibing <yuehaibing@huawei.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <20190123084912.13376-1-yuehaibing@huawei.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <f1c0c8d3-49de-bf5d-32c1-1717ea238107@ti.com>
Date:   Wed, 23 Jan 2019 16:02:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123084912.13376-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/19 2:19 PM, YueHaibing wrote:
> There is no need to have the 'gpio_unbanked' variable static since
> new value always be assigned before use it.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpio/gpio-davinci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index bdb29e5..f250454 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -465,7 +465,7 @@ static const struct irq_domain_ops davinci_gpio_irq_ops = {
>  
>  static struct irq_chip *davinci_gpio_get_irq_chip(unsigned int irq)
>  {
> -	static struct irq_chip_type gpio_unbanked;
> +	struct irq_chip_type gpio_unbanked;
>  
>  	gpio_unbanked = *irq_data_get_chip_type(irq_get_irq_data(irq));
>  
> @@ -474,7 +474,7 @@ static struct irq_chip *davinci_gpio_get_irq_chip(unsigned int irq)
>  
>  static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
>  {
> -	static struct irq_chip gpio_unbanked;
> +	struct irq_chip gpio_unbanked;
>  
>  	gpio_unbanked = *irq_get_chip(irq);
>  	return &gpio_unbanked;
> 

