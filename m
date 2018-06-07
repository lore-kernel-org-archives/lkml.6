Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VQ55CqYPGVt+EwAAmS7hNA
	; Thu, 07 Jun 2018 10:57:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0BEF76089E; Thu,  7 Jun 2018 10:57:42 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY/qVtpA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6011360115;
	Thu,  7 Jun 2018 10:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6011360115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeFGK5j (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:57:39 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34284 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbeFGK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:57:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so9611307wro.1;
        Thu, 07 Jun 2018 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3GYk00ZwUJ+1vbIBVQMFkCIBrSSqwqpFUsv7NdkrWGQ=;
        b=WY/qVtpAw0mZ2adJbHQBsHk2P+44E1LCmoo1lTqT3sfsMXM/g+GC4vNSxYzmbL7wiw
         NsrCtFw8gzzQe3synjOxkeSo1lNdln0F+TJ87aVOZwYbUXh47xF3xLn+8Q+nfVY49Cgx
         ruSE+EnlYRvzZZUHqAZKcW6wfvr9Ldv6jS+df3o5JjZ+eE6ql7spP+HxGP2G3UomEsDP
         50bf6fC1RwY+uCKlCO4DnewY2DSuLyNtXm+EPSbkKrjBLw3+8SV4q3bjCmOsnhNqZepm
         8uk4TuBJ/HQ3mKrgVolpwyrvJ99eht6AAEbT3t1WvhvrhQ8y5E7sSxhxWV8rQ18ASgKq
         QHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3GYk00ZwUJ+1vbIBVQMFkCIBrSSqwqpFUsv7NdkrWGQ=;
        b=D+Mjv7f89rBgeLgEZmpoa+xd/3H6QLjL5lCVF+I324OiF0s5oQ5sFkm104/AuJnIFv
         Ayn4q0EoopbTFY3uJIQAOVWQiTbOKf5+4eMrs2kczkhnTFe4EasuaAwQE/5BL9v7RE/Y
         sMRMz9yXVXNMkBbpOIU37PqkTdCdPkKR1sxhhbuMedTAsIJcAJOz2+1sqKvp74nB8Jzk
         +yN2n6GZ8zrl4Z6+9qXYJsQ7x8F5T7bqZi5hP7U+iV5EB2kjKINzld2SK4dnAPUhH3/q
         D9MkozNux+ej/2AN2mpLVFT3JelWFypxhNiDAa+8uus8nkKqCJiHhYkWPiqb4a7yAl7k
         jKNA==
X-Gm-Message-State: APt69E1SiT8xI05WcxNNStSFiaty7F8fkWRBYHjo6bDzoZRmf5kjD4vA
        4A4AH4rVlAzXla+QNQkrO4NxV3ly
X-Google-Smtp-Source: ADUXVKJDI5gsYKtUDdc2ukrivl4CjJG2Nfmj79O7UCV7ua9baGr0QJZ478Ith6gcgU4dyISzPNZmPQ==
X-Received: by 2002:adf:9724:: with SMTP id r33-v6mr1352933wrb.79.1528369055506;
        Thu, 07 Jun 2018 03:57:35 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id n7-v6sm22417507wrr.39.2018.06.07.03.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 03:57:34 -0700 (PDT)
Subject: Re: [PATCH v3 08/10] mfd: da9063: Register RTC only on DA9063L
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-8-marek.vasut+renesas@gmail.com>
 <20180605075321.GM21163@dell>
 <ac43842f-7d8a-1d6d-7077-9fb58ab852b7@gmail.com>
 <20180606061623.GT21163@dell>
 <69893894-899f-54cd-2610-96653ec246c0@gmail.com>
 <20180607050411.GB21163@dell>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <feeb19cc-e7df-1859-86b9-da99059d8e32@gmail.com>
Date: Thu, 7 Jun 2018 12:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607050411.GB21163@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 07:04 AM, Lee Jones wrote:
> On Wed, 06 Jun 2018, Marek Vasut wrote:
>> On 06/06/2018 08:16 AM, Lee Jones wrote:
>>> On Tue, 05 Jun 2018, Marek Vasut wrote:
>>
>> [...]
>>
>>>>>> -static const struct mfd_cell da9063_devs[] = {
>>>>>> +static const struct mfd_cell da9063_common_devs[] = {
>>>>>>  	{
>>>>>>  		.name		= DA9063_DRVNAME_REGULATORS,
>>>>>
>>>>> Appreciate that these are historical, but these device name defines
>>>>> make me shudder.  They only serve to act as an obfuscation layer when
>>>>> debugging at platform level.  Please consider getting rid of them.
>>>>
>>>> The macro can be shared between the core and the drivers, so the names
>>>> never run out of sync.
>>>
>>> Platform driver name changes are vary rare.  Even if they are changed,
>>> even light testing would uncover the fact that child drivers do not
>>> .probe().
>>
>> Sure, while if the macro is used, this problem is avoided altogether.
>>
>>> Due to the current obfuscation, I currently have no idea
>>> what this device's name is.
>>
>> I'm sure ctags or git grep can easily help.
> 
> I'm aware how to get around the 'issue', but it's an additional step
> which is avoidable.  For me personally it comes from doing *a lot* of
> platform level work and being irritated by the extra grepping.  Macros
> for driver names does not sit right with me at all.  There are even
> worse examples of people defining the MACROs *inside* the driver,
> which doesn't even benefit from the small redeeming feature you
> mention above.

If we follow this line of thinking, we could just run cpp and expand all
macros. Then there's no need for grepping at all. That probably won't be
the result anyone would like though.

> Anyway, I'm happy with you not wanting to change it.  Just leave them
> as they are for now.
> 
>>>>>> +	{
>>>>>> +		.name		= DA9063_DRVNAME_VIBRATION,
>>>>>> +	},
>>>>>
>>>>> Place this on a single line please.
>>>>
>>>> This would only make the style inconsistent with the ie. LEDs entry.
>>>>
>>>>>         { .name	= DA9063_DRVNAME_VIBRATION },
>>>
>>> If that is a one line entry spaced over multiple lines, then that
>>> should also be changed.
>>>
>>> Maybe I will go through and stylise this driver a bit after all (but
>>> as time is short at the moment, maybe not!) :)
>>
>> You'd end up with two entries which look different then the rest, which
>> triggers my OCD.
> 
> OCD or not, it's never okay to waste lines.  If ordering it not
> important (which it should not be -- it's fragile to rely on device
> ordering in MFD cells), the multi-line entries go at the top, followed
> by the single line entries.  If done right, it looks the opposite of
> bad/out of place.

My point is, the style should at least be consistent. But anyway.

-- 
Best regards,
Marek Vasut
