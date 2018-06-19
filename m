Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B060B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="thlal+0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B060B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937669AbeFSLNi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:13:38 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:24769 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937314AbeFSLNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:13:36 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JBDXSt022482;
        Tue, 19 Jun 2018 06:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529406813;
        bh=Gt4ansNJqppfGc5TxMm1Fh4I4HO6vSrGP/vDMASm7xg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=thlal+0V72VGX+W7ByIDPp0ncSR/6MgGICsL0Q7SEYs6YMm5vHqd7BQ6T+mhWVWP4
         ACLsib8+zZkY5zT0L/iGJR3pucuMQC17JB16kjkAiL8sZKybg2N5EIpLAT6/8XjwhF
         UddFDxTV09FLvSA579/Szfy9hf5fEX6ChfD6nV5k=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JBDXKm018099;
        Tue, 19 Jun 2018 06:13:33 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 06:13:32 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 06:13:32 -0500
Received: from [172.22.219.203] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JBDSCL005185;
        Tue, 19 Jun 2018 06:13:29 -0500
Subject: Re: [PATCH 2/4] clk: clk: Add clk_dflt_restore
To:     Tero Kristo <t-kristo@ti.com>, <sboyd@kernel.org>,
        <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <d-gerlach@ti.com>
References: <1529382505-3069-1-git-send-email-j-keerthy@ti.com>
 <1529382505-3069-3-git-send-email-j-keerthy@ti.com>
 <e3ef633e-d506-58cf-b6f1-bae188dbe875@ti.com>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <b0651571-a30a-93b4-5a88-c9738239d35d@ti.com>
Date:   Tue, 19 Jun 2018 16:43:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e3ef633e-d506-58cf-b6f1-bae188dbe875@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2018 11:36 AM, Tero Kristo wrote:
> On 19/06/18 07:28, Keerthy wrote:
>> The default restore context function enables or disables
>> the clock based on the enable_count. This is done in cases
>> where the clock context is lost and based on the enable_count
>> the clock either needs to be enabled/disabled. This particularly
>> helps restore the state of gate clocks.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   drivers/clk/clk.c            | 19 +++++++++++++++++++
>>   include/linux/clk-provider.h |  2 ++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 7347e06..c201b8b 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -910,6 +910,25 @@ static int clk_core_enable_lock(struct clk_core 
>> *core)
>>       return ret;
>>   }
>> +/**
>> + * clk_dflt_restore_context - restore context for poweroff
>> + * @hw: the clk_hw pointer of clock whose state is to be restored
>> + *
>> + * The default restore context function enables or disables
>> + * the clock based on the enable_count. This is done in cases
>> + * where the clock context is lost and based on the enable_count
>> + * the clock either needs to be enabled/disabled. This particularly
>> + * helps restore the state of gate clocks.
>> + */
>> +void clk_dflt_restore_context(struct clk_hw *hw)
> 
> I think the name of this function is wrong, it should be 
> clk_gate_restore_context, as only gate clocks are ever going to be using 
> this afaics.

Okay. Yes this applies to gate clocks. I will fix this.

> 
> -Tero
> 
>> +{
>> +    if (hw->clk->core->enable_count)
>> +        hw->clk->core->ops->enable(hw);
>> +    else
>> +        hw->clk->core->ops->disable(hw);
>> +}
>> +EXPORT_SYMBOL_GPL(clk_dflt_restore_context);
>> +
>>   static int _clk_save_context(struct clk_core *clk)
>>   {
>>       struct clk_core *child;
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index 7f30d62..3e0c61a 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -992,5 +992,7 @@ static inline void clk_writel(u32 val, u32 __iomem 
>> *reg)
>>   #endif    /* platform dependent I/O accessors */
>> +void clk_dflt_restore_context(struct clk_hw *hw);
>> +
>>   #endif /* CONFIG_COMMON_CLK */
>>   #endif /* CLK_PROVIDER_H */
>>
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. 
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
