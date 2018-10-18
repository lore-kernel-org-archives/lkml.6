Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C297E21486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C297E21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeJSBBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:01:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728554AbeJSBBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:01:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD1E3B03A;
        Thu, 18 Oct 2018 16:59:52 +0000 (UTC)
Subject: Re: [PATCH v3 lora-next 1/5] regmap: Add regmap_noinc_write API
To:     Ben Whitten <ben.whitten@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     starnight@g.ncu.edu.tw, hasnain.virk@arm.com,
        netdev@vger.kernel.org, liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Stefan Rehm <rehm@miromico.ch>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-2-git-send-email-ben.whitten@lairdtech.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <2908e406-a2e3-29cb-579c-949ddd383e97@suse.de>
Date:   Thu, 18 Oct 2018 18:59:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539361567-3602-2-git-send-email-ben.whitten@lairdtech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.10.18 um 18:26 schrieb Ben Whitten:
> The regmap API had a noinc_read function added for instances where devices
> supported returning data from an internal FIFO in a single read.
> 
> This commit adds the noinc_write variant to allow writing to a non
> incrementing register, this is used in devices such as the sx1301 for
> loading firmware.
> 
> Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>

Reviewed-by: Andreas Färber <afaerber@suse.de>

Mark, please take this one through your tree - I'll rebase the LoRa
parts on linux-next then.

Thanks,
Andreas

