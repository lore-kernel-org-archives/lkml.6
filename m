Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC4DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE64208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MFtSlqeu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FZ+9B27g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE64208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeG3XPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:15:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeG3XPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:15:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 61356606DD; Mon, 30 Jul 2018 21:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532986683;
        bh=Z/8xCqhESJc+7qvenQ8JGn1RjpZp/CObJ6Qv0iFtc2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MFtSlqeuXLde6jxc8CipHHmvNhLMwT5BxlrD45iXi/EAi8rZEvPBzk4OtacbYbzhY
         TiQviYLLkop4CKiM0hQ1QpSzCR3LibdN5tDGSwAjwuUQeamUuWaJf8Rhd56FqDvVE/
         KATa7NtMRmkgqRV9klOye7+nDr8sS4mmLqmPojU8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6032960397;
        Mon, 30 Jul 2018 21:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532986681;
        bh=Z/8xCqhESJc+7qvenQ8JGn1RjpZp/CObJ6Qv0iFtc2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FZ+9B27ge3xthPTwIx52g3stCH3z0Hsyu9t6WyUFEztyO4jRYHrkXZQK/q5+2//pJ
         Expfoy1CUO2+l8WO/wIC+IwesBy/3UZZyvUWQc/80ai2iqgrAq+cgfhqHIpmX2G/X0
         LG6yTT4L3ZwejPxAQ3vrjsa2HVI5DbmKJWIJNJpA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Jul 2018 14:38:01 -0700
From:   vnkgutta@codeaurora.org
To:     Borislav Petkov <bp@alien8.de>
Cc:     evgreen@chromium.org, robh@kernel.org, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org
Subject: Re: [PATCH v0 3/4] drivers: edac: Add cache erp driver for Last Level
 Cache Controller (LLCC)
In-Reply-To: <20180729034927.GA2916@nazgul.tnic>
References: <1532540697-26630-1-git-send-email-vnkgutta@codeaurora.org>
 <1532540697-26630-4-git-send-email-vnkgutta@codeaurora.org>
 <20180729034927.GA2916@nazgul.tnic>
Message-ID: <090d55ef84af7bc6c750b93219408437@codeaurora.org>
X-Sender: vnkgutta@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-28 20:49, Borislav Petkov wrote:
> On Wed, Jul 25, 2018 at 10:44:56AM -0700, Venkata Narendra Kumar Gutta 
> wrote:
>> Add cache error reporting driver for single and double bit errors on
>> Last Level Cache Controller (LLCC) cache. This driver takes care of
>> dumping registers and add config options to enable and disable panic
>> when these errors happen.
>> 
>> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
>> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> 
> This SOB chain doesn't make any sense - see
> Documentation/process/submitting-patches.rst

Do you mean the Signed-off-by lines above? That's because
Channagoud is the one who is the original author of this driver,
and I'm the one who did the incremental changes (changes in llcc)
and uploading it upstream.
That's why the Signed-off is like that.
Which way do you think it should be?

> 
>> ---
>>  drivers/edac/Kconfig          |  21 ++
>>  drivers/edac/Makefile         |   1 +
>>  drivers/edac/qcom_llcc_edac.c | 520 
>> ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 542 insertions(+)
>>  create mode 100644 drivers/edac/qcom_llcc_edac.c
> 
> Needs MAINTAINERS entry so that you get all the bug reports.
I'll update it.
> 
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 57304b2..68518ad 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -460,4 +460,25 @@ config EDAC_TI
>>  	  Support for error detection and correction on the
>>            TI SoCs.
>> 
>> +config EDAC_QCOM_LLCC
>> +        depends on QCOM_LLCC
>> +        tristate "QCOM EDAC Controller for LLCC Cache"
> 
> No edac driver per functional unit pls - see how altera_edac.c does it,
> for example. IOW, this driver - if it cannot share/reuse any of the
> existing edac drivers, it should be called qcom_edac and contain all 
> the
> Qualcomm-specific RAS features there.

Ok, I'll refactor it.


