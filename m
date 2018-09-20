Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB144C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645B921535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmIHzvqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645B921535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbeITU1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:27:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38425 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbeITU1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:27:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so5946916wrw.5;
        Thu, 20 Sep 2018 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=SKhb9yB5A289MAdewktlKKycx1yxBBaptEJVYoz7rco=;
        b=MmIHzvqT5uqGtRPhaw9U7w7Nl6M26biUUhwHG2umsbGgEfcMxfTDMyAoqQ6YqP8WS4
         wBxtcqRxH1T27BznoldiyoZR21f9STV1uSyDiMcPdeqbirpEe1NY2YAL3kDFkdlps+Yv
         m+uQkEmJERJUUKXPoUGMc5V6XEpdHMfIQOnzfnV9rhiAqTS6R4XZk3rLqfJM756S225L
         tBFD7P6XLNn0ueU39HsD5BTpoxm4f5N/VNHjGJNAsOTSDCt6C3wFFiSXhReCdr0+27XU
         /6fF6BsiTKA5bzM+3EeEgWY30PPP1ot6TU22TD2Ox0WVQTzzY2FHW06JqsOWzsKwx73r
         GtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=SKhb9yB5A289MAdewktlKKycx1yxBBaptEJVYoz7rco=;
        b=UOoxlf1dJANIkqCks50CLR8cM06bnSAFGLQuu1fyfCizp6+XNUPqSsrx3pW3/CHUwe
         xpjMEbWEkZjjrdADpgNunwLl9rkeg52qRz1qr5e6zuNYIuj3JLxlG4FgMmv4VfPz79aV
         n/ATRNJnvHOvPZXAtuINjPEIgBMDtevQzHkqJwdyQ9ecssrFOf/him/FSPTDRAFBfazU
         /YJZFPJF6Gv2tqOXTvcrlZKKg359MIZMjBrmctw/bZTHi3oQ/8TSPnbi7wgzkv9+6gKA
         RZw27rfg8D6iuouEOQO0jMSkMTAayMNxexKFjSQxIX/yD/QpKb/RJcr46lWmlUEB5zlq
         nPBg==
X-Gm-Message-State: ABuFfohvTsqBy5lJif4VZO6b3RK+uKIFxr6vzEc+BGtqI6LOeuIwoMhl
        4btAOQBUZpzmbOgSmOFIbWYC3TY=
X-Google-Smtp-Source: ACcGV633pLWmq/EJ/WiY26CZQ2yb8OHltx4JLYG1G21SqJiVMLsTMYngSv42ObJxJeV1fHk/AZ2qfQ==
X-Received: by 2002:adf:f0d1:: with SMTP id x17-v6mr5047447wro.49.1537454635624;
        Thu, 20 Sep 2018 07:43:55 -0700 (PDT)
Received: from android-dhcp-8-1-0-d4-38-9c-a2-1f-05.home (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.gmail.com with ESMTPSA id v17-v6sm5185240wrc.63.2018.09.20.07.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 07:43:55 -0700 (PDT)
Date:   Thu, 20 Sep 2018 15:43:52 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20180916134836.73lggsydppdhhrpf@earth.universe>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180614151435.6471-1-ctatlor97@gmail.com> <20180614151435.6471-2-ctatlor97@gmail.com> <20180916134836.73lggsydppdhhrpf@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/4] power: supply: Add support for the Qualcomm Battery Monitoring System
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Craig <ctatlor97@gmail.com>
Message-ID: <00EB2660-4C2A-4A40-9D60-DA8152349585@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replies inline

