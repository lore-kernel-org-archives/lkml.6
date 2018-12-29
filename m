Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FCEC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C15E218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 00:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeL2A7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 19:59:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:37348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbeL2A7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 19:59:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A752AE46;
        Sat, 29 Dec 2018 00:58:59 +0000 (UTC)
Subject: Re: [PATCH RFC lora-next 2/4] net: lora: sx1301: add minimal to get
 AGC working prior to tx work
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     starnight@g.ncu.edu.tw, jiri@resnulli.us,
        linux-lpwan@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
 <20181219155616.9547-3-ben.whitten@lairdtech.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 xsFNBE6W6ZQBEAC/BIukDnkVenIkK9O14UucicBIVvRB5WSMHC23msS+R2h915mW7/vXfn+V
 0nrr5ECmEg/5OjujKf0x/uhJYrsxcp45nDyYCk+RYoOJmGzzUFya1GvT/c04coZ8VmgFUWGE
 vCfhHJro85dZUL99IoLP21VXEVlCPyIngSstikeuf14SY17LPTN1aIpGQDI2Qt8HHY1zOVWv
 iz53aiFLFeIVhQlBmOABH2Ifr2M9loRC9yOyGcE2GhlzgyHGlQxEVGFn/QptX6iYbtaTBTU0
 c72rpmbe1Nec6hWuzSwu2uE8lF+HYcYi+22ml1XBHNMBeAdSEbSfDbwc///8QKtckUzbDvME
 S8j4KuqQhwvYkSg7dV9rs53WmjO2Wd4eygkC3tBhPM5s38/6CVGl3ABiWJs3kB08asUNy8Wk
 juusU/nRJbXDzxu1d+hv0d+s5NOBy/5+7Pa6HeyBnh1tUmCs5/f1D/cJnuzzYwAmZTHFUsfQ
 ygGBRRKpAVu0VxCFNPSYKW0ULi5eZV6bcj+NAhtafGsWcv8WPFXgVE8s2YU38D1VtlBvCo5/
 0MPtQORqAQ/Itag1EHHtnfuK3MBtA0fNxQbb2jha+/oMAi5hKpmB/zAlFoRtYHwjFPFldHfv
 Iljpe1S0rDASaF9NsQPfUBEm7dA5UUkyvvi00HZ3e7/uyBGb0QARAQABzSJBbmRyZWFzIEbD
 pHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgID
 AQIeAQIXgAUCTqGJnQIZAQAKCRD6LtEtPn4BPzetD/4rF6k/HF+9U9KqykfJaWdUHJvXpI85
 Roab12rQbiIrL4hVEYKrYwPEKpCf+FthXpgOq+JdTGJ831DMlTx7Ed5/QJ9KAAQuhZlSNjSc
 +FNobJm7EbFv9jWFjQC0JcOl17Ji1ikgRcIRDCul1nQh9jCdfh1b848GerZmzteNdT9afRJm
 7rrvMqXs1Y52/dTlfIW0ygMA2n5Vv3EwykXJOPF6fRimkErKO84sFMNg0eJV9mXs+Zyionfi
 g2sZJfVeKjkDqjxy7sDDBZZR68I9HWq5VJQrXqQkCZUvtr6TBLI+uiDLbGRUDNxA3wgjVdS2
 v9bhjYceSOHpKU+h3H2S8ju9rjhOADT2F5lUQMTSpjlzglh8IatV5rXLGkXEyum4MzMo2sCE
 Cr+GD6i2M3pHCtaIVV3xV0nRGALa6DdF7jBWqM54KHaKsE883kFH2+6ARcPCPrnPm7LX98h2
 4VpG984ysoq6fpzHHG/KCaYCEOe1bpr3Plmmp3sqj0utA6lwzJy0hj5dqug+lqmg7QKAnxl+
 porgluoY56U0X0PIVBc0yO0dWqRxtylJa9kDX/TKwFYNVddMn2NQNjOJXzx2H9hf0We7rG7+
 F/vgwALVVYbiTzvp2L0XATTv/oX4BHagAa/Qc3dIsBYJH+KVhBp+ZX4uguxk4xlc2hm75b1s
 cqeAD87BTQROlumUARAAzd7eu+tw/52FB7xQZWDv5aF+6CAkoz7AuY4s1fo0AQQDqjLOdpQF
 bifdH7B8SnsA4eo0syfs+1tZW6nn9hdy1GHEMbeuvdhNwkhEfYGDYpSue7oVxB4jajKvRHAP
 VcewKZIxvIiZ5aSp5n1Bd7B0c0C443DHiWE/0XWSpvbU7fTzTNvdz+2OZmGtqCn610gBqScv
 1BOiP3OfLly8ghxcJsos23c0mkB/1iWlzh3UMFIGrzsK3sZJ/3uRaLYFimmqqPlSwFqx3b0M
 1gFdHWKfOpvQ4wwP5P10xwvqNXLWC30wB1QmJGD/X8aAoVNnGsmEL7GcWF4cLoOSRidSoccz
 znShE+Ap+FVDD6MRyesNT4D67l792//B38CGJRdELtNacdwazaFgxH9O85Vnd70ZC7fIcwzG
 yg/4ZEf96DlAvrSOnu/kgklofEYdzpZmW+Fqas6cnk6ZaHa35uHuBPesdE13MVz5TeiHGQTW
 xP1jbgWQJGPvJZ+htERT8SZGBQRb1paoRd1KWQ1mlr3CQvXtfA/daq8p/wL48sXrKNwedrLV
 iZOeJOFwfpJgsFU4xLoO/8N0RNFsnelBgWgZE3ZEctEd4BsWFUw+czYCPYfqOcJ556QUGA9y
 DeDcxSitpYrNIvpk4C5CHbvskVLKPIUVXxTNl8hAGo1Ahm1VbNkYlocAEQEAAcLBXwQYAQIA
 CQUCTpbplAIbDAAKCRD6LtEtPn4BPzA6D/9TbSBOPM99SHPX9JiEQAw4ITCBF2oTWeZQ6RJg
 RKpB15lzyPfyFbNSceJp9dCiwDWe+pzKaX6KYOFZ5+YTS0Ph2eCR+uT2l6Mt6esAun8dvER/
 xlPDW7p88dwGUcV8mHEukWdurSEDTj8V3K29vpgvIgRq2lHCn2wqRQBGpiJAt72Vg0HxUlwN
 GAJNvhpeW8Yb43Ek7lWExkUgOfNsDCTvDInF8JTFtEXMnUcPxC0d/GdAuvBilL9SlmzvoDIZ
 5k2k456bkY3+3/ydDvKU5WIgThydyCEQUHlmE6RdA3C1ccIrIvKjVEwSH27Pzy5jKQ78qnhv
 dtLLAavOXyBJnOGlNDOpOyBXfv02x91RoRiyrSIM7dKmMEINKQlAMgB/UU/6B+mvzosbs5d3
 4FPzBLuuRz9WYzXmnC460m2gaEVk1GjpidBWw0yY6kgnAM3KhwCFSecqUQCvwKFDGSXDDbCr
 w08b3GDk40UoCoUq9xrGfhlf05TUSFTg2NlSrK7+wAEsTUgs2ZYLpHyEeftoDDnKpM4ghs/O
 ceCeyZUP1zSgRSjgITQp691Uli5Nd1mIzaaM8RjOE/Rw67FwgblKR6HAhSy/LYw1HVOu+Ees
 RAEdbtRt37A8brlb/ENxbLd9SGC8/j20FQjit7oPNMkTJDs7Uo2eb7WxOt5pSTVVqZkv7Q==
