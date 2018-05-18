Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeERQ4b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:56:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeERQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:56:26 -0400
Subject: Re: [PATCH 2/2] pwm: stm32: initialize raw local variables
To: Fabrice Gasnier <fabrice.gasnier@st.com>, lee.jones@linaro.org,
        thierry.reding@gmail.com
Cc: sfr@canb.auug.org.au, gerald.baeza@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <53e327ba-10c0-618c-edf4-1e1b528527c7@infradead.org>
Date: Fri, 18 May 2018 09:56:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 08:24 AM, Fabrice Gasnier wrote:
> This removes build warning when COMPILE_TEST=y and MFD_STM32_TIMERS=n
> in drivers/pwm/pwm-stm32.c. In function 'stm32_pwm_capture' 'raw_prd' and
> 'raw_dty' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 60bfc07..09383c6 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -170,7 +170,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
>  	unsigned long long prd, div, dty;
>  	unsigned long rate;
>  	unsigned int psc = 0, icpsc, scale;
> -	u32 raw_prd, raw_dty;
> +	u32 raw_prd = 0, raw_dty = 0;
>  	int ret = 0;
>  
>  	mutex_lock(&priv->lock);
> 


-- 
~Randy
