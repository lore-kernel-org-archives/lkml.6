Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26281ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42FB2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42FB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeGQNoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:44:21 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16929 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728889AbeGQNoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:44:21 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6HD98oq010817;
        Tue, 17 Jul 2018 15:11:25 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k85rehe9e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 17 Jul 2018 15:11:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 56DDA34;
        Tue, 17 Jul 2018 13:11:24 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38A35540D;
        Tue, 17 Jul 2018 13:11:24 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.48) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 17 Jul
 2018 15:11:23 +0200
Subject: Re: [PATCH 2/2] pinctrl: stm32: add syscfg mask parameter
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1531821387-29845-1-git-send-email-ludovic.Barre@st.com>
 <1531821387-29845-3-git-send-email-ludovic.Barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <4acc415d-f162-67a2-57d6-0a7defda434f@st.com>
Date:   Tue, 17 Jul 2018 15:11:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1531821387-29845-3-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

add Rob, I forgotten rob's mail.

On 07/17/2018 11:56 AM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds mask parameter to define IRQ mux field.
> This field could vary depend of IRQ mux selection register.
> To avoid backward compatibility, the drivers set
> the legacy value by default.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index dfed609..f756232 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -46,6 +46,8 @@
>   #define STM32_GPIO_PINS_PER_BANK 16
>   #define STM32_GPIO_IRQ_LINE	 16
>   
> +#define SYSCFG_IRQMUX_MASK GENMASK(3, 0)
> +
>   #define gpio_range_to_bank(chip) \
>   		container_of(chip, struct stm32_gpio_bank, range)
>   
> @@ -1033,6 +1035,7 @@ static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
>   	struct device *dev = &pdev->dev;
>   	struct regmap *rm;
>   	int offset, ret, i;
> +	int mask, mask_width;
>   
>   	parent = of_irq_find_parent(np);
>   	if (!parent)
> @@ -1052,12 +1055,21 @@ static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
>   	if (ret)
>   		return ret;
>   
> +	ret = of_property_read_u32_index(np, "st,syscfg", 2, &mask);
> +	if (ret)
> +		mask = SYSCFG_IRQMUX_MASK;
> +
> +	mask_width = fls(mask);
> +
>   	for (i = 0; i < STM32_GPIO_PINS_PER_BANK; i++) {
>   		struct reg_field mux;
>   
>   		mux.reg = offset + (i / 4) * 4;
> -		mux.lsb = (i % 4) * 4;
> -		mux.msb = mux.lsb + 3;
> +		mux.lsb = (i % 4) * mask_width;
> +		mux.msb = mux.lsb + mask_width - 1;
> +
> +		dev_dbg(dev, "irqmux%d: reg:%#x, lsb:%d, msb:%d\n",
> +			i, mux.reg, mux.lsb, mux.msb);
>   
>   		pctl->irqmux[i] = devm_regmap_field_alloc(dev, rm, mux);
>   		if (IS_ERR(pctl->irqmux[i]))
> 
