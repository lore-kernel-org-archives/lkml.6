Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeBIOxK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:53:10 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:38148 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeBIOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:53:09 -0500
Subject: Re: [PATCH] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Palmer Dabbelt <palmer@sifive.com>, <antonynpavlov@gmail.com>,
        "Linux MIPS Mailing List" <linux-mips@linux-mips.org>,
        <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <mhng-f000d448-7ead-4cee-9e2f-5d58692c0922@palmer-si-x1c4>
 <1518182572-23376-1-git-send-email-matt.redfearn@mips.com>
 <CAHp75VeiAUg1NCK59wZjZNnLZqEXDF5dpi8pmtTcP1WhX2wvVA@mail.gmail.com>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <30b2cff6-ad18-617e-cc11-ad2188193c3a@mips.com>
Date: Fri, 9 Feb 2018 14:52:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeiAUg1NCK59wZjZNnLZqEXDF5dpi8pmtTcP1WhX2wvVA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1518187973-452060-5654-53521-1
X-BESS-VER: 2018.1.1-r1801291958
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189857
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 09/02/18 13:45, Andy Shevchenko wrote:
> On Fri, Feb 9, 2018 at 3:22 PM, Matt Redfearn <matt.redfearn@mips.com> wrote:
>> When these are included into arch Kconfig files, maintaining
>> alphabetical ordering of the selects means these get split up. To allow
>> for keeping things tidier and alphabetical, rename the selects to
>> GENERIC_LIB_*
>>
> 
> I don't remember who suggested that, if it wasn't you, please add
> Suggested-by tag with appropriate name.

It was me that suggested the rename, before we ack replacing MIPS' 
compiler intrinsics with these generic ones.

Thanks,
Matt


> 
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> ---
>>   arch/riscv/Kconfig |  6 +++---
>>   lib/Kconfig        | 12 ++++++------
>>   lib/Makefile       | 12 ++++++------
>>   3 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 2c6adf12713a..5f1e2188d029 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -99,9 +99,9 @@ config ARCH_RV32I
>>          bool "RV32I"
>>          select CPU_SUPPORTS_32BIT_KERNEL
>>          select 32BIT
>> -       select GENERIC_ASHLDI3
>> -       select GENERIC_ASHRDI3
>> -       select GENERIC_LSHRDI3
>> +       select GENERIC_LIB_ASHLDI3
>> +       select GENERIC_LIB_ASHRDI3
>> +       select GENERIC_LIB_LSHRDI3
>>
>>   config ARCH_RV64I
>>          bool "RV64I"
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index c5e84fbcb30b..946d0890aad6 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -584,20 +584,20 @@ config STRING_SELFTEST
>>
>>   endmenu
>>
>> -config GENERIC_ASHLDI3
>> +config GENERIC_LIB_ASHLDI3
>>          bool
>>
>> -config GENERIC_ASHRDI3
>> +config GENERIC_LIB_ASHRDI3
>>          bool
>>
>> -config GENERIC_LSHRDI3
>> +config GENERIC_LIB_LSHRDI3
>>          bool
>>
>> -config GENERIC_MULDI3
>> +config GENERIC_LIB_MULDI3
>>          bool
>>
>> -config GENERIC_CMPDI2
>> +config GENERIC_LIB_CMPDI2
>>          bool
>>
>> -config GENERIC_UCMPDI2
>> +config GENERIC_LIB_UCMPDI2
>>          bool
>> diff --git a/lib/Makefile b/lib/Makefile
>> index d11c48ec8ffd..7e1ef77e86a3 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -252,9 +252,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
>>   obj-$(CONFIG_PARMAN) += parman.o
>>
>>   # GCC library routines
>> -obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
>> -obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
>> -obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
>> -obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
>> -obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
>> -obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
>> +obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
>> +obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
>> +obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
>> +obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>> +obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>> +obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
>> --
>> 2.7.4
>>
> 
> 
> 