> 
>> +        help
>> +          Support for error detection and correction on the
>> +          QCOM LLCC cache. Report errors caught by LLCC ECC
>> +          mechanism.
>> +
>> +          For debugging issues having to do with stability and 
>> overall system
>> +          health, you should probably say 'Y' here.
>> +
>> +config EDAC_QCOM_LLCC_PANIC_ON_UE
>> +        depends on EDAC_QCOM_LLCC
>> +        bool "Panic on uncorrectable errors - qcom llcc"
>> +        help
>> +          Forcibly cause a kernel panic if an uncorrectable error 
>> (UE) is
>> +          detected. This can reduce debugging times on hardware which 
>> may be
>> +          operating at voltages or frequencies outside normal 
>> specification.
>> +
>> +          For production builds, you should probably say 'N' here.
>> +
>>  endif # EDAC
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
>> index 02b43a7..28aff28 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -77,3 +77,4 @@ obj-$(CONFIG_EDAC_ALTERA)		+= altera_edac.o
>>  obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>> +obj-$(CONFIG_EDAC_QCOM_LLCC)		+= qcom_llcc_edac.o
>> diff --git a/drivers/edac/qcom_llcc_edac.c 
>> b/drivers/edac/qcom_llcc_edac.c
>> new file mode 100644
>> index 0000000..7a678b5
>> --- /dev/null
>> +++ b/drivers/edac/qcom_llcc_edac.c
>> @@ -0,0 +1,520 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/edac.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/smp.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/regmap.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/soc/qcom/llcc-qcom.h>
>> +#include "edac_mc.h"
>> +#include "edac_device.h"
>> +
>> +#ifdef CONFIG_EDAC_QCOM_LLCC_PANIC_ON_UE
>> +#define LLCC_ERP_PANIC_ON_UE 1
>> +#else
>> +#define LLCC_ERP_PANIC_ON_UE 0
>> +#endif
>> +
>> +#define EDAC_LLCC	"qcom_llcc"
>> +
>> +#define TRP_SYN_REG_CNT	6
>> +
>> +#define DRP_SYN_REG_CNT	8
>> +
>> +#define LLCC_COMMON_STATUS0		0x0003000C
>> +#define LLCC_LB_CNT_MASK		GENMASK(31, 28)
>> +#define LLCC_LB_CNT_SHIFT		28
>> +
>> +/* single & Double Bit syndrome register offsets */
>> +#define TRP_ECC_SB_ERR_SYN0		0x0002304C
>> +#define TRP_ECC_DB_ERR_SYN0		0x00020370
>> +#define DRP_ECC_SB_ERR_SYN0		0x0004204C
>> +#define DRP_ECC_DB_ERR_SYN0		0x00042070
>> +
>> +/* Error register offsets */
>> +#define TRP_ECC_ERROR_STATUS1		0x00020348
>> +#define TRP_ECC_ERROR_STATUS0		0x00020344
>> +#define DRP_ECC_ERROR_STATUS1		0x00042048
>> +#define DRP_ECC_ERROR_STATUS0		0x00042044
>> +
>> +/* TRP, DRP interrupt register offsets */
>> +#define DRP_INTERRUPT_STATUS		0x00041000
>> +#define TRP_INTERRUPT_0_STATUS		0x00020480
>> +#define DRP_INTERRUPT_CLEAR		0x00041008
>> +#define DRP_ECC_ERROR_CNTR_CLEAR	0x00040004
>> +#define TRP_INTERRUPT_0_CLEAR		0x00020484
>> +#define TRP_ECC_ERROR_CNTR_CLEAR	0x00020440
>> +
>> +/* Mask and shift macros */
>> +#define ECC_DB_ERR_COUNT_MASK	GENMASK(4, 0)
> 
> Align all those to the same vertical column.
Sure, I'll update it in the next patch set.
> 
>> +#define ECC_DB_ERR_WAYS_MASK	GENMASK(31, 16)
>> +#define ECC_DB_ERR_WAYS_SHIFT	BIT(4)
>> +
>> +#define ECC_SB_ERR_COUNT_MASK	GENMASK(23, 16)
>> +#define ECC_SB_ERR_COUNT_SHIFT	BIT(4)
>> +#define ECC_SB_ERR_WAYS_MASK	GENMASK(15, 0)
>> +
>> +#define SB_ECC_ERROR		BIT(0)
>> +#define DB_ECC_ERROR		BIT(1)
>> +
>> +#define DRP_TRP_INT_CLEAR	GENMASK(1, 0)
>> +#define DRP_TRP_CNT_CLEAR	GENMASK(1, 0)
>> +
>> +/* Config registers offsets*/
>> +#define DRP_ECC_ERROR_CFG       0x00040000
>> +
>> +/* TRP, DRP interrupt register offsets */
>> +#define CMN_INTERRUPT_0_ENABLE          0x0003001C
>> +#define CMN_INTERRUPT_2_ENABLE          0x0003003C
>> +#define TRP_INTERRUPT_0_ENABLE          0x00020488
>> +#define DRP_INTERRUPT_ENABLE            0x0004100C
>> +
>> +#define SB_ERROR_THRESHOLD      0x1
>> +#define SB_ERROR_THRESHOLD_SHIFT        24
>> +#define SB_DB_TRP_INTERRUPT_ENABLE      0x3
>> +#define TRP0_INTERRUPT_ENABLE   0x1
>> +#define DRP0_INTERRUPT_ENABLE   BIT(6)
>> +#define SB_DB_DRP_INTERRUPT_ENABLE      0x3
>> +
>> +
>> +enum {
>> +	LLCC_DRAM_CE = 0,
>> +	LLCC_DRAM_UE,
>> +	LLCC_TRAM_CE,
>> +	LLCC_TRAM_UE,
>> +};
>> +
>> +struct errors_edac {
>> +	const char *msg;
>> +	void (*func)(struct edac_device_ctl_info *edev_ctl,
>> +				int inst_nr, int block_nr, const char *msg);
>> +};
>> +
>> +static const struct errors_edac errors[] = {
>> +	{"LLCC Data RAM correctable Error", edac_device_handle_ce},
>> +	{"LLCC Data RAM uncorrectable Error", edac_device_handle_ue},
>> +	{"LLCC Tag RAM correctable Error", edac_device_handle_ce},
>> +	{"LLCC Tag RAM uncorrectable Error", edac_device_handle_ue},
>> +};
>> +
>> +static int qcom_llcc_core_setup(struct regmap *llcc_bcast_regmap)
>> +{
>> +	u32 sb_err_threshold;
>> +	int ret;
>> +
>> +	/* Enable TRP in instance 2 of common interrupt enable register */
>> +	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
>> +				TRP0_INTERRUPT_ENABLE,
>> +				TRP0_INTERRUPT_ENABLE);
> 
> Align arguments at the opening brace. Check the rest below too.
Sure, I'll update them in next patch.
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable ECC interrupts on Tag Ram */
>> +	ret = regmap_update_bits(llcc_bcast_regmap, TRP_INTERRUPT_0_ENABLE,
>> +				SB_DB_TRP_INTERRUPT_ENABLE,
>> +				SB_DB_TRP_INTERRUPT_ENABLE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable SB error for Data RAM */
>> +	sb_err_threshold = (SB_ERROR_THRESHOLD << SB_ERROR_THRESHOLD_SHIFT);
>> +	ret = regmap_write(llcc_bcast_regmap, DRP_ECC_ERROR_CFG,
>> +				sb_err_threshold);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable DRP in instance 2 of common interrupt enable register */
>> +	ret = regmap_update_bits(llcc_bcast_regmap, CMN_INTERRUPT_2_ENABLE,
>> +				DRP0_INTERRUPT_ENABLE, DRP0_INTERRUPT_ENABLE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Enable ECC interrupts on Data Ram */
>> +	ret = regmap_write(llcc_bcast_regmap, DRP_INTERRUPT_ENABLE,
>> +				SB_DB_DRP_INTERRUPT_ENABLE);
>> +	return ret;
>> +}
>> +
>> +/* Clear the error interrupt and counter registers */
>> +static int qcom_llcc_clear_errors(int err_type, struct llcc_drv_data 
>> *drv)
>> +{
>> +	int ret = 0;
>> +
>> +	switch (err_type) {
>> +	case LLCC_DRAM_CE:
>> +	case LLCC_DRAM_UE:
>> +		/* Clear the interrupt */
>> +		ret = regmap_write(drv->bcast_regmap, DRP_INTERRUPT_CLEAR,
>> +					DRP_TRP_INT_CLEAR);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* Clear the counters */
>> +		ret = regmap_write(drv->bcast_regmap, DRP_ECC_ERROR_CNTR_CLEAR,
>> +					DRP_TRP_CNT_CLEAR);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	case LLCC_TRAM_CE:
>> +	case LLCC_TRAM_UE:
>> +		ret = regmap_write(drv->bcast_regmap, TRP_INTERRUPT_0_CLEAR,
>> +					DRP_TRP_INT_CLEAR);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_write(drv->bcast_regmap, TRP_ECC_ERROR_CNTR_CLEAR,
>> +					DRP_TRP_CNT_CLEAR);
>> +		if (ret)
>> +			return ret;
>> +		break;
>> +	}
>> +	return ret;
>> +}
>> +
>> +/* Dump syndrome registers for tag Ram Double bit errors */
>> +static int dump_trp_db_syn_reg(struct llcc_drv_data *drv, u32 bank)
>> +{
>> +	int i, ret;
>> +	int db_err_cnt;
>> +	int db_err_ways;
>> +	u32 synd_reg;
>> +	u32 synd_val;
>> +
>> +	for (i = 0; i < TRP_SYN_REG_CNT; i++) {
>> +		synd_reg = TRP_ECC_DB_ERR_SYN0 + (i * 4);
>> +		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
>> +				&synd_val);
>> +		if (ret)
>> +			return ret;
>> +		edac_printk(KERN_CRIT, EDAC_LLCC, "TRP_ECC_SYN%d: 0x%8x\n",
>> +			i, synd_val);
>> +	}
>> +
>> +	ret = regmap_read(drv->regmap,
>> +				drv->offsets[bank] + TRP_ECC_ERROR_STATUS1,
>> +				&db_err_cnt);
>> +	if (ret)
>> +		return ret;
>> +	db_err_cnt = (db_err_cnt & ECC_DB_ERR_COUNT_MASK);
>> +	edac_printk(KERN_CRIT, EDAC_LLCC, "Double-Bit error count: 0x%4x\n",
>> +		db_err_cnt);
>> +
>> +	ret = regmap_read(drv->regmap,
>> +		drv->offsets[bank] + TRP_ECC_ERROR_STATUS0, &db_err_ways);
>> +	if (ret)
>> +		return ret;
>> +	db_err_ways = (db_err_ways & ECC_DB_ERR_WAYS_MASK);
>> +	db_err_ways >>= ECC_DB_ERR_WAYS_SHIFT;
>> +
>> +	edac_printk(KERN_CRIT, EDAC_LLCC, "Double-Bit error ways: 0x%4x\n",
>> +		db_err_ways);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Dump syndrome register for tag Ram Single Bit Errors */
>> +static int dump_trp_sb_syn_reg(struct llcc_drv_data *drv, u32 bank)
>> +{
>> +	int i, ret;
>> +	int sb_err_cnt;
>> +	int sb_err_ways;
>> +	u32 synd_reg;
>> +	u32 synd_val;
>> +
>> +	for (i = 0; i < TRP_SYN_REG_CNT; i++) {
>> +		synd_reg = TRP_ECC_SB_ERR_SYN0 + (i * 4);
>> +		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
>> +					&synd_val);
>> +		if (ret)
>> +			return ret;
>> +		edac_printk(KERN_CRIT, EDAC_LLCC, "TRP_ECC_SYN%d: 0x%8x\n",
>> +				i, synd_val);
>> +	}
>> +
>> +	ret = regmap_read(drv->regmap,
>> +				drv->offsets[bank] + TRP_ECC_ERROR_STATUS1,
>> +				&sb_err_cnt);
>> +	if (ret)
>> +		return ret;
>> +	sb_err_cnt = (sb_err_cnt & ECC_SB_ERR_COUNT_MASK);
>> +	sb_err_cnt >>= ECC_SB_ERR_COUNT_SHIFT;
>> +	edac_printk(KERN_CRIT, EDAC_LLCC, "Single-Bit error count: 0x%4x\n",
>> +		sb_err_cnt);
>> +
>> +	ret = regmap_read(drv->regmap,
>> +				drv->offsets[bank] + TRP_ECC_ERROR_STATUS0,
>> +				&sb_err_ways);
>> +	if (ret)
>> +		return ret;
>> +
>> +	sb_err_ways = sb_err_ways & ECC_SB_ERR_WAYS_MASK;
>> +
>> +	edac_printk(KERN_CRIT, EDAC_LLCC, "Single-Bit error ways: 0x%4x\n",
>> +			sb_err_ways);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Dump syndrome registers for Data Ram Double bit errors */
>> +static int dump_drp_db_syn_reg(struct llcc_drv_data *drv, u32 bank)
>> +{
>> +	int i, ret;
>> +	int db_err_cnt;
>> +	int db_err_ways;
>> +	u32 synd_reg;
>> +	u32 synd_val;
>> +
>> +	for (i = 0; i < DRP_SYN_REG_CNT; i++) {
>> +		synd_reg = DRP_ECC_DB_ERR_SYN0 + (i * 4);
>> +		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
>> +					&synd_val);
>> +		if (ret)
>> +			return ret;
>> +		edac_printk(KERN_CRIT, EDAC_LLCC, "DRP_ECC_SYN%d: 0x%8x\n",
>> +				i, synd_val);
>> +	}
>> +
>> +	ret = regmap_read(drv->regmap,
>> +				drv->offsets[bank] + DRP_ECC_ERROR_STATUS1,
>> +				&db_err_cnt);
>> +	if (ret)
>> +		return ret;
>> +	db_err_cnt = (db_err_cnt & ECC_DB_ERR_COUNT_MASK);
>> +	edac_printk(KERN_CRIT, EDAC_LLCC, "Double-Bit error count: 0x%4x\n",
>> +		db_err_cnt);
>> +
>> +	ret = regmap_read(drv->regmap,
>> +				drv->offsets[bank] + DRP_ECC_ERROR_STATUS0,
>> +				&db_err_ways);
>> +	if (ret)
>> +		return ret;
>> +	db_err_ways &= ECC_DB_ERR_WAYS_MASK;
>> +	db_err_ways >>= ECC_DB_ERR_WAYS_SHIFT;
>> +	edac_printk(KERN_CRIT, EDAC_LLCC, "Double-Bit error ways: 0x%4x\n",
>> +		db_err_ways);
>> +
>> +	return ret;
>> +}
>> +
>> +/* Dump Syndrome registers for Data Ram Single bit errors*/
>> +static int dump_drp_sb_syn_reg(struct llcc_drv_data *drv, u32 bank)
>> +{
>> +	int i, ret;
>> +	int sb_err_cnt;
>> +	int sb_err_ways;
>> +	u32 synd_reg;
>> +	u32 synd_val;
>> +
>> +	for (i = 0; i < DRP_SYN_REG_CNT; i++) {
>> +		synd_reg = DRP_ECC_SB_ERR_SYN0 + (i * 4);
>> +		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
>> +					&synd_val);
>> +		if (ret)
>> +			return ret;
>> +		edac_printk(KERN_CRIT, EDAC_LLCC, "DRP_ECC_SYN%d: 0x%8x\n",
>> +				i, synd_val);
>> +	}
>> +
>> +	ret = regmap_read(drv->regmap,
>> +				drv->offsets[bank] + DRP_ECC_ERROR_STATUS1,
>> +				&sb_err_cnt);
>> +	if (ret)
>> +		return ret;
>> +	sb_err_cnt &= ECC_SB_ERR_COUNT_MASK;
>> +	sb_err_cnt >>= ECC_SB_ERR_COUNT_SHIFT;
>> +	edac_printk(KERN_CRIT, EDAC_LLCC, "Single-Bit error count: 0x%4x\n",
>> +		sb_err_cnt);
>> +
>> +	ret = regmap_read(drv->regmap,
>> +				drv->offsets[bank] + DRP_ECC_ERROR_STATUS0,
>> +				&sb_err_ways);
>> +	if (ret)
>> +		return ret;
>> +	sb_err_ways = sb_err_ways & ECC_SB_ERR_WAYS_MASK;
>> +
>> +	edac_printk(KERN_CRIT, EDAC_LLCC, "Single-Bit error ways: 0x%4x\n",
>> +		sb_err_ways);
>> +
>> +	return ret;
>> +}
>> +
>> +
> 
> one newline is enough.
Ok, I'll remove it.
> 
>> +static int dump_syn_reg(struct edac_device_ctl_info *edev_ctl,
>> +			 int err_type, u32 bank)
>> +{
>> +	int ret = 0;
>> +	struct llcc_drv_data *drv = edev_ctl->pvt_info;
>> +
>> +	switch (err_type) {
>> +	case LLCC_DRAM_CE:
>> +		ret = dump_drp_sb_syn_reg(drv, bank);
>> +		break;
>> +	case LLCC_DRAM_UE:
>> +		ret = dump_drp_db_syn_reg(drv, bank);
>> +		break;
>> +	case LLCC_TRAM_CE:
>> +		ret = dump_trp_sb_syn_reg(drv, bank);
>> +		break;
>> +	case LLCC_TRAM_UE:
>> +		ret = dump_trp_db_syn_reg(drv, bank);
>> +		break;
>> +	}
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = qcom_llcc_clear_errors(err_type, drv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	errors[err_type].func(edev_ctl, 0, bank, errors[err_type].msg);
>> +
>> +	return ret;
>> +}
>> +
>> +static irqreturn_t qcom_llcc_check_cache_errors
>> +		(struct edac_device_ctl_info *edev_ctl)
> 
> Please don't split the function name from the args.
Ok, I'll update this one.
> 
> static irqreturn_t
> qcom_llcc_check_cache_errors(struct edac_device_ctl_info *edev_ctl)
> 
> is a bit better, for example.
> 
>> +{
>> +	int ret;
>> +	u32 drp_error;
>> +	u32 trp_error;
>> +	struct llcc_drv_data *drv = edev_ctl->pvt_info;
>> +	u32 i;
>> +	irqreturn_t irq_rc = IRQ_NONE;
>> +
>> +	for (i = 0; i < drv->num_banks; i++) {
>> +		/* Look for Data RAM errors */
>> +		ret = regmap_read(drv->regmap,
>> +				drv->offsets[i] + DRP_INTERRUPT_STATUS,
>> +				&drp_error);
>> +		if (ret)
>> +			return irq_rc;
>> +
>> +		if (drp_error & SB_ECC_ERROR) {
>> +			edac_printk(KERN_CRIT, EDAC_LLCC,
>> +				"Single Bit Error detected in Data Ram\n");
>> +			dump_syn_reg(edev_ctl, LLCC_DRAM_CE, i);
>> +			irq_rc = IRQ_HANDLED;
>> +		} else if (drp_error & DB_ECC_ERROR) {
>> +			edac_printk(KERN_CRIT, EDAC_LLCC,
>> +				"Double Bit Error detected in Data Ram\n");
>> +			dump_syn_reg(edev_ctl, LLCC_DRAM_UE, i);
>> +			irq_rc = IRQ_HANDLED;
>> +		}
>> +
>> +		/* Look for Tag RAM errors */
>> +		ret = regmap_read(drv->regmap,
>> +				drv->offsets[i] + TRP_INTERRUPT_0_STATUS,
>> +				&trp_error);
>> +		if (ret)
>> +			return irq_rc;
>> +		if (trp_error & SB_ECC_ERROR) {
>> +			edac_printk(KERN_CRIT, EDAC_LLCC,
>> +				"Single Bit Error detected in Tag Ram\n");
>> +			dump_syn_reg(edev_ctl, LLCC_TRAM_CE, i);
>> +			irq_rc = IRQ_HANDLED;
>> +		} else if (trp_error & DB_ECC_ERROR) {
>> +			edac_printk(KERN_CRIT, EDAC_LLCC,
>> +				"Double Bit Error detected in Tag Ram\n");
>> +			dump_syn_reg(edev_ctl, LLCC_TRAM_UE, i);
>> +			irq_rc = IRQ_HANDLED;
>> +		}
>> +	}
>> +
>> +	return irq_rc;
>> +}
>> +
>> +static irqreturn_t llcc_ecc_irq_handler
>> +			(int irq, void *edev_ctl)
> 
> That looks like a useless wrapper, get rid of it.
Ok, Done.
> 
>> +{
>> +	return qcom_llcc_check_cache_errors(edev_ctl);
>> +}
>> +
>> +static int qcom_llcc_erp_probe(struct platform_device *pdev)
>> +{
>> +	int rc;
>> +	u32 ecc_irq;
>> +	struct edac_device_ctl_info *edev_ctl;
>> +	struct device *dev = &pdev->dev;
>> +	struct llcc_drv_data *llcc_driv_data = pdev->dev.platform_data;
> 
> Please sort function local variables declaration in a reverse christmas
> tree order:
> 
> 	<type> longest_variable_name;
> 	<type> shorter_var_name;
> 	<type> even_shorter;
> 	<type> i;
> 
> Ditto for the other functions.
Ok, I'll update it for all other functions too.

