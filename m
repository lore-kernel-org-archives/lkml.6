Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0ABFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5434D20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5434D20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbeINWbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:31:07 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48237 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINWbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:31:07 -0400
X-IronPort-AV: E=Sophos;i="5.53,374,1531810800"; 
   d="scan'208";a="20712040"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Sep 2018 10:15:42 -0700
Received: from [10.145.5.146] (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Fri, 14 Sep 2018
 10:15:42 -0700
Subject: Re: [PATCH] usb: gadget: udc: atmel: handle at91sam9rl PMC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180910201249.23036-1-alexandre.belloni@bootlin.com>
From:   Cristian Birsan <cristian.birsan@microchip.com>
Message-ID: <90ccdf34-149e-b4b7-d6a9-9ebee241918c@microchip.com>
Date:   Fri, 14 Sep 2018 20:14:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910201249.23036-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.09.2018 23:12, Alexandre Belloni wrote:
> The at91sam9rl PMC is not quite the same as the at91sam9g45 one and now has
> its own compatible string. Add support for that.
> 
> Fixes: 217bace8e548 ("ARM: dts: fix PMC compatible")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

It looks good to me.

Acked-by: Cristian Birsan <cristian.birsan@microchip.com>

> ---
>   drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 17147b8c771e..8f267be1745d 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2017,6 +2017,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>   
>   	udc->errata = match->data;
>   	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
> +	if (IS_ERR(udc->pmc))
> +		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9rl-pmc");
>   	if (IS_ERR(udc->pmc))
>   		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9x5-pmc");
>   	if (udc->errata && IS_ERR(udc->pmc))
> 
