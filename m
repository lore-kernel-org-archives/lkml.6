Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0299C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E85A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y1ryzaub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfBGOXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:23:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44408 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfBGOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:23:01 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17EMxch077203;
        Thu, 7 Feb 2019 08:22:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549549379;
        bh=LcXVQhCvd9vxFysgnSZ3Ihrhg5FU6gF/1yicUDaIHWg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=y1ryzaubkG6pANJ9FszOzd6/i0RdRSArZEJR5d/hnlUsvg39GTFg3aU8p/O0xNzCU
         sQ/auNFwJeWrhLKJqYi5yDjZs1YWMp+BEzr5px5qMxF8bDPQYf30KQhzLc2KUtAQ4S
         FuPtUYJ3tinxbaHbk3IimjKV8HpI4XSvSuyfBKtI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17EMx4H071297
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 08:22:59 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 08:22:55 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 08:22:55 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17EMsoc029891;
        Thu, 7 Feb 2019 08:22:54 -0600
Subject: Re: [PATCH v2 3/4] dt-bindings: phy: ti: Add dt binding documentation
 for SERDES in AM654x SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20190206110753.28738-1-kishon@ti.com>
 <20190206110753.28738-4-kishon@ti.com> <5C5C15E4.8010601@ti.com>
 <1eb6eee3-da8a-7400-c419-a60929b78904@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C5C3F3D.7080809@ti.com>
Date:   Thu, 7 Feb 2019 16:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1eb6eee3-da8a-7400-c419-a60929b78904@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/19 14:19, Kishon Vijay Abraham I wrote:
> Hi Roger,
> 
> On 07/02/19 4:56 PM, Roger Quadros wrote:
>>
>>
>> On 06/02/19 13:07, Kishon Vijay Abraham I wrote:
>>> AM654x has two SERDES instances. Each instance has three input clocks
>>> (left input, externel reference clock and right input) and two output
>>> clocks (left output and right output) in addition to a PLL mux clock
>>> which the SERDES uses for Clock Multiplier Unit (CMU refclock).
>>> The PLL mux clock can select from one of the three input clocks.
>>> The right output can select between left input and external reference
>>> clock while the left output can select between the right input and
>>> external reference clock.
>>>
>>> The left and right input reference clock of SERDES0 and SERDES1
>>> respectively are connected to the SoC clock. In the case of two lane
>>> SERDES personality card, the left input of SERDES1 is connected to
>>> the right output of SERDES0 in a chained fashion.
>>>
>>> See section "Reference Clock Distribution" of AM65x Sitara Processors
>>> TRM (SPRUID7 – April 2018) for more details.
>>>
>>> Add dt-binding documentation in order to represent all these different
>>> configurations in device tree.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  .../devicetree/bindings/phy/ti-phy.txt        | 77 +++++++++++++++++++
>>>  include/dt-bindings/phy/phy-am654-serdes.h    | 13 ++++
>>>  2 files changed, 90 insertions(+)
>>>  create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> index 57dfda8a7a1d..fc2fff6b2c37 100644
>>> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> @@ -132,3 +132,80 @@ sata_phy: phy@4a096000 {
>>>  	syscon-pllreset = <&scm_conf 0x3fc>;
>>>  	#phy-cells = <0>;
>>>  };
>>> +
>>> +
>>> +TI AM654 SERDES
>>> +
>>> +Required properties:
>>> + - compatible: Should be "ti,phy-am654-serdes"
>>> + - reg : Address and length of the register set for the device.
>>> + - reg-names: Should be "serdes" which corresponds to the register space
>>> +	populated in "reg".
>>> + - #phy-cells: determine the number of cells that should be given in the
>>> +	phandle while referencing this phy. Should be "2". The 1st cell
>>> +	corresponds to the phy type (should be one of the types specified in
>>> +	include/dt-bindings/phy/phy.h) and the 2nd cell should be the serdes
>>> +	lane function.
>>> +	If SERDES0 is referenced 2nd cell should be:
>>> +		0 - USB3
>>> +		1 - PCIe0 Lane0
>>> +		2 - ICSS2 SGMII Lane0
>>> +	If SERDES1 is referenced 2nd cell should be:
>>> +		0 - PCIe1 Lane0
>>> +		1 - PCIe0 Lane1
>>> +		2 - ICSS2 SGMII Lane1
>>
>> Instead of these magic numbers and expecting a human to decipher this
>> which is prone to error, is it better to create the following defines and
>> check for valid configuration in the driver?
>>
>> AM654_SERDES_LANE_USB3,
>> AM654_SERDES_LANE_PCIE_LANE0,
>> AM654_SERDES_LANE_PCIE_LANE1,
>> AM654_SERDES_LANE_SGMII,
>>
>> So if you pass AM654_SERDES_LANE_PCIE_LANE0 to SERDES1, driver can easily
>> figure out that it should be 1 if it is serdes0 and 0 if serdes1
>>
>> Which means the DT must contain something so that you can identify
>> if it is serdes0 or serdes1.
> 
> Generally I'd like to avoid drivers having to know instance numbers. That gets
> more complicated to handle when the same IP is used in different platforms.

But this PHY driver is for AM654 platform. Are you saying that variants of this
platform have different lane configurations?

You have already specified of the possibilities that can be in 2nd cell in
the binding document.

Is it better to create a directory ti/ and put this binding in ti,phy-am654-serdes.txt
instead of the already so large ti,phy.txt?

> 
> Rob, what's your opinion?
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
