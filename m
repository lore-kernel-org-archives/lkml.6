Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B89C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EB320779
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRM3IFdN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EB320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933451AbeGIQLL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:11:11 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39838 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeGIQLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:11:09 -0400
Received: by mail-qt0-f193.google.com with SMTP id q12-v6so15814336qtp.6;
        Mon, 09 Jul 2018 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=unYalhh+/fjE9BAUSAWlTvt2qcV1E3HHENB3jNamGoM=;
        b=QRM3IFdN7tfGuLcNGRJADv+xTDgCDj5TQ7XNg4N8Gut3Fq9D0QAUdkvWk91gZJB2V8
         DqnFs/5UgrdDciWlCMLB9a1jtSMw4ApT4a28i7ZC8YMqCv6CFCY3Wu5emsZkso9LbVeY
         u4waNb3wcYCfkO/8lZwcSQds4XVBhwUYS2f3DLLFmZWosC56Kc3WKue5CfS4a6rxrZ+M
         lH8QtVtc+LrZGtjZyuzmFjwXDO+PhbVduU+DgxRNstst1epx3/5U80FfeNzD3jcCJzGA
         sTHxI4fY8JtgAeIf1PWIZNgppXZoTtM31d0hg7nocS2nkvR8UU/iQzARHz5G80vk9TDP
         h6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=unYalhh+/fjE9BAUSAWlTvt2qcV1E3HHENB3jNamGoM=;
        b=S5hzvquR1sXQc4o7J8PJpqBPxXJpUz3lhWvaV2mhhNnKFjOkwq2yGgRNEPEeY1qJ1E
         fbZ+1bz35zHO50LPjdZdPnEbgLbhfsQf0loyBkBGTpqBT4kE5ls957SKAJMmH7qzwn92
         TSn8HpDbXmA27Od2wnvHHVu2iaVsXWHhvMMJNZLOR6zTP8NzP+HAybIoYeQ+4ybJMdtG
         L5Jr9E1VVoxP+VVTQruC2Jq6k6CdAFBphgJT8RuLImVOXon16LpEImmV/bUZT6iX8ZiM
         F0mX0E64+nXoHQJi3ekr+LtLtmGIdIQtwmeXYAauJUnhx2IdO/XW5Y/d38CASu7LaGUz
         qz0g==
X-Gm-Message-State: APt69E3+xmM1nqpgt2Q/vPz8OKMFI0pOhQf5i8CAzZC7QxWR4k79ROEn
        MFiC8PZGfQVQSJM7mEoQCzd+0mn5
X-Google-Smtp-Source: AAOMgpegJ7ZdRPRU+dLASMHcRwO2zv97ENwmdeqVwUQztmPpPLY+jDflu0PkufrSlWYy5D2olVEjnA==
X-Received: by 2002:ac8:36f0:: with SMTP id b45-v6mr19333779qtc.249.1531152668255;
        Mon, 09 Jul 2018 09:11:08 -0700 (PDT)
Received: from [10.178.4.240] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id e11-v6sm10431994qkb.4.2018.07.09.09.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 09:11:07 -0700 (PDT)
Subject: Re: [PATCH] hwmon: rpi: fix link error against rpi_firmware module
To:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Vadim Pasternak <vadimp@mellanox.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180709154301.1781663-1-arnd@arndb.de>
 <20180709155509.GA4191@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <4fe1c931-772c-0df0-6bf7-d32a495b5f80@gmail.com>
Date:   Mon, 9 Jul 2018 09:11:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709155509.GA4191@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/09/2018 08:55 AM, Guenter Roeck wrote:
> On Mon, Jul 09, 2018 at 05:42:44PM +0200, Arnd Bergmann wrote:
>> Compile-testing without CONFIG_RASPBERRYPI_FIRMWARE is possible, but we
>> cannot build the rpi hwmon driver into the kernel if the firmware code
>> is a loadable module:
>>
>> drivers/hwmon/raspberrypi-hwmon.o: In function `rpi_hwmon_probe':
>> raspberrypi-hwmon.c:(.text+0x140): undefined reference to `rpi_firmware_property'
>> drivers/hwmon/raspberrypi-hwmon.o: In function `get_values_poll':
>> raspberrypi-hwmon.c:(.text+0x350): undefined reference to `rpi_firmware_property'
>>
>> This adapts the dependency to disallow that combination.
>>
>> Fixes: 3c493c885cf8 ("hwmon: Add support for RPi voltage sensor")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> This will have to go through Florian's tree.

Thanks for looping me in, I just sent the pull requests out Arnd, do you
want me to squash this into 3c493c885cf8 ("hwmon: Add support for RPi
voltage sensor") and resubmit?

Ray just informed me he has additional DTS stuff he would like to see
included.

> 
> Guenter
> 
>> ---
>>  drivers/hwmon/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index a4e5d3c9fc71..81da17a42dc9 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -1322,7 +1322,7 @@ config SENSORS_PWM_FAN
>>  
>>  config SENSORS_RASPBERRYPI_HWMON
>>  	tristate "Raspberry Pi voltage monitor"
>> -	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
>> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> 
> Is that one of the situations where "imply RASPBERRYPI_FIRMWARE"
> would be useful ?
> 
>>  	help
>>  	  If you say yes here you get support for voltage sensor on the
>>  	  Raspberry Pi.
>> -- 
>> 2.9.0
>>

-- 
Florian
