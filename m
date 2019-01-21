Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D5C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CC220870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="avzHkoLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfAULt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:49:59 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42152 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfAULt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:49:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LBnuTJ086776;
        Mon, 21 Jan 2019 05:49:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548071396;
        bh=5TxD4tkdborkMhOuzEaW88Ki689yLurLd1lVU2WAlNo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=avzHkoLFc+uaBMHrCqtTkYzeOHsPLnRSJHBGKmKP5XAz29vx0Ff9OUN4dZgHWGNFf
         89MDbT440Hnxml9Nk+cmMAwdyyBQwVqV8N352SNsAArk7jNm4XukMGxjZsJ3ZN1rbv
         dlOABZBalcdBzj5a6/xqa5me0kL8uf7oGjBzHuKI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LBnuT5099469
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 05:49:56 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 05:49:56 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 05:49:56 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LBns86019837;
        Mon, 21 Jan 2019 05:49:54 -0600
Subject: Re: [PATCH 2/3] dt-bindings: phy: ti: Add dt binding documentation
 for SERDES in AM654x SoC
To:     Roger Quadros <rogerq@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190121064813.18444-1-kishon@ti.com>
 <20190121064813.18444-3-kishon@ti.com> <5C4596F8.7030009@ti.com>
 <b619ace8-f2be-8eb0-080e-0ae7a43799df@ti.com> <5C45AB63.4010005@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <7980b15c-0187-32e1-c728-d3d98e4c8c0e@ti.com>
Date:   Mon, 21 Jan 2019 17:19:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C45AB63.4010005@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/01/19 4:52 PM, Roger Quadros wrote:
> 
> 
> On 21/01/19 12:47, Kishon Vijay Abraham I wrote:
>> Hi Roger,
>>
>> On 21/01/19 3:25 PM, Roger Quadros wrote:
>>> Kishon,
>>>
>>> On 21/01/19 08:48, Kishon Vijay Abraham I wrote:
>>>> AM654x has two SERDES instances. Each instance has three input clocks
>>>> (left input, externel reference clock and right input) and two output
>>>> clocks (left output and right output) in addition to a PLL mux clock
>>>> which the SERDES uses for Clock Multiplier Unit (CMU refclock).
>>>> The PLL mux clock can select from one of the three input clocks.
>>>> The right output can select between left input and external reference
>>>> clock while the left output can select between the right input and
>>>> external reference clock.
>>>>
>>>> The left and right input reference clock of SERDES0 and SERDES1
>>>> respectively are connected to the SoC clock. In the case of two lane
>>>> SERDES personality card, the left input of SERDES1 is connected to
>>>> the right output of SERDES0 in a chained fashion.
>>>>
>>>> See section "Reference Clock Distribution" of AM65x Sitara Processors
>>>> TRM (SPRUID7 – April 2018) for more details.
>>>>
>>>> Add dt-binding documentation in order to represent all these different
>>>> configurations in device tree.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  .../devicetree/bindings/phy/ti-phy.txt        | 77 +++++++++++++++++++
>>>>  include/dt-bindings/phy/phy-am654-serdes.h    | 13 ++++
>>>>  2 files changed, 90 insertions(+)
>>>>  create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
>>>> index 57dfda8a7a1d..fc2fff6b2c37 100644
>>>> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
>>>> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
>>>> @@ -132,3 +132,80 @@ sata_phy: phy@4a096000 {
>>>>  	syscon-pllreset = <&scm_conf 0x3fc>;
>>>>  	#phy-cells = <0>;
>>>>  };
>>>> +
>>>> +
>>>> +TI AM654 SERDES
>>>> +
>>>> +Required properties:
>>>> + - compatible: Should be "ti,phy-am654-serdes"
>>>> + - reg : Address and length of the register set for the device.
>>>> + - reg-names: Should be "serdes" which corresponds to the register space
>>>> +	populated in "reg".
>>>> + - #phy-cells: determine the number of cells that should be given in the
>>>> +	phandle while referencing this phy. Should be "2". The 1st cell
>>>> +	corresponds to the phy type (should be one of the types specified in
>>>> +	include/dt-bindings/phy/phy.h) and the 2nd cell should be the serdes
>>>> +	lane function.
>>>> +	If SERDES0 is referenced 2nd cell should be:
>>>> +		0 - USB3
>>>> +		1 - PCIe0 Lane0
>>>> +		2 - ICSS2 SGMII Lane0
>>>> +	If SERDES1 is referenced 2nd cell should be:
>>>> +		0 - PCIe1 Lane0
>>>> +		1 - PCIe0 Lane1
>>>> +		2 - ICSS2 SGMII Lane1
>>>
>>> Can we have a way to change default lane at probe time without having any user dependencies.
>>>
>>> e.g. To work in USB2.0 mode I don't want SERDES0 to be in lane 0 (which is SoC default).
>>> But at the same time the application might not be using PCIe or SGMII, so there is no
>>> PHY user to change the lane to 1 or 2.
>>>
>>> A DT property to allow selection of a default lane at probe time would help
>> Ideally we should be disabling the module that is not used ("status" property
>> of SERDES0 dt would be "disabled"). So there is no guarantee SERDES will be probed.
>>
> 
> OK. Is there something that can be done at the serdes_mux?
> As per bindings/mux/mmio-mux.txt
> 
> Optional properties:
> - idle-states : if present, the state the muxes will have when idle. The
>                 special state MUX_IDLE_AS_IS is the default.
> 
> Could that be used?

Looks like that's something we could use.

Thanks
Kishon
