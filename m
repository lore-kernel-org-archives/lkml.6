Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1308AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94E120862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94E120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeKESR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:17:27 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:58701 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:17:27 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gJaiS-0004mT-44 from Vladimir_Zapolskiy@mentor.com ; Mon, 05 Nov 2018 00:58:36 -0800
Received: from [137.202.108.125] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Mon, 5 Nov 2018 08:58:31 +0000
Subject: Re: [PATCH] ARM: dts: i.MX25: add the clocks for the EPIT blocks
To:     Shawn Guo <shawnguo@kernel.org>, Martin Kaiser <martin@kaiser.cx>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
References: <1541093567-29205-1-git-send-email-martin@kaiser.cx>
 <20181104144614.GJ26016@tiger>
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <0298f7ec-fbff-8edb-92bb-70a736ddaf25@mentor.com>
Date:   Mon, 5 Nov 2018 10:58:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20181104144614.GJ26016@tiger>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Clément.

On 11/04/2018 04:46 PM, Shawn Guo wrote:
> On Thu, Nov 01, 2018 at 06:32:47PM +0100, Martin Kaiser wrote:
>> The i.MX25 contains two EPIT (Enhanced Periodic Interrupt Timer)
>> function blocks. Add their ipg and per clocks to the device tree.
>>
>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> 
> Are these EPIT devices actually used in upstream kernel, or just
> somewhere else?

Clément wrote a good driver, which has already passed a series of reviews,
but this clocks add-on is actually missing.

Clément, can you please add clock-names property and the corresponding
functional change to your driver? Thank you in advance.

--
Best wishes,
Vladimir

>> ---
>>
>> I tried to make this similar to gpt1 and gpt2.
>>
>>  arch/arm/boot/dts/imx25.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
>> index b25309d26ea5..e80101847aff 100644
>> --- a/arch/arm/boot/dts/imx25.dtsi
>> +++ b/arch/arm/boot/dts/imx25.dtsi
>> @@ -388,12 +388,16 @@
>>  			epit1: timer@53f94000 {
>>  				compatible = "fsl,imx25-epit";
>>  				reg = <0x53f94000 0x4000>;
>> +				clocks = <&clks 83>, <&clks 43>;
>> +				clock-names = "ipg", "per";
>>  				interrupts = <28>;
>>  			};
>>  
>>  			epit2: timer@53f98000 {
>>  				compatible = "fsl,imx25-epit";
>>  				reg = <0x53f98000 0x4000>;
>> +				clocks = <&clks 84>, <&clks 43>;
>> +				clock-names = "ipg", "per";
>>  				interrupts = <27>;
>>  			};
>>  
>> -- 
>> 2.1.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
