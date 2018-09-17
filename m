Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88D6ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D3E214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FvSo3SuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D3E214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeIRCG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:06:26 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58024 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIRCG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:06:26 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8HKbJE0125421;
        Mon, 17 Sep 2018 15:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537216639;
        bh=bEbhqcxK+DIJuaCXLIiskaxUGGWiG+qfbUS1gJSnkP0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FvSo3SuQJ5CBmlyPrTrsjYz22zL8+1QBp5ZQJubpVWBFwkykTHY+LVVeFSLMRPYnY
         0dxYXnIRteQK/cTBGeniZTb//BErTNJ8cMduuC8h43LvtnWV8Utv+LbZGxx2bxGbvC
         N7PMityCA7cA1gHGs7CSct4S5iwLj6ICTMQXzFeA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8HKbJUt012332;
        Mon, 17 Sep 2018 15:37:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 17
 Sep 2018 15:37:19 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 17 Sep 2018 15:37:19 -0500
Received: from [172.22.136.27] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8HKbI1E008146;
        Mon, 17 Sep 2018 15:37:18 -0500
Subject: Re: [PATCH] power: supply: bq27xxx: Add support for BQ27411
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Liu Xiang <liu.xiang6@zte.com.cn>
CC:     <pali.rohar@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxiang_1999@126.com>
References: <1532266436-20182-1-git-send-email-liu.xiang6@zte.com.cn>
 <20180916113523.fq4n7nsasigy3wyg@earth.universe>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <3da8eff1-3d4a-4515-c855-34aececc4d71@ti.com>
Date:   Mon, 17 Sep 2018 15:37:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180916113523.fq4n7nsasigy3wyg@earth.universe>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/16/2018 06:35 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Jul 22, 2018 at 09:33:56PM +0800, Liu Xiang wrote:
>> According to the datasheet, bq27411 is similar to bq27421.
>>
>> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
>> ---
> 
> Looks good to me. Do you plan to test/review this Andrew, or
> should I proceed with merging this patch?
> 


I do not have this particular hardware for testing, but the patch does
look correct,

Reviewed-by: Andrew F. Davis <afd@ti.com>


> -- Sebastian
> 
>>  Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 1 +
>>  drivers/power/supply/bq27xxx_battery.c                     | 9 +++++++++
>>  drivers/power/supply/bq27xxx_battery_i2c.c                 | 2 ++
>>  include/linux/power/bq27xxx_battery.h                      | 1 +
>>  4 files changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> index 37994fd..4fa8e08 100644
>> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
>> @@ -23,6 +23,7 @@ Required properties:
>>   * "ti,bq27546" - BQ27546
>>   * "ti,bq27742" - BQ27742
>>   * "ti,bq27545" - BQ27545
>> + * "ti,bq27411" - BQ27411
>>   * "ti,bq27421" - BQ27421
>>   * "ti,bq27425" - BQ27425
>>   * "ti,bq27426" - BQ27426
>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>> index f022e1b..6dbbe95 100644
>> --- a/drivers/power/supply/bq27xxx_battery.c
>> +++ b/drivers/power/supply/bq27xxx_battery.c
>> @@ -432,6 +432,7 @@ enum bq27xxx_reg_index {
>>  		[BQ27XXX_REG_AP] = 0x18,
>>  		BQ27XXX_DM_REG_ROWS,
>>  	};
>> +#define bq27411_regs bq27421_regs
>>  #define bq27425_regs bq27421_regs
>>  #define bq27426_regs bq27421_regs
>>  #define bq27441_regs bq27421_regs
>> @@ -665,6 +666,7 @@ enum bq27xxx_reg_index {
>>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>>  	POWER_SUPPLY_PROP_MANUFACTURER,
>>  };
>> +#define bq27411_props bq27421_props
>>  #define bq27425_props bq27421_props
>>  #define bq27426_props bq27421_props
>>  #define bq27441_props bq27421_props
>> @@ -725,6 +727,12 @@ enum bq27xxx_dm_reg_id {
>>  #define bq27545_dm_regs 0
>>  #endif
>>  
>> +static struct bq27xxx_dm_reg bq27411_dm_regs[] = {
>> +	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0, 32767 },
>> +	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2800,  3700 },
>> +};
>> +
>>  static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
>>  	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
>>  	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
>> @@ -802,6 +810,7 @@ enum bq27xxx_dm_reg_id {
>>  	[BQ27546]   = BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
>>  	[BQ27742]   = BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
>>  	[BQ27545]   = BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
>> +	[BQ27411]   = BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>>  	[BQ27421]   = BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>>  	[BQ27425]   = BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
>>  	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
>> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
>> index 4006912..2677c38 100644
>> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
>> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
>> @@ -247,6 +247,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
>>  	{ "bq27546", BQ27546 },
>>  	{ "bq27742", BQ27742 },
>>  	{ "bq27545", BQ27545 },
>> +	{ "bq27411", BQ27411 },
>>  	{ "bq27421", BQ27421 },
>>  	{ "bq27425", BQ27425 },
>>  	{ "bq27426", BQ27426 },
>> @@ -279,6 +280,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
>>  	{ .compatible = "ti,bq27546" },
>>  	{ .compatible = "ti,bq27742" },
>>  	{ .compatible = "ti,bq27545" },
>> +	{ .compatible = "ti,bq27411" },
>>  	{ .compatible = "ti,bq27421" },
>>  	{ .compatible = "ti,bq27425" },
>>  	{ .compatible = "ti,bq27426" },
>> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
>> index d6355f4..507c5e2 100644
>> --- a/include/linux/power/bq27xxx_battery.h
>> +++ b/include/linux/power/bq27xxx_battery.h
>> @@ -24,6 +24,7 @@ enum bq27xxx_chip {
>>  	BQ27546,
>>  	BQ27742,
>>  	BQ27545, /* bq27545 */
>> +	BQ27411,
>>  	BQ27421, /* bq27421, bq27441, bq27621 */
>>  	BQ27425,
>>  	BQ27426,
>> -- 
>> 1.9.1
>>
