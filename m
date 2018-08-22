Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB356C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665B5214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WRvJd2sC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665B5214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeHVOck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:32:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35950 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbeHVOck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:32:40 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7MB7tR7001738;
        Wed, 22 Aug 2018 06:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534936075;
        bh=gf4J1Xn8qCdZ5qRyHfC8Z3uovce7hc2tU9H/qgtLzK8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WRvJd2sC1MtMjrA2ErZtJJFYhislcLEC8yPQI0Bk9xmMgUZNeSClM3z98V1rM6MwQ
         nPaAZ/samH8qXADNHi4QHaGctjKtRuOCS6VWhx6ooDJQ96i1b65KLnBYifahIz7Tgq
         DW9evdTaK9PdKehlsdYG8QBxzd55Xxe05ixZJA1I=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7MB7tho025797;
        Wed, 22 Aug 2018 06:07:55 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 22
 Aug 2018 06:07:54 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 22 Aug 2018 06:07:54 -0500
Received: from [172.22.219.113] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7MB7mxZ009823;
        Wed, 22 Aug 2018 06:07:50 -0500
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which it
 is functional
To:     Johan Hovold <johan@kernel.org>, <tony@atomide.com>
CC:     <d-gerlach@ti.com>, <linux-kernel@vger.kernel.org>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
 <20180822073409.GK14967@localhost> <20180822073719.GL14967@localhost>
 <ae71d45f-9260-3547-5ff2-355c084fcf8e@ti.com>
 <20180822084318.GN14967@localhost>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <335b4efe-ab18-df83-35f2-ee232c09f2e3@ti.com>
Date:   Wed, 22 Aug 2018 16:37:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822084318.GN14967@localhost>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2018 2:13 PM, Johan Hovold wrote:
> On Wed, Aug 22, 2018 at 01:50:29PM +0530, J, KEERTHY wrote:
>>
>>
>> On 8/22/2018 1:07 PM, Johan Hovold wrote:
>>> On Wed, Aug 22, 2018 at 09:34:09AM +0200, Johan Hovold wrote:
>>>> On Wed, Aug 22, 2018 at 11:02:31AM +0530, Keerthy wrote:
>>>>> Enable DS0 for only those platforms on which it is functional
>>>>>
>>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>>> ---
>>>>>    arch/arm/mach-omap2/pm33xx-core.c    | 5 +++++
>>>>>    drivers/soc/ti/pm33xx.c              | 9 +++++++++
>>>>>    include/linux/platform_data/pm33xx.h | 2 ++
>>>>>    3 files changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
>>>>> index f4971e4..f0f6e8e 100644
>>>>> --- a/arch/arm/mach-omap2/pm33xx-core.c
>>>>> +++ b/arch/arm/mach-omap2/pm33xx-core.c
>>>>> @@ -135,6 +135,11 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
>>>>>    {
>>>>>    	int ret = 0;
>>>>>    
>>>>> +	if (!(args & WFI_FLAG_DEEP_SLEEP0)) {
>>>>> +		pr_err("DS0 mode not supported\n");
>>>>> +		return -ENOTSUPP;
>>>>> +	}
>>>>> +
>>>>>    	amx3_pre_suspend_common();
>>>>>    	scu_power_mode(scu_base, SCU_PM_POWEROFF);
>>>>>    	ret = cpu_suspend(args, fn);
>>>>> diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
>>>>> index d0dab32..53238d7 100644
>>>>> --- a/drivers/soc/ti/pm33xx.c
>>>>> +++ b/drivers/soc/ti/pm33xx.c
>>>>> @@ -324,6 +324,15 @@ static int am33xx_pm_probe(struct platform_device *pdev)
>>>>>    	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
>>>>>    	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
>>>>>    
>>>>> +	/*
>>>>> +	 * Deep Sleep0 mode is currently functional only on am437x-gp-evm,
>>>>> +	 * am33xx-evm and boneblack family. Hence set the DS0 flag
>>>>> +	 */
>>>>> +	if (of_machine_is_compatible("ti,am437x-gp-evm") ||
>>>>> +	    of_machine_is_compatible("ti,am335x-bone-black") ||
>>>>> +	    of_machine_is_compatible("ti,am335x-evm"))
>>>>> +		suspend_wfi_flags |= WFI_FLAG_DEEP_SLEEP0;
>>>>
>>>> What about other (out-of-tree) machines which supports DS0 and which
>>>> this change would break?
>>>>
>>>> I think this needs to be a blacklist if anything.
>>>>
>>>> Please also expand in the commit message why you think this is needed.
>>
>> Currently when one does echo mem > /sys/power/state on unsuppored
>> machines there can be a crash or a hang. So bail out with a message.
> 
> Yes, but why is this unsupported on some machines? Which machines, and
> why? Your commit messages should be self-contained and hold the
> information needed to determine whether your patch makes sense in the
> first place.

Okay

> 
>>>> Last, what tree is this against? There's no am43xx_suspend() in
>>>> linux-next (and you add compatibles above for am33xx too).
>>>
>>> Sorry, there is indeed an am43xx_suspend(), but you are adding
>>> compatibles for am33xx which use am33xx_suspend().
>>
>> am33xx_pm_probe is a common probe function for both am33 and am43.
> 
> Yes, but you add a check for your new flag only to am43xx_suspend(), not
> to am33xx_suspend() which is used by the am33xx compatibles you add.

Got it. I will add a check there as well.

> 
>> AFAIK for am33 family am335x-evm and am335x-bone-black support Deep
>> Sleep mode. For am43 family am43tx-gp-evm alone supports at the moment.
> 
> But these are development boards (EVKs), not SOC families (or
> chip revisions). What about all the products that customers to TI who
> have bought these SoCs have built?
> 
>> Can you let me know of other am33 machines that support DS0 mode?
> 
> I have a customer who use DS0, whose DTS is not yet in mainline, and
> whose setup this patch would break for example.

okay

> 
>> I could have simply used ti,am33xx compatible which covers entire am33
>> family but then am33xx-bone (bone white) does not support this mode.
> 
> Yes, and a blacklist would make much more sense for something like this
> if where talking about specific boards.
> 
> Also note that your patch doesn't even handle bone-white as you didn't
> add a check to am33xx_suspend() as I pointed out above.

Tony,

Black list is easier here?

Regards,
Keerthy
> 
> Johan
> 
