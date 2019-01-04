Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68737C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BCA208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCSoDSWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfADMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:43:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35118 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfADMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:43:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so17480227pgs.2;
        Fri, 04 Jan 2019 04:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k7Ae9Gp3hmkTJbXoou1IGK5GNuzjk/zbC4Ak4ywdLrY=;
        b=uCSoDSWtmQOJlVTf/1lghw54omGqG7iG37ohR2YYnN2K9c2w1an4jbLHm90Og6wvlt
         LVGP6pgm3xpafi01BNOdYmtfv7537cYXpJHl3RNOLsnxkcqFDlR4CyYNGDZXQ0JGSjtG
         oHHvZYMXpNPBV53NfZN2NOUch8/DZZEHNOG3GsF+NlnIz3M5Sgf/RpwD/uhbAFR+4gZz
         i2y/zX79Rcgj7P8PdC7/W7yxiTx2Eymd6VTA11qbF9bsSnUV+QvenZ/VOY0aMCa73OHU
         H55BQlY12oaxnEWPK2+pdvR2eDrKBz98TCbYfcX67QvWWUBU9asY8EFvXeqDIHyiGh7C
         15pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k7Ae9Gp3hmkTJbXoou1IGK5GNuzjk/zbC4Ak4ywdLrY=;
        b=uhCoXamGYYo2NNWBofwGMizO/gbF3jShP2+D6gcAGxuxVNi4zf7F+j7mqegnVkrELJ
         aMpKKTWbe98VaTi9VozOrBM3XCVYS6Ze8ThjzHtkgDsOsY4DdhS9PFmHsVZzwvUJzdJV
         2xyqK0YLdb4C+mNqb2zjQjoUonpLDqU/uaaLNViKbrWAhcuvz5BP2aT0iRwIMltafrkq
         uA2HGCMysfXGOGsw6MQsCFAtQqHasQeTMgg6UJBH7gJl3+tx7szuEP/KCHfvi08GPAGd
         s5F751PsJQdLKIA1if0l1fzRtt9WC64fvfKnViUASIwthKHIwvQX0wLVV3CcSf5LA5cx
         dxeA==
X-Gm-Message-State: AJcUuke6D5eXGccj2AaBL3uCuNAhN2yQJDnwst7ScKKz4j0e7aVrRclS
        KMVcFLbGIHUJQSpRXlcBRNr6p4AXBBx7BKDi
X-Google-Smtp-Source: ALg8bN4Uyy+ibrbPc5cdUr7CwJ3ZP93Geq+zlxlAFtm7qlSailzEsscw9O+pftST/I36G7Dve78Y6A==
X-Received: by 2002:a63:ac1a:: with SMTP id v26mr1564725pge.293.1546605796027;
        Fri, 04 Jan 2019 04:43:16 -0800 (PST)
Received: from [10.8.8.190] ([89.238.186.237])
        by smtp.gmail.com with ESMTPSA id m3sm71820847pgl.69.2019.01.04.04.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 04:43:15 -0800 (PST)
Subject: Re: [PATCH RFC lora-next 2/4] net: lora: sx1301: add minimal to get
 AGC working prior to tx work
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     starnight@g.ncu.edu.tw, jiri@resnulli.us,
        linux-lpwan@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20181219155616.9547-1-ben.whitten@lairdtech.com>
 <20181219155616.9547-3-ben.whitten@lairdtech.com>
 <8484168b-46bd-afae-6541-5a4b1db26557@suse.de>
