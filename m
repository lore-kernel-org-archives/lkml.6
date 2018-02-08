Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBHChx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 21:37:53 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46431 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeBHChv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 21:37:51 -0500
X-Google-Smtp-Source: AH8x225sM1Q3VK80qAB9iuJO58PbHwhIt1h2Ud2jcNsP0k/4GcxmoFdEuVN+RtDVZ9Jlr0cJszWziQ==
Subject: Re: [PATCH] ACPI/IORT: Remove linker section for IORT entries again
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
 <20180207114104.GA22549@e107981-ln.cambridge.arm.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <c2f09386-90c6-809c-127b-87bd3d80c7ca@gmail.com>
Date: Thu, 8 Feb 2018 10:37:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207114104.GA22549@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2018 7:41 PM, Lorenzo Pieralisi Wrote:
> On Tue, Feb 06, 2018 at 08:11:34PM -0800, Jia He wrote:
>> In commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
>> probing"), iort entries was removed in vmlinux.lds.h. But in
>> commit 2fcc112af37f ("clocksource/drivers: Rename clksrc table to timer"),
>> this line was back incorrectly.
>>
>> It does no harm except for adding some useless symbols, so fix it.
>>
>> Signed-off-by: Jia He <hejianet@gmail.com>
forget to add another Signed-off-by line(because of my company's 
opensource rules)

Signed-off-by: Jia He <jia.he@hxt-semitech.com>

>> ---
>>   include/asm-generic/vmlinux.lds.h | 1 -
>>   1 file changed, 1 deletion(-)
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>
> Who is picking this up ?
Sorry, do you mean who is picking up acpi/iort subsystem?
I can't answer this question. I find this minor bug while doing the code 
review.

Cheers,
Jia
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index 1ab0e52..58b1dab 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -589,7 +589,6 @@
>>   	IRQCHIP_OF_MATCH_TABLE()					\
>>   	ACPI_PROBE_TABLE(irqchip)					\
>>   	ACPI_PROBE_TABLE(timer)						\
>> -	ACPI_PROBE_TABLE(iort)						\
>>   	EARLYCON_TABLE()
>>   
>>   #define INIT_TEXT							\
>> -- 
>> 2.7.4
>>
