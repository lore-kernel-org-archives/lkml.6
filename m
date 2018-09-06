Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A402075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A402075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbeIFTyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:54:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51520 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeIFTyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:54:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxw3Q-0001pO-Pd; Thu, 06 Sep 2018 15:18:44 +0000
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180906133348.brzvqt53nzukn7n2@kili.mountain>
 <21c6b967-f4b5-db68-89b4-a9caa4e76fda@canonical.com>
 <20180906144838.2dtqexjqieqjdpub@mwanda>
From:   Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] gpio: ep93xx: fix test for end of loop
Message-ID: <6098ff32-7f64-38db-8937-a9d257935c97@canonical.com>
Date:   Thu, 6 Sep 2018 16:18:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180906144838.2dtqexjqieqjdpub@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/18 15:48, Dan Carpenter wrote:
> On Thu, Sep 06, 2018 at 02:50:44PM +0100, Colin Ian King wrote:
>> On 06/09/18 14:33, Dan Carpenter wrote:
>>> The problem is that if port == ARRAY_SIZE() and "gc == &epg->gc[port]"
>>> then that should be treated as invalid.
>>>
>>> Fixes: fd935fc421e7 ("gpio: ep93xx: Do not pingpong irq numbers")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
>>> index 68a416fc3141..b0699f57ddf5 100644
>>> --- a/drivers/gpio/gpio-ep93xx.c
>>> +++ b/drivers/gpio/gpio-ep93xx.c
>>> @@ -80,7 +80,7 @@ static int ep93xx_gpio_port(struct gpio_chip *gc)
>>>  		port++;
>>>  
>>>  	/* This should not happen but is there as a last safeguard */
>>> -	if (gc != &epg->gc[port]) {
>>> +	if (port == ARRAY_SIZE(epg->gc)) {
>>>  		pr_crit("can't find the GPIO port\n");
>>>  		return 0;
>>>  	}
>>>
>>
>> Good catch! I overlooked that one.
> 
> It's unfortunate but I don't think any of our static checkers would have
> caught it.  You found this bug because of cppcheck, right?  I know it
> warns about the bounds test after use.  Does it also warn about the out
> of bounds?

It can catch these, not sure how well it compares to the other tools I use.

> 
> Smatch doesn't warn about the out of bounds read because Smatch has bad
> handling of loops.  Smatch is supposed to warn about the test after use
> but that code is buggy.  I will investigate what's going on.
> 
> I have an unpublished test so Smatch does warn that the port < sizeof()
> means that port is in terms of bytes but we're using it as an array
> offset.  That's how I noticed this code, but it only warns about the
> first use, so it warns about the loop but not the post-loop test.
> 
> I should fix Smatch's handling of loops so that we know this function
> originally could return 0-8 and you maybe get a warning in the caller.
> Unfortunately, I'm not sure I would have paid very much attention to a
> warning like that because they tend to be prone to false positives.  We
> have a lot of loops that do:
> 
> 	for (i = 0; i < ARRAY_SIZE(array); i++) {
> 		if (foo <= array[i])
> 			break;
> 	}

..yep, the are a lot of these to fix up for sure.

> 
> And the last element of the array[] is UINT_MAX so we always break.
> It's a lot of work but not necessarily difficult work.
> 
> regards,
> dan carpenter
> 

