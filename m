Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbeEIEBD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 00:01:03 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:51293 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEIEBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 00:01:01 -0400
Subject: Re: [PATCH 0/4] ARM: dts: am437x boards: Correct (again) tps65218 irq
 type
To: Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: <bcousson@baylibre.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180508132053.5471-1-peter.ujfalusi@ti.com>
 <20180508141600.GT98604@atomide.com>
From: Keerthy <j-keerthy@ti.com>
Message-ID: <4b4100d0-85e1-659b-8f7e-b3d4b3925e82@ti.com>
Date: Wed, 9 May 2018 09:30:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180508141600.GT98604@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 08 May 2018 07:46 PM, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [180508 13:22]:
>> Hi,
>>
>> While based on the datasheet of tps65218 the INT is low active, the GIC_SPI
>> does not support anythin but IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_EDGE_RISING:
>>
>> [    2.761814] genirq: Setting trigger mode 8 for irq 102 failed (irq_chip_set_type_parent+0x0/0x30)
>> [    2.770913] tps65218 0-0024: Failed to request IRQ 102 for tps65218: -22
>> [    2.777854] tps65218: probe of 0-0024 failed with error -22
> 
> So does the tps65218 have some register to control the interrupt
> direction or is it's datasheet wrong?
> 
> BTW, ADC might be a good test case for PMIC interrupt if it has one.

There is no ADC on this PMIC.

> 
>> Use LEVEL_HIGH for the interrupt as it looks to be the correct setting:
>> INTn of tps65218 is connected to NMIn of the SoC.
>>
>> The offending patches are only in linux-next.
> 
> OK
> 
> Regards,
> 
> Tony
> 
