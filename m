Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F908C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FB321525
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FB321525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeHVQST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:18:19 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:52557 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbeHVQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:18:19 -0400
X-IronPort-AV: E=Sophos;i="5.53,274,1531810800"; 
   d="scan'208";a="16397832"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Aug 2018 05:53:31 -0700
Received: from [10.145.4.72] (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Wed, 22 Aug 2018
 05:53:29 -0700
Subject: Re: [PATCH v11 0/6] Driver for at91 usart in spi mode
To:     "broonie@kernel.org" <broonie@kernel.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "richard.genoud@gmail.com" <richard.genoud@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
From:   Radu Pirea <radu.pirea@microchip.com>
Message-ID: <ba108fbe-d3c4-a60e-a1c0-441fe3082212@microchip.com>
Date:   Wed, 22 Aug 2018 15:55:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180713164736.26028-1-radu.pirea@microchip.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

I saw that the patches were not applied to your tree for this kernel 
version. After the discussion with Nicolas, I remember that you said 
that you will take the patches in your tree. I addressed Mark comments 
related to the last version of patches. Is there something that must be 
reworked in order to take the patches?

On 7/13/18 7:47 PM, Radu Pirea - M19893 wrote:
> Hello,
> 
> This is the second version of driver. I added a mfd driver which by
> default probes atmel_serial driver and if in dt is specified to probe
> the spi driver, then the spi-at91-usart driver will be probed. The
> compatible for atmel_serial is now the compatible for at91-usart mfd
> driver and compatilbe for atmel_serial driver was changed in order to
> keep the bindings for serial as they are.
> 
> @Lee, could you take this patch series into your tree? I addressed all Mark
> remarks.
> 
> Changes in v11:
> - removed "depends on HAS_DMA" from drivers/spi/Kconfig because the driver has
> no dma support
> - changed "selects MFD_AT91_USART" to "depends on MFD_AT91_USART" in
> drivers/spi/Kconfig
> - changed comment style in spi-at91-usart.c
> 
> Changes in v10:
> -fixed kbuild test robot warning
> 
> Changes in v9:
> - minor changes
> - rebased on top of broonie/for-4.19
> 
> Changes in v8:
> - fixed passing an empty mfd cell if "atmel,usart-mode" value is invalid
> 
> Changes in v7:
> - synced up  SPDIX license with module license
> - numbering of usart modes starts from 0 insteand of 1
> 
> Changes in v6:
> - removed unused compatible strings from serial and spi drivers
> 
> Changes in v5:
> - fixed usage of stdout-path property with atmel_serial driver
> 
> Changes in v4:
> - modified the spi driver to use cs gpio support form spi subsystem
> - fixed dma transfers for serial driver
> - squashed binding for spi and serial and moved them to mfd/atmel-usart.txt
> 
> Changes in v3:
> - fixed spi slaves probing
> 
> Changes in v2:
> - added at91-usart mfd driver
> - modified spi-at91-usart driver to work as mfd driver child
> - modified atmel_serial driver to work as mfd driver child
> 
> Changes in v1:
> - added spi-at91-usart driver
> 
> Radu Pirea (6):
>    MAINTAINERS: add at91 usart mfd driver
>    dt-bindings: add binding for atmel-usart in SPI mode
>    mfd: at91-usart: added mfd driver for usart
>    MAINTAINERS: add at91 usart spi driver
>    spi: at91-usart: add driver for at91-usart as spi
>    tty/serial: atmel: change the driver to work under at91-usart mfd
> 
>   .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
>   MAINTAINERS                                   |  16 +
>   drivers/mfd/Kconfig                           |   9 +
>   drivers/mfd/Makefile                          |   1 +
>   drivers/mfd/at91-usart.c                      |  71 +++
>   drivers/spi/Kconfig                           |   8 +
>   drivers/spi/Makefile                          |   1 +
>   drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
>   drivers/tty/serial/Kconfig                    |   1 +
>   drivers/tty/serial/atmel_serial.c             |  42 +-
>   include/dt-bindings/mfd/at91-usart.h          |  17 +
>   11 files changed, 606 insertions(+), 17 deletions(-)
>   rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>   create mode 100644 drivers/mfd/at91-usart.c
>   create mode 100644 drivers/spi/spi-at91-usart.c
>   create mode 100644 include/dt-bindings/mfd/at91-usart.h
> 
