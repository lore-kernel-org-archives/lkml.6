Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4A7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173F42077B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173F42077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbeKQMok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:44:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727961AbeKQMoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:44:39 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC5A754EFEC45;
        Sat, 17 Nov 2018 10:29:40 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sat, 17 Nov 2018
 10:29:34 +0800
CC:     <wangbinghui@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "John Stultz" <john.stultz@linaro.org>
Subject: Re: [PATCH 01/10] dt-bindings: usb: add support for dwc3 controller
 on HiSilicon SoCs
To:     Rob Herring <robh@kernel.org>
References: <20181027095820.40056-1-chenyu56@huawei.com>
 <20181027095820.40056-2-chenyu56@huawei.com> <20181112160241.GA14074@bogus>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <9fce6a58-d986-25e4-1791-ba375e4f075e@huawei.com>
Date:   Sat, 17 Nov 2018 10:29:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181112160241.GA14074@bogus>
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

On 2018/11/13 0:02, Rob Herring wrote:
> On Sat, Oct 27, 2018 at 05:58:11PM +0800, Yu Chen wrote:
>> This patch adds binding descriptions to support the dwc3 controller
>> on HiSilicon SoCs and boards like the HiKey960.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>>  .../devicetree/bindings/usb/dwc3-hisi.txt          | 53 ++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/dwc3-hisi.txt b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>> new file mode 100644
>> index 000000000000..e715e7b1c324
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
>> @@ -0,0 +1,53 @@
>> +HiSilicon DWC3 USB SoC controller
>> +
>> +This file documents the parameters for the dwc3-hisi driver.
>> +
>> +Required properties:
>> +- compatible:	should be "hisilicon,hi3660-dwc3"
>> +- clocks:	A list of phandle + clock-specifier pairs for the
>> +		clocks listed in clock-names
>> +- clock-names:	Specify clock names
>> +- resets:	list of phandle and reset specifier pairs.
>> +
>> +Sub-nodes:
>> +The dwc3 core should be added as subnode to HiSilicon DWC3 as shown in the
>> +example below. The DT binding details of dwc3 can be found in:
>> +Documentation/devicetree/bindings/usb/dwc3.txt
> 
> If you only have clocks and resets and no glue registers, then you 
> don't need a sub-node. Just make the controller one node.
> 

In dwc3 glue driver，the controller driver usually probed by call of_platform_populate
which will search the child node of glue driver.
The code of function of_platform_populate is as below:

	for_each_child_of_node(root, child) {
                 rc = of_platform_bus_create(child, matches, lookup, parent, true);
                 if (rc) {
                         of_node_put(child);
                         break;
                 }
         }

So I think the controller node should be a sub-node.

>> +
>> +Example:
>> +	usb3: hisi_dwc3 {
>> +		compatible = "hisilicon,hi3660-dwc3";
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
>> +			 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>> +		clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
>> +		assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>> +		assigned-clock-rates = <229000000>;
>> +		resets = <&crg_rst 0x90 8>,
>> +			 <&crg_rst 0x90 7>,
>> +			 <&crg_rst 0x90 6>,
>> +			 <&crg_rst 0x90 5>;
>> +
>> +		dwc3: dwc3@ff100000 {
> 
> usb@...
> 
>> +			compatible = "snps,dwc3";
>> +			reg = <0x0 0xff100000 0x0 0x100000>;
>> +			interrupts = <0 159 4>, <0 161 4>;
>> +			phys = <&usb_phy>;
>> +			phy-names = "usb3-phy";
>> +			dr_mode = "otg";
>> +			maximum-speed = "super-speed";
>> +			phy_type = "utmi";
>> +			snps,dis-del-phy-power-chg-quirk;
>> +			snps,lfps_filter_quirk;
>> +			snps,dis_u2_susphy_quirk;
>> +			snps,dis_u3_susphy_quirk;
>> +			snps,tx_de_emphasis_quirk;
>> +			snps,tx_de_emphasis = <1>;
>> +			snps,dis_enblslpm_quirk;
>> +			snps,gctl-reset-quirk;
>> +			extcon = <&hisi_hikey_usb>;
>> +		};
>> +	};
>> -- 
>> 2.15.0-rc2
>>
> 
> 
> .
> 

