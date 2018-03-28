Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeC1Lx1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 07:53:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33185 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbeC1LxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 07:53:22 -0400
X-Google-Smtp-Source: AIpwx48Mi3T/zLTZ4RJbuHBikuRgaLchfTtacTuBWQmS68F4yriWxqY+s5cOnJtgTnuaR7FsvaJRT7zJNgz4z3XEBds=
MIME-Version: 1.0
In-Reply-To: <CA+7wUsz-ihu7aoE4UfVhojDjH0pcR8QbVGLCzMyA3RocLJz5-A@mail.gmail.com>
References: <20180322202007.23088-1-malat@debian.org> <20180322202007.23088-15-malat@debian.org>
 <97df68d1-d4fe-bf8e-7852-9b418eec042f@c-s.fr> <CA+7wUsxVW1a2yvyhYv=YFNV1VEQCcro5JDN1RewghVaHDq5znw@mail.gmail.com>
 <20180324211020.Horde.kEO4b3mHPV88FKM0OiRT0Q1@messagerie.si.c-s.fr>
 <CA+7wUszsJUJJeb+xhzjGr8YxDt-BYruBwda7Dq-nFfyt0sU0ew@mail.gmail.com>
 <20180327175806.Horde.f26UMak3wqEtNtiMmJy51w2@messagerie.si.c-s.fr>
 <20180327193323.Horde.S-Hqc40p7JjEsZPPEa3YNg1@messagerie.si.c-s.fr> <CA+7wUsz-ihu7aoE4UfVhojDjH0pcR8QbVGLCzMyA3RocLJz5-A@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 28 Mar 2018 13:53:01 +0200
X-Google-Sender-Auth: TaDBkyEnnRYq4ERM-kdoSYiEC4c
Message-ID: <CA+7wUsxjkceXWosOaGwd4Rw7NkPiRoCd9BeMm9QfmOJ3v4nD5Q@mail.gmail.com>
Subject: Re: [PATCH 14/19] powerpc/altivec: Add missing prototypes for altivec
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SBrW7H013621