> ---
>  drivers/base/regmap/internal.h |  3 ++
>  drivers/base/regmap/regmap.c   | 77 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/regmap.h         | 19 +++++++++++
>  3 files changed, 99 insertions(+)
> 
> diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
> index a6bf34d63..404f123 100644
> --- a/drivers/base/regmap/internal.h
> +++ b/drivers/base/regmap/internal.h
> @@ -94,11 +94,13 @@ struct regmap {
>  	bool (*readable_reg)(struct device *dev, unsigned int reg);
>  	bool (*volatile_reg)(struct device *dev, unsigned int reg);
>  	bool (*precious_reg)(struct device *dev, unsigned int reg);
> +	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
>  	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
>  	const struct regmap_access_table *wr_table;
>  	const struct regmap_access_table *rd_table;
>  	const struct regmap_access_table *volatile_table;
>  	const struct regmap_access_table *precious_table;
> +	const struct regmap_access_table *wr_noinc_table;
>  	const struct regmap_access_table *rd_noinc_table;
>  
>  	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
> @@ -183,6 +185,7 @@ bool regmap_writeable(struct regmap *map, unsigned int reg);
>  bool regmap_readable(struct regmap *map, unsigned int reg);
>  bool regmap_volatile(struct regmap *map, unsigned int reg);
>  bool regmap_precious(struct regmap *map, unsigned int reg);
> +bool regmap_writeable_noinc(struct regmap *map, unsigned int reg);
>  bool regmap_readable_noinc(struct regmap *map, unsigned int reg);
>  
>  int _regmap_write(struct regmap *map, unsigned int reg,
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 0360a90..d4f1fc6 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -168,6 +168,17 @@ bool regmap_precious(struct regmap *map, unsigned int reg)
>  	return false;
>  }
>  
> +bool regmap_writeable_noinc(struct regmap *map, unsigned int reg)
> +{
> +	if (map->writeable_noinc_reg)
> +		return map->writeable_noinc_reg(map->dev, reg);
> +
> +	if (map->wr_noinc_table)
> +		return regmap_check_range_table(map, reg, map->wr_noinc_table);
> +
> +	return true;
> +}
> +
>  bool regmap_readable_noinc(struct regmap *map, unsigned int reg)
>  {
>  	if (map->readable_noinc_reg)
> @@ -777,11 +788,13 @@ struct regmap *__regmap_init(struct device *dev,
>  	map->rd_table = config->rd_table;
>  	map->volatile_table = config->volatile_table;
>  	map->precious_table = config->precious_table;
> +	map->wr_noinc_table = config->wr_noinc_table;
>  	map->rd_noinc_table = config->rd_noinc_table;
>  	map->writeable_reg = config->writeable_reg;
>  	map->readable_reg = config->readable_reg;
>  	map->volatile_reg = config->volatile_reg;
>  	map->precious_reg = config->precious_reg;
> +	map->writeable_noinc_reg = config->writeable_noinc_reg;
>  	map->readable_noinc_reg = config->readable_noinc_reg;
>  	map->cache_type = config->cache_type;
>  
> @@ -1298,6 +1311,7 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
>  	map->readable_reg = config->readable_reg;
>  	map->volatile_reg = config->volatile_reg;
>  	map->precious_reg = config->precious_reg;
> +	map->writeable_noinc_reg = config->writeable_noinc_reg;
>  	map->readable_noinc_reg = config->readable_noinc_reg;
>  	map->cache_type = config->cache_type;
>  
> @@ -1898,6 +1912,69 @@ int regmap_raw_write(struct regmap *map, unsigned int reg,
>  EXPORT_SYMBOL_GPL(regmap_raw_write);
>  
>  /**
> + * regmap_noinc_write(): Write data from a register without incrementing the
> + *			register number
> + *
> + * @map: Register map to write to
> + * @reg: Register to write to
> + * @val: Pointer to data buffer
> + * @val_len: Length of output buffer in bytes.
> + *
> + * The regmap API usually assumes that bulk bus write operations will write a
> + * range of registers. Some devices have certain registers for which a write
> + * operation can write to an internal FIFO.
> + *
> + * The target register must be volatile but registers after it can be
> + * completely unrelated cacheable registers.
> + *
> + * This will attempt multiple writes as required to write val_len bytes.
> + *
> + * A value of zero will be returned on success, a negative errno will be
> + * returned in error cases.
> + */
> +int regmap_noinc_write(struct regmap *map, unsigned int reg,
> +		      const void *val, size_t val_len)
> +{
> +	size_t write_len;
> +	int ret;
> +
> +	if (!map->bus)
> +		return -EINVAL;
> +	if (!map->bus->write)
> +		return -ENOTSUPP;
> +	if (val_len % map->format.val_bytes)
> +		return -EINVAL;
> +	if (!IS_ALIGNED(reg, map->reg_stride))
> +		return -EINVAL;
> +	if (val_len == 0)
> +		return -EINVAL;
> +
> +	map->lock(map->lock_arg);
> +
> +	if (!regmap_volatile(map, reg) || !regmap_writeable_noinc(map, reg)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	while (val_len) {
> +		if (map->max_raw_write && map->max_raw_write < val_len)
> +			write_len = map->max_raw_write;
> +		else
> +			write_len = val_len;
> +		ret = _regmap_raw_write(map, reg, val, write_len);
> +		if (ret)
> +			goto out_unlock;
> +		val = ((u8 *)val) + write_len;
> +		val_len -= write_len;
> +	}
> +
> +out_unlock:
> +	map->unlock(map->lock_arg);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(regmap_noinc_write);
> +
> +/**
>   * regmap_field_update_bits_base() - Perform a read/modify/write cycle a
>   *                                   register field.
>   *
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index 379505a..de04dc4 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -268,6 +268,13 @@ typedef void (*regmap_unlock)(void *);
>   *                field is NULL but precious_table (see below) is not, the
>   *                check is performed on such table (a register is precious if
>   *                it belongs to one of the ranges specified by precious_table).
> + * @writeable_noinc_reg: Optional callback returning true if the register
> + *			supports multiple write operations without incrementing
> + *			the register number. If this field is NULL but
> + *			wr_noinc_table (see below) is not, the check is
> + *			performed on such table (a register is no increment
> + *			writeable if it belongs to one of the ranges specified
> + *			by wr_noinc_table).
>   * @readable_noinc_reg: Optional callback returning true if the register
>   *			supports multiple read operations without incrementing
>   *			the register number. If this field is NULL but
> @@ -302,6 +309,7 @@ typedef void (*regmap_unlock)(void *);
>   * @rd_table:     As above, for read access.
>   * @volatile_table: As above, for volatile registers.
>   * @precious_table: As above, for precious registers.
> + * @wr_noinc_table: As above, for no increment writeable registers.
>   * @rd_noinc_table: As above, for no increment readable registers.
>   * @reg_defaults: Power on reset values for registers (for use with
>   *                register cache support).
> @@ -352,6 +360,7 @@ struct regmap_config {
>  	bool (*readable_reg)(struct device *dev, unsigned int reg);
>  	bool (*volatile_reg)(struct device *dev, unsigned int reg);
>  	bool (*precious_reg)(struct device *dev, unsigned int reg);
> +	bool (*writeable_noinc_reg)(struct device *dev, unsigned int reg);
>  	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
>  
>  	bool disable_locking;
> @@ -369,6 +378,7 @@ struct regmap_config {
>  	const struct regmap_access_table *rd_table;
>  	const struct regmap_access_table *volatile_table;
>  	const struct regmap_access_table *precious_table;
> +	const struct regmap_access_table *wr_noinc_table;
>  	const struct regmap_access_table *rd_noinc_table;
>  	const struct reg_default *reg_defaults;
>  	unsigned int num_reg_defaults;
> @@ -979,6 +989,8 @@ int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
>  int regmap_write_async(struct regmap *map, unsigned int reg, unsigned int val);
>  int regmap_raw_write(struct regmap *map, unsigned int reg,
>  		     const void *val, size_t val_len);
> +int regmap_noinc_write(struct regmap *map, unsigned int reg,
> +		     const void *val, size_t val_len);
>  int regmap_bulk_write(struct regmap *map, unsigned int reg, const void *val,
>  			size_t val_count);
>  int regmap_multi_reg_write(struct regmap *map, const struct reg_sequence *regs,
> @@ -1222,6 +1234,13 @@ static inline int regmap_raw_write_async(struct regmap *map, unsigned int reg,
>  	return -EINVAL;
>  }
>  
> +static inline int regmap_noinc_write(struct regmap *map, unsigned int reg,
> +				    const void *val, size_t val_len)
> +{
> +	WARN_ONCE(1, "regmap API is disabled");
> +	return -EINVAL;
> +}
> +
>  static inline int regmap_bulk_write(struct regmap *map, unsigned int reg,
>  				    const void *val, size_t val_count)
>  {
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