Organization: SUSE Linux GmbH
Message-ID: <8484168b-46bd-afae-6541-5a4b1db26557@suse.de>
Date:   Sat, 29 Dec 2018 01:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181219155616.9547-3-ben.whitten@lairdtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Am 19.12.18 um 16:56 schrieb Ben Whitten:
> As part of initialisation when opening the lora device after loading
> the AGC firmware we need to satisfy its startup procedure which involves
> a few steps;
> 
> Loading a 16 entry lookup table.
> For this I have hard coded the laird ETSI certified table for use on the
> RG186-M2 (EU) cards, this will need investigation on how other devices
> load calibration data.

Isn't calibration performed before this firmware is initialized? I left
out reading the values back from firmware previously, but that should
get implemented. In the userspace implementation, do you get these from
a config file or did you modify the reference code to hardcode them?

If these are different calibration values from the ones returned by
firmware, then a DT property would be an easy way to get
hardware-specific data into the driver. However, same as with your clk
config, that makes us dependent on DT, which we shouldn't be for ACPI
and USB. If we consider it configuration data rather than an immutable
fact, then we would need a netlink command to set them.

In any case, we have some other vendors on this list, so hopefully
someone can comment. :)

> 
> Selecting the correct channel to transmit on.
> Currently always 0 for the reference design.

