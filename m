Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EADC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDE126740
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDE126740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbeFZJAi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:00:38 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49357 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932333AbeFZJAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:00:36 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5Q8xOOB003775;
        Tue, 26 Jun 2018 10:59:40 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jujbhr1cv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 26 Jun 2018 10:59:40 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D09344D;
        Tue, 26 Jun 2018 08:59:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 145E41D15;
        Tue, 26 Jun 2018 08:59:35 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 26 Jun
 2018 10:59:34 +0200
Subject: Re: [PATCH v1] ARM: multi_v7_defconfig: enable STM32 DMAv2, DMAMUX
 and MDMA
To:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1527498513-19167-1-git-send-email-pierre-yves.mordret@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <7ecfa4af-5df0-7843-ae6c-0c5e34bdac2c@st.com>
Date:   Tue, 26 Jun 2018 10:59:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527498513-19167-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pierre-Yves

On 05/28/2018 11:08 AM, Pierre-Yves MORDRET wrote:
> This enables drivers for STM32:
>   - DMAv2
>   - DMMAUX
>   - MDMA
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> ---
>    Version history:
>       v1:
>          * Initial
> ---
> ---
>   arch/arm/configs/multi_v7_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 89167cd..9f62957 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -887,6 +887,9 @@ CONFIG_QCOM_BAM_DMA=y
>   CONFIG_XILINX_DMA=y
>   CONFIG_DMA_SUN6I=y
>   CONFIG_ST_FDMA=m
> +CONFIG_STM32_DMA=y
> +CONFIG_STM32_DMAMUX=y
> +CONFIG_STM32_MDMA=y
>   CONFIG_STAGING=y
>   CONFIG_SENSORS_ISL29018=y
>   CONFIG_SENSORS_ISL29028=y
> 

Applied on stm32-next.

Thanks.
Alex
