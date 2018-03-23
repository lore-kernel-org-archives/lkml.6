Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeCWMZQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:25:16 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:39101 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeCWMZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:25:14 -0400
X-Google-Smtp-Source: AG47ELs+MAx8oil7cfeFoeZi/kbHZnVMIMWepSfFgu7p3IoTORTX/Jy6coLAeu0YEogp72TDNLqviD+0H8m1kNtjVB0=
MIME-Version: 1.0
In-Reply-To: <97df68d1-d4fe-bf8e-7852-9b418eec042f@c-s.fr>
References: <20180322202007.23088-1-malat@debian.org> <20180322202007.23088-15-malat@debian.org>
 <97df68d1-d4fe-bf8e-7852-9b418eec042f@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 23 Mar 2018 13:24:53 +0100
X-Google-Sender-Auth: ED6DUJ_ePdJorOKnL40ktWzaQLU
Message-ID: <CA+7wUsxVW1a2yvyhYv=YFNV1VEQCcro5JDN1RewghVaHDq5znw@mail.gmail.com>
Subject: Re: [PATCH 14/19] powerpc/altivec: Add missing prototypes for altivec
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2NCPLwq022395

On Fri, Mar 23, 2018 at 1:19 PM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 22/03/2018 à 21:20, Mathieu Malaterre a écrit :
>>
>> Some functions prototypes were missing for the non-altivec code. Add the
>> missing prototypes directly in xor_vmx, fix warnings treated as errors
>> with
>> W=1:
>>
>>    arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype for
>> ‘xor_altivec_2’ [-Werror=missing-prototypes]
>>    arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype for
>> ‘xor_altivec_3’ [-Werror=missing-prototypes]
>>    arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype for
>> ‘xor_altivec_4’ [-Werror=missing-prototypes]
>>    arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype for
>> ‘xor_altivec_5’ [-Werror=missing-prototypes]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/lib/xor_vmx.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
>> index 5c2b0839b179..2173e3c84151 100644
>> --- a/arch/powerpc/lib/xor_vmx.h
>> +++ b/arch/powerpc/lib/xor_vmx.h
>> @@ -19,3 +19,17 @@ void __xor_altivec_4(unsigned long bytes, unsigned long
>> *v1_in,
>>   void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>>                              unsigned long *v2_in, unsigned long *v3_in,
>>                              unsigned long *v4_in, unsigned long *v5_in);
>> +
>> +void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
>> +                            unsigned long *v2_in);
>> +
>
>
> Only used in one place, should be static instead of adding it in a .h
>
> Same for the other ones.

$ git grep xor_altivec_2
[...]
arch/powerpc/lib/xor_vmx_glue.c:EXPORT_SYMBOL(xor_altivec_2);

Are you sure I can change this function to static ?

> Christophe
>
>
>> +void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
>> +                            unsigned long *v2_in, unsigned long *v3_in);
>> +
>> +void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
>> +                            unsigned long *v2_in, unsigned long *v3_in,
>> +                            unsigned long *v4_in);
>> +
>> +void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>> +                            unsigned long *v2_in, unsigned long *v3_in,
>> +                            unsigned long *v4_in, unsigned long *v5_in);
>>
>
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le
> logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
