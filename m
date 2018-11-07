Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA05C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AF52086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WI1rH4zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AF52086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbeKHCKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:10:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37066 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbeKHCKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DHAJ0zvB14+CJMMTneQbUri14hu/yYe6nqPTJT8OobI=; b=WI1rH4zEOgXL4vKfjpBV6Yl7k/
        dAgtVuEmAbQqDXukOeYcB1fipwJbN7y9HqChi4Iti+lVK9pg9xapnOM3R3XVrXwHoS2dx7rk+czrb
        fC9s6K9RoTHCWpaQO57lwpaz5hcaEVRwwsobFG1eEC3Fw6fWBsH7D8YgZYnPfewyrBwf2MCgXyFZR
        TaH0yERQ+n/pd6CzjECadi1l4lCpsEQWENoFaEYiicJkMw+eYTUfuM+vv3/79v/+d7coi2j6hpxAJ
        zwO/J1IaczzB4kZFaFxZJX6Zoz5TZeT2+ap5PxB73W5RSpv5F17YbZSzjLjOSefbrL4HUBPg443+9
        oPe3+MDQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKQr0-0007am-La; Wed, 07 Nov 2018 16:38:54 +0000
Subject: Re: [PATCH] regulator: bd71837: add <linux/of.h> to fix build errors
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <cf89bc2f-f7c0-0ed6-38d8-0c47a05ed706@infradead.org>
 <042F8805D2046347BB8420BEAE397A4066F1CF4C@WILL-MAIL001.REu.RohmEu.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6a52ae58-b5d6-d86b-3597-5b8a1fe30e97@infradead.org>
Date:   Wed, 7 Nov 2018 08:38:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <042F8805D2046347BB8420BEAE397A4066F1CF4C@WILL-MAIL001.REu.RohmEu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 11:02 PM, Vaittinen, Matti wrote:
> Hello,
> 
> From: Randy Dunlap <rdunlap@infradead.org>
> 
>> Fix build error due to missing header file:
>>
>> drivers/regulator/bd71837-regulator.c:242:3: error: implicit declaration of function 'of_match_ptr' [-Werror=implicit-function-declaration]
>>
>> Fixes: ba08799e90b5 ("regulator: bd71837: BD71837 PMIC regulator driver")
> 
> //snip
> 
>> --- lnx-419.orig/drivers/regulator/bd71837-regulator.c
>> +++ lnx-419/drivers/regulator/bd71837-regulator.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/mfd/rohm-bd718x7.h>
>>  #include <linux/module.h>
>> +#include <linux/of.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/regulator/driver.h>
>>  #include <linux/regulator/machine.h>
> 
> Not sure if this is relevant but if I am not mistaken this should already be fixed by: 
> df43519eb706edfe951284a825642ce2e1d38d09 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df43519eb706edfe951284a825642ce2e1d38d09
> 
> 
> Br,
>     Matti Vaittinen
> 

Hi,

It seems that this same patch is now needed in
drivers/regulator/bd718x7-regulator.c:

From linux-next-2018-11-07:

file: drivers/regulator/bd718x7-regulator.c: errors: 109, warnings: 0

This is a small sample of the errors:

  CC [M]  drivers/regulator/bd718x7-regulator.o
../drivers/regulator/bd718x7-regulator.c:355:4: error: implicit declaration of function ‘of_match_ptr’ [-Werror=implicit-function-declaration]
    .of_match = of_match_ptr("BUCK1"),
    ^
../drivers/regulator/bd718x7-regulator.c:355:4: error: initializer element is not constant
../drivers/regulator/bd718x7-regulator.c:355:4: error: (near initialization for ‘bd71847_regulators[0].desc.of_match’)
../drivers/regulator/bd718x7-regulator.c:356:4: error: initializer element is not constant
    .regulators_node = of_match_ptr("regulators"),
    ^
../drivers/regulator/bd718x7-regulator.c:356:4: error: (near initialization for ‘bd71847_regulators[0].desc.regulators_node’)
../drivers/regulator/bd718x7-regulator.c:379:4: error: initializer element is not constant
    .of_match = of_match_ptr("BUCK2"),
    ^


thanks,
-- 
~Randy
