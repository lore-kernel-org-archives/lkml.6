Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0386EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A550A258E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A550A258E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeFYMRJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:17:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39703 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932965AbeFYMRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:17:07 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5PCDb9e001396;
        Mon, 25 Jun 2018 14:16:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jtvaps8mg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Jun 2018 14:16:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7430A3A;
        Mon, 25 Jun 2018 12:16:38 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FF2C12B1;
        Mon, 25 Jun 2018 12:16:38 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Jun
 2018 14:16:37 +0200
Subject: Re: [PATCH 1/1] ARM: dts: stm32: Add HASH support on stm32mp157c
To:     Lionel Debieve <lionel.debieve@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180514100034.10282-1-lionel.debieve@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <e830c0ab-409a-7d6c-b654-9640f0fe36fd@st.com>
Date:   Mon, 25 Jun 2018 14:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514100034.10282-1-lionel.debieve@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lionel,

On 05/14/2018 12:00 PM, Lionel Debieve wrote:
> This patch add HASH instance of the stm32mp157c SoC
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index b66f673b5038..cb39fb6d9960 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -702,6 +702,18 @@
>   			status = "disabled";
>   		};
>   
> +		hash1: hash@54002000 {
> +			compatible = "st,stm32f756-hash";
> +			reg = <0x54002000 0x400>;
> +			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&rcc HASH1>;
> +			resets = <&rcc HASH1_R>;
> +			dmas = <&mdma1 31 0x10 0x1000A02 0x0 0x0 0x0>;
> +			dma-names = "in";
> +			dma-maxburst = <2>;
> +			status = "disabled";
> +		};
> +
>   		rng1: rng@54003000 {
>   			compatible = "st,stm32-rng";
>   			reg = <0x54003000 0x400>;
> 

Applied on stm32-next.

Thanks.
Alex
