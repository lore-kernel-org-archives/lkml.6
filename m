Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39025208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bv6ofV5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39025208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbeGaQKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:10:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55056 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbeGaQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:10:48 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so4748994itb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=33+0xhK8D0V75xsBaSyMLOAfTpGJIEBUYqqWGYaDpFQ=;
        b=bv6ofV5ZyWELrIKMV2zTuFzIVgVonxV2qyZvsoSe6WlZGSPHQRMIPuu2B0jNZSCvOC
         2IQCcr6K1OGgRgPV+gmIsxhbKSCkYBBTJrGtfdAjEXkKwxwjZn/XH+TtYA1N9W8ndTgY
         Ojf6Da9WE4IO3UgK798eKFXhACvZArDKy4sB2U6WQh80Y37Xdpc76HpqQ/qeYtHUfG50
         8UksJEjMIIuyTIvTrk5vr6lXI8WEDXacAbZgm0T3ioUnvnW9NpO5e0+b2moRgGvDvFwA
         ptTDuVgIDz4vgl6tm9BbupRNLYKpzYirbhh069zOqnDmXlQC+FhHuSQh5Bt6BLL/Ff6I
         5+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=33+0xhK8D0V75xsBaSyMLOAfTpGJIEBUYqqWGYaDpFQ=;
        b=YBbGdrOIOeqcFBimJys4I90wtO+/cDAJQYChk7xeqCoTmIIkRLBOy+TwaxQ1vZBw+p
         ECbBxlNu79ZVBNsbN6/sY+sUrrz6QfXqD7wSdN+g5foUPefqaIjotr4Tz6v2giM7wH9w
         Hp6bZUT8Nwo8eyJGLjbJUZc9eXm5A2cAdZTiyz85HOnNX5IgcHdVhO3T290DrMfobTeh
         KXb5dsWnxBlPlzPwTa5Hx08WaoHQevdIkH0G05LB0FafTWBAsOXRiFVkAectqw0rB/Sw
         AXjC8E0w1LqwdT53Shr2QhS/T8rMdkjnkISt8l5ATvqtmL98aQ808PHSPXBpBhN1uI4X
         6WWQ==
X-Gm-Message-State: AOUpUlEEtR6LcPevkwxQ5Q2N+TjtSqEKiuXkws6WXPclNM2b+Vz9To6x
        +J+zJ3dsHmQCu0KT7kKbP8CPWEWjuCQ=
X-Google-Smtp-Source: AAOMgpf3MQjcAqBj5y+ydByugeLbKq86B4lbbrj3cKRGmo8Pph4NUEvqzv7UJdgkf930XoiSchJrDw==
X-Received: by 2002:a24:2e58:: with SMTP id i85-v6mr3190257ita.32.1533047412206;
        Tue, 31 Jul 2018 07:30:12 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id w5-v6sm4459476ioc.58.2018.07.31.07.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:30:11 -0700 (PDT)
Subject: Re: [PATCH 2/6] x86: factor out RapidIO Kconfig menu;
To:     Thomas Gleixner <tglx@linutronix.de>, Alexei Colin <acolin@isi.edu>
Cc:     Peter Anvin <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-3-acolin@isi.edu>
 <alpine.DEB.2.21.1807310054180.1725@nanos.tec.linutronix.de>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <bdc726c6-a629-ed27-d78d-0c6521ca0fa5@gmail.com>
Date:   Tue, 31 Jul 2018 10:30:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807310054180.1725@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-30 06:55 PM, Thomas Gleixner wrote:
> On Mon, 30 Jul 2018, Alexei Colin wrote:
> 
>> The menu entry is now defined in the rapidio subtree.
> 
> This could be folded into the patch which actually adds the rapidio
> specific Kconfig to avoid kconfig complaining about double entries.
>
Please share details how to reproduce double entries warning.

> But either way is fine for me.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: John Paul Walters <jwalters@isi.edu>
>> Cc: x86@kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Alexei Colin <acolin@isi.edu>
>> ---
>>   arch/x86/Kconfig | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 27fce7e84357..6f057000e486 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2828,14 +2828,6 @@ config AMD_NB
>>   
>>   source "drivers/pcmcia/Kconfig"
>>   
>> -config RAPIDIO
>> -	tristate "RapidIO support"
>> -	depends on PCI
>> -	default n
>> -	help
>> -	  If enabled this option will include drivers and the core
>> -	  infrastructure code to support RapidIO interconnect devices.
>> -
>>   source "drivers/rapidio/Kconfig"
>>   
>>   config X86_SYSFB
>> -- 
>> 2.18.0
>>
>>
