Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6CskMWKHGVv7QgAAmS7hNA
	; Thu, 07 Jun 2018 19:28:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6EF596074D; Thu,  7 Jun 2018 19:28:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dwtw4sOS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CD02A60290;
	Thu,  7 Jun 2018 19:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD02A60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbeFGT2e (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:28:34 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:52243 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeFGT2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:28:31 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w57JSUMU017549;
        Thu, 7 Jun 2018 14:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528399710;
        bh=DPNjxUj9qlEqQKGz4E9O5pSWkvEE0gAyzK0qECIq+RY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Dwtw4sOSdLfNpkD23jYzufxqhnbkgwGPqosBU9+bx0wQkNzuwM35ae9xAdLmyjBKn
         nXxFUwrR6TM59NzwDZadPs+3LIbihNv3/WU+7paZIVm0N14HfMZv2iOP5PEDCvqW2X
         LQiRnK6lEIa3ZAtdEmg4uAfSdVr4uLNB3E1wN2FA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w57JSUUS007073;
        Thu, 7 Jun 2018 14:28:30 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 7 Jun
 2018 14:28:30 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 7 Jun 2018 14:28:30 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w57JSUcF012561;
        Thu, 7 Jun 2018 14:28:30 -0500
Subject: Re: [PATCH 2/2] gpio: davinci: Do not assume continuous IRQ numbering
To: Keerthy <j-keerthy@ti.com>, <linus.walleij@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <t-kristo@ti.com>
References: <1528276734-1483-1-git-send-email-j-keerthy@ti.com>
 <1528276734-1483-2-git-send-email-j-keerthy@ti.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <fa15890c-756e-0821-df69-302fdd451283@ti.com>
Date: Thu, 7 Jun 2018 14:28:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528276734-1483-2-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2018 04:18 AM, Keerthy wrote:
> Currently the driver assumes that the interrupts are continuous
> and does platform_get_irq only once and assumes the rest are continuous,
> instead call platform_get_irq for all the interrupts and store them
> in an array for later use.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Tested for GPIO Interrupts on da850-lcdk and keystone-k2g-evm boards.
> 
>   drivers/gpio/gpio-davinci.c | 49 ++++++++++++++++++++++++++++++---------------
>   1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index 861f35b..375578c 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -42,6 +42,7 @@ struct davinci_gpio_regs {
>   
>   #define BINTEN	0x8 /* GPIO Interrupt Per-Bank Enable Register */
>   #define MAX_LABEL_SIZE 20
> +#define MAX_INT_PER_BANK 32
>   
>   static void __iomem *gpio_base;
>   static unsigned int offset_array[5] = {0x10, 0x38, 0x60, 0x88, 0xb0};
> @@ -55,7 +56,7 @@ static inline struct davinci_gpio_regs __iomem *irq2regs(struct irq_data *d)
>   	return g;
>   }
>   
> -static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq);
> +static int davinci_gpio_irq_setup(struct platform_device *pdev, int *bank_irq);
>   
>   /*--------------------------------------------------------------------------*/
>   
> @@ -168,7 +169,8 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>   {
>   	static int ctrl_num, bank_base;
>   	int gpio, bank, ret = 0;
> -	unsigned ngpio, nbank, bank_irq;
> +	unsigned int ngpio, nbank, nirq;
> +	int bank_irq[MAX_INT_PER_BANK], i;
>   	struct davinci_gpio_controller *chips;
>   	struct davinci_gpio_platform_data *pdata;
>   	struct device *dev = &pdev->dev;
> @@ -197,6 +199,16 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>   	if (WARN_ON(ARCH_NR_GPIOS < ngpio))
>   		ngpio = ARCH_NR_GPIOS;
>   
> +	/*
> +	 * If there are unbanked interrupts then the number of
> +	 * interrupts is equal to number of gpios else all are banked so
> +	 * number of interrupts is equal to number of banks(each with 16 gpios)
> +	 */
> +	if (pdata->gpio_unbanked)
> +		nirq = pdata->gpio_unbanked;
> +	else
> +		nirq = DIV_ROUND_UP(ngpio, 16);
> +
>   	nbank = DIV_ROUND_UP(ngpio, 32);
>   	chips = devm_kzalloc(dev,
>   			     nbank * sizeof(struct davinci_gpio_controller),
> @@ -209,10 +221,13 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>   	if (IS_ERR(gpio_base))
>   		return PTR_ERR(gpio_base);
>   
> -	bank_irq = platform_get_irq(pdev, 0);
> -	if (bank_irq < 0) {
> -		dev_dbg(dev, "IRQ not populated\n");
> -		return bank_irq;
> +	for (i = 0; i < nirq; i++) {
> +		bank_irq[i] = platform_get_irq(pdev, i);
> +		if (bank_irq[i] < 0) {
> +			dev_info(dev, "IRQ not populated, err = %d\n",
> +				 bank_irq[i]);
> +			return bank_irq[i];
> +		}
>   	}
>   
>   	snprintf(label, MAX_LABEL_SIZE, "davinci_gpio.%d", ctrl_num++);
> @@ -458,7 +473,7 @@ static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
>    * (dm6446) can be set appropriately for GPIOV33 pins.
>    */
>   
> -static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
> +static int davinci_gpio_irq_setup(struct platform_device *pdev, int *bank_irq)
>   {
>   	unsigned	gpio, bank;
>   	int		irq;
> @@ -492,6 +507,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
>   		dev_err(dev, "Error %ld getting gpio clock\n", PTR_ERR(clk));
>   		return PTR_ERR(clk);
>   	}
> +
>   	ret = clk_prepare_enable(clk);
>   	if (ret)
>   		return ret;
> @@ -531,12 +547,12 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev, int bank_irq)
>   	if (pdata->gpio_unbanked) {
>   		/* pass "bank 0" GPIO IRQs to AINTC */
>   		chips->chip.to_irq = gpio_to_irq_unbanked;
> -		chips->base_irq = bank_irq;
> +		chips->base_irq = bank_irq[0];


i think, you need to update gpio_to_irq_unbanked() also, which
probably would require to save array of irqs.


and gpio_irq_type_unbanked()



[...]
> 

-- 
regards,
-grygorii
