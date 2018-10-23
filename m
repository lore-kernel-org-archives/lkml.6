Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F085C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB05E204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZAMzZmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB05E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeJXDel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:34:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46268 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbeJXDek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:34:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id o2-v6so2026486lfl.13;
        Tue, 23 Oct 2018 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqY84tiS/iXTCTRJflVvZ5Ci6t/R3jNgj5FkDN1n+Fw=;
        b=uZAMzZmSGpORVZZVe+pGxQM/FjCXdcgcs1L1RJKgvId2n4ZFGe5wUsVon8uoSDZIMA
         oBD0HkUBw0J1/FF+FrwG8D7PUJzi7Wi+1aViPQjhZbCHBWbw9YwXXUpACQBWWSaAqmI0
         7Z4YMpnxd3xGqZBAWssLHX51Uo8gPde7vZXRD60B6KhhknL5Ye+OEkekpwTHhk61OLCe
         YWB2Iw9rJfhCyD1OWZHiYnHX6P7qlENrL135dwbcVFyLnDrtaPlF2+bqKedQ+WOrYjMz
         3v1vxc0dBAsEMCRXTNomBoiqZJz/EjyfQ1L9R3s2A6DPWC2+asjIDtGkF7KNBn5l8Xuj
         II4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqY84tiS/iXTCTRJflVvZ5Ci6t/R3jNgj5FkDN1n+Fw=;
        b=pl7rvQ8YT5bjuT2CchZ/bxR8RM7tJQmnp8/JcPTS+ZiT7KeriCcoGZ3O143abGYkXU
         y3WFWGM8HvcOCTJ2HBGSGKsmXv5enFincdTmR8ZePhpIwkwn7GqIJy/kHdBT9Xomhd5R
         gZLVxRlgHHxJCkyCL5MmAoV0NqhhvSljWQxKqi6JmZDm2i0fc+wHQXQStd+qQ4Y2BPVJ
         +3lQfkiOrReKA/yPHhBHpBSGvsbJFkTnbn1kXWw67kVQGgTN+q1lXCL4lIA70lEV12hl
         XedORZfe/VKG5bKZmJg7NTPvIC5Av2etvZ/zJWlKyI4ekaOSECIrjCxDjd/t/SE8Ir5e
         JYVw==
X-Gm-Message-State: ABuFfohrndBCKGy/0GZclezUHT7BHdRi7Qame+GOTalZJx6e9kCsq3hT
        iJZfuk+67J6efIv6vhQB8fc=
X-Google-Smtp-Source: ACcGV60DNsxOn/9Qv8HFzBvlw13Jy8UfNNAz/ECZLXmXQvgTqkd4QRtPC+LS/+44dSB/O8mpHmmU5w==
X-Received: by 2002:a19:6e0b:: with SMTP id j11-v6mr12663503lfc.118.1540321797233;
        Tue, 23 Oct 2018 12:09:57 -0700 (PDT)
Received: from [192.168.1.18] (dks61.neoplus.adsl.tpnet.pl. [83.24.22.61])
        by smtp.gmail.com with ESMTPSA id b21-v6sm325911lfi.17.2018.10.23.12.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:09:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dan O'Donovan <dan@emutex.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
 <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com> <20181023185453.GA27397@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <226e0df2-83f9-bee5-f359-a3e040d12311@gmail.com>
Date:   Tue, 23 Oct 2018 21:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023185453.GA27397@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 08:54 PM, Pavel Machek wrote:
> Hi!
> 
>>> +	led->field = devm_regmap_field_alloc(dev, regmap, conf);
>>> +	if (IS_ERR(led->field))
>>> +		return PTR_ERR(led->field);
>>> +
>>> +	led->cdev.max_brightness = 1;
>>
>> s/1/LED_ON/
> 
> Actually, I prefer constant 1 here, as it makes it immediately obvious
> this supports just 0/1.
> 
> Yes, LED_ON is also 1, but I had to grep the header files for
> that... (I thought it was 255).

If we have the enum for that, let's use it.
Here's the commit message of the patch adding LED_ON - it should
be somehow familiar to you - see the ack.

commit 4e552c8cb5bc9137e67e035bab8df6dddbca7384
Author: Andi Shyti <andi.shyti@samsung.com>
Date:   Thu Jan 5 11:34:12 2017 +0900

    leds: add LED_ON brightness as boolean value

    Some devices do not handle the led brightness or simply don't
    care about it. Conceptually said devices want to just switch on
    or off the led. It is useless in this case to have a 255 range
    of brightness, while just having an LED_ON and LED_OFF improves
    the boolean meaning of the led status.

    Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
    Acked-by: Pavel Machek <pavel@ucw.cz>
    Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>


-- 
Best regards,
Jacek Anaszewski
