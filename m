Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E2C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F45020853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 07:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F45020853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeJOPYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:24:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46575 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbeJOPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:24:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9F7dKbf005682;
        Mon, 15 Oct 2018 09:39:21 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n37kf9q3k-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Oct 2018 09:39:21 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 17CBF42;
        Mon, 15 Oct 2018 07:39:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C32CD24D2;
        Mon, 15 Oct 2018 07:39:17 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.49) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Oct
 2018 09:39:16 +0200
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND
 controller documentation
To:     Rob Herring <robh@kernel.org>
CC:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
 <1538732520-2800-2-git-send-email-christophe.kerello@st.com>
 <20181012203229.GA9657@bogus>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <823a5f95-631f-ebe6-9ffb-87de7962b4ff@st.com>
Date:   Mon, 15 Oct 2018 09:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012203229.GA9657@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-15_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 10:32 PM, Rob Herring wrote:
> On Fri, Oct 05, 2018 at 11:41:58AM +0200, christophe.kerello@st.com wrote:
>> From: Christophe Kerello <christophe.kerello@st.com>
>>
>> This patch adds the documentation of the device tree bindings for the STM32
>> FMC2 NAND controller.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
>>   .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    | 59 ++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
>> new file mode 100644
>> index 0000000..b620176
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt
>> @@ -0,0 +1,59 @@
>> +STMicroelectronics Flexible Memory Controller 2 (FMC2)
>> +NAND Interface
>> +
>> +Required properties:
>> +- compatible: Should be one of:
>> +              * st,stm32mp15-fmc2
>> +- reg: NAND flash controller memory areas.
>> +       First region contains the register location.
>> +       Regions 2 to 4 respectively contain the data, command,
>> +       and address space for CS0.
>> +       Regions 5 to 7 contain the same areas for CS1.
>> +- interrupts: The interrupt number
>> +- pinctrl-0: Standard Pinctrl phandle (see: pinctrl/pinctrl-bindings.txt)
>> +- clocks: Use common clock framework
> 
> How many? 'common clock framework' is a Linux thing, not part of
> bindings.
> 

Hi Rob,

Only one clock is needed.
I will replace this comment by:
  - clocks: the clock needed by the NAND flash controller.

Regards,
Christophe Kerello.

>> +
>> +Optional properties:
>> +- resets: Reference to a reset controller asserting the FMC controller
>> +- dmas: DMA specifiers (see: dma/stm32-mdma.txt)
>> +- dma-names: Must be "tx", "rx" and "ecc"
>> +
>> +Optional children nodes:
>> +Children nodes represent the available NAND chips.
>> +
>> +Optional properties:
>> +- nand-on-flash-bbt: see nand.txt
>> +- nand-ecc-strength: see nand.txt
>> +- nand-ecc-step-size: see nand.txt
>> +
>> +The following ECC strength and step size are currently supported:
>> + - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Hamming)
>> + - nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
>> + - nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8) (default)
>> +
>> +Example:
>> +
>> +	fmc: nand-controller@58002000 {
>> +		compatible = "st,stm32mp15-fmc2";
>> +		reg = <0x58002000 0x1000>,
>> +		      <0x80000000 0x1000>,
>> +		      <0x88010000 0x1000>,
>> +		      <0x88020000 0x1000>,
>> +		      <0x81000000 0x1000>,
>> +		      <0x89010000 0x1000>,
>> +		      <0x89020000 0x1000>;
>> +		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&rcc FMC_K>;
>> +		resets = <&rcc FMC_R>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&fmc_pins_a>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		nand@0 {
>> +			reg = <0>;
>> +			nand-on-flash-bbt;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +		};
>> +	};
>> -- 
>> 1.9.1
>>
