Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336E0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04232218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pwToANPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBKMMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:12:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52144 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfBKMMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:12:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1BCBV8B065230;
        Mon, 11 Feb 2019 06:11:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549887091;
        bh=nLJGr9HIid9oerfAWo/iG+WzCc+bgoeRiLmuDD+BNEo=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=pwToANPy/KXa1swN6MLuiyHoWKt9Jn4bwn/ycJ9Ci8WJXy+yibef+Gn3Se3tuTChO
         94LjTqUhU+rlhrwqqnjgzHzxtC1lRTFNPjIzbEzhG/kLCKH9+ASwjGTv1JSdQWyuaT
         wsr1qUrcvLFnEuR6bWdHHT6KmbwbZrx/V2CQJBoY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1BCBVec128838
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 06:11:31 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 11
 Feb 2019 06:11:29 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 11 Feb 2019 06:11:29 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1BCBQ5D010534;
        Mon, 11 Feb 2019 06:11:26 -0600
Subject: Re: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
To:     Tony Lindgren <tony@atomide.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-3-git-send-email-rogerq@ti.com>
 <20190204180031.GL5720@atomide.com>
CC:     <s-anna@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <david@lechnology.com>,
        <woods.technical@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C61666D.3030308@ti.com>
Date:   Mon, 11 Feb 2019 14:11:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190204180031.GL5720@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On 04/02/19 20:00, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190204 15:54]:
>> +static int sysc_enable_pruss(struct sysc *sysc)
>> +{
>> +	int i;
>> +	u32 reg;
>> +	bool ready;
>> +
>> +	/* configure for Smart Idle & Smart Standby */
>> +	reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
>> +	reg &= ~(SYSC_PRUSS_STANDBY_MASK | SYSC_PRUSS_IDLE_MASK);
>> +	reg |= SYSC_PRUSS_STANDBY_SMART | SYSC_IDLE_SMART;
>> +	sysc_write(sysc, sysc->offsets[SYSC_SYSCONFIG], reg);
> 
> I think you can get rid of the SYSC_PRUSS_ defines here
> if you define the bits for it in struct sysc_regbits. The
> idle modes are SYSC_IDLE_* defines we already have in
> include/dt-bindings/bus/ti-sysc.h.
> 
> My guess is these will just become generic sysc_enable()
> and sysc_disable() functions :)
> 
> If you need module specific handling, you could add function
> pointers for enable and disable to struct sysc_capabilities.

OK. I'll move all this to a generic handler then.
> 
>> @@ -649,6 +693,9 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
>>  		goto idled;
>>  	}
>>  
>> +	if (ddata->cap->type == TI_SYSC_PRUSS)
>> +		sysc_disable_pruss(ddata);
>> +
>>  	for (i = 0; i < ddata->nr_clocks; i++) {
>>  		if (IS_ERR_OR_NULL(ddata->clocks[i]))
>>  			continue;
> 
> Ideally this would be just unconditional call to generic
> sysc_disable() here for non-legacy mode. Then if module
> specific enable and disable are there, sysc_enable() and
> disable() can call them.

OK.

> 
>> +static const struct sysc_regbits sysc_regbits_pruss = {
>> +	.midle_shift = -ENODEV,
>> +	.clkact_shift = -ENODEV,
>> +	.sidle_shift = -ENODEV,
>> +	.enwkup_shift = -ENODEV,
>> +	.srst_shift = -ENODEV,
>> +	.autoidle_shift = -ENODEV,
>> +	.dmadisable_shift = -ENODEV,
>> +	.emufree_shift = -ENODEV,
>> +};
> 
> So it seems you should populate at least midle_shift and sidle_shift
> bits here as in PRUSS_SYSCFG. I think STANDBY_MODE offset should go
> into the .midle_shift as it mentions initiator in TRM, and IDLE_MODE
> offset should go into .sidle_shift. So this might be really just using
> sysc_regbits_omap4_simple except it has an additional STANDBY_INIT
> bit which you could add for struct sysc_regbits if we don't have
> something similar already.

Got it.

> 
>> @@ -1702,6 +1772,10 @@ static int sysc_probe(struct platform_device *pdev)
>>  
>>  	INIT_DELAYED_WORK(&ddata->idle_work, ti_sysc_idle);
>>  
>> +	/* FIXME: how to ensure PRUSS stays enabled? */
>> +	if (ddata->cap->type == TI_SYSC_PRUSS)
>> +		goto skip_pm_put;
>> +

This was my bad. I forgot to move the pm_runtime_enable/get from the old
pruss_soc_bus.c to pruss.c :). It work after than and this hack is not required.

>>  	/* At least earlycon won't survive without deferred idle */
>>  	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE_ON_INIT |
>>  				 SYSC_QUIRK_NO_RESET_ON_INIT)) {
> 
> Hmm so do you need to specify ti,no-idle-on-init or what's
> the logic needed here?

I was using "ti,no-reset-on-init" but that was because sysc_reset() was returning error
due to missing syss mask. That can be fixed like so.

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 5b9c81a..f5f2000 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -941,6 +941,7 @@ static int sysc_reset(struct sysc *ddata)
 	int val;
 
 	if (ddata->legacy_mode || offset < 0 ||
+	    ddata->cap->regbits->srst_shift == -ENODEV ||
 	    ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
 		return 0;


> 
>> diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
>> index 8ec78e8..7138384 100644
>> --- a/include/dt-bindings/bus/ti-sysc.h
>> +++ b/include/dt-bindings/bus/ti-sysc.h
>> @@ -17,17 +17,6 @@
>>  
>>  #define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
>>  
>> -/* SYSCONFIG specific to PRUSS */
>> -#define SYSC_PRUSS_SUB_MWAIT		(1 << 5)
>> -#define SYSC_PRUSS_STANDBY_INIT		(1 << 4)
>> -
>> -#define SYSC_PRUSS_STANDBY_FORCE	(0 << 2)
>> -#define SYSC_PRUSS_STANDBY_NO		(1 << 2)
>> -#define SYSC_PRUSS_STANDBY_SMART	(2 << 2)
>> -#define SYSC_PRUSS_STANDBY_MASK		(3 << 2)
>> -
>> -#define SYSC_PRUSS_IDLE_MASK		3
>> -
>>  /* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
>>  #define SYSC_IDLE_FORCE			0
>>  #define SYSC_IDLE_NO			1
> 
> I suggest you make this series independent of the
> rest of the PRUSS patches as we can add this
> separately. So no need to define these bits at all
> AFAIK.

OK. Thanks.

cheers,
-roger

> 
> Regards,
> 
> Tony
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
