Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C149DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962B620A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962B620A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbeHPF4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:56:33 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:23954 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbeHPF4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:56:33 -0400
Received: from [10.18.59.72] (10.18.59.72) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 16 Aug
 2018 11:01:27 +0800
Subject: Re: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic
 Meson PCIe Phy controller
To:     Rob Herring <robh@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, <shawn.lin@rock-chips.com>,
        <devicetree@vger.kernel.org>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227134-151584-2-git-send-email-hanjie.lin@amlogic.com>
 <20180814225012.GA19305@rob-hp-laptop>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <60f152b4-39b3-0205-794b-13a1617956d8@amlogic.com>
Date:   Thu, 16 Aug 2018 11:01:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814225012.GA19305@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.59.72]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/15 6:50, Rob Herring wrote:
> On Tue, Aug 14, 2018 at 02:12:13AM -0400, Hanjie Lin wrote:
>> From: Yue Wang <yue.wang@amlogic.com>
> 
> Subject should be "dt-bindings: phy: ..."
> 
>> The Meson-PCIE-PHY controller supports the 5-Gbps data rate
>> of the PCI Express Gen 2 specification and is backwardcompatible
> 
> space    

yes, I will fix
                                               ^
> 
>> with the 2.5-Gbps Gen 1.1 specification with only
>> inferred idle detection supported on AMLOGIC SoCs.
> 
> AMLOGIC or Amlogic? 
> 

yes, we will stick to 'Amlogic'

>>
>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
>> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
>> ---
>>  .../bindings/phy/amlogic,meson-pcie-phy.txt        | 31 ++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt b/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
>> new file mode 100644
>> index 0000000..db99085
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
>> @@ -0,0 +1,31 @@
>> +* Amlogic Meson AXG PCIE PHY binding
>> +
>> +Required properties:
>> +- compatible:	Should be
>> +	- "amlogic,axg-pcie-phy"
>> +- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
> 
> You don't need to distinguish port A and B?

No, we don't. Theoretically there is only one phy in the chip,
and we have distinguished ports by reset lines.

Thanks for all corrections and suggestions.

> 
>> +- reg:		The base address and length of the registers
>> +- resets:	phandle to the reset lines
>> +- reset-names:	must contain "phy" and "peripheral"
>> +	- "port_a" Port A reset
>> +	- "port_b" Port B reset
>> +	- "phy"	PHY reset
>> +	- "apb"	APB reset
>> +Optional properties:
>> +- phy-supply:	see phy-bindings.txt in this directory
>> +
>> +Example:
>> +	pcie_phy: pcie-phy@ff644000 {
>> +		#phy-cells = <0>;
>> +		compatible = "amlogic,axg-pcie-phy";
>> +		reg = <0x0 0xff644000 0x0 0x2000>;
>> +		resets = <&reset RESET_PCIE_A>,
>> +				<&reset RESET_PCIE_B>,
>> +				<&reset RESET_PCIE_PHY>,
>> +				<&reset RESET_PCIE_APB>;
>> +		reset-names =
>> +				"port_a",
>> +				"port_b",
>> +				"phy",
>> +				"apb";
>> +	};
>> -- 
>> 2.7.4
>>
> 
> .
> 
