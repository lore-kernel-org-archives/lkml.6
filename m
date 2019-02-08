Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244C1C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62F121924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nh0lM93U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfBHLaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:30:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47074 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfBHL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:29:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18BTr3g110425;
        Fri, 8 Feb 2019 05:29:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549625393;
        bh=HGzvHnNfCkbD9HiE6oB+g14lGZLuNB9ZAn/E7+lLLbs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nh0lM93UNTpWWMtfhdxGoBuptZTdZu7gazTdJ5g42ijxXimDxxI8xyKBX+r/UmWZ4
         L7KzC8XdcUrEB/r0/+Afzsa6h10cyL4NCGenZU1NeUdAGAxkN274c3jO6UM1YaqsDT
         XnHfwvrddq+VET69MSHTCt2LdLDOMViy6cb1q234=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18BTra8113898
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 05:29:53 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 05:29:52 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 05:29:52 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18BTnEa007496;
        Fri, 8 Feb 2019 05:29:49 -0600
Subject: Re: [PATCH 5/8] usb: ohci-da8xx: add vbus and overcurrent gpios
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190205102546.29457-1-brgl@bgdev.pl>
 <20190205102546.29457-6-brgl@bgdev.pl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <d666c2eb-8193-6c63-c379-181482607a9e@ti.com>
Date:   Fri, 8 Feb 2019 16:59:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205102546.29457-6-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 05/02/19 3:55 PM, Bartosz Golaszewski wrote:
> +static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
> +{
> +	struct da8xx_ohci_hcd *da8xx_ohci = data;
> +
> +	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio))
> +		gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0);
> +
> +	return IRQ_HANDLED;
> +}

Its pretty strange to see gpiod_get_value_cansleep() being called from
irq context, although I agree right now it uses SoC GPIOs so it should
actually never sleep.

Isn't it better to use gpiod_get_value() instead so you get a warning on
incorrect usage?

Thanks,
Sekhar
