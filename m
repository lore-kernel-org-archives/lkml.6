Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937520AbeBUPMC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:12:02 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58213 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934062AbeBUPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:11:59 -0500
Subject: Re: [PATCH 2/2] ARM: pinctrl: stm32: Optimizes and enhances stm32gpio
 irqchip
To: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-gpio@vger.kernel.org>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c7b7066a-001a-4a4f-d68b-e143ede411a5@st.com>
Date: Wed, 21 Feb 2018 16:11:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519221027-4028-3-git-send-email-radoslaw.pietrzyk@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Radoslaw,

On 02/21/2018 02:50 PM, Radoslaw Pietrzyk wrote:
> 	- removes unneeded irq_chip.irq_eoi callback
> 	- adds irq_chip.irq_set_wake callback for possible
> 	in the future GPIO wakeup
> 
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index 617df16..5b1740d 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -268,10 +268,10 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
>   
>   static struct irq_chip stm32_gpio_irq_chip = {
>   	.name           = "stm32gpio",
> -	.irq_eoi	= irq_chip_eoi_parent,
>   	.irq_mask       = irq_chip_mask_parent,
>   	.irq_unmask     = irq_chip_unmask_parent,
>   	.irq_set_type   = irq_chip_set_type_parent,
> +	.irq_set_wake   = irq_chip_set_wake_parent,
Thanks, this one was in my backlog.

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>


>   	.irq_request_resources = stm32_gpio_irq_request_resources,
>   	.irq_release_resources = stm32_gpio_irq_release_resources,
>   };
> 
