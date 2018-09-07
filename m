Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A26C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A3B2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RbrudgHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A3B2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbeIGWCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:02:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50192 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeIGWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:02:55 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w87HKQhc076405;
        Fri, 7 Sep 2018 12:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536340826;
        bh=TO5FVzDcH+dFEOSbAoyqecsSvTCpgmF6H5DB3gbkU8A=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=RbrudgHWXt8I+9ty/2fyN8PLV/8+6tSkmhvNzdteeZHGjfytNnNmwqzlCZocZQtsP
         XeaWDqSoOItxIQahQ7qE/FmjchcNzPX/IIjwlMDRFheRf10EEBwToWtburKyuZCdmt
         ToTGr+o0qDW4DY6JV5dyOJdgG7IO54fVOMb/KoOo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w87HKQBK000309;
        Fri, 7 Sep 2018 12:20:26 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 7 Sep
 2018 12:20:26 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 7 Sep 2018 12:20:25 -0500
Received: from [172.22.180.93] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w87HKPf4031735;
        Fri, 7 Sep 2018 12:20:25 -0500
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>, <sre@kernel.org>,
        <nekit1000@gmail.com>, <mpartap@gmx.net>, <merlijn@wizzup.org>,
        <lee.jones@linaro.org>
References: <20180829093108.GB22065@amd> <20180907093954.GA26364@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e10bdc74-8138-055e-c829-7befbc7161b4@ti.com>
Date:   Fri, 7 Sep 2018 12:20:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907093954.GA26364@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 09/07/2018 04:39 AM, Pavel Machek wrote:
> On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
>> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>
>> mfd: ti-lmu: constify mfd_cell tables
>>     
>> Add const attribute to all mfd_cell structures.
>>     
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> Lee, I guess this is for you to apply. Any news there?
> 
> There are more patches ready,

As I stated in another email thread.  I don't see the need for this level of LMU framework.

Here is the reference thread

https://lore.kernel.org/patchwork/patch/982550/

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v4.19
> 
> and it would be good to get them in. (Alternatively, you can just
> cherry-pick them from droid4-pending-v4.19).
> 
> Thanks,
> 							Pavel
> 							
> 
>> diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
>> index cfb411c..990437e 100644
>> --- a/drivers/mfd/ti-lmu.c
>> +++ b/drivers/mfd/ti-lmu.c
>> @@ -25,7 +25,7 @@
>>  #include <linux/slab.h>
>>  
>>  struct ti_lmu_data {
>> -	struct mfd_cell *cells;
>> +	const struct mfd_cell *cells;
>>  	int num_cells;
>>  	unsigned int max_register;
>>  };
>> @@ -63,7 +63,7 @@ static void ti_lmu_disable_hw(struct ti_lmu *lmu)
>>  		gpio_set_value(lmu->en_gpio, 0);
>>  }
>>  
>> -static struct mfd_cell lm3532_devices[] = {
>> +static const struct mfd_cell lm3532_devices[] = {
>>  	{
>>  		.name          = "ti-lmu-backlight",
>>  		.id            = LM3532,
>> @@ -78,7 +78,7 @@ static struct mfd_cell lm3532_devices[] = {
>>  	.of_compatible = "ti,lm363x-regulator",	\
>>  }						\
>>  
>> -static struct mfd_cell lm3631_devices[] = {
>> +static const struct mfd_cell lm3631_devices[] = {
>>  	LM363X_REGULATOR(LM3631_BOOST),
>>  	LM363X_REGULATOR(LM3631_LDO_CONT),
>>  	LM363X_REGULATOR(LM3631_LDO_OREF),
>> @@ -91,7 +91,7 @@ static struct mfd_cell lm3631_devices[] = {
>>  	},
>>  };
>>  
>> -static struct mfd_cell lm3632_devices[] = {
>> +static const struct mfd_cell lm3632_devices[] = {
>>  	LM363X_REGULATOR(LM3632_BOOST),
>>  	LM363X_REGULATOR(LM3632_LDO_POS),
>>  	LM363X_REGULATOR(LM3632_LDO_NEG),
>> @@ -102,7 +102,7 @@ static struct mfd_cell lm3632_devices[] = {
>>  	},
>>  };
>>  
>> -static struct mfd_cell lm3633_devices[] = {
>> +static const struct mfd_cell lm3633_devices[] = {
>>  	{
>>  		.name          = "ti-lmu-backlight",
>>  		.id            = LM3633,
>> @@ -120,7 +120,7 @@ static struct mfd_cell lm3633_devices[] = {
>>  	},
>>  };
>>  
>> -static struct mfd_cell lm3695_devices[] = {
>> +static const struct mfd_cell lm3695_devices[] = {
>>  	{
>>  		.name          = "ti-lmu-backlight",
>>  		.id            = LM3695,
>> @@ -128,7 +128,7 @@ static struct mfd_cell lm3695_devices[] = {
>>  	},
>>  };
>>  
>> -static struct mfd_cell lm3697_devices[] = {
>> +static const struct mfd_cell lm3697_devices[] = {
>>  	{
>>  		.name          = "ti-lmu-backlight",
>>  		.id            = LM3697,
>>
> 
> 
> 


-- 
------------------
Dan Murphy
