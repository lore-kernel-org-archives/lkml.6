Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753511AbeCXUKc convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:10:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62780 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752754AbeCXUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:10:30 -0400
Date: Sat, 24 Mar 2018 21:10:20 +0100
Message-ID: <20180324211020.Horde.kEO4b3mHPV88FKM0OiRT0Q1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 14/19] powerpc/altivec: Add missing prototypes for
 altivec
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-15-malat@debian.org>
 <97df68d1-d4fe-bf8e-7852-9b418eec042f@c-s.fr>
 <CA+7wUsxVW1a2yvyhYv=YFNV1VEQCcro5JDN1RewghVaHDq5znw@mail.gmail.com>
In-Reply-To: <CA+7wUsxVW1a2yvyhYv=YFNV1VEQCcro5JDN1RewghVaHDq5znw@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> a écrit :

> On Fri, Mar 23, 2018 at 1:19 PM, christophe leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>>
>> Le 22/03/2018 à 21:20, Mathieu Malaterre a écrit :
>>>
>>> Some functions prototypes were missing for the non-altivec code. Add the
>>> missing prototypes directly in xor_vmx, fix warnings treated as errors
>>> with
>>> W=1:
>>>
>>>    arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype for
>>> ‘xor_altivec_2’ [-Werror=missing-prototypes]
>>>    arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype for
>>> ‘xor_altivec_3’ [-Werror=missing-prototypes]
>>>    arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype for
>>> ‘xor_altivec_4’ [-Werror=missing-prototypes]
>>>    arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype for
>>> ‘xor_altivec_5’ [-Werror=missing-prototypes]
>>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>> ---
>>>   arch/powerpc/lib/xor_vmx.h | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
>>> index 5c2b0839b179..2173e3c84151 100644
>>> --- a/arch/powerpc/lib/xor_vmx.h
>>> +++ b/arch/powerpc/lib/xor_vmx.h
>>> @@ -19,3 +19,17 @@ void __xor_altivec_4(unsigned long bytes, unsigned long
>>> *v1_in,
>>>   void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>>>                              unsigned long *v2_in, unsigned long *v3_in,
>>>                              unsigned long *v4_in, unsigned long *v5_in);
>>> +
>>> +void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
>>> +                            unsigned long *v2_in);
>>> +
>>
>>
>> Only used in one place, should be static instead of adding it in a .h
>>
>> Same for the other ones.
>
> $ git grep xor_altivec_2
> [...]
> arch/powerpc/lib/xor_vmx_glue.c:EXPORT_SYMBOL(xor_altivec_2);
>
> Are you sure I can change this function to static ?

Yes you are right.  But in fact those fonctions are already defined in  
asm/xor. h
So you just need to add the missing #include

Christophe

>
>> Christophe
>>
>>
>>> +void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
>>> +                            unsigned long *v2_in, unsigned long *v3_in);
>>> +
>>> +void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
>>> +                            unsigned long *v2_in, unsigned long *v3_in,
>>> +                            unsigned long *v4_in);
>>> +
>>> +void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>>> +                            unsigned long *v2_in, unsigned long *v3_in,
>>> +                            unsigned long *v4_in, unsigned long *v5_in);
>>>
>>
>> ---
>> L'absence de virus dans ce courrier électronique a été vérifiée par le
>> logiciel antivirus Avast.
>> https://www.avast.com/antivirus
>>