From:   Ben Whitten <ben.whitten@gmail.com>
Message-ID: <73275872-d130-bdee-7d75-8b3f83ba4cfd@gmail.com>
Date:   Fri, 4 Jan 2019 21:42:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8484168b-46bd-afae-6541-5a4b1db26557@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/12/2018 09:58, Andreas Färber wrote:
> Hi Ben,
> 
> Am 19.12.18 um 16:56 schrieb Ben Whitten:
>> As part of initialisation when opening the lora device after loading
>> the AGC firmware we need to satisfy its startup procedure which involves
>> a few steps;
>>
>> Loading a 16 entry lookup table.
>> For this I have hard coded the laird ETSI certified table for use on the
>> RG186-M2 (EU) cards, this will need investigation on how other devices
>> load calibration data.
> 
> Isn't calibration performed before this firmware is initialized? I left
> out reading the values back from firmware previously, but that should
> get implemented. In the userspace implementation, do you get these from
> a config file or did you modify the reference code to hardcode them?

The calibration you refer to is the IQ offset calibration, as far as
I can tell this is a separate thing from the power table the chip uses.
In the user space implementation these values are placed in the config
file.

> 
> If these are different calibration values from the ones returned by
> firmware, then a DT property would be an easy way to get
> hardware-specific data into the driver. However, same as with your clk
> config, that makes us dependent on DT, which we shouldn't be for ACPI
> and USB. If we consider it configuration data rather than an immutable
> fact, then we would need a netlink command to set them.

Perhaps we can provide both mechanisms, a DT power table and a mechanism
to set via netlink prior to opening the interface.
As these power settings are hardware dependent and certified for our
card by FCC and ETSI I would prefer to include in DT.

> 
> In any case, we have some other vendors on this list, so hopefully
> someone can comment. :)
> 
>>
>> Selecting the correct channel to transmit on.
>> Currently always 0 for the reference design.
> 
> Similarly: DT or netlink depending on whether fixed, and fall back to 0
> as default.

Agreed, so on the DT would it be appropriate to have a handle in the
sx1301 node with a link to the radio which can transmit, eg.

tx = <&radio0 0>;

Allowing for both to be transmitters if that if a hardware choice.

