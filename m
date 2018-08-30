Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C066DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F58E20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F58E20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeH3RsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:48:23 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:48367 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbeH3RsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:48:23 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 421P0J0tCFz1qwdZ;
        Thu, 30 Aug 2018 15:46:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 421P0H6rJfz1tLP6;
        Thu, 30 Aug 2018 15:46:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id QRRtW53repI0; Thu, 30 Aug 2018 15:46:05 +0200 (CEST)
X-Auth-Info: Dfc9DAQRQPe3xrxB1xOYU9QcvPfIgkdGfn+nqlzRO6o=
Received: from [192.168.1.106] (79.120.172.10.pool.invitel.hu [79.120.172.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 30 Aug 2018 15:46:05 +0200 (CEST)
Subject: Re: [PATCH] ARM: dts: imx6ull: fix pinmux input_val for uart5 rx pin
To:     =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20180830124702.12572-1-hs@denx.de>
 <218369fa-8ec1-fd3c-dd2e-b4821e11cb62@armadeus.com>
Reply-To: hs@denx.de
From:   Heiko Schocher <hs@denx.de>
Message-ID: <1d81ae5d-7d55-c059-1e1a-d3efb3588c37@denx.de>
Date:   Thu, 30 Aug 2018 15:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <218369fa-8ec1-fd3c-dd2e-b4821e11cb62@armadeus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sébastien,

Am 30.08.2018 um 15:25 schrieb Sébastien Szymanski:
> Hi,
> 
> On 08/30/2018 02:47 PM, Heiko Schocher wrote:
>> on the imx6ull the input_val for uart5 rx function
>> of pin MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX
>> is 7 and not 5 as on the imx6ul. With this
>> patch, console on an imx6ull based board works
>> with uart5.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> This is already fixed on v4.19-rc1 and also on a few others PADs that
> have similar issue.
> Moreover signals common for both i.MX6UL and i.MX6ULL should have
> IMX6UL_ as prefix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=for-next&id=387301d5b88e2fe91de9baf4ca25f771cc633f70

My patch was based on current HEAD ...Ah, got it, this patch is in
"for-next"

Thanks! And sorry for the noise.

bye,
Heiko
> 
> Regards,
> 
>>
>> ---
>>
>>   arch/arm/boot/dts/imx6ull-pinfunc.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
>> index fdc46bb09cc1a..d835aeae5485b 100644
>> --- a/arch/arm/boot/dts/imx6ull-pinfunc.h
>> +++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
>> @@ -61,5 +61,6 @@
>>   #define MX6ULL_PAD_CSI_DATA05__ESAI_TX_CLK                        0x01F8 0x0484 0x0000 0x9 0x0
>>   #define MX6ULL_PAD_CSI_DATA06__ESAI_TX5_RX0                       0x01FC 0x0488 0x0000 0x9 0x0
>>   #define MX6ULL_PAD_CSI_DATA07__ESAI_T0                            0x0200 0x048C 0x0000 0x9 0x0
>> +#define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX		0x00C0 0x034C 0x0644 0 7
>>   
>>   #endif /* __DTS_IMX6ULL_PINFUNC_H */
>>
> 
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
