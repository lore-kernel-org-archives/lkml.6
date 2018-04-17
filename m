Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeDQQtr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:49:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63091 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754473AbeDQQtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:49:45 -0400
Subject: Re: [PATCH] powerpc: Allow selection of
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
 <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr>
Date: Tue, 17 Apr 2018 18:49:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/04/2018 à 18:45, Mathieu Malaterre a écrit :
> On Tue, Apr 17, 2018 at 12:49 PM, Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> This option does dead code and data elimination with the linker by
>> compiling with -ffunction-sections -fdata-sections and linking with
>> --gc-sections.
>>
>> By selecting this option on mpc885_ads_defconfig,
>> vmlinux LOAD segment size gets reduced by 10%
>>
>> Program Header before the patch:
>>      LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
>>           filesz 0x0036eda4 memsz 0x0038de04 flags rwx
>>
>> Program Header after the patch:
>>      LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
>>           filesz 0x00316da4 memsz 0x00334268 flags rwx
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/Kconfig | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 8fe4353be5e3..e1fac49cf465 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -888,6 +888,14 @@ config PPC_MEM_KEYS
>>
>>            If unsure, say y.
>>
>> +config PPC_UNUSED_ELIMINATION
>> +       bool "Eliminate unused functions and data from vmlinux"
>> +       default n
>> +       select LD_DEAD_CODE_DATA_ELIMINATION
>> +       help
>> +         Select this to do dead code and data elimination with the linker
>> +         by compiling with -ffunction-sections -fdata-sections and linking
>> +         with --gc-sections.
>>   endmenu
>>
> 
> Just for reference, I cannot boot my Mac Mini G4 anymore (yaboot). The
> messages I can see (prom_init) are:

Which version of GCC do you use ?

Can you provide the generated System.map with and without that option 
active ?

Thanks
Christophe

> 
> ---
> done
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x01100000 -> 0x01100e02
> Device tree struct   0x01101000 -> 0x01109000
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x00140000 ...
> _
> ---
> 
> 
> 
>>   config ISA_DMA_API
>> --
>> 2.13.3
>>
