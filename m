Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753827AbeC1TMM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:12:12 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33379 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753769AbeC1TMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:12:09 -0400
X-Google-Smtp-Source: AIpwx4+7tGWBocvCrUZydweEFDESrQfSQ1HiVKO3bctH+W9PnczrYTNth6CI4zmAKc+nClUGV0WqZmC0rwZk7lwn8rk=
MIME-Version: 1.0
In-Reply-To: <fd5993b4-0b0a-3c65-65a8-b26445d0d440@c-s.fr>
References: <20180322202007.23088-1-malat@debian.org> <20180322202007.23088-12-malat@debian.org>
 <fd5993b4-0b0a-3c65-65a8-b26445d0d440@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 28 Mar 2018 21:11:48 +0200
X-Google-Sender-Auth: UM37DOUIsOWREAOknxBo6eEdFQ4
Message-ID: <CA+7wUsxtWCoE1rxP6e57MEfB_zjLUzTa36CD=TyZS4_DkrQ81Q@mail.gmail.com>
Subject: Re: [PATCH 11/19] powerpc/powermac: Move pmac_pfunc_base_install
 prototype to header file
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SJCIIf005067

On Fri, Mar 23, 2018 at 1:13 PM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 22/03/2018 à 21:19, Mathieu Malaterre a écrit :
>>
>> The pmac_pfunc_base_install prototype was declared in powermac/smp.c since
>> function was used there, move it to pmac_pfunc.h header to be visible in
>> pfunc_base.c. Fix a warning treated as error with W=1:
>>
>>    arch/powerpc/platforms/powermac/pfunc_base.c:330:12: error: no previous
>> prototype for ‘pmac_pfunc_base_install’ [-Werror=missing-prototypes]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/include/asm/pmac_pfunc.h | 1 +
>>   arch/powerpc/platforms/powermac/smp.c | 1 -
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/pmac_pfunc.h
>> b/arch/powerpc/include/asm/pmac_pfunc.h
>> index 73bd8f28f2a8..99f7a288789a 100644
>> --- a/arch/powerpc/include/asm/pmac_pfunc.h
>> +++ b/arch/powerpc/include/asm/pmac_pfunc.h
>> @@ -245,6 +245,7 @@ extern void pmf_put_function(struct pmf_function
>> *func);
>>     extern int pmf_call_one(struct pmf_function *func, struct pmf_args
>> *args);
>>   +extern int pmac_pfunc_base_install(void);
>
>
>
> extern keyword is not needed

I understand; but for consistency every single protoypes in this
header file actually use the extern keyword. Is there a guide/best
practice to refer to in this case ?

> Christophe
>
>>     /* Suspend/resume code called by via-pmu directly for now */
>>   extern void pmac_pfunc_base_suspend(void);
>> diff --git a/arch/powerpc/platforms/powermac/smp.c
>> b/arch/powerpc/platforms/powermac/smp.c
>> index 95275e0e2efa..447da6db450a 100644
>> --- a/arch/powerpc/platforms/powermac/smp.c
>> +++ b/arch/powerpc/platforms/powermac/smp.c
>> @@ -65,7 +65,6 @@
>>   #endif
>>     extern void __secondary_start_pmac_0(void);
>> -extern int pmac_pfunc_base_install(void);
>>     static void (*pmac_tb_freeze)(int freeze);
>>   static u64 timebase;
>>
>
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le
> logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
