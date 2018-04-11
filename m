Return-Path: <afd@ti.com>
X-Google-Smtp-Source: AIpwx48yoU23x4mG+yon2x7r5eSJt6Us72DoiuYeaRm+gmUywsIvrDKbe4YpQ1bv5PK4SWbs5Giw
ARC-Seal: i=1; a=rsa-sha256; t=1523461417; cv=none;
        d=google.com; s=arc-20160816;
        b=r4ZgGzXfadRrqzPJLrKn+f/8kx7bdSNaMALztynHVkGk8+v6xMIR2q5gW+mu/TUb1X
         hWyvgd7blHdKQDyoJ3+dJ+CR4YpQ+8ZiXgek6yverNn/tR2ke1/wcaob6q/0tOF1H9wM
         tL7Ot8Sn/JtiL+nKLQF8honmZCpNdqw6lehrHZEOMiyyPIjMcgVYZE4yly4s9c0iyGgD
         A4oSkFfD5BDW0+EVrGoiwwbHTDUo7EnINUtFfbg3R5RwmnAOJZbWnWMUK4ArM5ZON2D1
         ZsOIG3t01o5JlkW+ulMjwasj7wAb/XdcJ/zPm1B8MfdwSOvn16QyDGRkkPFjY8S5ZrB4
         xk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=JF1AA6mpdRGLmMWXFJVcZhBGQA5LzE35rOB1u3skUoY=;
        b=lTfS/G7E8X9Lch4PzgcxFINjzIFrIW0jjJPlnJ35xXrAmA8WK77TdX2VWZppAz+h2G
         QUgeBFCHDNdBXXdJp84HSibVy4D2J+4LQnf/hZdjEO/nt6y7T2COSkNk6zqX0Tz6BBOb
         d5GluZSZujTJf08EDRJfpd2fi217gtuBGOUy+OxkONOaMJToGet7fpJPIu5vOpVBwENL
         e9Khj+HNjj0xehHbymyoju9NpIWR0s24oweYqydvEZupv1bfcYUpODNSRrPOeyBAbiGr
         BKh1Zp5nx7LYAo1Rnymm9M2ar8/EqMLGJyHJd4RrghNsxQMynNVarV5JfC+pTzsK4Fd+
         CrQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=r0kCKys8;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=r0kCKys8;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio
 Estevam <festevam@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
Date: Wed, 11 Apr 2018 10:43:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411141555.15044-3-peda@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597465079277258605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 09:15 AM, Peter Rosin wrote:
> This is a current sense amplifier from Analog Devices.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/iio/afe/Kconfig              |  3 +-
>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
> index 642ce4eb12a6..0e10fe8f459a 100644
> --- a/drivers/iio/afe/Kconfig
> +++ b/drivers/iio/afe/Kconfig
> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>  	depends on OF || COMPILE_TEST
>  	help
>  	  Say yes here to build support for the IIO unit converter
> -	  that handles voltage dividers and current sense shunts.
> +	  that handles voltage dividers, current sense shunts and
> +	  the LT6106 Current Sense Amplifier from Analog Devices.

Could work better to split these out into separate drivers. Maybe a
iio-shunt-resistor.c that does just voltage->current with the
appropriate scaling. Then make a a separate lt6106.c.

"iio-unit-converter.c" isn't really doing what it says it is, it is not
a generic "unit converter" like one would assume. Having the driver name
describe what kind of device it physically represents will be better
when more complex AFEs show up that, for instance, have programmable
gains and need a larger driver.

Andrew

>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called iio-unit-converter.
> diff --git a/drivers/iio/afe/iio-unit-converter.c b/drivers/iio/afe/iio-unit-converter.c
> index fc50290d7e5e..4b0ae5ab9c2d 100644
> --- a/drivers/iio/afe/iio-unit-converter.c
> +++ b/drivers/iio/afe/iio-unit-converter.c
> @@ -144,6 +144,53 @@ static int unit_converter_configure_channel(struct device *dev,
>  	return 0;
>  }
>  
> +static int unit_converter_adi_lt6106_props(struct device *dev,
> +					   struct unit_converter *uc)
> +{
> +	u32 sense;
> +	u32 rin;
> +	u32 rout;
> +	u32 factor;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, "sense-resistor-micro-ohms",
> +				       &sense);
> +	if (ret) {
> +		dev_err(dev, "failed to read the sense resistance: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "input-resistor-ohms", &rin);
> +	if (ret) {
> +		dev_err(dev, "failed to read the input resistance: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = device_property_read_u32(dev, "output-resistor-ohms", &rout);
> +	if (ret) {
> +		dev_err(dev, "failed to read the output resistance: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Calculate the scaling factor, rin / (rout * sense), while trying
> +	 * to keep the fraction from overflowing.
> +	 */
> +	factor = gcd(sense, 1000000);
> +	uc->numerator = 1000000 / factor;
> +	uc->denominator = sense / factor;
> +
> +	factor = gcd(uc->numerator, rout);
> +	uc->numerator /= factor;
> +	uc->denominator *= rout / factor;
> +
> +	factor = gcd(uc->denominator, rin);
> +	uc->numerator *= rin / factor;
> +	uc->denominator /= factor;
> +
> +	return 0;
> +}
> +
>  static int unit_converter_current_sense_shunt_props(struct device *dev,
>  						    struct unit_converter *uc)
>  {
> @@ -175,11 +222,16 @@ static int unit_converter_voltage_divider_props(struct device *dev,
>  }
>  
>  enum unit_converter_variant {
> +	ADI_LT6106,
>  	CURRENT_SENSE_SHUNT,
>  	VOLTAGE_DIVIDER,
>  };
>  
>  static const struct unit_converter_cfg unit_converter_cfg[] = {
> +	[ADI_LT6106] = {
> +		.type = IIO_CURRENT,
> +		.props = unit_converter_adi_lt6106_props,
> +	},
>  	[CURRENT_SENSE_SHUNT] = {
>  		.type = IIO_CURRENT,
>  		.props = unit_converter_current_sense_shunt_props,
> @@ -191,6 +243,8 @@ static const struct unit_converter_cfg unit_converter_cfg[] = {
>  };
>  
>  static const struct of_device_id unit_converter_match[] = {
> +	{ .compatible = "adi,lt6106",
> +	  .data = &unit_converter_cfg[ADI_LT6106], },
>  	{ .compatible = "current-sense-shunt",
>  	  .data = &unit_converter_cfg[CURRENT_SENSE_SHUNT], },
>  	{ .compatible = "voltage-divider",
> 
