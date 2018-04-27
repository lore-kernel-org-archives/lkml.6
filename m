Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757840AbeD0JdR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:33:17 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:42559 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeD0JdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:33:15 -0400
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: tlv320dac33: Use gpio_is_valid()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, <jikos@kernel.org>,
        <benjamin.tissoires@redhat.com>, <jkosina@suse.cz>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
 <b61f3ee038bc0f577e60256c71a68bea783d0a13.1524819052.git.arvind.yadav.cs@gmail.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <c96ee82d-6b8f-2836-bbdc-57191f894056@ti.com>
Date: Fri, 27 Apr 2018 12:33:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b61f3ee038bc0f577e60256c71a68bea783d0a13.1524819052.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-04-27 11:56, Arvind Yadav wrote:
> Replace the manual validity checks for the GPIO with the
> gpio_is_valid().

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  sound/soc/codecs/tlv320dac33.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index a957eae..c23b9db 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -397,13 +397,13 @@ static int dac33_hard_power(struct snd_soc_component *component, int power)
>  				goto exit;
>  		}
>  
> -		if (dac33->power_gpio >= 0)
> +		if (gpio_is_valid(dac33->power_gpio))
>  			gpio_set_value(dac33->power_gpio, 1);
>  
>  		dac33->chip_power = 1;
>  	} else {
>  		dac33_soft_power(component, 0);
> -		if (dac33->power_gpio >= 0)
> +		if (gpio_is_valid(dac33->power_gpio))
>  			gpio_set_value(dac33->power_gpio, 0);
>  
>  		ret = regulator_bulk_disable(ARRAY_SIZE(dac33->supplies),
> @@ -1519,7 +1519,7 @@ static int dac33_i2c_probe(struct i2c_client *client,
>  	dac33->fifo_mode = DAC33_FIFO_BYPASS;
>  
>  	/* Check if the reset GPIO number is valid and request it */
> -	if (dac33->power_gpio >= 0) {
> +	if (gpio_is_valid(dac33->power_gpio)) {
>  		ret = gpio_request(dac33->power_gpio, "tlv320dac33 reset");
>  		if (ret < 0) {
>  			dev_err(&client->dev,
> @@ -1548,7 +1548,7 @@ static int dac33_i2c_probe(struct i2c_client *client,
>  
>  	return ret;
>  err_get:
> -	if (dac33->power_gpio >= 0)
> +	if (gpio_is_valid(dac33->power_gpio))
>  		gpio_free(dac33->power_gpio);
>  err_gpio:
>  	return ret;
> @@ -1561,7 +1561,7 @@ static int dac33_i2c_remove(struct i2c_client *client)
>  	if (unlikely(dac33->chip_power))
>  		dac33_hard_power(dac33->component, 0);
>  
> -	if (dac33->power_gpio >= 0)
> +	if (gpio_is_valid(dac33->power_gpio))
>  		gpio_free(dac33->power_gpio);
>  
>  	return 0;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
