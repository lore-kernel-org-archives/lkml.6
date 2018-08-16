Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AB9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79172213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 03:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79172213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbeHPGG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 02:06:28 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:37687 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbeHPGG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 02:06:28 -0400
Received: from [10.18.59.72] (10.18.59.72) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 16 Aug
 2018 11:11:27 +0800
Subject: Re: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic
 Meson PCIe controller
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <1534227522-186798-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227522-186798-2-git-send-email-hanjie.lin@amlogic.com>
 <fd6b76f0c6f5b4dfd1527440b0f6275417e434c1.camel@baylibre.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <e83998fa-a4d2-5593-1a41-70bd232b4123@amlogic.com>
Date:   Thu, 16 Aug 2018 11:11:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fd6b76f0c6f5b4dfd1527440b0f6275417e434c1.camel@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.59.72]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/14 18:41, Jerome Brunet wrote:
> On Tue, 2018-08-14 at 02:18 -0400, Hanjie Lin wrote:
>> From: Yue Wang <yue.wang@amlogic.com>
>>
>> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
>> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
>> controller.
>>
>> Signed-off-by: Yue Wang <hanjie.lin@amlogic.com>
>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
>> ---
>>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 57 ++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> new file mode 100644
>> index 0000000..48233e4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>> @@ -0,0 +1,57 @@
>> +Amlogic Meson AXG DWC PCIE SoC controller
>> +
>> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
>> +It shares common functions with the PCIe DesignWare core driver and
>> +inherits common properties defined in
>> +Documentation/devicetree/bindings/pci/designware-pci.txt.
>> +
>> +Additional properties are described here:
>> +
>> +Required properties:
>> +- compatible:
>> +	should contain "amlogic,axg-pcie" to identify the core.
>> +- reg:
>> +	Should contain the configuration address space.
>> +- reg-names: Must be
>> +	- "elbi"	External local bus interface registers
>> +	- "cfg"		Meson specific registers
>> +	- "config"	PCIe configuration space
>> +- clocks: Must contain an entry for each entry in clock-names.
>> +- clock-names: Must include the following entries:
>> +	- "pcie"
>> +	- "pcie_bus"
>> +	- "pcie_general"
>> +	- "pcie_mipi_en"
> 
> Could you briefly describe what each clock is needed for ?
> 

Yes, is this more clear?

- clock-names:  Amlogic Meson AXG
Usage: required for  
Value type: <stringlist>
Definition: Should contain the following entries
- "pclk"       PCIe GEN 100M PLL clock
- "port"       PCIe_x(A 0r B) RC clock gate 
- "general"    PCIe Phy clock 
- "mipi"       PCIe_x(A or B) 100M ref clock gate

>> +
>> +Example configuration:
>> +
>> +	pcie: pcie@dffff000 {
>> +			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>> +			reg = <0x0 0xf9800000 0x0 0x400000
>> +					0x0 0xff646000 0x0 0x2000
>> +					0x0 0xf9f00000 0x0 0x100000>;
>> +			reg-names = "elbi", "cfg", "config";
>> +			reset-gpio = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
>> +			interrupts = <0 177 IRQ_TYPE_EDGE_RISING>;
> 
> replace 0 with GIC_SPI please

Right, I will fix it.

> 
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0>;
>> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
>> +			bus-range = <0x0 0xff>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			device_type = "pci";
>> +			phys = <&pcie_phy>;
>> +			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
>> +			num-lanes = <1>;
>> +			pcie-num = <1>;
>> +
>> +			clocks = <&clkc CLKID_USB
>> +					&clkc CLKID_MIPI_ENABLE
>> +					&clkc CLKID_PCIE_A
>> +					&clkc CLKID_PCIE_CML_EN0>;
>> +			clock-names = "pcie_general",
>> +					"pcie_refpll",
>> +					"pcie_mipi_en",
>> +					"pcie",
>> +					"port";
> 
> Several things are disturbing above:
> * pcie_general is provided by the USB clock gate ???
> * pcie_refpll: I suppose this is a copy/paste error, not used in your driver
> (and shouldn't be need BTW)
> 
> suggested names:
> * pcie_general -> general
> * pcie_mipi_en -> mipi
> * pcie -> pclk
> * port (OK)
> 

Thanks, we will follow your suggestion.

>> +	};
> 
> 
> .
> 
