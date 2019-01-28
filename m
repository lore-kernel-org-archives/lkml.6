Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D2C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E650D2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCVlxR7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfA1V0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:26:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfA1V0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=95S9QM7iEn/sBoEi8goRMACGTPIMuwlKqUSU55SNdCw=; b=gCVlxR7ZdaswZpVdpiWYWL/s2
        fAQyew3/xX9UAD+OtVLsaYDnWfBgcdxejOyzc5DepJFzYnF2PJ4YnPFUIGZUfTPd/ExD3Q04+TaOR
        TGn+Dc3WpVdumcrUFPXTbKcddhmFI9nVnBXIscWXFn+Yq92+EuRPlZjzW+IogVDg5yUu36wbBri8a
        h+fzWaOArhrz7YPR4QjC7MMu5vH9hUxvNDCNNMLbwrd/NPYXsLjlMTmtz4pgGSSbseGR59AWsRmqA
        ZCdWim7DrVt4ED6lHyn57kVawwjcTZW3rEheerbjjB7qJGCoHozsm9kYWbJ28wgN4OYoNPM9pMI28
        i3FQn5nSw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goEQY-000485-LZ; Mon, 28 Jan 2019 21:26:46 +0000
Subject: Re: [PATCH] extcon: Fix build issues in ptn5150
To:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <88f71303-575e-6680-a207-da102bda8ef2@infradead.org>
 <1548650292-15762-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
 <20190128071059.GA32040@chikyu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3fd82d2a-c3db-0afa-13bb-25206aeb9ccd@infradead.org>
Date:   Mon, 28 Jan 2019 13:26:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190128071059.GA32040@chikyu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/19 11:10 PM, Vijai Kumar K wrote:
> On Mon, Jan 28, 2019 at 10:08:12AM +0530, Vijai Kumar K wrote:
> I was wondering, what is the normal procedure in the below case
> when the build fails because of the driver.
> Should I send a new patch as a whole [PATCH v3] for the driver
> or should I send a new patch to fix the issue like below.

Hi,

I think that's up to the maintainer who merged the version that is
currently in linux-next.

For the patch:
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> Thanks,
> Vijai Kumar K
>> - extcon-ptn5150 driver uses gpio libraries
>> - Add GPIOLIB in depends section of Kconfig
>>
>> Error:
>> -----
>>>   CC      drivers/extcon/extcon-ptn5150.o
>>> ../drivers/extcon/extcon-ptn5150.c: In function ‘ptn5150_irq_work’:
>>> ../drivers/extcon/extcon-ptn5150.c:130:5: error: implicit declaration of function ‘gpiod_set_value’ [-Werror=implicit-function-declaration]
>>>      gpiod_set_value(info->vbus_gpiod, 0);
>>>      ^
>>> ../drivers/extcon/extcon-ptn5150.c: In function ‘ptn5150_i2c_probe’:
>>> ../drivers/extcon/extcon-ptn5150.c:242:2: error: implicit declaration of function ‘devm_gpiod_get’ [-Werror=implicit-function-declaration]
>>>   info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
>>>   ^
>>> ../drivers/extcon/extcon-ptn5150.c:242:53: error: ‘GPIOD_IN’ undeclared (first use in this function)
>>>   info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
>>>                                                      ^
>>> ../drivers/extcon/extcon-ptn5150.c:242:53: note: each undeclared identifier is reported only once for each function it appears in
>>> ../drivers/extcon/extcon-ptn5150.c:252:2: error: implicit declaration of function ‘gpiod_direction_output’ [-Werror=implicit-function-declaration]
>>>   ret = gpiod_direction_output(info->vbus_gpiod, 0);
>>>   ^
>>> ../drivers/extcon/extcon-ptn5150.c:271:3: error: implicit declaration of function ‘gpiod_to_irq’ [-Werror=implicit-function-declaration]
>>>    info->irq = gpiod_to_irq(info->int_gpiod);
>> -----
>>
>> Signed-off-by: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
>> ---
>>  drivers/extcon/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index b9cc027..330dd8b 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -116,7 +116,7 @@ config EXTCON_PALMAS
>>  
>>  config EXTCON_PTN5150
>>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
>> -	depends on I2C
>> +	depends on I2C && GPIOLIB
>>  	select REGMAP_I2C
>>  	help
>>  	  Say Y here to enable support for USB peripheral and USB host
>> -- 
>> 2.7.4
>>


-- 
~Randy
