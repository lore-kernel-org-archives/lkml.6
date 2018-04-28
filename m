Return-Path: <elder@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524945509; cv=none;
        d=google.com; s=arc-20160816;
        b=hODbb/vI74zqRmjZxBXUou6iNFtyHnto97PwuYKCeOpHyhYnFVpSSN7qKZYXNJhRf0
         Fo9/gQzuo+ve8B62CluUV47gMhPha+M2rewGqciuKbvV0Nx6oY8gE+9XXiMvjLF+AAx4
         o+My2vledt1+8WrvGufyoVLeB0NaWr9nR/BWdVtc5XjDUFi7kWwCuIjmU1dQkrw6yiNr
         CtRfaniZhxl9d8FuMSOFo9/kJmbgeH2jRL8ROcVrqEkFEmahDMoMdFuP+3tEY9+0gIyh
         SXCS0ucMHg2xgq+anddIdvN+C1THf4OV0B2rWC4a9GhB4v6f/faPf5ne4UWtl0dhqyRp
         V7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=1NRGZwStwNqT7I8+LEqlDJa7K4FKXszzQzXaY6mPSus=;
        b=0XdJuN5IM23RLQ/IiGqZ/c8iKfIHUbsQHW4Lq7yw5STwt/J4OAzBZsgEdspgv1ifNr
         vXIM1AcL0FLHmu0QeISBzy4DK1HkNgyrsWxIGjtr7PT87LAH5Z+dDgf/L/k7bse0mzpY
         3wPVDxPXMZW86MAQDZgNs7VGx0qgYSGt8sCasgqqAAtGpRxFmP4ZjjLa9wwmd6QHnELP
         uiu7smpCuT3athd7oMTvgTvVuc9z0+yaU5aiW66ECgAVgwrQk4ewyOdroAveuPQ1FSYB
         x+uSgS/Zn4ywpQw6DLaN+0df+QFx9vs/tptQJR+Ybm5PyEzWbQAJ8cisujUKNsapA0WA
         O4eg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QXcR+B8/;
       spf=pass (google.com: domain of elder@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=elder@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=QXcR+B8/;
       spf=pass (google.com: domain of elder@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=elder@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpyDamJMsxohHm4S0fEzFYxcPLkGEmw9ncFcjK+tTuu+QhfG5Ye5ukifeZcN0mrzTsVxWQ0Mw==
Subject: Re: [greybus-dev] [PATCH v2] staging: greybus: Use gpio_is_valid()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, hvaibhav.linux@gmail.com,
 johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
From: Alex Elder <elder@linaro.org>
Message-ID: <b2ab24c5-92ea-5c99-af89-30c3e7ee61af@linaro.org>
Date: Sat, 28 Apr 2018 14:58:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598896358310387815?=
X-GMAIL-MSGID: =?utf-8?q?1599021262750652036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 11:35 PM, Arvind Yadav wrote:
> Replace the manual validity checks for the GPIO with the
> gpio_is_valid().
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
> chnage in v2 :
>              Returning invalid gpio as error instead of -ENODEV.
> 
>  drivers/staging/greybus/arche-platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index 83254a7..c3a7da5 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -448,7 +448,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>  							"svc,reset-gpio",
>  							0);
> -	if (arche_pdata->svc_reset_gpio < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>  		dev_err(dev, "failed to get reset-gpio\n");
>  		return arche_pdata->svc_reset_gpio;
>  	}
> @@ -468,7 +468,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
>  							  "svc,sysboot-gpio",
>  							  0);
> -	if (arche_pdata->svc_sysboot_gpio < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
>  		dev_err(dev, "failed to get sysboot gpio\n");
>  		return arche_pdata->svc_sysboot_gpio;
>  	}
> @@ -487,7 +487,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
>  							"svc,refclk-req-gpio",
>  							0);
> -	if (arche_pdata->svc_refclk_req < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
>  		dev_err(dev, "failed to get svc clock-req gpio\n");
>  		return arche_pdata->svc_refclk_req;
>  	}
> 
