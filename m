Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76351C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8CD217DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyxzrSvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8CD217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeHMK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:26:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37925 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMK0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:26:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so13371659wro.5;
        Mon, 13 Aug 2018 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Fh4kNRb5a83/y1xapxot0dwuIPnrMVdtD5f0LktPsYg=;
        b=oyxzrSvoon4tV0t4hGmZBv/S6Oun2kZxLkPDOpLPwFlz5X+xGmiAoyrNa6TJyWhNRY
         6TtBRvh6DcUy0C2xbHZ85BWZdulB8GaZhjTXCODVvQEuQ9hbZG3X1xQAgCVwNEy9g55d
         xVHs/3gi2BiNgGuXaIp7UuOQWVvYTO8tpwXXwblZdPT//jDGndOibEvKkC009MPpk48t
         YS9cw6w5e3tTxxvEMfBManqJjS1RFw5azqKHUO3Mj2FNQEZl+Zze6HeJQZzFyLsSP+du
         eAgZx7WuJiK7sDhB6HEiNKAKDCScoA5j80CikjBOb8qcNAYvEj1oVCrLRCRepxjrCcIa
         RXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Fh4kNRb5a83/y1xapxot0dwuIPnrMVdtD5f0LktPsYg=;
        b=fREshz48e4MYP+NNns8g3mcI/q3hDoKnVmSExjTisBdfjLMrENaqwdHteJCy9XqACP
         t0G09QT3EcygvKDej31CaI1CFVAsDYngzZZc++Whw6d+GuaD3dL03U/hKhYiwV/P1Hp0
         GPk3BHZcF40eO6bjuzFXfk3FYXNUKHV8WStkLZ2C4XNo00YejutC4rKacrDlEqVMIfF4
         NJJnxyyhpma82u5urQAZC1JFaVmsBzkRxxNDL1bLrgOsdbwEbGIK8dA9Buf4ykn094MD
         4Q/xjILw8dDdxc6tPK0y3CB8xXumUGZn12OsOcCJZ8JRUy/f39qVruUytpnLzSXlHwRG
         EU+A==
X-Gm-Message-State: AOUpUlHZG+YYk8KDFQluFgIl3U5s46ugZEKKpfd8GX7emnz5UEF2e1ku
        o4m4llWCsaTYzu1YjBW3RA==
X-Google-Smtp-Source: AA+uWPwyeO0K/YbH/BQpUYr4nsfWIOegvA1RSwt6lPRE41A6bxvbbkzD/JXglKhOMNLpOUaVvcebZg==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr9665457wro.264.1534146313793;
        Mon, 13 Aug 2018 00:45:13 -0700 (PDT)
Received: from Helena.home (host86-141-127-107.range86-141.btcentralplus.com. [86.141.127.107])
        by smtp.gmail.com with ESMTPSA id m207-v6sm8503918wma.31.2018.08.13.00.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 00:45:13 -0700 (PDT)
Date:   Mon, 13 Aug 2018 08:45:09 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <69cf26ba-5dae-e84c-2fa8-15699fdd9986@codeaurora.org>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180810202123.29238-1-ctatlor97@gmail.com> <69cf26ba-5dae-e84c-2fa8-15699fdd9986@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: qcom: Add Global Clock controller (GCC) driver for SDM660
To:     Taniya Das <tdas@codeaurora.org>
CC:     linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
From:   Craig Tatlor <ctatlor97@gmail.com>
Message-ID: <63F4E7C0-6925-4EC0-84B9-75B31AC664E4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 August 2018 07:55:34 BST, Taniya Das <tdas@codeaurora=2Eorg> wrote:
>Hello Craig,
>
>Could you please correct the authorship and also provide the reference=20
>to code where this is picked from?
Okay,=20
Got code from here https://github=2Ecom/sonyxperiadev/kernel/blob/aosp/LA=
=2EUM=2E6=2E4=2Er1/drivers/clk/qcom/gcc-sdm660=2Ec
but changed it quite a bit for upstream,
Should I change the commit author and add your signed off by and say I did=
 cleanups on my signed off by=2E