> 
>>
>> Then ending the AGC init procedure and seeing that it has come up.
>>
>> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
>> ---
>>   drivers/net/lora/sx1301.c | 254 +++++++++++++++++++++++++++++++++++++-
>>   drivers/net/lora/sx1301.h |  16 +++
>>   2 files changed, 268 insertions(+), 2 deletions(-)
> 
> Many thanks for working on this! Some nits inline.
> 
>> diff --git a/drivers/net/lora/sx1301.c b/drivers/net/lora/sx1301.c
>> index e75df93b96d8..0c7b6d0b31af 100644
>> --- a/drivers/net/lora/sx1301.c
>> +++ b/drivers/net/lora/sx1301.c
>> @@ -24,6 +24,121 @@
>>   
>>   #include "sx1301.h"
>>   
>> +static struct sx1301_tx_gain_lut tx_gain_lut[] = {
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 0,
>> +		.dac_gain = 3,
>> +		.mix_gain = 8,
>> +		.rf_power = -3,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 0,
>> +		.dac_gain = 3,
>> +		.mix_gain = 9,
>> +		.rf_power = 0,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 0,
>> +		.dac_gain = 3,
>> +		.mix_gain = 12,
>> +		.rf_power = 3,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 0,
>> +		.dac_gain = 3,
>> +		.mix_gain = 13,
>> +		.rf_power = 4,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 1,
>> +		.dac_gain = 3,
>> +		.mix_gain = 8,
>> +		.rf_power = 6,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 1,
>> +		.dac_gain = 3,
>> +		.mix_gain = 9,
>> +		.rf_power = 9,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 1,
>> +		.dac_gain = 3,
>> +		.mix_gain = 10,
>> +		.rf_power = 10,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 1,
>> +		.dac_gain = 3,
>> +		.mix_gain = 11,
>> +		.rf_power = 12,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 1,
>> +		.dac_gain = 3,
>> +		.mix_gain = 12,
>> +		.rf_power = 13,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 1,
>> +		.dac_gain = 3,
>> +		.mix_gain = 13,
>> +		.rf_power = 14,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 1,
>> +		.dac_gain = 3,
>> +		.mix_gain = 15,
>> +		.rf_power = 16,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 2,
>> +		.dac_gain = 3,
>> +		.mix_gain = 10,
>> +		.rf_power = 19,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 2,
>> +		.dac_gain = 3,
>> +		.mix_gain = 11,
>> +		.rf_power = 21,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 2,
>> +		.dac_gain = 3,
>> +		.mix_gain = 12,
>> +		.rf_power = 22,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 2,
>> +		.dac_gain = 3,
>> +		.mix_gain = 13,
>> +		.rf_power = 24,
>> +	},
>> +	{
>> +		.dig_gain = 0,
>> +		.pa_gain = 2,
>> +		.dac_gain = 3,
>> +		.mix_gain = 14,
>> +		.rf_power = 25,
>> +	},
>> +};
>> +
>>   static const struct regmap_range_cfg sx1301_regmap_ranges[] = {
>>   	{
>>   		.name = "Pages",
>> @@ -184,6 +299,34 @@ static int sx1301_load_firmware(struct sx1301_priv *priv, int mcu,
>>   	return 0;
>>   }
>>   
>> +static int sx1301_agc_transaction(struct sx1301_priv *priv, unsigned int val,
>> +				  unsigned int *status)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_write(priv->regmap, SX1301_CHRS, SX1301_AGC_CMD_WAIT);
>> +	if (ret) {
>> +		dev_err(priv->dev, "AGC transaction start failed\n");
>> +		return ret;
>> +	}
>> +	usleep_range(1000, 2000);
>> +
>> +	ret = regmap_write(priv->regmap, SX1301_CHRS, val);
>> +	if (ret) {
>> +		dev_err(priv->dev, "AGC transaction value failed\n");
>> +		return ret;
>> +	}
>> +	usleep_range(1000, 2000);
> 
> Looks like CHRS needs some regmap annotation as e.g. volatile?
> 
>> +
>> +	ret = regmap_read(priv->regmap, SX1301_AGCSTS, status);
>> +	if (ret) {
>> +		dev_err(priv->dev, "AGC status read failed\n");
>> +		return ret;
>> +	}
> 
> Ditto for AGCSTS.
> Otherwise we won't be able to enable caching and field access will
> always be less performant than the previous code.

Agreed, will do.

> 
>> +
>> +	return 0;
>> +}
>> +
>>   static int sx1301_agc_calibrate(struct sx1301_priv *priv)
>>   {
>>   	const struct firmware *fw;
>> @@ -356,9 +499,53 @@ static int sx1301_load_all_firmware(struct sx1301_priv *priv)
>>   		return -ENXIO;
>>   	}
>>   
>> -	return 0;
>> +	return ret;
> 
> Accidental change?

Whoops yes.

> 
>>   }
>>   
>> +static int sx1301_load_tx_gain_lut(struct sx1301_priv *priv)
>> +{
>> +	struct sx1301_tx_gain_lut *lut = priv->tx_gain_lut;
>> +	unsigned int val, status;
>> +	int ret, i;
>> +
>> +	/* HACK use internal gain table in the short term */
>> +	lut = tx_gain_lut;
>> +	priv->tx_gain_lut_size = ARRAY_SIZE(tx_gain_lut);
>> +
>> +	for (i = 0; i < priv->tx_gain_lut_size; i++) {
>> +		val = lut->mix_gain + (lut->dac_gain << 4) +
>> +			(lut->pa_gain << 6);
> 
> Looks like we're writing to a bitfield? Please use constants for the
> shifts then (maybe add masks, too?), and I'd rather reverse the order.

Yes its a bit field, just needs to be written at once. Will do.

> 
>> +
>> +		ret = sx1301_agc_transaction(priv, val, &status);
>> +		if (ret) {
>> +			dev_err(priv->dev, "AGC LUT load failed\n");
>> +			return ret;
>> +		}
>> +		if (status != (0x30 + i)) {
>> +			dev_err(priv->dev,
>> +				"AGC firmware LUT init error: 0x%02X\n", val);
> 
> Continuing from 1/4, please avoid wasting the first like that.
> Also I think x is more common than X?

Sure thing.

> 
>> +			return -ENXIO;
>> +		}
>> +		lut++;
>> +	}
>> +
>> +	/* Abort the transaction if there are less then 16 entries */
>> +	if (priv->tx_gain_lut_size < SX1301_TX_GAIN_LUT_MAX) {
>> +		ret = sx1301_agc_transaction(priv, SX1301_AGC_CMD_ABORT, &val);
>> +		if (ret) {
>> +			dev_err(priv->dev, "AGC LUT abort failed\n");
>> +			return ret;
>> +		}
>> +		if (val != 0x30) {
> 
> Any insights into the magic number that would allow for a constant?

No insights to the meaning of the bits, may just be a success constant.

> 
>> +			dev_err(priv->dev,
>> +				"AGC firmware LUT abort error: 0x%02X\n", val);
>> +			return -ENXIO;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +};
>> +
>>   static netdev_tx_t sx130x_loradev_start_xmit(struct sk_buff *skb,
>>   					     struct net_device *netdev)
>>   {
>> @@ -378,6 +565,7 @@ static int sx130x_loradev_open(struct net_device *netdev)
>>   {
>>   	struct sx1301_priv *priv = netdev_priv(netdev);
>>   	int ret;
>> +	unsigned int val;
> 
> I'd prefer to switch those two lines, as you and I have done elsewhere.

Sure will do.

> 
>>   
>>   	netdev_dbg(netdev, "%s", __func__);
>>   
>> @@ -416,12 +604,74 @@ static int sx130x_loradev_open(struct net_device *netdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	/* TODO */
>> +	/* TODO Load constant adjustments, patches */
>> +
>> +	/* TODO Frequency time drift */
>> +
>> +	/* TODO Configure lora multi demods, bitfield of active */
>> +
>> +	/* TODO Load concenrator multi channel frequencies */
> 
> concentrator
> 
>> +
>> +	/* TODO enale to correlator on enabled frequenies */
> 
> enale?
> frequencies
> 
>> +
>> +	/* TODO PPMi, and modem enable */
>>   
>>   	ret = sx1301_load_all_firmware(priv);
>>   	if (ret)
>>   		return ret;
>>   
>> +	usleep_range(1000, 2000);
>> +
>> +	ret = regmap_read(priv->regmap, SX1301_AGCSTS, &val);
>> +	if (ret) {
>> +		dev_err(priv->dev, "AGC status read failed\n");
>> +		return ret;
>> +	}
>> +	if (val != 0x10) {
> 
> Magic number
> 
>> +		dev_err(priv->dev, "AGC firmware init failure: 0x%02X\n", val);
>> +		return -ENXIO;
>> +	}
>> +
>> +	ret = sx1301_load_tx_gain_lut(priv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Load Tx freq MSBs
>> +	 * Always 3 if f > 768 for SX1257 or f > 384 for SX1255
>> +	 */
> 
> That comment style seems rather uncommon.

An artifact of checkpatch, which wants no blank lines at the start of a 
comment block.

> What about SX1258?
> Mark it as TODO/HACK or use a variable below?

Variable sounds good populated from a case of tx radio types.
Note we may have a problem if we try and use a radio outside of this 
band as we may have to reinitialize the AGC to get this value in.

> 
>> +	ret = sx1301_agc_transaction(priv, 3, &val);
>> +	if (ret) {
>> +		dev_err(priv->dev, "AGC Tx MSBs load failed\n");
>> +		return ret;
>> +	}
>> +	if (val != 0x33) {
> 
> Magic number

Looks like a success message | loaded value. I'll add that.

> 
>> +		dev_err(priv->dev, "AGC firmware Tx MSBs error: 0x%02X\n", val);
>> +		return -ENXIO;
>> +	}
>> +
>> +	/* Load chan_select firmware option */
>> +	ret = sx1301_agc_transaction(priv, 0, &val);
> 
> I'm guessing this is the mentioned hardcoded channel? I.e., radio A is
> selected? Are there any hardware properties involved here (DT) or is
> that a pure configuration choice (netlink)?

I believe this is the transmit choice so it is bound by hardware, if 
there is a board with two radios in the TX chain then it should be 
select-able which one to transmit. Though I'm not sure how common that 
use case will be.

> 
>> +	if (ret) {
>> +		dev_err(priv->dev, "AGC chan select failed\n");
>> +		return ret;
>> +	}
>> +	if (val != 0x30) {
>> +		dev_err(priv->dev,
>> +			"AGC firmware chan select error: 0x%02X", val);
>> +		return -ENXIO;
>> +	}
>> +
>> +	/* End AGC firmware init and check status */
>> +	ret = sx1301_agc_transaction(priv, 0, &val);
>> +	if (ret) {
>> +		dev_err(priv->dev, "AGC radio select failed\n");
>> +		return ret;
>> +	}
>> +	if (val != 0x40) {
>> +		dev_err(priv->dev, "AGC firmware init error: 0x%02X", val);
>> +		return -ENXIO;
>> +	}
> 
> Could you move all that new code into an sx130x_agc_init() helper
> function please?

Yep will do.

> 
> Are those operations all reentrant, or do we need code for _close, too?

I don't know if there is any shutdown procedure, I think on any open it 
needs to reinitialize.

> 
> We should also think about locking a sequence of operations, like I did
> for sx1276 iirc.

I see you have just sent up a patch with that.

> 
>> +
>>   	ret = open_loradev(netdev);
>>   	if (ret)
>>   		return ret;
>> diff --git a/drivers/net/lora/sx1301.h b/drivers/net/lora/sx1301.h
>> index dd2b7da94fcc..04c9af64c181 100644
>> --- a/drivers/net/lora/sx1301.h
>> +++ b/drivers/net/lora/sx1301.h
>> @@ -20,6 +20,11 @@
>>   #define SX1301_MCU_AGC_FW_VERSION 4
>>   #define SX1301_MCU_AGC_CAL_FW_VERSION 2
>>   
>> +#define SX1301_AGC_CMD_WAIT 16
>> +#define SX1301_AGC_CMD_ABORT 17
> 
> This would seem a good place for the status codes, too?

Yep

> 
>> +
>> +#define SX1301_TX_GAIN_LUT_MAX 16
>> +
>>   /* Page independent */
>>   #define SX1301_PAGE     0x00
>>   #define SX1301_VER      0x01
>> @@ -105,6 +110,14 @@ static const struct reg_field sx1301_regmap_fields[] = {
>>   		REG_FIELD(SX1301_EMERGENCY_FORCE_HOST_CTRL, 0, 0),
>>   };
>>   
>> +struct sx1301_tx_gain_lut {
>> +	unsigned int	dig_gain;
>> +	unsigned int	pa_gain;
>> +	unsigned int	dac_gain;
>> +	unsigned int	mix_gain;
>> +	int		rf_power; /* dBm measured at board connector */
>> +};
>> +
>>   struct sx1301_priv {
>>   	struct lora_dev_priv lora;
>>   	struct device		*dev;
>> @@ -112,6 +125,9 @@ struct sx1301_priv {
>>   	struct gpio_desc *rst_gpio;
>>   	struct regmap		*regmap;
>>   	struct regmap_field *regmap_fields[ARRAY_SIZE(sx1301_regmap_fields)];
>> +
>> +	struct sx1301_tx_gain_lut tx_gain_lut[SX1301_TX_GAIN_LUT_MAX];
>> +	u8 tx_gain_lut_size;
>>   };
>>   
>>   int __init sx130x_radio_init(void);


Thanks!
Ben Whitten
