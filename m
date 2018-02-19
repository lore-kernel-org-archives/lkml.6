Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeBSPQ0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:16:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7797 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751528AbeBSPQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:16:24 -0500
Subject: Re: [PATCH 1/5] dt-bindings: mmc: document the stm32 sdmmc bindings
To: Rob Herring <robh@kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <1518701697-14242-1-git-send-email-ludovic.Barre@st.com>
 <1518701697-14242-2-git-send-email-ludovic.Barre@st.com>
 <20180219144735.sbxa76z6aik3w453@rob-hp-laptop>
From: Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <12fc58db-3b21-4c83-30ce-e1b495928dbc@st.com>
Date: Mon, 19 Feb 2018 16:16:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180219144735.sbxa76z6aik3w453@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Rob

Ok for all changes

BR
Ludo

On 02/19/2018 03:47 PM, Rob Herring wrote:
> On Thu, Feb 15, 2018 at 02:34:53PM +0100, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> Document the binding for stm32 sdmmc controller.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   .../devicetree/bindings/mmc/st,stm32-sdmmc.txt     | 35 ++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt b/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
>> new file mode 100644
>> index 0000000..52eb1f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/st,stm32-sdmmc.txt
>> @@ -0,0 +1,35 @@
>> +* STMicroelectronics STM32 SDMMC controller
>> +
>> +The highspeed MMC host controller on STM32 soc family
>> +provides an interface for MMC, SD and SDIO types of memory cards.
>> +
>> +This file documents differences between the core properties described
>> +by mmc.txt and the properties used by the sdmmc driver.
>> +
>> +Required properties:
>> + - compatible: Should be "st,stm32h7-sdmmc"
>> + - reg: mmc controller base registers
>> + - interrupts: Should contain the interrupt number
>> + - clocks: Should contain phandle for the clock feeding the controller
>> + - resets: Should contain phandle for the reset feeding the controller
>> +
>> +Optional property:
>> +- st,dirpol: Allow to select direction polarity of external voltage
> 
> This doesn't need to be so terse. Perhaps "st,dir-output-high".
> 

Ok, I take "st,dir-output-high", your're right it's more descriptive :-)

>> +  transceiver (which manage data and command direction).
>> +  if set: Voltage transceiver IOs are driven as output when direction signals are high,
>> +  else: Voltage transceiver IOs are driven as output when direction signals are low.
>> +- st,negedge: generate data & command on sdmmc clock falling edge
> 
> st,neg-edge
> 
>> +- st,pin-ckin: use sdmmc_ckin pin from an external driver to sample
>> +  the receive data (example: with voltage switch transceiver).
> 
> st,use-ckin
> 

OK

>> +
>> +Example:
>> +	sdmmc1: sdmmc@52007000 {
> 
> mmc@...
>

OK

>> +		compatible = "st,stm32h7-sdmmc";
>> +		reg = <0x52007000 0x1000>;
>> +		interrupts = <49>;
>> +		clocks = <&rcc SDMMC1_CK>;
>> +		resets = <&rcc SDMMC1_R>;
>> +		bus-width = <4>;
>> +		cap-sd-highspeed;
>> +		cap-mmc-highspeed;
>> +	};
>> -- 
>> 2.7.4
>>
