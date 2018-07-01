Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2152510F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/lFYfiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2152510F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeGBQH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:07:29 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41504 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeGBQH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:07:27 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11-v6so7723170pff.8;
        Mon, 02 Jul 2018 09:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=9siBq07cC7jVM+7IWI4eZcVYx7cVY8NJ7DdDhfvyRx8=;
        b=K/lFYfiZ8jvS7mpT4a8WnwGFzYob1uu9WwrGCpjFGUP+vIJt7c5ESTrwZMUb9rorlk
         /vtDcVis3cYGg1t70u2H0puXRFmJRt3T5F+wngcrwJ1XEQ5Cj+4DftQbYwwVRMvk3vO/
         XU5auDVvh9qOZ8KcAMzxA6UkpWtthzWsrzXE6cHXDhHGcqywiTqbzI4vZlVzS/ai7TUE
         uHL7jPdJw3yv8WVBnSZoSTL5v2kGUxoSvlWxcJeG7KAvGA/YzoWICQIkDWUgWUDOX5rY
         irXdmKxTZg12ZYteEsY+jgImqxnyK5KQRexLGYBqyT6rcbWkHuhXH7dMksEy+LzMZh85
         4Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9siBq07cC7jVM+7IWI4eZcVYx7cVY8NJ7DdDhfvyRx8=;
        b=mnOgquLLnFThbQZsBVgoVB/MZEtxaSmGWzzOBi+fJhOAKPVWw8dNSFTMi9/7Nh87jY
         Y6OH0Fk7f0tIU43idR5hn+xPIr1gLv+7xbnKeJzvXgp6J8EXQfeeRQk2vH5zpv5DD3zP
         bgsVFo6eQmUyIk6Zfb+tHF7BEpetnshfTavWq/gSLd8weP01vBYzECMqVcfVbhWbQNG1
         z9Ky9owiWuUFyLPXNgl6h7wqbPgqgLHPoQdY81D4GgD/2FrRg8T4bc7I4KFhRb7QUnpJ
         2LZ2NJDVpf76HbtYT1cWT22KA9kZZlJfLotCK6FuEaz3HWvCIq/Qp7MHKyI4G+6icW0L
         EgZg==
X-Gm-Message-State: APt69E3wVt3d3kzafssPiS+6LfW51TpHe8MOoqi3eUKCPFOrKmw5mUiq
        u6AJbWWe/I/ai8oppkWRbTEcy2mk
X-Google-Smtp-Source: AAOMgpePd5kD4cr3xboUA5i8IX9wfkdkW09fS0tUDzToljgphsj43bKkYuyf68qt+4G6RRhJfwE6mQ==
X-Received: by 2002:a65:61aa:: with SMTP id i10-v6mr1937833pgv.139.1530547646711;
        Mon, 02 Jul 2018 09:07:26 -0700 (PDT)
Received: from [192.168.219.108] ([116.36.201.74])
        by smtp.gmail.com with ESMTPSA id 145-v6sm28304473pfz.69.2018.07.02.09.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 09:07:25 -0700 (PDT)
Subject: Re: [PATCH] media: i2c: lm3560: add support for lm3559 chip
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        m.chehab@samsung.com, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org
References: <20180506080607.GA24212@amd> <20180623213328.GA19154@amd>
From:   Daniel Jeong <gshark.jeong@gmail.com>
Message-ID: <92fcf91d-f955-9a16-bf99-aad95f39a92a@gmail.com>
Date:   Mon, 2 Jul 2018 03:00:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180623213328.GA19154@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> On Sun 2018-05-06 10:06:07, Pavel Machek wrote:
>> Add support for LM3559, as found in Motorola Droid 4 phone, for
>> example. SW interface seems to be identical.
>>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> Ping?

>fping daniel
daniel is alive. :)

>
> Could this and media: i2c: lm3560: use conservative defaults be
> applied for v4.19? This is not too complex...
>
> 								Pavel

The lm3559 datasheet should be reviewed first
to know whether those products have same register map and field data for each register.

> 								
>> diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
>> index b600e03a..c4e5ed5 100644
>> --- a/drivers/media/i2c/lm3560.c
>> +++ b/drivers/media/i2c/lm3560.c
>> @@ -1,6 +1,6 @@
>>   /*
>>    * drivers/media/i2c/lm3560.c
>> - * General device driver for TI lm3560, FLASH LED Driver
>> + * General device driver for TI lm3559, lm3560, FLASH LED Driver
>>    *
>>    * Copyright (C) 2013 Texas Instruments
>>    *
>> @@ -465,6 +479,7 @@ static int lm3560_remove(struct i2c_client *client)
>>   }
>>   
>>   static const struct i2c_device_id lm3560_id_table[] = {
>> +	{LM3559_NAME, 0},
>>   	{LM3560_NAME, 0},
>>   	{}
>>   };
>> diff --git a/include/media/i2c/lm3560.h b/include/media/i2c/lm3560.h
>> index a5bd310..0e2b1c7 100644
>> --- a/include/media/i2c/lm3560.h
>> +++ b/include/media/i2c/lm3560.h
>> @@ -22,6 +22,7 @@
>>   
>>   #include <media/v4l2-subdev.h>
>>   
>> +#define LM3559_NAME	"lm3559"
>>   #define LM3560_NAME	"lm3560"
>>   #define LM3560_I2C_ADDR	(0x53)
>>   
>>
>
>

