Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbeE2JN5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:13:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:39324 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932284AbeE2JNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:13:54 -0400
X-IronPort-AV: E=Sophos;i="5.49,455,1520924400";
   d="scan'208";a="12543115"
Subject: Re: [PATCH v4 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
To: Richard Genoud <richard.genoud@gmail.com>, <broonie@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <gregkh@linuxfoundation.org>
CC: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-7-radu.pirea@microchip.com>
 <e1445467-2df0-4593-852d-939e6795f318@sorico.fr>
From: Radu Pirea <radu.pirea@microchip.com>
Message-ID: <44649341-c238-5b59-6786-50d80f9d4cba@microchip.com>
Date: Tue, 29 May 2018 12:15:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e1445467-2df0-4593-852d-939e6795f318@sorico.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/28/2018 01:08 PM, Richard Genoud wrote:
> On 25/05/2018 19:19, Radu Pirea wrote:
>> This patch modifies the place where resources and device tree properties
>> are searched.
>>
>> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
>> ---
>>   drivers/tty/serial/Kconfig        |  1 +
>>   drivers/tty/serial/atmel_serial.c | 40 +++++++++++++++++--------------
>>   2 files changed, 23 insertions(+), 18 deletions(-)
> the stdout-path property of the chosen node is still broken in this verion.
> if :
> stdout-path = "serial0:115200n8";
> is set in the DTS, the console output should go on serial0 (aka dbgu)
> cf Documentation/devicetree/bindings/chosen.txt
> 
> With this patch applied, this is not the case anymore.
> Adding console=ttyS0,115200 in the chosen node is not the solution here.
> 

I fixed the issue few minutes ago :)

I hope DMA setup is ok now.

> 
> regards,
> Richard.
> 
