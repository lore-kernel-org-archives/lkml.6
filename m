Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997ACC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CFB20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CFB20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=assembler.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756700AbeFOV5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:57:17 -0400
Received: from mail.medvecky.net ([85.118.132.146]:45413 "EHLO
        mail.medvecky.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756665AbeFOV5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:57:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.medvecky.net (Postfix) with ESMTP id 001895E2002;
        Fri, 15 Jun 2018 23:52:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at medvecky.net
Received: from mail.medvecky.net ([127.0.0.1])
        by localhost (slovakia.medvecky.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1qeQ7dKZNeBm; Fri, 15 Jun 2018 23:51:37 +0200 (CEST)
Received: from [192.168.88.62] (ip-89-102-11-14.net.upcbroadband.cz [89.102.11.14])
        by mail.medvecky.net (Postfix) with ESMTPSA id 89CA95E2001;
        Fri, 15 Jun 2018 23:51:37 +0200 (CEST)
Subject: Re: Ryzen 2700 Temperature offset?
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jon.grimm@amd.com
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Chris Ouellet <rabbit.of.war@gmail.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <C85830A6-BCC7-4137-84E5-38503873F278@canonical.com>
 <20180607154915.GA7061@roeck-us.net>
 <54EAD835-C48D-4751-9BFF-71536241129A@canonical.com>
 <20180610051420.GA22601@roeck-us.net>
From:   Rudolf Marek <r.marek@assembler.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=r.marek@assembler.cz; prefer-encrypt=mutual; keydata=
 xsBNBFN2VH4BCADpv+3Tkikr+X489Xso9UC719YdxgGiy0xBjDiWC22wAd3tHy6G3nEhWfh4
 1UNGcqscPAvJMn2GhgSJRfBzj0wALXLkoTYta78wEK+Ji+Gs7PX9VhqRKt9/OIn/2XJ1Yv9i
 e8uo9MFBGFCB5roz+Ws8rdXq0Quu7VZylzRv7qqhxMAk9RvXCT2tyt6XY16R7ZEL9wbSLRAl
 h8LRPMF0iiLH1YenfSCX2XkW7eA7CJSjh9pwIBFOF5cd5mcT69OPO+TuAbdvgCcZPEoQQBhk
 QmOr2PlUOl3CSgqtTxjAjAxXhPTU7Q3xxgB2Oa7xbt3Eic2Z4lltP/dowULZqXvsC5DxABEB
 AAHNI1J1ZG9sZiBNYXJlayA8ci5tYXJla0Bhc3NlbWJsZXIuY3o+wsB+BBMBAgAoBQJTdlR+
 AhsjBQkJZgGABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDAb22rZM9dcMf1B/97PHhB
 YaPoM4PHlk3o3HEs0ZxiJyVqDLpmM8kOh+Pcvb40KX0uebiODfeff+RYJWOff27la7AzqG20
 dEAi3hpHYVigZWf3BaLXwCbUKlyLLydks4qydfKBG62PnM74sW1M/sfFA/bdzC9tnjy4G9r9
 mXNBJBDHb4XuHeukqlrMLDDGW78wrfv4tjtW9Z3Aoroja9CnxREt6c3iHA50TX65BrthPxhF
 c+ES+4J/uuBe6pfq9PN8HZKBWgK+jhCoyCajck964ccVF1a2uTRhN39gXtA2YpKUqb+dcsp+
 2NH2eBVYZYaPVJIoIWPxhriOHszs+NjOkk+jBw2gVLy4bmOlzsBNBFN2VH4BCADsg91uA/mm
 l6APO+aWyqkiPjENreT2DT2gmoaEkp07jZrzNcQrLyNhGhsH6+UtCJLV9YNHbfJb7wsfXmXh
 IRh+TQYLJlrU4tBqvVB0F24+MEAFdt/1/jAmaihRZWKdE/Ogtt0YV7BEKfJk2KZxrG4wLB4G
 g57kI+aVmoVRl7/WmM46JpOJhBqvI6/Pw/ZIDhJZfrOXCCWM3pYjx0ftkkULPl6E6dXv3V7N
 9dMV4bqNj4PDfysptFoVo02AblHqMmmBQ2LcI+o5HNm2iPyTklKMmq8Z5kblXDR6GXe2rO5c
 5j0vQ6q5uSyVa30JNJcfl2iUT2akFv7n+RRWhlyCItjpABEBAAHCwGUEGAECAA8FAlN2VH4C
 GwwFCQlmAYAACgkQwG9tq2TPXXAq4Af/UhDBiEaW/s1gDmtci6ZBTDetOdWGx69dzD2rIm1b
 OoQiO1EZ+WNFe0RFmMByfCsRVXP4iD/Ly1l0c6ZNvCBPR+ssXlnltE0Z1S43ZrR4gYjWw2GM
 y1EcSOLv6Yvt/+8IS6YANlzR6RRBs2pM1ndM2AhI43k2rpGFarNEX7z9QrdcoZ4rY94DUGwZ
 0hlQ5VrGt/DAnMkJmOkr6Yriiybw8COnw4qigLfZH6b87vUqdBjRr3BR0iD3ahiXUY0bhlX2
 bQE1IdT8+enQsm4+ePcC8Oihl8Y9JI/cBCw3eEZOl2p1+8aRq7tGkLsilWXUCDJ2kCDQixCJ
 RoTzi/gSro2qhg==
Message-ID: <abf1f966-f56f-70f2-7c79-047b31fc066f@assembler.cz>
Date:   Fri, 15 Jun 2018 23:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180610051420.GA22601@roeck-us.net>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Please can you help?

Thanks
Rudolf


Dne 10.6.2018 v 07:14 Guenter Roeck napsal(a):
> On Sun, Jun 10, 2018 at 03:03:47AM +0800, Kai-Heng Feng wrote:
>> at 23:49, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>> On Thu, Jun 07, 2018 at 11:03:13AM +0800, Kai Heng Feng wrote:
>>>> Hi Guenter,
>>>>
>>>> A user thinks the Ryzen 2700 temperature may not be correct [1].
>>>> Can you take a look when you have time? Thanks.
>>>>
>>>> Also, where can I find all these temperature offsets? I googled but with
>>>> no
>>>> result.
>>> Problem is that the offsets are not documented in public, making it
>>> difficult to find out. For Ryzen 2700, there is currently no offset
>>> configured; I was told that there is none. For Ryzen 2700X, the offset
>>> is 10 degrees C.
>>
>> I am still quite interesting where you get this information...
>>
> Primarily lots of online research. Windows tools usually support the
> offsets, so screendumps help in some cases. 
> 
>>>
>>>> [1] https://bugs.launchpad.net/bugs/1774817
>>>
>>> The key here is the commit mentioned in the log (1b59788979acd). It does
>>> not only adjust the per-CPU offset, but also takes a configurable offset
>>> of 49 degrees C into account. You'll need to apply that patch in your
>>> kernel, or the temperature may be off by 49 degrees C.
>>
>> So unless AMD shares these offsets value, we can never know what correct
>> offsets are?
>>
> Unfortunately that is correct.
> 
> AFAIK the information is available from AMD under NDA. I can not sign such an
> NDA, and even if I could and would, I could not use the information in an open
> source driver. Kind of a loose-loose situation. If you (Canonical) have any
> influence at AMD, it might be useful to let them know that their policy is
> not very helpful.
> 
> Guenter
> 
> 
>> Kai-Heng
>>
>>>
>>> Hope this helps. If not, please let me know. Note that I am travelling;
>>> responses may be delayed.
>>>
>>> Guenter
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