Similarly: DT or netlink depending on whether fixed, and fall back to 0
as default.

> 
> Then ending the AGC init procedure and seeing that it has come up.
> 
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
> ---
>  drivers/net/lora/sx1301.c | 254 +++++++++++++++++++++++++++++++++++++-
>  drivers/net/lora/sx1301.h |  16 +++
>  2 files changed, 268 insertions(+), 2 deletions(-)

Many thanks for working on this! Some nits inline.

> diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
> index e75df93b96d8..0c7b6d0b31af 100644
> --- a/drivers/net/lora/sx1301.c
> +++ b/drivers/net/lora/sx1301.c
> @@ -24,6 +24,121 @@
>  
>  #include "sx1301.h"
>  
> +static struct sx1301_tx_gain_lut tx_gain_lut[] = {
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 0,
> +		.dac_gain = 3,
> +		.mix_gain = 8,
> +		.rf_power = -3,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 0,
> +		.dac_gain = 3,
> +		.mix_gain = 9,
> +		.rf_power = 0,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 0,
> +		.dac_gain = 3,
> +		.mix_gain = 12,
> +		.rf_power = 3,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 0,
> +		.dac_gain = 3,
> +		.mix_gain = 13,
> +		.rf_power = 4,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 1,
> +		.dac_gain = 3,
> +		.mix_gain = 8,
> +		.rf_power = 6,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 1,
> +		.dac_gain = 3,
> +		.mix_gain = 9,
> +		.rf_power = 9,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 1,
> +		.dac_gain = 3,
> +		.mix_gain = 10,
> +		.rf_power = 10,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 1,
> +		.dac_gain = 3,
> +		.mix_gain = 11,
> +		.rf_power = 12,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 1,
> +		.dac_gain = 3,
> +		.mix_gain = 12,
> +		.rf_power = 13,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 1,
> +		.dac_gain = 3,
> +		.mix_gain = 13,
> +		.rf_power = 14,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 1,
> +		.dac_gain = 3,
> +		.mix_gain = 15,
> +		.rf_power = 16,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 2,
> +		.dac_gain = 3,
> +		.mix_gain = 10,
> +		.rf_power = 19,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 2,
> +		.dac_gain = 3,
> +		.mix_gain = 11,
> +		.rf_power = 21,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 2,
> +		.dac_gain = 3,
> +		.mix_gain = 12,
> +		.rf_power = 22,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 2,
> +		.dac_gain = 3,
> +		.mix_gain = 13,
> +		.rf_power = 24,
> +	},
> +	{
> +		.dig_gain = 0,
> +		.pa_gain = 2,
> +		.dac_gain = 3,
> +		.mix_gain = 14,
> +		.rf_power = 25,
> +	},
> +};
> +
>  static const struct regmap_range_cfg sx1301_regmap_ranges[] = {
>  	{
>  		.name = "Pages",
> @@ -184,6 +299,34 @@ static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu,
>  	return 0;
>  }
>  
> +static int sx1301_agc_transaction(struct sx1301_priv *priv, unsigned int val,
> +				  unsigned int *status)
> +{
> +	int ret;
> +
> +	ret = regmap_write(priv->regmap, SX1301_CHRS, SX1301_AGC_CMD_WAIT);
> +	if (ret) {
> +		dev_err(priv->dev, "AGC transaction start failed\n");
> +		return ret;
> +	}
> +	usleep_range(1000, 2000);
> +
> +	ret = regmap_write(priv->regmap, SX1301_CHRS, val);
> +	if (ret) {
> +		dev_err(priv->dev, "AGC transaction value failed\n");
> +		return ret;
> +	}
> +	usleep_range(1000, 2000);

Looks like CHRS needs some regmap annotation as e.g. volatile?

> +
> +	ret = regmap_read(priv->regmap, SX1301_AGCSTS, status);
> +	if (ret) {
> +		dev_err(priv->dev, "AGC status read failed\n");
> +		return ret;
> +	}

Ditto for AGCSTS.
Otherwise we won't be able to enable caching and field access will
always be less performant than the previous code.

> +
> +	return 0;
> +}
> +
>  static int sx1301_agc_calibrate(struct sx1301_priv *priv)
>  {
>  	const struct firmware *fw;
> @@ -356,9 +499,53 @@ static int sx1301_load_all_firmware(struct sx1301_priv *priv)
>  		return -ENXIO;
>  	}
>  
> -	return 0;
> +	return ret;

Accidental change?

>  }
>  
> +static int sx1301_load_tx_gain_lut(struct sx1301_priv *priv)
> +{
> +	struct sx1301_tx_gain_lut *lut = priv->tx_gain_lut;
> +	unsigned int val, status;
> +	int ret, i;
> +
> +	/* HACK use internal gain table in the short term */
> +	lut = tx_gain_lut;
> +	priv->tx_gain_lut_size = ARRAY_SIZE(tx_gain_lut);
> +
> +	for (i = 0; i < priv->tx_gain_lut_size; i++) {
> +		val = lut->mix_gain + (lut->dac_gain << 4) +
> +			(lut->pa_gain << 6);

Looks like we're writing to a bitfield? Please use constants for the
shifts then (maybe add masks, too?), and I'd rather reverse the order.

> +
> +		ret = sx1301_agc_transaction(priv, val, &status);
> +		if (ret) {
> +			dev_err(priv->dev, "AGC LUT load failed\n");
> +			return ret;
> +		}
> +		if (status != (0x30 + i)) {
> +			dev_err(priv->dev,
> +				"AGC firmware LUT init error: 0x%02X\n", val);

Continuing from 1/4, please avoid wasting the first like that.
Also I think x is more common than X?

> +			return -ENXIO;
> +		}
> +		lut++;
> +	}
> +
> +	/* Abort the transaction if there are less then 16 entries */
> +	if (priv->tx_gain_lut_size < SX1301_TX_GAIN_LUT_MAX) {
> +		ret = sx1301_agc_transaction(priv, SX1301_AGC_CMD_ABORT, &val);
> +		if (ret) {
> +			dev_err(priv->dev, "AGC LUT abort failed\n");
> +			return ret;
> +		}
> +		if (val != 0x30) {

Any insights into the magic number that would allow for a constant?

> +			dev_err(priv->dev,
> +				"AGC firmware LUT abort error: 0x%02X\n", val);
> +			return -ENXIO;
> +		}
> +	}
> +
> +	return ret;
> +};
> +
>  static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb,
>  					     struct net_device *netdev)
>  {
> @@ -378,6 +565,7 @@ static int sx130x_loradev_open(struct net_device *netdev)
>  {
>  	struct sx1301_priv *priv = netdev_priv(netdev);
>  	int ret;
> +	unsigned int val;

I'd prefer to switch those two lines, as you and I have done elsewhere.

>  
>  	netdev_dbg(netdev, "%s", __func__);
>  
> @@ -416,12 +604,74 @@ static int sx130x_loradev_open(struct net_device *netdev)
>  	if (ret)
>  		return ret;
>  
> -	/* TODO */
> +	/* TODO Load constant adjustments, patches */
> +
> +	/* TODO Frequency time drift */
> +
> +	/* TODO Configure lora multi demods, bitfield of active */
> +
> +	/* TODO Load concenrator multi channel frequencies */

concentrator

> +
> +	/* TODO enale to correlator on enabled frequenies */

enale?
frequencies

> +
> +	/* TODO PPMi, and modem enable */
>  
>  	ret = sx1301_load_all_firmware(priv);
>  	if (ret)
>  		return ret;
>  
> +	usleep_range(1000, 2000);
> +
> +	ret = regmap_read(priv->regmap, SX1301_AGCSTS, &val);
> +	if (ret) {
> +		dev_err(priv->dev, "AGC status read failed\n");
> +		return ret;
> +	}
> +	if (val != 0x10) {

Magic number

> +		dev_err(priv->dev, "AGC firmware init failure: 0x%02X\n", val);
> +		return -ENXIO;
> +	}
> +
> +	ret = sx1301_load_tx_gain_lut(priv);
> +	if (ret)
> +		return ret;
> +
> +	/* Load Tx freq MSBs
> +	 * Always 3 if f > 768 for SX1257 or f > 384 for SX1255
> +	 */

That comment style seems rather uncommon.
What about SX1258?
Mark it as TODO/HACK or use a variable below?

> +	ret = sx1301_agc_transaction(priv, 3, &val);
> +	if (ret) {
> +		dev_err(priv->dev, "AGC Tx MSBs load failed\n");
> +		return ret;
> +	}
> +	if (val != 0x33) {

Magic number

> +		dev_err(priv->dev, "AGC firmware Tx MSBs error: 0x%02X\n", val);
> +		return -ENXIO;
> +	}
> +
> +	/* Load chan_select firmware option */
> +	ret = sx1301_agc_transaction(priv, 0, &val);

I'm guessing this is the mentioned hardcoded channel? I.e., radio A is
selected? Are there any hardware properties involved here (DT) or is
that a pure configuration choice (netlink)?

> +	if (ret) {
> +		dev_err(priv->dev, "AGC chan select failed\n");
> +		return ret;
> +	}
> +	if (val != 0x30) {
> +		dev_err(priv->dev,
> +			"AGC firmware chan select error: 0x%02X", val);
> +		return -ENXIO;
> +	}
> +
> +	/* End AGC firmware init and check status */
> +	ret = sx1301_agc_transaction(priv, 0, &val);
> +	if (ret) {
> +		dev_err(priv->dev, "AGC radio select failed\n");
> +		return ret;
> +	}
> +	if (val != 0x40) {
> +		dev_err(priv->dev, "AGC firmware init error: 0x%02X", val);
> +		return -ENXIO;
> +	}

Could you move all that new code into an sx130x_agc_init() helper
function please?

Are those operations all reentrant, or do we need code for _close, too?

We should also think about locking a sequence of operations, like I did
for sx1276 iirc.

> +
>  	ret = open_loradev(netdev);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
> index dd2b7da94fcc..04c9af64c181 100644
> --- a/drivers/net/lora/sx1301.h
> +++ b/drivers/net/lora/sx1301.h
> @@ -20,6 +20,11 @@
>  #define SX1301_MCU_AGC_FW_VERSION 4
>  #define SX1301_MCU_AGC_CAL_FW_VERSION 2
>  
> +#define SX1301_AGC_CMD_WAIT 16
> +#define SX1301_AGC_CMD_ABORT 17

This would seem a good place for the status codes, too?

> +
> +#define SX1301_TX_GAIN_LUT_MAX 16
> +
>  /* Page independent */
>  #define SX1301_PAGE     0x00
>  #define SX1301_VER      0x01
> @@ -105,6 +110,14 @@ static const struct reg_field sx1301_regmap_fields[] = {
>  		REG_FIELD(SX1301_EMERGENCY_FORCE_HOST_CTRL, 0, 0),
>  };
>  
> +struct sx1301_tx_gain_lut {
> +	unsigned int	dig_gain;
> +	unsigned int	pa_gain;
> +	unsigned int	dac_gain;
> +	unsigned int	mix_gain;
> +	int		rf_power; /* dBm measured at board connector */
> +};
> +
>  struct sx1301_priv {
>  	struct lora_dev_priv lora;
>  	struct device		*dev;
> @@ -112,6 +125,9 @@ struct sx1301_priv {
>  	struct gpio_desc *rst_gpio;
>  	struct regmap		*regmap;
>  	struct regmap_field *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];
> +
> +	struct sx1301_tx_gain_lut tx_gain_lut[SX1301_TX_GAIN_LUT_MAX];
> +	u8 tx_gain_lut_size;
>  };
>  
>  int __init sx130x_radio_init(void);

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
