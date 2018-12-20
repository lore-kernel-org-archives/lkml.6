Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95902C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B636218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeLTBdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:33:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16167 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbeLTBdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:33:22 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 513CF986813B0;
        Thu, 20 Dec 2018 09:33:18 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Thu, 20 Dec 2018
 09:33:14 +0800
CC:     <liuyu712@hisilicon.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangbinghui@hisilicon.com>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 01/12] dt-bindings: usb: add support for dwc3
 controller on HiSilicon SoCs
To:     Rob Herring <robh@kernel.org>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-2-chenyu56@huawei.com>
 <fde4d37b-0c4d-055b-a0ba-4e9fe87717ad@cogentembedded.com>
 <33cda716-d09c-28e7-d4b4-26f246786f5e@huawei.com>
 <680c5b9f-e2c7-926d-7d10-4ce2cd091282@cogentembedded.com>
 <bbe390f0-2fa6-515b-42c5-ede620b2b8c7@huawei.com>
 <20181219140953.GA9910@bogus>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <3d9727c4-e3c7-6eb0-cecd-e16af2fa6b66@huawei.com>
Date:   Thu, 20 Dec 2018 09:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181219140953.GA9910@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018/12/19 22:09, Rob Herring wrote:
> On Mon, Dec 03, 2018 at 05:28:56PM +0800, Chen Yu wrote:
>> Hi,
>>
>> On 2018/12/3 16:59, Sergei Shtylyov wrote:
>>> On 03.12.2018 11:51, Chen Yu wrote:
>>>
>>>>>> This patch adds binding descriptions to support the dwc3 controller
>>>>>> on HiSilicon SoCs and boards like the HiKey960.
>>>>>>
>>>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>> Cc: John Stultz <john.stultz@linaro.org>
>>>>>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>>>>>> ---
>>>>>>    .../devicetree/bindings/usb/dwc3-hisi.txt          | 67 ++++++++++++++++++++++
>>>>>>    1 file changed, 67 insertions(+)
>>>>>>    create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3-hisi.txt b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>>>>> new file mode 100644
>>>>>> index 000000000000..d32d2299a0a1
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>>>>> @@ -0,0 +1,67 @@
>>>>>> +HiSilicon DWC3 USB SoC controller
>>>>>> +
>>>>>> +This file documents the parameters for the dwc3-hisi driver.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible:    should be "hisilicon,hi3660-dwc3"
>>>>>> +- clocks:    A list of phandle + clock-specifier pairs for the
>>>>>> +        clocks listed in clock-names
>>>>>> +- clock-names:    Specify clock names
>>>>>> +- resets:    list of phandle and reset specifier pairs.
>>>>>> +
>>>>>> +Sub-nodes:
>>>>>> +The dwc3 core should be added as subnode to HiSilicon DWC3 as shown in the
>>>>>> +example below. The DT binding details of dwc3 can be found in:
>>>>>> +Documentation/devicetree/bindings/usb/dwc3.txt
>>>>>> +
>>>>>> +Example:
>>>>>> +    usb3: hisi_dwc3 {
>>>>>> +        compatible = "hisilicon,hi3660-dwc3";
>>>>>> +        #address-cells = <2>;
>>>>>> +        #size-cells = <2>;
>>>>>> +        ranges;
>>>>>> +
>>>>>> +        clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
>>>>>> +             <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>>>>>> +        clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
>>>>>> +        assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>>>>>> +        assigned-clock-rates = <229000000>;
>>>>>> +        resets = <&crg_rst 0x90 8>,
>>>>>> +             <&crg_rst 0x90 7>,
>>>>>> +             <&crg_rst 0x90 6>,
>>>>>> +             <&crg_rst 0x90 5>;
>>>>>> +
>>>>>> +        dwc3: dwc3@ff100000 {
> 
> Please combine these into a single node. Unless you have a wrapper with 
> registers, you don't need these 2 nodes. Clocks and reset can go in the 
> dwc3 node.

Yes, clocks can go in the dwc3 node, but there are four resets need to be
deasserted for dwc3 usb of Hi3660 Soc and there is only one reset handled
in dwc3 driver.

> 
>>>>>
>>>>>      According to the DT spec, the node names should be generic, not chip specific, i.e. usb@ff100000 in this case.
>>>>>
>>>>
>>>> Do you mean it should be usb@ff100000: dwc3@ff100000 ?
>>>
>>>     dwc3: usb@ff100000
>>>
>>>    "dwc3:" is a label, not name.
>>
>> I use the node name "dwc3@ff100000" according to Documentation/devicetree/bindings/usb/dwc3.txt
>> and documentations of vendor drivers, i.e. qcom,dwc3.txt, rockchip,dwc3.txt.
>>
>> In these documentations, the dwc3 sub-node name uses "dwc3@xxxxxxxx".
>>
>> I think it is better to be same as the other vendor's dwc3 drivers.
> 
> It's not. The other bindings are wrong. Follow the DT Spec.
> 
> Rob
> 
> .
> 

