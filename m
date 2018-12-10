Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBCC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8072084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ycXOerql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8072084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeLJN2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:28:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57488 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbeLJN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:28:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBADRoEC007067;
        Mon, 10 Dec 2018 07:27:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544448470;
        bh=JW4TH8hgq7AM1mcRb3UP0uz5sNmGSd6Mt0fB3WIi3pA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ycXOerqlibfLZ1TAeddcO8xCrqw8AwwogdTFKaAxLwro8QLwatnXOuJPwDJsMfHHz
         +Jgs6WZYF6XvWaIkcSW7uFGE0eSAZYRcq90SyFrjbi3QWaHhOdne2cjlQdPWtI0vvC
         WOSnjR2GXwXkuEx6Wx5jnpUGrxUnJag6WqtrUutw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBADRobf031423
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 07:27:50 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 07:27:50 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 07:27:50 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBADRkNF030324;
        Mon, 10 Dec 2018 07:27:47 -0600
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am654: Add Support for MMC/SD
To:     Nishanth Menon <nm@ti.com>, Vignesh R <vigneshr@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <mark.rutland@arm.com>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-2-faiz_abbas@ti.com>
 <a6aacd53-e1c4-fce0-7712-f276c80bbffc@ti.com>
 <20181208154526.ivbvwvcx6otg7lvh@akan>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <044fa725-9b6d-e331-ee10-664e59128e64@ti.com>
Date:   Mon, 10 Dec 2018 19:00:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181208154526.ivbvwvcx6otg7lvh@akan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 08/12/18 9:15 PM, Nishanth Menon wrote:
> On 10:56-20181208, Vignesh R wrote:
>>
>>
>> On 07/12/18 2:12 PM, Faiz Abbas wrote:
>>> There are two MMC host controller instances present on the TI's
>>> Am654 SOCs. Add device tree nodes for the same.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 28 ++++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> index 916434839603..d07212f16a81 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>>> @@ -129,4 +129,32 @@
>>>  		clocks = <&k3_clks 113 1>;
>>>  		power-domains = <&k3_pds 113>;
>>>  	};
>>> +
>>> +	sdhci0: sdhci@4f80000 {
>>> +		compatible = "ti,am654-sdhci-5.1";
>>> +		reg = <0x0 0x4f80000 0x0 0x260>, <0x0 0x4f90000 0x0 0x134>;
>>> +		power-domains = <&k3_pds 47>;
>>> +		clocks = <&k3_clks 47 0>, <&k3_clks 47 1>;
>>> +		clock-names = "clk_ahb", "clk_xin";
>>> +		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>>> +		sdhci-caps-mask = <0x80000007 0x0>;
>>> +		mmc-ddr-1_8v;
>>> +		ti,otap-del-sel = <0x2>;
>>> +		ti,trm-icp = <0x8>;
>>> +		status = "disabled";
>>> +	};
>>
>> Please drop "status=disabled" from dtsi. Can be disabled as required in
>> the board dts.
> 
> 
> yes - the standard in k3 is to disable the nodes that are'nt needed in
> board.dtsi.
> 
> This is different from "disabled by default" approach in DRA7 or OMAP4
> for example.
> 

Ok. Will fix in v2.

Thanks,
Faiz
