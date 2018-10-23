Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554D5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02756205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxl4hBZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02756205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeJXE4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:56:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34608 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725761AbeJXE4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:56:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id j17-v6so2671770lja.1;
        Tue, 23 Oct 2018 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6XOEUTdoRV1qoHkxjcJ6+yNDXpL2YUFg+LHoW6GavzM=;
        b=cxl4hBZ0n0J1AOpiwCL74oIcoRIjYnDC+dPfnub+ZkfPfgylAchLwi9fgUTSIIffUo
         bWa9VNCBiwraYjvFFvrQ/OzB0leaKE6JpEHtDeZvru3VQl3wu8BQ8rxga0I+I5BuUid3
         D3dPJlO5wHBiB6sBDKgjhopdIZdxS7mcgJkuBU+HCvzUXaE5JOlANJeOH+ecsMYQtwEJ
         oy9x8rY8G0vDQLKeRWLfPwyXqhdNgPRuCMlzia3fIr4y2F9M1flAxUYw8O6FCaOHUnDC
         aykUhBbwkzIRjZu5onbo8Qlv0a0LPpSkxfgnRAfTbBczDi3wSJ+Gmej+ZLmsNAXrMyHU
         Sfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6XOEUTdoRV1qoHkxjcJ6+yNDXpL2YUFg+LHoW6GavzM=;
        b=CJC0IEtOgJ9xZo6up0hQgiflEhNqi48GeKi62BrqZom8W1pEhLIeBgtPsrtVGQ9IjE
         fCdtkqvV9a0R27bJlyW4uXkwGAPu4UA1LJyn9/Hhv7/HyfD676lKaUkjzPBZE6bAh0oq
         fbmnShGZImDZUHgdRAaECVV4Un/TIelT/R1IkExKXe4EFbyC4jAzl1na6V/yZPkUgl8P
         4YHR7i/cfZC06YItifPdJDqqXsN3w/PWWXnS3kOnz6FjRa0Qj0z88+tKbKTbmVxnWFdX
         1IV+P1+CqEUsWd4Hon3rXfC/E6n3cRwYe+arxmW+kwXNZNxATKIui3w3KoPqs5wurxDc
         Rkew==
X-Gm-Message-State: ABuFfoilaQgBdwUmBZaPwuJwPGdI1TNSlIKWerWNlinTw13mwgTw2Be0
        XLNFebtxj0bdvbDUKZ81SkM=
X-Google-Smtp-Source: ACcGV61FPUEDNMb32EmmQVNyWhSBC+utRC+aFZjh2pahFv1Bh33MIUo0piXmLHA+GBGBZLMrmo7Dmg==
X-Received: by 2002:a2e:8347:: with SMTP id l7-v6mr23689941ljh.140.1540326682287;
        Tue, 23 Oct 2018 13:31:22 -0700 (PDT)
Received: from [192.168.1.18] (dks61.neoplus.adsl.tpnet.pl. [83.24.22.61])
        by smtp.gmail.com with ESMTPSA id a2-v6sm358778lfi.23.2018.10.23.13.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 13:31:21 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
To:     Joe Perches <joe@perches.com>, Dan O'Donovan <dan@emutex.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
 <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com>
 <16591e6735e32baad10f083c688119ce79d12911.camel@perches.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1570e79b-3ea4-b389-72c8-1d595a46f380@gmail.com>
Date:   Tue, 23 Oct 2018 22:31:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <16591e6735e32baad10f083c688119ce79d12911.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 09:23 PM, Joe Perches wrote:
> On Tue, 2018-10-23 at 20:50 +0200, Jacek Anaszewski wrote:
>>> diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
>>> new file mode 100644
>>> index 0000000..34a6973
>>> --- /dev/null
>>> +++ b/drivers/leds/leds-upboard.c
>>> @@ -0,0 +1,104 @@
> []
>>> +#include <linux/kernel.h>
>>> +#include <linux/leds.h>
>>> +#include <linux/mfd/upboard.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/acpi.h>
>>
>> The last include should go first to keep alphabetical order.
> 
> There is no accepted single kernel style for #include
> file ordering.

Well, I myself have been asked several times for sorting
includes, that's why I keep requiring it for the LED subsystem too.

When it's by the occasion of a new driver submission, it costs
virtually nothing. And it allows for avoiding any prospective
noise on the list due to the submissions like "Order includes".

As a first shot the following returns 77:

git log | grep -i "include.*alphabetical" | wc -l

Aside of that, in case of this particular patch the intention seemingly
was to have includes ordered lexicographically, since only the last
item didn't fit for this pattern.

> drivers/leds does not use a single style nor is this
> particular variant documented anywhere to my knowledge.

Unspecified kind of includes sorting is mentioned in the
Documentation/process/coding-style.rst, line 637.

> Until such a time when either a local preferred style
> document or a treewide preferred style exists, please
> stop asking people to modify #include ordering for
> various styles like reverse christmas tree by length,
> alphabetic ordering, or other individual style
> My preferred style would always have kernel.h first
> as that may help with precompiled headers and overall
> kernel compilation time one day.

If that will happen we'll see massive rearrangement of includes
anyway.

But OK, I've skimmed through other subsystems and core kernel
files and realized that this is indeed often not preserved.

So, provided there are no other strong arguments in favor
of sorting, I will give up this nitpicking from now on.

-- 
Best regards,
Jacek Anaszewski
