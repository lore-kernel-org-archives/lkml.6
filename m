Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6991C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870F521773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tVFnDAex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfBSQzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:55:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53434 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBSQzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:55:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1JGtdUj128305;
        Tue, 19 Feb 2019 10:55:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550595339;
        bh=M44LB+PRNgBsgOFKtCI0Ekh3VGZmiezY7ckDfddy4bc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tVFnDAexACYNn4qjvpdoGdvwT2Q2KhEcTz82uskd5yGFbMfbV89WKPKBk42pStqnJ
         R0imCGXR4qIOr0AxYBSLgXyjRYY9Cu4MQNeCquKcT6J6GEb27vR4P7kzvVcdrTeY/y
         6xGxGqKNBFH3QsT4Xh41xrHSANOiS2zRh4rIdVDE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1JGtddb032783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 10:55:39 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 10:55:38 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 10:55:38 -0600
Received: from [172.22.103.104] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1JGtbUE013939;
        Tue, 19 Feb 2019 10:55:38 -0600
Subject: Re: [PATCH] bq27x00: use cached flags
To:     Arthur Demchenkov <spinal.by@gmail.com>
CC:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190218065920.16205-1-spinal.by@gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <be028fd4-f05b-4357-d693-46e226b0f2c7@ti.com>
Date:   Tue, 19 Feb 2019 10:55:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190218065920.16205-1-spinal.by@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 12:59 AM, Arthur Demchenkov wrote:
> The flags were just read by bq27xxx_battery_update(),
> no need to read them again.
> 
> Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
> ---

Nothing obviously wrong with this patch so:

Reviewed-by: Andrew F. Davis <afd@ti.com>

At this point we have W1 regmap and so we now have everything we should
need to convert this driver over to regmap. Then the caching comes for
free and a lot of checks and such can be dropped.

Thanks,
Andrew

>  drivers/power/supply/bq27xxx_battery.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 6dbbe95844a3..29b3a4056865 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1555,27 +1555,14 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
>  		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
>  }
>  
> -/*
> - * Read flag register.
> - * Return < 0 if something fails.
> - */
>  static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
>  {
> -	int flags;
> -	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
> -
> -	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> -	if (flags < 0) {
> -		dev_err(di->dev, "error reading flag register:%d\n", flags);
> -		return flags;
> -	}
> -
>  	/* Unlikely but important to return first */
> -	if (unlikely(bq27xxx_battery_overtemp(di, flags)))
> +	if (unlikely(bq27xxx_battery_overtemp(di, di->cache.flags)))
>  		return POWER_SUPPLY_HEALTH_OVERHEAT;
> -	if (unlikely(bq27xxx_battery_undertemp(di, flags)))
> +	if (unlikely(bq27xxx_battery_undertemp(di, di->cache.flags)))
>  		return POWER_SUPPLY_HEALTH_COLD;
> -	if (unlikely(bq27xxx_battery_dead(di, flags)))
> +	if (unlikely(bq27xxx_battery_dead(di, di->cache.flags)))
>  		return POWER_SUPPLY_HEALTH_DEAD;
>  
>  	return POWER_SUPPLY_HEALTH_GOOD;
> @@ -1612,6 +1599,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  			cache.capacity = bq27xxx_battery_read_soc(di);
>  			if (di->regs[BQ27XXX_REG_AE] != INVALID_REG_ADDR)
>  				cache.energy = bq27xxx_battery_read_energy(di);
> +			di->cache.flags = cache.flags;
>  			cache.health = bq27xxx_battery_read_health(di);
>  		}
>  		if (di->regs[BQ27XXX_REG_CYCT] != INVALID_REG_ADDR)
> 
