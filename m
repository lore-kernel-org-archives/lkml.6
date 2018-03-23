Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeCWPXB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:23:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54796 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751553AbeCWPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:22:59 -0400
Subject: Re: [RESEND PATCH 2/3] pwm: stm32: LPTimer: use 3 cells xlate
To: <thierry.reding@gmail.com>, <alexandre.torgue@st.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <benjamin.gaignard@linaro.org>
References: <1519392965-28235-1-git-send-email-fabrice.gasnier@st.com>
 <1519392965-28235-3-git-send-email-fabrice.gasnier@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <d23f866b-67af-4e5b-14aa-a2c5a0a499ec@st.com>
Date: Fri, 23 Mar 2018 16:22:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519392965-28235-3-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-23_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 02:36 PM, Fabrice Gasnier wrote:
> From: Gerald Baeza <gerald.baeza@st.com>
> 
> STM32 Low-Power Timer supports generic 3 cells pwm to encode
> PWM number, period and polarity.
> 
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 1ac9e43..346b7bd 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -203,6 +203,8 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
>  	priv->chip.dev = &pdev->dev;
>  	priv->chip.ops = &stm32_pwm_lp_ops;
>  	priv->chip.npwm = 1;
> +	priv->chip.of_xlate = of_pwm_xlate_with_flags;
> +	priv->chip.of_pwm_n_cells = 3;
>  
>  	ret = pwmchip_add(&priv->chip);
>  	if (ret < 0)
> 

Hi Thierry, all,

Gentle ping for driver review since DT Bindings has been reviewed by Rob.

Many thanks in advance,
Regards,
Fabrice
