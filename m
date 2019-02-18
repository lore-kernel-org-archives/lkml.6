Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88186C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CC321736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLLvGgoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391938AbfBRSJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:09:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34825 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388403AbfBRSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:09:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so9112680plo.2;
        Mon, 18 Feb 2019 10:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PCmd0k5+CjHJP9bGlT9saSlFbvFHR2TOS6VtYPX/JMc=;
        b=GLLvGgoZMSMurMSI4CbPezceHY6bYRo9o5UBDZfT54CE/CeAPJVQCaBYHOrEUkGPzZ
         go4CFUcWrJaC8bU6xS/zzSdMEP0HosI1NN+5WIaaSP7GHj+QcgqnqGNBZ5ULn+W4lz7t
         kY0eTaSAkZd6Oxx/LVkRbVfmcIQCfnHCHv/POnuwmi4aptF+Z4vN3wy1+TNHOTdkHTmG
         4CTk2lqGjUONlcDdkk/uwYvAozPoHYWaKvlHYZbhA6LyEhUm6HJ4Ss8nJGmi0wzPBx0M
         s48FupyPS2IXLIiVijdMR2/7nXqIiP7L9jHttwAyEJ3tp9cljMz5YZl8Xd71UwX2hfHn
         r8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PCmd0k5+CjHJP9bGlT9saSlFbvFHR2TOS6VtYPX/JMc=;
        b=MZu7peo/K5tlW7SOMBr3NkBbMkXj17Y4LWAZQKf2cSZ3bPbCxwPU7aSW7czS6f2c3m
         40hF6wlYwtpDInKVfO1yJ+DI30rx6pCcizfT3z4pTcacpwlHEx/tjVLTIBdzcW3hRbmF
         Q6pZm8U6v1j8ZBp6LdzXyWIbU5D1fzxxm4o4n6CrQJxY+OU9/qLG0QWYkjt4g86EEBBn
         hyEXomUzk68g5sCO1f9q99LsDB/0dHxAXUlZxRK7B2DYAAJ+seB1Y//x0lrDUFlkCo8S
         DV5YAOxz49tPu9mPUI/vkqatwYyw3SapheImx7qEuDErLlWbfqHk659BVIdlE8ug3dIc
         7R0w==
X-Gm-Message-State: AHQUAub0aaZ4ghQ4iIPSeatTEAq7EMPRyqSo60/Er8mSWxZc19fuBZL2
        kBs0QxKA7Qd+w01hSgqKcITo4a/y
X-Google-Smtp-Source: AHgI3IZSlKbC7kvzWsqg02tQKpjX0FGy+9gIn1FnDMLS9fknX4TOqBrnaL4mcliXMxe47ZLvYMsfsA==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr26963273plp.333.1550513344271;
        Mon, 18 Feb 2019 10:09:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o26sm7936254pfk.139.2019.02.18.10.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 10:09:03 -0800 (PST)
Subject: Re: [PATCH] s390/setup: fix early warning messages
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190218154640.GA27699@roeck-us.net>
 <20190218180146.79930fe6@mschwideX1>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0b8201f1-bdb0-d274-4354-ceb0d05530d2@roeck-us.net>
Date:   Mon, 18 Feb 2019 10:09:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218180146.79930fe6@mschwideX1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 2/18/19 9:01 AM, Martin Schwidefsky wrote:
> On Mon, 18 Feb 2019 07:46:40 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> Hi,
>>
>> On Thu, Feb 14, 2019 at 03:40:56PM +0100, Martin Schwidefsky wrote:
>>> The setup_lowcore() function creates a new prefix page for the boot CPU.
>>> The PSW mask for the system_call, external interrupt, i/o interrupt and
>>> the program check handler have the DAT bit set in this new prefix page.
>>>
>>> At the time setup_lowcore is called the system still runs without virtual
>>> address translation, the paging_init() function creates the kernel page
>>> table and loads the CR13 with the kernel ASCE.
>>>
>>> Any code between setup_lowcore() and the end of paging_init() that has
>>> a BUG or WARN statement will create a program check that can not be
>>> handled correctly as there is no kernel page table yet.
>>>
>>> To allow early WARN statements initially setup the lowcore with DAT off
>>> and set the DAT bit only after paging_init() has completed.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>
>> This patch causes s390 qemu emulations to crash with a kernel stack overflow.
>> Reverting the patch fixes the problem. Crash log and bisect results below.
> 
> Urgs, yes. That is EDAT-1 again that makes it work with 1MB pages but breaks
> with 4K mapping where the prefix page is mapped to absolute zero.
> 

Is there some non-default configuration besides defconfig that I could run to
catch both working and non-working images ? I don't immediately see an option
to select the page size.

Thanks,
Guenter

> Just using S390_lowcore instead of lowcore_ptr[0] does not work either
> because low-address protection is already active. I'll think of something.
> 
> Thanks for bug report!
> 

