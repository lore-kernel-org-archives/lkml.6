Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C92ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CEE20858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CEE20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeGMKId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:08:33 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:31320 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeGMKId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:08:33 -0400
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="16197461"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 13 Jul 2018 02:54:37 -0700
Received: from [10.145.4.57] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Fri, 13 Jul 2018
 02:54:36 -0700
Subject: Re: [PATCH v10 5/6] spi: at91-usart: add driver for at91-usart as spi
To:     Mark Brown <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <lee.jones@linaro.org>, <richard.genoud@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <gregkh@linuxfoundation.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-6-radu.pirea@microchip.com>
 <20180710181559.GG8104@sirena.org.uk>
From:   Radu Pirea <radu.pirea@microchip.com>
Message-ID: <dc410321-5dfd-7c26-2a3e-d2b2840da214@microchip.com>
Date:   Fri, 13 Jul 2018 12:56:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710181559.GG8104@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2018 09:15 PM, Mark Brown wrote:
> On Mon, Jun 25, 2018 at 08:22:29PM +0300, Radu Pirea wrote:
> 
> This is mostly good, just a couple of small things:
> 
>> +config SPI_AT91_USART
>> +	tristate "Atmel USART Controller SPI driver"
>> +	depends on HAS_DMA
>> +	depends on (ARCH_AT91 || COMPILE_TEST)
>> +	select MFD_AT91_USART
> 
> Why is this selecting rather than depending on the MFD like we normally
> do?
> 

Hi Mark,

If I add depends instead of select, current defconfigs will be broken 
and the proper driver will not be selected. Like this, there is no 
required change in any defconfig. Selecting the serial or spi driver 
from menuconfig makes the MFD completely transparent.
>> @@ -0,0 +1,432 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for AT91 USART Controllers as SPI
>> + *
>> + * Copyright (C) 2018 Microchip Technology Inc.
>> + * Author: Radu Pirea <radu.pirea@microchip.com>
>> + */
> 
> Please use C++ comments for the whole block so it looks a bit more
> intentional.

Ok. I will change it.

> 
> Otherwise
> 
> Reviwed-by: Mark Brown <broonie@kernel.org>
> 