Also, hey, you wrote the original driver :)
>
>On 8/11/2018 1:51 AM, Craig Tatlor wrote:
>> Add support for the global clock controller found on SDM660
>> based devices=2E This should allow most non-multimedia device
>> drivers to probe and control their clocks=2E
>> Based on CAF implementation=2E
>>=20
>> Signed-off-by: Craig Tatlor <ctatlor97@gmail=2Ecom>
>> ---
>>   =2E=2E=2E/devicetree/bindings/clock/qcom,gcc=2Etxt    |    1 +
>>   drivers/clk/qcom/Kconfig                      |    9 +
>>   drivers/clk/qcom/Makefile                     |    1 +
>>   drivers/clk/qcom/gcc-sdm660=2Ec                 | 2479
>+++++++++++++++++
>>   include/dt-bindings/clock/qcom,gcc-sdm660=2Eh   |  159 ++
>>   5 files changed, 2649 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gcc-sdm660=2Ec
>>   create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm660=2Eh
>>=20
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc=2Etxt
>b/Documentation/devicetree/bindings/clock/qcom,gcc=2Etxt
>> index 664ea1fd6c76=2E=2Ee498ad2e8db8 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc=2Etxt
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc=2Etxt
>> @@ -19,6 +19,7 @@ Required properties :
>>   			"qcom,gcc-msm8996"
>>   			"qcom,gcc-msm8998"
>>   			"qcom,gcc-mdm9615"
>> +			"qcom,gcc-sdm660"
>>   			"qcom,gcc-sdm845"
>>  =20
>>   - reg : shall contain base register location and length
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 9c3480dcc38a=2E=2Ec4bda6d24c1f 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -226,6 +226,15 @@ config MSM_GCC_8998
>>   	  Say Y if you want to use peripheral devices such as UART, SPI,
>>   	  i2c, USB, UFS, SD/eMMC, PCIe, etc=2E
>>  =20
>> +config SDM_GCC_660
>> +	tristate "SDM660 Global Clock Controller"
>> +	select QCOM_GDSC
>> +	depends on COMMON_CLK_QCOM
>> +	help
>> +	  Support for the global clock controller on SDM660 devices=2E
>> +	  Say Y if you want to use peripheral devices such as UART, SPI,
>> +	  i2C, USB, UFS, SDDC, PCIe, etc=2E
>> +
>>   config SDM_GCC_845
>>   	tristate "SDM845 Global Clock Controller"
>>   	select QCOM_GDSC
>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
>> index 762c01137c2f=2E=2E6e37d30d7c02 100644
>> --- a/drivers/clk/qcom/Makefile
>> +++ b/drivers/clk/qcom/Makefile
>> @@ -38,6 +38,7 @@ obj-$(CONFIG_QCOM_A53PLL) +=3D a53-pll=2Eo
>>   obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) +=3D apcs-msm8916=2Eo
>>   obj-$(CONFIG_QCOM_CLK_RPM) +=3D clk-rpm=2Eo
>>   obj-$(CONFIG_QCOM_CLK_SMD_RPM) +=3D clk-smd-rpm=2Eo
>> +obj-$(CONFIG_SDM_GCC_660) +=3D gcc-sdm660=2Eo
>>   obj-$(CONFIG_SDM_GCC_845) +=3D gcc-sdm845=2Eo
>>   obj-$(CONFIG_SDM_VIDEOCC_845) +=3D videocc-sdm845=2Eo
>>   obj-$(CONFIG_SPMI_PMIC_CLKDIV) +=3D clk-spmi-pmic-div=2Eo
>> diff --git a/drivers/clk/qcom/gcc-sdm660=2Ec
>b/drivers/clk/qcom/gcc-sdm660=2Ec
>> new file mode 100644
>> index 000000000000=2E=2Ebdb445aa4baa
>> --- /dev/null
>> +++ b/drivers/clk/qcom/gcc-sdm660=2Ec
>> @@ -0,0 +1,2479 @@
>> +// SPDX-License-Identifier: GPL-2=2E0
>> +/*
>> + * Copyright (c) 2016-2017, The Linux Foundation=2E All rights
>reserved=2E
>> + * Copyright (c) 2018, Craig Tatlor=2E
>> + */
>> +
>> +#include <linux/kernel=2Eh>
>> +#include <linux/bitops=2Eh>
>> +#include <linux/err=2Eh>
>> +#include <linux/platform_device=2Eh>
>> +#include <linux/module=2Eh>
>> +#include <linux/of=2Eh>
>> +#include <linux/of_device=2Eh>
>> +#include <linux/clk-provider=2Eh>
>> +#include <linux/regmap=2Eh>
>> +#include <linux/reset-controller=2Eh>
>> +
>> +#include <dt-bindings/clock/qcom,gcc-sdm660=2Eh>
>> +
>> +#include "common=2Eh"
>> +#include "clk-regmap=2Eh"
>> +#include "clk-alpha-pll=2Eh"
>> +#include "clk-rcg=2Eh"
>> +#include "clk-branch=2Eh"
>> +#include "reset=2Eh"
>> +#include "gdsc=2Eh"
>> +
>> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
>> +
>> +enum {
>> +	P_XO,
>> +	P_SLEEP_CLK,
>> +	P_GPLL0,
>> +	P_GPLL1,
>> +	P_GPLL4,
>> +	P_GPLL0_EARLY_DIV,
>> +	P_GPLL1_EARLY_DIV,
>> +};
>> +
>> +static const struct parent_map
>gcc_parent_map_xo_gpll0_gpll0_early_div[] =3D {
>> +	{ P_XO, 0 },
>> +	{ P_GPLL0, 1 },
>> +	{ P_GPLL0_EARLY_DIV, 6 },
>> +};
>> +
>> +static const char * const
>gcc_parent_names_xo_gpll0_gpll0_early_div[] =3D {
>> +	"xo",
>> +	"gpll0",
>> +	"gpll0_early_div",
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_xo_gpll0[] =3D {
>> +	{ P_XO, 0 },
>> +	{ P_GPLL0, 1 },
>> +};
>> +
>> +static const char * const gcc_parent_names_xo_gpll0[] =3D {
>> +	"xo",
>> +	"gpll0",
>> +};
>> +
>> +static const struct parent_map
>gcc_parent_map_xo_gpll0_sleep_clk_gpll0_early_div[] =3D {
>> +	{ P_XO, 0 },
>> +	{ P_GPLL0, 1 },
>> +	{ P_SLEEP_CLK, 5 },
>> +	{ P_GPLL0_EARLY_DIV, 6 },
>> +};
>> +
>> +static const char * const
>gcc_parent_names_xo_gpll0_sleep_clk_gpll0_early_div[] =3D {
>> +	"xo",
>> +	"gpll0",
>> +	"sleep_clk",
>> +	"gpll0_early_div",
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_xo_sleep_clk[] =3D {
>> +	{ P_XO, 0 },
>> +	{ P_SLEEP_CLK, 5 },
>> +};
>> +
>> +static const char * const gcc_parent_names_xo_sleep_clk[] =3D {
>> +	"xo",
>> +	"sleep_clk",
>> +};
>> +
>> +static const struct parent_map gcc_parent_map_xo_gpll4[] =3D {
>> +	{ P_XO, 0 },
>> +	{ P_GPLL4, 5 },
>> +};
>> +
>> +static const char * const gcc_parent_names_xo_gpll4[] =3D {
>> +	"xo",
>> +	"gpll4",
>> +};
>> +
>> +static const struct parent_map
>gcc_parent_map_xo_gpll0_gpll0_early_div_gpll1_gpll4_gpll1_early_div[] =3D
>{
>> +	{ P_XO, 0 },
>> +	{ P_GPLL0, 1 },
>> +	{ P_GPLL0_EARLY_DIV, 3 },
>> +	{ P_GPLL1, 4 },
>> +	{ P_GPLL4, 5 },
>> +	{ P_GPLL1_EARLY_DIV, 6 },
>> +};
>> +
>> +static const char * const
>gcc_parent_names_xo_gpll0_gpll0_early_div_gpll1_gpll4_gpll1_early_div[]
>=3D {
>> +	"xo",
>> +	"gpll0",
>> +	"gpll0_early_div",
>> +	"gpll1",
>> +	"gpll4",
>> +	"gpll1_early_div",
>> +};
>> +
>> +static const struct parent_map
>gcc_parent_map_xo_gpll0_gpll4_gpll0_early_div[] =3D {
>> +	{ P_XO, 0 },
>> +	{ P_GPLL0, 1 },
>> +	{ P_GPLL4, 5 },
>> +	{ P_GPLL0_EARLY_DIV, 6 },
>> +};
>> +
>> +static const char * const
>gcc_parent_names_xo_gpll0_gpll4_gpll0_early_div[] =3D {
>> +	"xo",
>> +	"gpll0",
>> +	"gpll4",
>> +	"gpll0_early_div",
>> +};
>> +
>> +static const struct parent_map
>gcc_parent_map_xo_gpll0_gpll0_early_div_gpll4[] =3D {
>> +	{ P_XO, 0 },
>> +	{ P_GPLL0, 1 },
>> +	{ P_GPLL0_EARLY_DIV, 2 },
>> +	{ P_GPLL4, 5 },
>> +};
>> +
>> +static const char * const
>gcc_parent_names_xo_gpll0_gpll0_early_div_gpll4[] =3D {
>> +	"xo",
>> +	"gpll0",
>> +	"gpll0_early_div",
>> +	"gpll4",
>> +};
>> +
>> +static struct clk_fixed_factor xo =3D {
>> +	=2Emult =3D 1,
>> +	=2Ediv =3D 1,
>> +	=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "xo",
>> +		=2Eparent_names =3D (const char *[]){ "xo_board" },
>> +		=2Enum_parents =3D 1,
>> +		=2Eops =3D &clk_fixed_factor_ops,
>> +	},
>> +};
>> +
>> +static struct clk_alpha_pll gpll0_early =3D {
>> +	=2Eoffset =3D 0x0,
>> +	=2Eregs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>> +	=2Eclkr =3D {
>> +		=2Eenable_reg =3D 0x52000,
>> +		=2Eenable_mask =3D BIT(0),
>> +		=2Ehw=2Einit =3D &(struct clk_init_data){
>> +			=2Ename =3D "gpll0_early",
>> +			=2Eparent_names =3D (const char *[]){ "xo" },
>> +			=2Enum_parents =3D 1,
>> +			=2Eops =3D &clk_alpha_pll_ops,
>> +		},
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor gpll0_early_div =3D {
>> +	=2Emult =3D 1,
>> +	=2Ediv =3D 2,
>> +	=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "gpll0_early_div",
>> +		=2Eparent_names =3D (const char *[]){ "gpll0_early" },
>> +		=2Enum_parents =3D 1,
>> +		=2Eops =3D &clk_fixed_factor_ops,
>> +	},
>> +};
>> +
>> +static struct clk_alpha_pll_postdiv gpll0 =3D {
>> +	=2Eoffset =3D 0x00000,
>> +	=2Eregs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "gpll0",
>> +		=2Eparent_names =3D (const char *[]){ "gpll0_early" },
>> +		=2Enum_parents =3D 1,
>> +		=2Eops =3D &clk_alpha_pll_postdiv_ops,
>> +	},
>> +};
>> +
>> +static struct clk_alpha_pll gpll1_early =3D {
>> +	=2Eoffset =3D 0x1000,
>> +	=2Eregs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>> +	=2Eclkr =3D {
>> +		=2Eenable_reg =3D 0x52000,
>> +		=2Eenable_mask =3D BIT(1),
>> +		=2Ehw=2Einit =3D &(struct clk_init_data){
>> +			=2Ename =3D "gpll1_early",
>> +			=2Eparent_names =3D (const char *[]){ "xo" },
>> +			=2Enum_parents =3D 1,
>> +			=2Eops =3D &clk_alpha_pll_ops,
>> +		},
>> +	},
>> +};
>> +
>> +static struct clk_fixed_factor gpll1_early_div =3D {
>> +	=2Emult =3D 1,
>> +	=2Ediv =3D 2,
>> +	=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "gpll1_early_div",
>> +		=2Eparent_names =3D (const char *[]){ "gpll1_early" },
>> +		=2Enum_parents =3D 1,
>> +		=2Eops =3D &clk_fixed_factor_ops,
>> +	},
>> +};
>> +
>> +static struct clk_alpha_pll_postdiv gpll1 =3D {
>> +	=2Eoffset =3D 0x1000,
>> +	=2Eregs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "gpll1",
>> +		=2Eparent_names =3D (const char *[]){ "gpll1_early" },
>> +		=2Enum_parents =3D 1,
>> +		=2Eops =3D &clk_alpha_pll_postdiv_ops,
>> +	},
>> +};
>> +
>> +static struct clk_alpha_pll gpll4_early =3D {
>> +	=2Eoffset =3D 0x77000,
>> +	=2Eregs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>> +	=2Eclkr =3D {
>> +		=2Eenable_reg =3D 0x52000,
>> +		=2Eenable_mask =3D BIT(4),
>> +		=2Ehw=2Einit =3D &(struct clk_init_data){
>> +			=2Ename =3D "gpll4_early",
>> +			=2Eparent_names =3D (const char *[]){ "xo" },
>> +			=2Enum_parents =3D 1,
>> +			=2Eops =3D &clk_alpha_pll_ops,
>> +		},
>> +	},
>> +};
>> +
>> +static struct clk_alpha_pll_postdiv gpll4 =3D {
>> +	=2Eoffset =3D 0x77000,
>> +	=2Eregs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data)
>> +	{
>> +		=2Ename =3D "gpll4",
>> +		=2Eparent_names =3D (const char *[]) { "gpll4_early" },
>> +		=2Enum_parents =3D 1,
>> +		=2Eops =3D &clk_alpha_pll_postdiv_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_blsp1_qup1_i2c_apps_clk_src[] =3D {
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(50000000, P_GPLL0, 12, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x19020,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_i2c_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_qup1_i2c_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_blsp1_qup1_spi_apps_clk_src[] =3D {
>> +	F(960000, P_XO, 10, 1, 2),
>> +	F(4800000, P_XO, 4, 0, 0),
>> +	F(9600000, P_XO, 2, 0, 0),
>> +	F(15000000, P_GPLL0, 10, 1, 4),
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(25000000, P_GPLL0, 12, 1, 2),
>> +	F(50000000, P_GPLL0, 12, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1900c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_spi_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_qup1_spi_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1b020,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_i2c_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_qup2_i2c_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1b00c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_spi_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_qup2_spi_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp1_qup3_i2c_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1d020,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_i2c_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_qup3_i2c_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp1_qup3_spi_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1d00c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_spi_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_qup3_spi_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp1_qup4_i2c_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1f020,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_i2c_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_qup4_i2c_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp1_qup4_spi_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1f00c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_spi_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_qup4_spi_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_blsp1_uart1_apps_clk_src[] =3D {
>> +	F(3686400, P_GPLL0, 1, 96, 15625),
>> +	F(7372800, P_GPLL0, 1, 192, 15625),
>> +	F(14745600, P_GPLL0, 1, 384, 15625),
>> +	F(16000000, P_GPLL0, 5, 2, 15),
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(24000000, P_GPLL0, 5, 1, 5),
>> +	F(32000000, P_GPLL0, 1, 4, 75),
>> +	F(40000000, P_GPLL0, 15, 0, 0),
>> +	F(46400000, P_GPLL0, 1, 29, 375),
>> +	F(48000000, P_GPLL0, 12=2E5, 0, 0),
>> +	F(51200000, P_GPLL0, 1, 32, 375),
>> +	F(56000000, P_GPLL0, 1, 7, 75),
>> +	F(58982400, P_GPLL0, 1, 1536, 15625),
>> +	F(60000000, P_GPLL0, 10, 0, 0),
>> +	F(63157895, P_GPLL0, 9=2E5, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 blsp1_uart1_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1a00c,
>> +	=2Emnd_width =3D 16,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_uart1_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_uart1_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp1_uart2_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1c00c,
>> +	=2Emnd_width =3D 16,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_uart1_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp1_uart2_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_qup1_i2c_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x26020,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_i2c_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_qup1_i2c_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_qup1_spi_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2600c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_spi_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_qup1_spi_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_qup2_i2c_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x28020,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_i2c_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_qup2_i2c_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_qup2_spi_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2800c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_spi_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_qup2_spi_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_qup3_i2c_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2a020,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_i2c_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_qup3_i2c_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_qup3_spi_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2a00c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_spi_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_qup3_spi_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_qup4_i2c_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2c020,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_i2c_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_qup4_i2c_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_qup4_spi_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2c00c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_qup1_spi_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_qup4_spi_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_uart1_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2700c,
>> +	=2Emnd_width =3D 16,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_uart1_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_uart1_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 blsp2_uart2_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2900c,
>> +	=2Emnd_width =3D 16,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_blsp1_uart1_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "blsp2_uart2_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_gp1_clk_src[] =3D {
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(100000000, P_GPLL0, 6, 0, 0),
>> +	F(200000000, P_GPLL0, 3, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 gp1_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x64004,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_sleep_clk_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_gp1_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "gp1_clk_src",
>> +		=2Eparent_names =3D
>gcc_parent_names_xo_gpll0_sleep_clk_gpll0_early_div,
>> +		=2Enum_parents =3D 4,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 gp2_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x65004,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_sleep_clk_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_gp1_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "gp2_clk_src",
>> +		=2Eparent_names =3D
>gcc_parent_names_xo_gpll0_sleep_clk_gpll0_early_div,
>> +		=2Enum_parents =3D 4,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 gp3_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x66004,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_sleep_clk_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_gp1_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "gp3_clk_src",
>> +		=2Eparent_names =3D
>gcc_parent_names_xo_gpll0_sleep_clk_gpll0_early_div,
>> +		=2Enum_parents =3D 4,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_hmss_gpll0_clk_src[] =3D {
>> +	F(300000000, P_GPLL0, 2, 0, 0),
>> +	F(600000000, P_GPLL0, 1, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 hmss_gpll0_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x4805c,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_hmss_gpll0_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "hmss_gpll0_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_hmss_gpll4_clk_src[] =3D {
>> +	F(384000000, P_GPLL4, 4, 0, 0),
>> +	F(768000000, P_GPLL4, 2, 0, 0),
>> +	F(1536000000, P_GPLL4, 1, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 hmss_gpll4_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x48074,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll4,
>> +	=2Efreq_tbl =3D ftbl_hmss_gpll4_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "hmss_gpll4_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll4,
>> +		=2Enum_parents =3D 2,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_hmss_rbcpr_clk_src[] =3D {
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 hmss_rbcpr_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x48044,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_hmss_rbcpr_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "hmss_rbcpr_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0,
>> +		=2Enum_parents =3D 2,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_pdm2_clk_src[] =3D {
>> +	F(60000000, P_GPLL0, 10, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 pdm2_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x33010,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_pdm2_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "pdm2_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_qspi_ser_clk_src[] =3D {
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(80200000, P_GPLL1_EARLY_DIV, 5, 0, 0),
>> +	F(160400000, P_GPLL1, 5, 0, 0),
>> +	F(267333333, P_GPLL1, 3, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 qspi_ser_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x4d00c,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D
>gcc_parent_map_xo_gpll0_gpll0_early_div_gpll1_gpll4_gpll1_early_div,
>> +	=2Efreq_tbl =3D ftbl_qspi_ser_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "qspi_ser_clk_src",
>> +		=2Eparent_names =3D
>gcc_parent_names_xo_gpll0_gpll0_early_div_gpll1_gpll4_gpll1_early_div,
>> +		=2Enum_parents =3D 6,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_sdcc1_apps_clk_src[] =3D {
>> +	F(144000, P_XO, 16, 3, 25),
>> +	F(400000, P_XO, 12, 1, 4),
>> +	F(20000000, P_GPLL0_EARLY_DIV, 5, 1, 3),
>> +	F(25000000, P_GPLL0_EARLY_DIV, 6, 1, 2),
>> +	F(50000000, P_GPLL0_EARLY_DIV, 6, 0, 0),
>> +	F(100000000, P_GPLL0, 6, 0, 0),
>> +	F(192000000, P_GPLL4, 8, 0, 0),
>> +	F(384000000, P_GPLL4, 4, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 sdcc1_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x1602c,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll4_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_sdcc1_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "sdcc1_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll4_gpll0_early_div,
>> +		=2Enum_parents =3D 4,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_sdcc1_ice_core_clk_src[] =3D {
>> +	F(75000000, P_GPLL0_EARLY_DIV, 4, 0, 0),
>> +	F(150000000, P_GPLL0, 4, 0, 0),
>> +	F(200000000, P_GPLL0, 3, 0, 0),
>> +	F(300000000, P_GPLL0, 2, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 sdcc1_ice_core_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x16010,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_sdcc1_ice_core_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "sdcc1_ice_core_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_sdcc2_apps_clk_src[] =3D {
>> +	F(144000, P_XO, 16, 3, 25),
>> +	F(400000, P_XO, 12, 1, 4),
>> +	F(20000000, P_GPLL0_EARLY_DIV, 5, 1, 3),
>> +	F(25000000, P_GPLL0_EARLY_DIV, 6, 1, 2),
>> +	F(50000000, P_GPLL0_EARLY_DIV, 6, 0, 0),
>> +	F(100000000, P_GPLL0, 6, 0, 0),
>> +	F(192000000, P_GPLL4, 8, 0, 0),
>> +	F(200000000, P_GPLL0, 3, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 sdcc2_apps_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x14010,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div_gpll4,
>> +	=2Efreq_tbl =3D ftbl_sdcc2_apps_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "sdcc2_apps_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div_gpll4,
>> +		=2Enum_parents =3D 4,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_ufs_axi_clk_src[] =3D {
>> +	F(50000000, P_GPLL0_EARLY_DIV, 6, 0, 0),
>> +	F(100000000, P_GPLL0, 6, 0, 0),
>> +	F(150000000, P_GPLL0, 4, 0, 0),
>> +	F(200000000, P_GPLL0, 3, 0, 0),
>> +	F(240000000, P_GPLL0, 2=2E5, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 ufs_axi_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x75018,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_ufs_axi_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "ufs_axi_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_ufs_ice_core_clk_src[] =3D {
>> +	F(75000000, P_GPLL0_EARLY_DIV, 4, 0, 0),
>> +	F(150000000, P_GPLL0, 4, 0, 0),
>> +	F(300000000, P_GPLL0, 2, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 ufs_ice_core_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x76010,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_ufs_ice_core_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "ufs_ice_core_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_rcg2 ufs_phy_aux_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x76044,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_sleep_clk,
>> +	=2Efreq_tbl =3D ftbl_hmss_rbcpr_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "ufs_phy_aux_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_sleep_clk,
>> +		=2Enum_parents =3D 2,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_ufs_unipro_core_clk_src[] =3D {
>> +	F(37500000, P_GPLL0_EARLY_DIV, 8, 0, 0),
>> +	F(75000000, P_GPLL0, 8, 0, 0),
>> +	F(150000000, P_GPLL0, 4, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 ufs_unipro_core_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x76028,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_ufs_unipro_core_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "ufs_unipro_core_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_usb20_master_clk_src[] =3D {
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(60000000, P_GPLL0, 10, 0, 0),
>> +	F(120000000, P_GPLL0, 5, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 usb20_master_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2f010,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_usb20_master_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "usb20_master_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_usb20_mock_utmi_clk_src[] =3D {
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(60000000, P_GPLL0, 10, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 usb20_mock_utmi_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x2f024,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_usb20_mock_utmi_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "usb20_mock_utmi_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_usb30_master_clk_src[] =3D {
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(66666667, P_GPLL0_EARLY_DIV, 4=2E5, 0, 0),
>> +	F(120000000, P_GPLL0, 5, 0, 0),
>> +	F(133333333, P_GPLL0, 4=2E5, 0, 0),
>> +	F(150000000, P_GPLL0, 4, 0, 0),
>> +	F(200000000, P_GPLL0, 3, 0, 0),
>> +	F(240000000, P_GPLL0, 2=2E5, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 usb30_master_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0xf014,
>> +	=2Emnd_width =3D 8,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_usb30_master_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "usb30_master_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_usb30_mock_utmi_clk_src[] =3D {
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	F(40000000, P_GPLL0_EARLY_DIV, 7=2E5, 0, 0),
>> +	F(60000000, P_GPLL0, 10, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 usb30_mock_utmi_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0xf028,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_gpll0_gpll0_early_div,
>> +	=2Efreq_tbl =3D ftbl_usb30_mock_utmi_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "usb30_mock_utmi_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_gpll0_gpll0_early_div,
>> +		=2Enum_parents =3D 3,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static const struct freq_tbl ftbl_usb3_phy_aux_clk_src[] =3D {
>> +	F(1200000, P_XO, 16, 0, 0),
>> +	F(19200000, P_XO, 1, 0, 0),
>> +	{ }
>> +};
>> +
>> +static struct clk_rcg2 usb3_phy_aux_clk_src =3D {
>> +	=2Ecmd_rcgr =3D 0x5000c,
>> +	=2Emnd_width =3D 0,
>> +	=2Ehid_width =3D 5,
>> +	=2Eparent_map =3D gcc_parent_map_xo_sleep_clk,
>> +	=2Efreq_tbl =3D ftbl_usb3_phy_aux_clk_src,
>> +	=2Eclkr=2Ehw=2Einit =3D &(struct clk_init_data){
>> +		=2Ename =3D "usb3_phy_aux_clk_src",
>> +		=2Eparent_names =3D gcc_parent_names_xo_sleep_clk,
>> +		=2Enum_parents =3D 2,
>> +		=2Eops =3D &clk_rcg2_ops,
>> +	},
>> +};
>> +
>> +static struct clk_branch gcc_aggre2_ufs_axi_clk =3D {
>> +	=2Eha

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
