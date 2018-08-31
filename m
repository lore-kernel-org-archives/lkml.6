Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4F1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5D2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE5D2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeHaFv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:51:57 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:33729 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeHaFv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:51:57 -0400
Received: from [10.18.16.3] (10.18.16.3) by mail-sh2.amlogic.com (10.18.11.6)
 with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 31 Aug 2018 09:47:15
 +0800
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
To:     Rob Herring <robh@kernel.org>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <devicetree@vger.kernel.org>
References: <1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096165-45827-2-git-send-email-hanjie.lin@amlogic.com>
 <8c48964151d24758298ba935da336c0829e2b287.camel@baylibre.com>
 <11d7547b-feb4-6ecb-cef3-db46ce8ee2ef@amlogic.com>
 <20180829004122.GA25928@bogus>
 <84d5399c-67d4-f8a4-3613-00d91f21292f@amlogic.com>
 <CAL_JsqJPzfp1OimYXa26tEqTexyiuKMeKszveobHN3rKP8+RYQ@mail.gmail.com>
From:   Hanjie Lin <hanjie.lin@amlogic.com>
Message-ID: <12ce60a8-accc-3c8f-4d38-9bf31346b775@amlogic.com>
Date:   Fri, 31 Aug 2018 09:47:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJPzfp1OimYXa26tEqTexyiuKMeKszveobHN3rKP8+RYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.16.3]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/8/30 21:59, Rob Herring wrote:
> On Thu, Aug 30, 2018 at 2:37 AM Hanjie Lin <hanjie.lin@amlogic.com> wrote:
>>
>>
>>
>> On 2018/8/29 8:41, Rob Herring wrote:
>>> On Mon, Aug 27, 2018 at 04:55:20PM +0800, Hanjie Lin wrote:
>>>>
>>>>
>>>> On 2018/8/24 16:22, Jerome Brunet wrote:
>>>>> On Fri, 2018-08-24 at 15:36 +0800, Hanjie Lin wrote:
>>>>>> From: Yue Wang <yue.wang@amlogic.com>
>>>>>>
>>>>>> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
>>>>>> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
>>>>>> controller.
>>>>>>
>>>>>> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
>>>>>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 63 ++++++++++++++++++++++
>>>>>>  1 file changed, 63 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..8a831d1
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
>>>>>> @@ -0,0 +1,63 @@
>>>>>> +Amlogic Meson AXG DWC PCIE SoC controller
>>>>>> +
>>>>>> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
>>>>>> +It shares common functions with the PCIe DesignWare core driver and
>>>>>> +inherits common properties defined in
>>>>>> +Documentation/devicetree/bindings/pci/designware-pci.txt.
>>>>>> +
>>>>>> +Additional properties are described here:
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible:
>>>>>> +  should contain "amlogic,axg-pcie" to identify the core.
>>>>>> +- reg:
>>>>>> +  Should contain the configuration address space.
>>>>>> +- reg-names: Must be
>>>>>> +  - "elbi"        External local bus interface registers
>>>>>> +  - "cfg"         Meson specific registers
>>>>>> +  - "config"      PCIe configuration space
>>>>>> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
>>>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>>>> +- clock-names: Must include the following entries:
>>>>>> +  - "pclk"       PCIe GEN 100M PLL clock
>>>>>> +  - "port"       PCIe_x(A or B) RC clock gate
>>>>>> +  - "general"    PCIe Phy clock
>>>>>> +  - "mipi"       PCIe_x(A or B) 100M ref clock gate
>>>>>> +- resets: phandle to the reset lines.
>>>>>> +- reset-names: must contain "phy" and "peripheral"
>>>>>> +       - "port" Port A or B reset
>>>>>> +       - "apb" APB reset
>>>>>
>>>>> The above description is not coherent (phy <=> port)
>>>>>
>>>>
>>>> Yes, this should be port and apb here.
>>>> We'll integrate phy driver into ctrl driver, and move phy reset to here also.
>>>
>>> Why? That's the wrong thing to do if they are separate h/w blocks. You
>>> can do whatever you like in the drivers, but the DT should reflect the
>>> h/w.
>>>
>>> Rob
>>>
>>> .
>>>
>>
>> We have the dedicated phy driver which only process reset job,
>> and we consider that it's too overkill to do just these things .
>> So we will integrate phy reset job into the controller driver int the next version.
> 
> What's in the separate register space you had for the phy?
> 
> Rob
> 
> .
> 

As described with 'phy' reg in ctrl patch v3 thread [0]

- reg-names: Must be
	- "elbi"	External local bus interface registers
	- "cfg"		Meson specific registers
	- "phy"		Meson PCIE PHY registers
	- "config"	PCIe configuration space

When each controller driver probe, we powerup phy by write phy register like below: 
writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);

[0] https://lkml.kernel.org/r/1535616829-167936-1-git-send-email-hanjie.lin@amlogic.com