On Wed, Mar 28, 2018 at 9:26 AM, Mathieu Malaterre <malat@debian.org> wrote:
> On Tue, Mar 27, 2018 at 7:33 PM, LEROY Christophe
> <christophe.leroy@c-s.fr> wrote:
>> LEROY Christophe <christophe.leroy@c-s.fr> a écrit :
>>
>>
>>> Mathieu Malaterre <malat@debian.org> a écrit :
>>>
>>>> Christophe,
>>>>
>>>> On Sat, Mar 24, 2018 at 9:10 PM, LEROY Christophe
>>>> <christophe.leroy@c-s.fr> wrote:
>>>>>
>>>>> Mathieu Malaterre <malat@debian.org> a écrit :
>>>>>
>>>>>
>>>>>> On Fri, Mar 23, 2018 at 1:19 PM, christophe leroy
>>>>>> <christophe.leroy@c-s.fr> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Le 22/03/2018 à 21:20, Mathieu Malaterre a écrit :
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Some functions prototypes were missing for the non-altivec code. Add
>>>>>>>> the
>>>>>>>> missing prototypes directly in xor_vmx, fix warnings treated as
>>>>>>>> errors
>>>>>>>> with
>>>>>>>> W=1:
>>>>>>>>
>>>>>>>>   arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype
>>>>>>>> for
>>>>>>>> ‘xor_altivec_2’ [-Werror=missing-prototypes]
>>>>>>>>   arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype
>>>>>>>> for
>>>>>>>> ‘xor_altivec_3’ [-Werror=missing-prototypes]
>>>>>>>>   arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype
>>>>>>>> for
>>>>>>>> ‘xor_altivec_4’ [-Werror=missing-prototypes]
>>>>>>>>   arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype
>>>>>>>> for
>>>>>>>> ‘xor_altivec_5’ [-Werror=missing-prototypes]
>>>>>>>>
>>>>>>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>>>>>>> ---
>>>>>>>>  arch/powerpc/lib/xor_vmx.h | 14 ++++++++++++++
>>>>>>>>  1 file changed, 14 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
>>>>>>>> index 5c2b0839b179..2173e3c84151 100644
>>>>>>>> --- a/arch/powerpc/lib/xor_vmx.h
>>>>>>>> +++ b/arch/powerpc/lib/xor_vmx.h
>>>>>>>> @@ -19,3 +19,17 @@ void __xor_altivec_4(unsigned long bytes, unsigned
>>>>>>>> long
>>>>>>>> *v1_in,
>>>>>>>>  void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>>>>>>>>                             unsigned long *v2_in, unsigned long
>>>>>>>> *v3_in,
>>>>>>>>                             unsigned long *v4_in, unsigned long
>>>>>>>> *v5_in);
>>>>>>>> +
>>>>>>>> +void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
>>>>>>>> +                            unsigned long *v2_in);
>>>>>>>> +
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Only used in one place, should be static instead of adding it in a .h
>>>>>>>
>>>>>>> Same for the other ones.
>>>>>>
>>>>>>
>>>>>>
>>>>>> $ git grep xor_altivec_2
>>>>>> [...]
>>>>>> arch/powerpc/lib/xor_vmx_glue.c:EXPORT_SYMBOL(xor_altivec_2);
>>>>>>
>>>>>> Are you sure I can change this function to static ?
>>>>>
>>>>>
>>>>>
>>>>> Yes you are right.  But in fact those fonctions are already defined in
>>>>> asm/xor. h
>>>>> So you just need to add the missing #include
>>>>
>>>>
>>>> I originally tried it, but this leads to:
>>>>
>>>>  CC      arch/powerpc/lib/xor_vmx_glue.o
>>>> In file included from arch/powerpc/lib/xor_vmx_glue.c:16:0:
>>>> ./arch/powerpc/include/asm/xor.h:39:15: error: variable
>>>> ‘xor_block_altivec’ has initializer but incomplete type
>>>> static struct xor_block_template xor_block_altivec = {
>>>>               ^~~~~~~~~~~~~~~~~~
>>>> ./arch/powerpc/include/asm/xor.h:40:2: error: unknown field ‘name’
>>>> specified in initializer
>>>>  .name = "altivec",
>>>>  ^
>>>> [...]
>>>>
>>>> The file <asm/xor.h> (powerpc) is pretty much expected to be included
>>>> after <include/linux/raid/xor.h>.
>>>>
>>>> I did not want to tweak <asm/xor.h> to test for #ifdef _XOR_H just before
>>>>
>>>> #ifdef _XOR_H
>>>> static struct xor_block_template xor_block_altivec = {
>>>> [...]
>>>>
>>>> since this seems like a hack to me.
>>>>
>>>> Is this ok to test for #ifdef _XOR_H in <arch/powerpc/include/asm/xor.h>
>>>> ?
>>>
>>>
>>> What about including linux/raid/xor.h in asm/xor.h ?
>
> This leads to:
>
>   CALL    ../arch/powerpc/kernel/systbl_chk.sh
> In file included from ../arch/powerpc/include/asm/xor.h:57:0,
>                  from ../arch/powerpc/lib/xor_vmx_glue.c:17:
> ../include/asm-generic/xor.h:688:34: error: ‘xor_block_32regs’ defined
> but not used [-Werror=unused-variable]
>  static struct xor_block_template xor_block_32regs = {
>                                   ^~~~~~~~~~~~~~~~
> ../include/asm-generic/xor.h:680:34: error: ‘xor_block_8regs’ defined
> but not used [-Werror=unused-variable]
>  static struct xor_block_template xor_block_8regs = {
>                                   ^~~~~~~~~~~~~~~
> In file included from ../arch/powerpc/lib/xor_vmx_glue.c:17:0:
> ../arch/powerpc/include/asm/xor.h:39:34: error: ‘xor_block_altivec’
> defined but not used [-Werror=unused-variable]
>  static struct xor_block_template xor_block_altivec = {
>                                   ^~~~~~~~~~~~~~~~~
>   CALL    ../arch/powerpc/kernel/prom_init_check.sh
>

I'll prepare a patch which moves the prototypes from
arch/powerpc/include/asm/xor.h to
arch/powerpc/include/asm/xor_altivec.h (new file). I believe this
should be the simplest path.

>>
>> Or better: including linux/raid/xor.h then asm/xor.h in xor_vmx_glue.c ?
>>
>> Christophe
>>
>>>
>>> Christophe
>>>>
>>>>
>>>>> Christophe
>>>>>
>>>>>
>>>>>>
>>>>>>> Christophe
>>>>>>>
>>>>>>>
>>>>>>>> +void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
>>>>>>>> +                            unsigned long *v2_in, unsigned long
>>>>>>>> *v3_in);
>>>>>>>> +
>>>>>>>> +void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
>>>>>>>> +                            unsigned long *v2_in, unsigned long
>>>>>>>> *v3_in,
>>>>>>>> +                            unsigned long *v4_in);
>>>>>>>> +
>>>>>>>> +void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>>>>>>>> +                            unsigned long *v2_in, unsigned long
>>>>>>>> *v3_in,
>>>>>>>> +                            unsigned long *v4_in, unsigned long
>>>>>>>> *v5_in);
>>>>>>>>
>>>>>>>
>>>>>>> ---
>>>>>>> L'absence de virus dans ce courrier électronique a été vérifiée par le
>>>>>>> logiciel antivirus Avast.
>>>>>>> https://www.avast.com/antivirus
>>>>>>>
>>>>>
>>>>>
>>
>>
