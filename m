Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D863DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A66F2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+buzG++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A66F2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeK3ECN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:02:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38982 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbeK3ECM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:02:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so1299832pfc.6;
        Thu, 29 Nov 2018 08:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KQXwzrhhu5DBAxgaiQuDZ3fIWqtf7z9UYBheepLTtk8=;
        b=o+buzG++m4waboXUmJOPFiL18wBiIamGaIrAw2Gr8/A1E0iEuD9IUS69ErI/QQAOmu
         toMN1Nel/QiqEJJJppwQzE30Qs39A6auQ0Bs8qdtidyFLLmaLEZzkJzoiRV6gwTHSSYB
         BChMNhf1MVlLsbWuhzC5EgE5HYQBdJMczdCDUsZdK4DGY0QQalRVNFWo2Jnml5D4ieTg
         sJI7kHTPz1ZxoK57vV/IfFPJBMu/+Np0CnJkB4hJa0isVmpwFIbEXFt96sJ/Dzsn1Jvv
         zvx3KnH3JliHUdILMagzUqyiOiqUYyClNU5pEhlfQhA2RT3OsZyQbESM/ubahfm95iYK
         2K3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQXwzrhhu5DBAxgaiQuDZ3fIWqtf7z9UYBheepLTtk8=;
        b=otp91MqajCUkGfi9AB7VWDfe4ZcXOdQytEQ3Gw48+QSO3oxddFKMLT+InO70EtgN9R
         ypnKJP0XkkSYC1drmsCIcf0fRGLE4na1oRU44mOUWO3u9z4VUK6YJL6NtIhYOMNqYt0K
         R5/vJCKPknxMaKIhAFSbTaDLDS7iHw7IwGTHHDQozzyu6ykkQhR6aPshGCHNnodUZq6U
         wovslOdiNlkc0n6dJ2i487LcALIVtbTjLVu1uiz1yqjLPegrrAxjOgr1PFI4vu+ajhJT
         e6rU6PLNJGHCLIhn7lHxzUzIHL3HzO6uX8mSrc+aslUzB/jqSl0tP+8PWsX/aJ0bK1Vo
         3WZw==
X-Gm-Message-State: AA+aEWaRgL6rrDxXY9Qj/3ydOJhW+ZkXoxGVY47Qj4t/3jBfksbYVikl
        iVSPiwfNcL4jn9Y0906rr3I=
X-Google-Smtp-Source: AFSGD/WqUQub5hy3Dq+7rOilY97bk2hMSmtfyWb/X2BO9uWDmqsgC6QhIxQ52efLgpnNMdPrpZIN9w==
X-Received: by 2002:a63:e655:: with SMTP id p21mr1847819pgj.70.1543510570802;
        Thu, 29 Nov 2018 08:56:10 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id c67sm4027583pfg.170.2018.11.29.08.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:56:10 -0800 (PST)
Date:   Thu, 29 Nov 2018 08:56:08 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        vkoul@kernel.org, khasim.mohammed@linaro.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 2/4] drivers: thermal: tsens: Add generic support for
 TSENS v1 IP
Message-ID: <20181129165606.GE2688@localhost.localdomain>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
 <578f79ce10c51bbb7bd6f44395e10a3369a050f4.1543335819.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578f79ce10c51bbb7bd6f44395e10a3369a050f4.1543335819.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:59:05PM +0530, Amit Kucheria wrote:
> qcs404 has a single TSENS IP block with 10 sensors. It uses version 1.4
> of the TSENS IP, functionality for which is encapsulated inside
> qcom,tsens-v1 compatible.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Tested-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/thermal/qcom/Makefile       |   2 +-
>  drivers/thermal/qcom/tsens-common.c |   2 +-
>  drivers/thermal/qcom/tsens-v1.c     | 196 ++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c        |   3 +
>  drivers/thermal/qcom/tsens.h        |   3 +-
>  5 files changed, 203 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/thermal/qcom/tsens-v1.c
> 
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index a821929ede0b..60269ee90c43 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
> -qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
> +qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o tsens-v1.o
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 3be4be2e0465..98f77401bc12 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -76,7 +76,7 @@ void compute_intercept_slope(struct tsens_device *tmdev, u32 *p1,
>  	}
>  }
>  
> -static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
> +int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
>  {
>  	int degc, num, den;
>  
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> new file mode 100644
> index 000000000000..1dbf4fde6da8
> --- /dev/null
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, Linaro Limited
> + */
> +
> +#include <linux/regmap.h>
> +#include <linux/bitops.h>
> +#include "tsens.h"
> +
> +/* eeprom layout data for qcs404 (v1) */
> +#define BASE0_MASK	0x000007f8
> +#define BASE1_MASK	0x0007f800
> +#define BASE0_SHIFT	3
> +#define BASE1_SHIFT	11
> +
> +#define S0_P1_MASK	0x0000003f
> +#define S1_P1_MASK	0x0003f000
> +#define S2_P1_MASK	0x3f000000
> +#define S3_P1_MASK	0x000003f0
> +#define S4_P1_MASK	0x003f0000
> +#define S5_P1_MASK	0x0000003f
> +#define S6_P1_MASK	0x0003f000
> +#define S7_P1_MASK	0x3f000000
> +#define S8_P1_MASK	0x000003f0
> +#define S9_P1_MASK	0x003f0000
> +
> +#define S0_P2_MASK	0x00000fc0
> +#define S1_P2_MASK	0x00fc0000
> +#define S2_P2_MASK_1_0	0xc0000000
> +#define S2_P2_MASK_5_2	0x0000000f
> +#define S3_P2_MASK	0x0000fc00
> +#define S4_P2_MASK	0x0fc00000
> +#define S5_P2_MASK	0x00000fc0
> +#define S6_P2_MASK	0x00fc0000
> +#define S7_P2_MASK_1_0	0xc0000000
> +#define S7_P2_MASK_5_2	0x0000000f
> +#define S8_P2_MASK	0x0000fc00
> +#define S9_P2_MASK	0x0fc00000
> +
> +#define S0_P1_SHIFT	0
> +#define S0_P2_SHIFT	6
> +#define S1_P1_SHIFT	12
> +#define S1_P2_SHIFT	18
> +#define S2_P1_SHIFT	24
> +#define S2_P2_SHIFT_1_0	30
> +
> +#define S2_P2_SHIFT_5_2	0
> +#define S3_P1_SHIFT	4
> +#define S3_P2_SHIFT	10
> +#define S4_P1_SHIFT	16
> +#define S4_P2_SHIFT	22
> +
> +#define S5_P1_SHIFT	0
> +#define S5_P2_SHIFT	6
> +#define S6_P1_SHIFT	12
> +#define S6_P2_SHIFT	18
> +#define S7_P1_SHIFT	24
> +#define S7_P2_SHIFT_1_0	30
> +
> +#define S7_P2_SHIFT_5_2	0
> +#define S8_P1_SHIFT	4
> +#define S8_P2_SHIFT	10
> +#define S9_P1_SHIFT	16
> +#define S9_P2_SHIFT	22
> +
> +#define CAL_SEL_MASK	7
> +#define CAL_SEL_SHIFT	0
> +
> +static int calibrate_v1(struct tsens_device *tmdev)
> +{
> +	u32 base0 = 0, base1 = 0;
> +	u32 p1[10], p2[10];
> +	u32 mode = 0, lsb = 0, msb = 0;
> +	u32 *qfprom_cdata;
> +	int i;
> +
> +	qfprom_cdata = (u32 *)qfprom_read(tmdev->dev, "calib");
> +	if (IS_ERR(qfprom_cdata))
> +		return PTR_ERR(qfprom_cdata);
> +
> +	mode = (qfprom_cdata[4] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
> +	dev_dbg(tmdev->dev, "calibration mode is %d\n", mode);
> +
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		base1 = (qfprom_cdata[4] & BASE1_MASK) >> BASE1_SHIFT;
> +		p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
> +		p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
> +		/* This value is split over two registers, 2 bits and 4 bits */
> +		lsb   = (qfprom_cdata[0] & S2_P2_MASK_1_0) >> S2_P2_SHIFT_1_0;
> +		msb   = (qfprom_cdata[1] & S2_P2_MASK_5_2) >> S2_P2_SHIFT_5_2;
> +		p2[2] = msb << 2 | lsb;
> +		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
> +		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
> +		p2[5] = (qfprom_cdata[2] & S5_P2_MASK) >> S5_P2_SHIFT;
> +		p2[6] = (qfprom_cdata[2] & S6_P2_MASK) >> S6_P2_SHIFT;
> +		/* This value is split over two registers, 2 bits and 4 bits */
> +		lsb   = (qfprom_cdata[2] & S7_P2_MASK_1_0) >> S7_P2_SHIFT_1_0;
> +		msb   = (qfprom_cdata[3] & S7_P2_MASK_5_2) >> S7_P2_SHIFT_5_2;
> +		p2[7] = msb << 2 | lsb;
> +		p2[8] = (qfprom_cdata[3] & S8_P2_MASK) >> S8_P2_SHIFT;
> +		p2[9] = (qfprom_cdata[3] & S9_P2_MASK) >> S9_P2_SHIFT;
> +		for (i = 0; i < tmdev->num_sensors; i++)
> +			p2[i] = ((base1 + p2[i]) << 2);
> +		/* Fall through */
> +	case ONE_PT_CALIB2:
> +		base0 = (qfprom_cdata[4] & BASE0_MASK) >> BASE0_SHIFT;
> +		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
> +		p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
> +		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
> +		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
> +		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
> +		p1[5] = (qfprom_cdata[2] & S5_P1_MASK) >> S5_P1_SHIFT;
> +		p1[6] = (qfprom_cdata[2] & S6_P1_MASK) >> S6_P1_SHIFT;
> +		p1[7] = (qfprom_cdata[2] & S7_P1_MASK) >> S7_P1_SHIFT;
> +		p1[8] = (qfprom_cdata[3] & S8_P1_MASK) >> S8_P1_SHIFT;
> +		p1[9] = (qfprom_cdata[3] & S9_P1_MASK) >> S9_P1_SHIFT;
> +		for (i = 0; i < tmdev->num_sensors; i++)
> +			p1[i] = (((base0) + p1[i]) << 2);
> +		break;
> +	default:
> +		for (i = 0; i < tmdev->num_sensors; i++) {
> +			p1[i] = 500;
> +			p2[i] = 780;
... Wouldn't be nice to know what 500 or 780 stands for here?
Why these defaults? Do we expect to have further patches to keep
updating these?

> +		}
> +		break;
> +	}
> +
> +	compute_intercept_slope(tmdev, p1, p2, mode);
> +
> +	return 0;
> +}
> +
> +#define STATUS_OFFSET		0x44
> +#define LAST_TEMP_MASK		0x3ff
> +#define STATUS_VALID_BIT	BIT(14)
> +
> +static int get_temp_tsens_v1(struct tsens_device *tmdev, int id, int *temp)
> +{
> +	struct tsens_sensor *s = &tmdev->sensor[id];
> +	u32 code;
> +	unsigned int status_reg;
> +	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
> +	int ret;
> +
> +	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> +	ret = regmap_read(tmdev->tm_map, status_reg, &code);
> +	if (ret)
> +		return ret;
> +	last_temp = code & LAST_TEMP_MASK;
> +	if (code & STATUS_VALID_BIT)
> +		goto done;
> +
> +	/* Try a second time */
> +	ret = regmap_read(tmdev->tm_map, status_reg, &code);
> +	if (ret)
> +		return ret;
> +	if (code & STATUS_VALID_BIT) {
> +		last_temp = code & LAST_TEMP_MASK;
> +		goto done;
> +	} else {
> +		last_temp2 = code & LAST_TEMP_MASK;
> +	}
> +
> +	/* Try a third/last time */
> +	ret = regmap_read(tmdev->tm_map, status_reg, &code);
> +	if (ret)
> +		return ret;
> +	if (code & STATUS_VALID_BIT) {
> +		last_temp = code & LAST_TEMP_MASK;
> +		goto done;
> +	} else {
> +		last_temp3 = code & LAST_TEMP_MASK;
> +	}
> +
> +	if (last_temp == last_temp2)
> +		last_temp = last_temp2;
> +	else if (last_temp2 == last_temp3)
> +		last_temp = last_temp3;
> +done:
> +	/* Convert temperature from ADC code to milliCelsius */
> +	*temp = code_to_degc(last_temp, s) * 1000;

This three strikes/read approach seams awkward. Is this a broken
sensor or are you missing the programming steps? Maybe you need to
either wait for a IRQ on temp ready, or maybe you need simply wait
some amount of cycles before the sensor is ready with new temp/ADC
conversion, no?

Also, the goto's dont really help, as we dont really have any
resource to rollback here..

> +
> +	return 0;
> +}
> +
> +static const struct tsens_ops ops_generic_v1 = {
> +	.init		= init_common,
> +	.calibrate	= calibrate_v1,
> +	.get_temp	= get_temp_tsens_v1,
> +};
> +
> +const struct tsens_data data_tsens_v1 = {
> +	.ops		= &ops_generic_v1,
> +	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
> +};
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index f1ec9bbe4717..d0cc0c09894a 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -63,6 +63,9 @@ static const struct of_device_id tsens_table[] = {
>  	}, {
>  		.compatible = "qcom,msm8996-tsens",
>  		.data = &data_8996,
> +	}, {
> +		.compatible = "qcom,tsens-v1",
> +		.data = &data_tsens_v1,
>  	}, {
>  		.compatible = "qcom,tsens-v2",
>  		.data = &data_tsens_v2,
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 7b7feee5dc46..f8dc96c42b94 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -90,9 +90,10 @@ char *qfprom_read(struct device *, const char *);
>  void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
>  int init_common(struct tsens_device *);
>  int get_temp_common(struct tsens_device *, int, int *);
> +int code_to_degc(u32 adc_code, const struct tsens_sensor *s);
>  
>  /* TSENS v1 targets */
> -extern const struct tsens_data data_8916, data_8974, data_8960;
> +extern const struct tsens_data data_8916, data_8974, data_8960, data_tsens_v1;
>  /* TSENS v2 targets */
>  extern const struct tsens_data data_8996, data_tsens_v2;
>  
> -- 
> 2.17.1
> 
