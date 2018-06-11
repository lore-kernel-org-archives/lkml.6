Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6TMNNdILHluHLAAAmS7hNA
	; Mon, 11 Jun 2018 05:42:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 62C1D608FD; Mon, 11 Jun 2018 05:42:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CED1B607E7;
	Mon, 11 Jun 2018 05:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CED1B607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=siemens.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeFKFmj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:42:39 -0400
Received: from goliath.siemens.de ([192.35.17.28]:44662 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753750AbeFKFmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:42:38 -0400
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id w5B5g5tF008227
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jun 2018 07:42:05 +0200
Received: from [167.87.36.205] ([167.87.36.205])
        by mail1.siemens.de (8.15.2/8.15.2) with ESMTP id w5B5g4s4019474;
        Mon, 11 Jun 2018 07:42:04 +0200
Subject: Re: [PATCH] arm: Initialize hrtimer-based broadcast clockevent
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <86a7e675-11bd-3b8b-22a0-8f440db96293@siemens.com>
 <8f2fd3b9-416a-992e-5ca6-fc83aad5700d@siemens.com>
 <35966a15-8312-5ba9-ef76-33a6cfda1f32@siemens.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.kiszka@siemens.com; prefer-encrypt=mutual; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYwQTEQIAIwIbIwYLCQgHAwIEFQIIAwQWAgMBAh4BAheA
 BQJOpoNtAhkBAAoJEIrUrG965ecUOPUAoK+Rh12KgCjplHAS0AoiGKwGOuq7AKDEVnBtRAoy
 VRvp3lOlOx+P2Ay56M7BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepK
 vIfiM8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+
 bgvMOsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hncls
 Z/IYhXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVOR
 TOtzFK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5
 gz88SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI
 3KCT67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdI
 vttwzG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPx
 bRea9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zp
 q61toNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+N
 K8JJBBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wH
 AJ46S16yab+OxNkvOeoOEX0EnHVHaA==
Message-ID: <e24a907f-d016-5587-a62e-0046f60d9536@siemens.com>
Date: Mon, 11 Jun 2018 07:42:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <35966a15-8312-5ba9-ef76-33a6cfda1f32@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 17:54, Jan Kiszka wrote:
> On 2018-03-01 07:04, Jan Kiszka wrote:
>> On 2018-01-22 07:06, Jan Kiszka wrote:
>>> Analogously to 9358d755bd5c, this registers a broadcast clockevent in
>>> case no hardware broadcast timer is available and the per-CPU timers can
>>> be stopped in deep power states.
>>>
>>> Partitions of the Jailhouse hypervisor fall in this category.
>>> Registering the workaround timer allows to enter high-resolution mode in
>>> that case.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  arch/arm/kernel/time.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
>>> index 629f8e9981f1..0a45d861ef8e 100644
>>> --- a/arch/arm/kernel/time.c
>>> +++ b/arch/arm/kernel/time.c
>>> @@ -12,6 +12,7 @@
>>>   *  reading the RTC at bootup, etc...
>>>   */
>>>  #include <linux/clk-provider.h>
>>> +#include <linux/clockchips.h>
>>>  #include <linux/clocksource.h>
>>>  #include <linux/errno.h>
>>>  #include <linux/export.h>
>>> @@ -121,5 +122,7 @@ void __init time_init(void)
>>>  		of_clk_init(NULL);
>>>  #endif
>>>  		timer_probe();
>>> +
>>> +		tick_setup_hrtimer_broadcast();
>>>  	}
>>>  }
>>>
>>
>> Gentle ping, just to avoid that this falls through the cracks because
>> it's so small.
>>
> 
> 2nd ping. Should this patch be routed via ARM or rather some tip/timers
> tree?
> 

3rd try: Could someone have a look at this and merge it - or at least
ack it in order to move forward?

Thanks,
Jan
