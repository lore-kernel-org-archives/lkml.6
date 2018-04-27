Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757898AbeD0Jda (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:33:30 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:57331 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757361AbeD0Jd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:33:28 -0400
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: tpa6130a2: Use gpio_is_valid()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, <jikos@kernel.org>,
        <benjamin.tissoires@redhat.com>, <jkosina@suse.cz>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
 <195792a282b569037357ca17e4baad19893f0609.1524819052.git.arvind.yadav.cs@gmail.com>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2ed0acde-c4da-0e1d-a62a-433c858e14a6@ti.com>
Date: Fri, 27 Apr 2018 12:33:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <195792a282b569037357ca17e4baad19893f0609.1524819052.git.arvind.yadav.cs@gmail.com>
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
>  sound/soc/codecs/tpa6130a2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index 616cd4b..18f32b9 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -62,7 +62,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
>  			return ret;
>  		}
>  		/* Power on */
> -		if (data->power_gpio >= 0)
> +		if (gpio_is_valid(data->power_gpio))
>  			gpio_set_value(data->power_gpio, 1);
>  
>  		/* Sync registers */
> @@ -72,7 +72,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
>  			dev_err(data->dev,
>  				"Failed to sync registers: %d\n", ret);
>  			regcache_cache_only(data->regmap, true);
> -			if (data->power_gpio >= 0)
> +			if (gpio_is_valid(data->power_gpio))
>  				gpio_set_value(data->power_gpio, 0);
>  			ret2 = regulator_disable(data->supply);
>  			if (ret2 != 0)
> @@ -89,7 +89,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
>  		regcache_cache_only(data->regmap, true);
>  
>  		/* Power off */
> -		if (data->power_gpio >= 0)
> +		if (gpio_is_valid(data->power_gpio))
>  			gpio_set_value(data->power_gpio, 0);
>  
>  		ret = regulator_disable(data->supply);
> @@ -259,7 +259,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
>  
>  	data->id = id->driver_data;
>  
> -	if (data->power_gpio >= 0) {
> +	if (gpio_is_valid(data->power_gpio)) {
>  		ret = devm_gpio_request(dev, data->power_gpio,
>  					"tpa6130a2 enable");
>  		if (ret < 0) {
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