On 16 September 2018 14:48:36 BST, Sebastian Reichel <sebastian=2Ereichel@=
collabora=2Ecom> wrote:
>Hi,
>
>First of all thanks for the patch and big sorry for the long delay
>in reviewing this=2E I did not find enough time to do it properly
>until now :(
>
>On Thu, Jun 14, 2018 at 04:14:15PM +0100, Craig Tatlor wrote:
>> This patch adds a driver for the BMS (Battery Monitoring System)
>> block of the PM8941 PMIC, it uses a lookup table defined in the
>> device tree to generate a capacity from the BMS supplied OCV, it
>> then amends the coulomb counter to that to increase the accuracy
>> of the estimated capacity=2E
>>=20
>> Signed-off-by: Craig Tatlor <ctatlor97@gmail=2Ecom>
>> Reviewed-by: Linus Walleij <linus=2Ewalleij@linaro=2Eorg>
>> ---
>>=20
>> * Changes from v5:                                                  =20
>                                                                      =20
>>   Uses select for REGMAP_SPMI=2E                                      =
=20
>                                                                      =20
>>                                                                     =20
>                                                                      =20
>> * Changes from v4:                                                  =20
>                                                                      =20
>>   Cleaned up percentage interpolation function,                     =20
>                                                                      =20
>>   uses new fixp interpolation helper,                               =20
>                                                                      =20
>>   added some more error cases,                                      =20
>                                                                      =20
>>   uses devm_power_supply_register(),                                =20
>                                                                      =20
>>   uses a DIV_ROUND_CLOSEST for division and                         =20
>                                                                      =20
>>   uses micro(volts / amp hours) instead of                          =20
>                                                                      =20
>>   milli (volts / amp hours)=2E =20
>>=20
>>  drivers/power/supply/Kconfig    |   9 +
>>  drivers/power/supply/Makefile   |   1 +
>>  drivers/power/supply/qcom_bms=2Ec | 487
>++++++++++++++++++++++++++++++++
>>  3 files changed, 497 insertions(+)
>>  create mode 100644 drivers/power/supply/qcom_bms=2Ec
>>=20
>> diff --git a/drivers/power/supply/Kconfig
>b/drivers/power/supply/Kconfig
>> index 428b426842f4=2E=2E75f2f375f992 100644
>> --- a/drivers/power/supply/Kconfig
>> +++ b/drivers/power/supply/Kconfig
>> @@ -82,6 +82,15 @@ config BATTERY_ACT8945A
>>  	  Say Y here to enable support for power supply provided by
>>  	  Active-semi ActivePath ACT8945A charger=2E
>> =20
>> +config BATTERY_BMS
>> +	tristate "Qualcomm Battery Monitoring System driver"
>> +	depends on MFD_SPMI_PMIC || COMPILE_TEST
>> +	depends on OF
>> +	select REGMAP_SPMI
>> +	help
>> +	  Say Y to include support for the Battery Monitoring hardware
>> +	  found in some Qualcomm PM series PMICs=2E
>> +
>>  config BATTERY_CPCAP
>>  	tristate "Motorola CPCAP PMIC battery driver"
>>  	depends on MFD_CPCAP && IIO
>> diff --git a/drivers/power/supply/Makefile
>b/drivers/power/supply/Makefile
>> index e83aa843bcc6=2E=2E04204174b047 100644
>> --- a/drivers/power/supply/Makefile
>> +++ b/drivers/power/supply/Makefile
>> @@ -21,6 +21,7 @@ obj-$(CONFIG_BATTERY_88PM860X)	+=3D
>88pm860x_battery=2Eo
>>  obj-$(CONFIG_BATTERY_ACT8945A)	+=3D act8945a_charger=2Eo
>>  obj-$(CONFIG_BATTERY_AXP20X)	+=3D axp20x_battery=2Eo
>>  obj-$(CONFIG_CHARGER_AXP20X)	+=3D axp20x_ac_power=2Eo
>> +obj-$(CONFIG_BATTERY_BMS)	+=3D qcom_bms=2Eo
>>  obj-$(CONFIG_BATTERY_CPCAP)	+=3D cpcap-battery=2Eo
>>  obj-$(CONFIG_BATTERY_DS2760)	+=3D ds2760_battery=2Eo
>>  obj-$(CONFIG_BATTERY_DS2780)	+=3D ds2780_battery=2Eo
>> diff --git a/drivers/power/supply/qcom_bms=2Ec
>b/drivers/power/supply/qcom_bms=2Ec
>> new file mode 100644
>> index 000000000000=2E=2E718fd745c0f7
>> --- /dev/null
>> +++ b/drivers/power/supply/qcom_bms=2Ec
>> @@ -0,0 +1,487 @@
>> +// SPDX-License-Identifier: GPL
>> +
>> +/*
>> + * Qualcomm Battery Monitoring System driver
>> + *
>> + * Copyright (C) 2018 Craig Tatlor <ctatlor97@gmail=2Ecom>
>> + */
>> +
>> +#include <linux/module=2Eh>
>> +#include <linux/fixp-arith=2Eh>
>> +#include <linux/platform_device=2Eh>
>> +#include <linux/power_supply=2Eh>
>> +#include <linux/slab=2Eh>
>> +#include <linux/bitops=2Eh>
>> +#include <linux/of=2Eh>
>> +#include <linux/of_platform=2Eh>
>> +#include <linux/regmap=2Eh>
>> +#include <linux/irq=2Eh>
>> +#include <linux/interrupt=2Eh>
>> +#include <linux/iio/consumer=2Eh>
>> +
>> +#define REG_BMS_OCV_FOR_SOC_DATA0	0x90
>> +#define REG_BMS_SHDW_CC_DATA0		0xA8
>> +#define REG_BMS_CC_DATA_CTL		0x42
>> +#define REG_BMS_CC_CLEAR_CTL		0x4
>> +
>> +#define BMS_HOLD_OREG_DATA		BIT(0)
>> +#define BMS_CLEAR_SHDW_CC		BIT(6)
>> +
>> +#define BMS_CC_READING_RESOLUTION_N	542535
>> +#define BMS_CC_READING_RESOLUTION_D	10000
>> +#define BMS_CC_READING_TICKS		56
>> +#define BMS_SLEEP_CLK_HZ		32764
>> +
>> +#define SECONDS_PER_HOUR		3600
>> +#define TEMPERATURE_COLS		5
>> +#define MAX_CAPACITY_ROWS		50
>> +
>> +/* lookup table for ocv -> capacity conversion */
>> +struct bms_ocv_lut {
>> +	int rows;
>> +	s8 temp_legend[TEMPERATURE_COLS];
>> +	u8 capacity_legend[MAX_CAPACITY_ROWS];
>> +	u32 lut[MAX_CAPACITY_ROWS][TEMPERATURE_COLS];
>> +};
>> +
>> +/* lookup table for battery temperature -> fcc conversion */
>> +struct bms_fcc_lut {
>> +	s8 temp_legend[TEMPERATURE_COLS];
>> +	u32 lut[TEMPERATURE_COLS];
>> +};
>> +
>> +struct bms_device_info {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	struct bms_ocv_lut ocv_lut;
>> +	struct power_supply_desc bat_desc;
>> +	struct bms_fcc_lut fcc_lut;
>> +	struct iio_channel *adc;
>> +	struct mutex bms_output_lock;
>> +	u32 base_addr;
>> +
>> +	int ocv_thr_irq;
>> +	u32 ocv;
>> +};
>> +
>> +static bool between(int left, int right, int val)
>> +{
>> +	if (left <=3D val && val <=3D right)
>> +		return true;
>> +
>> +	if (left >=3D val && val >=3D right)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static int interpolate_capacity(int temp, u32 ocv,
>> +				struct bms_ocv_lut *ocv_lut)
>> +{
>> +	int pcj_minus_one =3D 0, pcj =3D 0, i2 =3D 0, i3 =3D 0, i, j;
>> +
>> +	for (j =3D 0; j < TEMPERATURE_COLS; j++)
>> +		if (temp <=3D ocv_lut->temp_legend[j])
>> +			break;
>> +
>> +	if (ocv >=3D ocv_lut->lut[0][j])
>> +		return ocv_lut->capacity_legend[0];
>> +
>> +	if (ocv <=3D ocv_lut->lut[ocv_lut->rows-1][j-1])
>> +		return ocv_lut->capacity_legend[ocv_lut->rows-1];
>> +
>> +	for (i =3D 0; i < ocv_lut->rows-1; i++) {
>> +		if (between(ocv_lut->lut[i][j],
>> +			    ocv_lut->lut[i+1][j], ocv))
>> +			i2 =3D i;
>> +
>> +		if (between(ocv_lut->lut[i][j-1],
>> +			    ocv_lut->lut[i+1][j-1], ocv))
>> +			i3 =3D i;
>> +	}
>> +
>> +	/* interpolate two capacities */
>> +	pcj =3D fixp_linear_interpolate(ocv_lut->lut[i2][j],
>> +				      ocv_lut->capacity_legend[i2],
>> +				      ocv_lut->lut[i2+1][j],
>> +				      ocv_lut->capacity_legend[i2+1],
>> +				      ocv);
>> +
>> +	pcj_minus_one =3D fixp_linear_interpolate(ocv_lut->lut[i3][j-1],
>> +						ocv_lut->capacity_legend[i3],
>> +						ocv_lut->lut[i3+1][j-1],
>> +						ocv_lut->capacity_legend[i3+1],
>> +						ocv);
>> +
>> +	/* interpolate them with the battery temperature */
>> +	return fixp_linear_interpolate(ocv_lut->temp_legend[j-1],
>> +				       pcj_minus_one,
>> +				       ocv_lut->temp_legend[j],
>> +				       pcj,
>> +				       temp);
>> +}
>> +
>> +static int interpolate_fcc(int temp, struct bms_fcc_lut *fcc_lut)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < TEMPERATURE_COLS; i++)
>> +		if (temp <=3D fcc_lut->temp_legend[i])
>> +			break;
>> +
>> +	return fixp_linear_interpolate(fcc_lut->temp_legend[i-1],
>> +			     fcc_lut->lut[i-1],
>> +			     fcc_lut->temp_legend[i],
>> +			     fcc_lut->lut[i],
>> +			     temp);
>> +}
>> +
>> +static int bms_lock_output_data(struct bms_device_info *di)
>> +{
>> +	int ret;
>> +
>> +	ret =3D regmap_update_bits(di->regmap, di->base_addr +
>> +				 REG_BMS_CC_DATA_CTL,
>> +				 BMS_HOLD_OREG_DATA, BMS_HOLD_OREG_DATA);
>> +	if (ret) {
>> +		dev_err(di->dev, "failed to lock bms output: %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Sleep for at least 100 microseconds here to make sure
>> +	 * there has been at least three cycles of the sleep clock
>> +	 * so that the registers are correctly locked=2E
>> +	 */
>> +	usleep_range(100, 1000);
>> +
>> +	return 0;
>> +}
>> +
>> +static int bms_unlock_output_data(struct bms_device_info *di)
>> +{
>> +	int ret;
>> +
>> +	ret =3D regmap_update_bits(di->regmap, di->base_addr +
>> +				 REG_BMS_CC_DATA_CTL,
>> +				 BMS_HOLD_OREG_DATA, 0);
>> +	if (ret) {
>> +		dev_err(di->dev, "failed to unlock bms output: %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bms_read_ocv(struct bms_device_info *di, u32 *ocv)
>> +{
>> +	int ret;
>> +	u16 read_ocv;
>> +
>> +	mutex_lock(&di->bms_output_lock);
>> +
>> +	ret =3D bms_lock_output_data(di);
>> +	if (ret)
>> +		goto err_lock;
>> +
>> +	ret =3D regmap_bulk_read(di->regmap, di->base_addr+
>> +			       REG_BMS_OCV_FOR_SOC_DATA0, &read_ocv, 2);
>> +	if (ret) {
>> +		dev_err(di->dev, "open circuit voltage read failed: %d", ret);
>> +		goto err_read;
>> +	}
>> +
>> +	dev_dbg(di->dev, "read open circuit voltage of: %d mv", read_ocv);
>> +
>> +
>
>one empty line is enough=2E
Will fix
>
>> +	*ocv =3D read_ocv * 1000;
>> +
>> +err_read:
>> +	bms_unlock_output_data(di);
>> +
>> +err_lock:
>> +	mutex_unlock(&di->bms_output_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int bms_read_cc(struct bms_device_info *di, s64 *cc_uah)
>> +{
>> +	int ret;
>> +	s64 cc_raw_s36, cc_raw, cc_uv, cc_pvh;
>> +
>> +	mutex_lock(&di->bms_output_lock);
>> +
>> +	ret =3D bms_lock_output_data(di);
>> +	if (ret)
>> +		goto err_lock;
>> +
>> +	ret =3D regmap_bulk_read(di->regmap, di->base_addr +
>> +			       REG_BMS_SHDW_CC_DATA0,
>> +			       &cc_raw_s36, 5);
>> +	if (ret) {
>> +		dev_err(di->dev, "coulomb counter read failed: %d", ret);
>> +		goto err_read;
>> +	}
>> +
>> +	ret =3D bms_unlock_output_data(di);
>> +	if (ret)
>> +		goto err_lock;
>> +
>> +	mutex_unlock(&di->bms_output_lock);
>> +
>> +	cc_raw =3D sign_extend32(cc_raw_s36, 28);
>> +
>> +	/* convert raw to uv */
>> +	cc_uv =3D div_s64(cc_raw * BMS_CC_READING_RESOLUTION_N,
>> +			BMS_CC_READING_RESOLUTION_D);
>> +
>> +	/* convert uv to pvh */
>> +	cc_pvh =3D div_s64(cc_uv * BMS_CC_READING_TICKS * 100000,
>> +			 BMS_SLEEP_CLK_HZ * SECONDS_PER_HOUR);
>> +
>> +	/* divide by impedance */
>> +	*cc_uah =3D div_s64(cc_pvh, 10000);
>> +
>> +	dev_dbg(di->dev, "read coulomb counter value of: %lld uah",
>*cc_uah);
>> +
>> +	return 0;
>> +
>> +err_read:
>> +	bms_unlock_output_data(di);
>> +
>> +err_lock:
>> +	mutex_unlock(&di->bms_output_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static void bms_reset_cc(struct bms_device_info *di)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&di->bms_output_lock);
>> +
>> +	ret =3D regmap_update_bits(di->regmap, di->base_addr +
>> +				 REG_BMS_CC_CLEAR_CTL,
>> +				 BMS_CLEAR_SHDW_CC,
>> +				 BMS_CLEAR_SHDW_CC);
>> +	if (ret) {
>> +		dev_err(di->dev, "coulomb counter reset failed: %d", ret);
>> +		goto err_lock;
>> +	}
>> +
>> +	/* wait at least three sleep cycles for cc to reset */
>> +	usleep_range(100, 1000);
>> +
>> +	ret =3D regmap_update_bits(di->regmap, di->base_addr +
>> +				 REG_BMS_CC_CLEAR_CTL,
>> +				 BMS_CLEAR_SHDW_CC, 0);
>> +	if (ret)
>> +		dev_err(di->dev, "coulomb counter re-enable failed: %d", ret);
>> +
>> +err_lock:
>> +	mutex_unlock(&di->bms_output_lock);
>> +}
>> +
>> +static int bms_calculate_capacity(struct bms_device_info *di, int
>*capacity)
>> +{
>> +	unsigned long fcc;
>> +	int ret, temp, ocv_capacity, temp_degc;
>> +	s64 cc =3D 0;
>> +
>> +	ret =3D iio_read_channel_raw(di->adc, &temp);
>> +	if (ret < 0) {
>> +		dev_err(di->dev, "failed to read temperature: %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	temp_degc =3D DIV_ROUND_CLOSEST(temp, 1000);
>> +
>> +	ret =3D bms_read_cc(di, &cc);
>> +	if (ret < 0) {
>> +		dev_err(di->dev, "failed to read coulomb counter: %d", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* interpolate capacity from open circuit voltage */
>> +	ocv_capacity =3D interpolate_capacity(temp_degc, di->ocv,
>> +					    &di->ocv_lut);
>> +
>> +	/* interpolate the full charge capacity from temperature */
>> +	fcc =3D interpolate_fcc(temp_degc, &di->fcc_lut);
>> +
>> +	/* append coloumb counter to capacity */
>> +	*capacity =3D DIV_ROUND_CLOSEST(fcc * ocv_capacity, 100);
>> +	*capacity =3D div_s64((*capacity - cc) * 100, fcc);
>> +
>> +	return 0;
>> +}
>> +
>> +
>> +
>
>one empty line is enough=2E=20
Will fix
>
>> +/*
>> + * Return power_supply property
>> + */
>> +static int bms_get_property(struct power_supply *psy,
>> +				   enum power_supply_property psp,
>> +				   union power_supply_propval *val)
>> +{
>> +	struct bms_device_info *di =3D power_supply_get_drvdata(psy);
>> +	int ret;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_CAPACITY:
>> +		ret =3D bms_calculate_capacity(di, &val->intval);
>> +		break;
>> +	default:
>> +		ret =3D -EINVAL;
>> +		break;
>> +	}
>> +
>> +	if (val->intval =3D=3D INT_MAX || val->intval =3D=3D INT_MIN)
>> +		ret =3D -EINVAL;
>> +
>> +	return ret;
>> +}
>> +
>> +static enum power_supply_property bms_props[] =3D {
>> +	POWER_SUPPLY_PROP_CAPACITY,
>> +};
>
>Why does the driver not expose the following battery information?
>
>temperature info via POWER_SUPPLY_PROP_TEMP
>ocv info via POWER_SUPPLY_PROP_VOLTAGE_OCV
>CC info via POWER_SUPPLY_PROP_CHARGE_COUNTER
>max current via POWER_SUPPLY_PROP_CURRENT_MAX

1=2E This is handled in the tsens driver iirc
2=2E Ocv is very inaccurate as it is only updated when device uses a very =
low amount of power (<10ma)=20
3=2E This isn't possible (unless you want to just give out the value anywa=
y) due to the way the driver tracks the cc (resets on every ocv update)
4=2Ethis is done in the smbb driver, the BMS is only a fuelguage and not a=
 fully blown charging ic
>
>> +static irqreturn_t bms_ocv_thr_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct bms_device_info *di =3D dev_id;
>> +
>> +	if (bms_read_ocv(di, &di->ocv) < 0)
>> +		return IRQ_HANDLED;
>> +
>> +	bms_reset_cc(di);
>> +	return IRQ_HANDLED;
>> +}
>
>You want to call power_supply_changed() here to notify userspace=2E
This doesn't mean battery is charged, just means ocv was updated (device u=
sed < 10ma of power)
>
>> +static int bms_probe(struct platform_device *pdev)
>> +{
>> +	struct power_supply_config psy_cfg =3D {};
>> +	struct bms_device_info *di;
>> +	struct power_supply *bat;
>> +	int ret;
>> +
>> +	di =3D devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
>> +	if (!di)
>> +		return -ENOMEM;
>> +
>> +	di->dev =3D &pdev->dev;
>> +
>> +	di->regmap =3D dev_get_regmap(pdev->dev=2Eparent, NULL);
>> +	if (!di->regmap) {
>> +		dev_err(di->dev, "Unable to get regmap");
>> +		return -EINVAL;
>> +	}
>> +
>> +	di->adc =3D devm_iio_channel_get(&pdev->dev, "temp");
>> +	if (IS_ERR(di->adc))
>> +		return PTR_ERR(di->adc);
>> +
>> +	ret =3D of_property_read_u32(di->dev->of_node, "reg",
>&di->base_addr);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret =3D of_property_read_u8_array(di->dev->of_node,
>> +						 "qcom,ocv-temp-legend-celsius",
>> +						 (u8 *)di->ocv_lut=2Etemp_legend,
>> +						 TEMPERATURE_COLS);
>> +	if (ret < 0) {
>> +		dev_err(di->dev, "no open circuit voltage temperature legend
>found");
>> +		return ret;
>> +	}
>> +
>> +	di->ocv_lut=2Erows =3D
>of_property_read_variable_u8_array(di->dev->of_node,
>> +						 "qcom,ocv-capacity-legend",
>> +						 di->ocv_lut=2Ecapacity_legend, 0,
>> +						 MAX_CAPACITY_ROWS);
>> +	if (di->ocv_lut=2Erows < 0) {
>> +		dev_err(di->dev, "no open circuit voltage capacity legend found");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D of_property_read_variable_u32_array(di->dev->of_node,
>> +						  "qcom,ocv-lut-microvolt",
>> +						  (u32 *)di->ocv_lut=2Elut,
>> +						  TEMPERATURE_COLS,
>> +						  TEMPERATURE_COLS *
>> +						  MAX_CAPACITY_ROWS);
>> +	if (ret < 0) {
>> +		dev_err(di->dev, "no open circuit voltage lut array found");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D of_property_read_u8_array(di->dev->of_node,
>> +						 "qcom,fcc-temp-legend-celsius",
>> +						 (u8 *)di->fcc_lut=2Etemp_legend,
>> +						 TEMPERATURE_COLS);
>> +	if (ret < 0) {
>> +		dev_err(di->dev, "no full charge capacity temperature legend
>found");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D of_property_read_u32_array(di->dev->of_node,
>> +						  "qcom,fcc-lut-microamp-hours",
>> +						  di->fcc_lut=2Elut,
>> +						  TEMPERATURE_COLS);
>> +	if (ret < 0) {
>> +		dev_err(di->dev, "no full charge capacity lut array found");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D bms_read_ocv(di, &di->ocv);
>> +	if (ret < 0) {
>> +		dev_err(di->dev, "failed to read initial open circuit voltage:
>%d",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	mutex_init(&di->bms_output_lock);
>> +
>> +	di->ocv_thr_irq =3D platform_get_irq_byname(pdev, "ocv_thr");
>> +
>> +	ret =3D devm_request_threaded_irq(di->dev, di->ocv_thr_irq, NULL,
>> +					bms_ocv_thr_irq_handler,
>> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> +					pdev->name, di);
>> +	if (ret < 0) {
>> +		dev_err(di->dev, "failed to request handler for open circuit
>voltage threshold IRQ");
>> +		return ret;
>> +	}
>> +
>> +
>
>one empty line is enough=2E
>
>> +	di->bat_desc=2Ename =3D "bms";
>> +	di->bat_desc=2Etype =3D POWER_SUPPLY_TYPE_BATTERY;
>> +	di->bat_desc=2Eproperties =3D bms_props;
>> +	di->bat_desc=2Enum_properties =3D ARRAY_SIZE(bms_props);
>> +	di->bat_desc=2Eget_property =3D bms_get_property;
>> +
>> +	psy_cfg=2Edrv_data =3D di;
>
>psy_cfg=2Eof_node =3D pdev->dev=2Eof_node;
>
>> +	bat =3D devm_power_supply_register(di->dev, &di->bat_desc, &psy_cfg);
>> +
>> +	return PTR_ERR_OR_ZERO(bat);
>> +}
>> +
>> +static const struct of_device_id bms_of_match[] =3D {
>> +	{=2Ecompatible =3D "qcom,pm8941-bms", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, bms_of_match);
>> +
>> +static struct platform_driver bms_driver =3D {
>> +	=2Eprobe =3D bms_probe,
>> +	=2Edriver =3D {
>> +		=2Ename =3D "qcom-bms",
>> +		=2Eof_match_table =3D of_match_ptr(bms_of_match),
>> +	},
>> +};
>> +module_platform_driver(bms_driver);
>> +
>> +MODULE_AUTHOR("Craig Tatlor <ctatlor97@gmail=2Ecom>");
>> +MODULE_DESCRIPTION("Qualcomm BMS driver");
>> +MODULE_LICENSE("GPL");
>
>Apart from the things above I would like to see the information
>about the battery cell itself being moved to 'struct
>power_supply_battery_info', see also my comment in the DT bindings=2E
Sure, will look into it
>
>-- Sebastian
