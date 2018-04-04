Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeDDUVX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 16:21:23 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37417 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeDDUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 16:21:21 -0400
X-Google-Smtp-Source: AIpwx49zD4scP09Mt/0bS0GHgB1eMjSIBv081M1YB68IecXhfhvPD8uszJIWaIcvu6u9LFQFQxbv48vUYv337w0FvEA=
MIME-Version: 1.0
In-Reply-To: <20180329180743.Horde.0e_zt3S4Pqcv7Z0dJwOgOg9@messagerie.si.c-s.fr>
References: <20180322202007.23088-2-malat@debian.org> <20180328192717.656-1-malat@debian.org>
 <20180329180743.Horde.0e_zt3S4Pqcv7Z0dJwOgOg9@messagerie.si.c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 4 Apr 2018 22:21:00 +0200
X-Google-Sender-Auth: dn59x4QpYktff1SddH3_72fgPE4
Message-ID: <CA+7wUszBw9Jw8z7x6h-OO=-LfxSWYS08DTTBozkPg08KbAzBNA@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] powerpc/powermac: Mark variable x as unused
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34KLUjA027544

On Thu, Mar 29, 2018 at 6:07 PM, LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
> Mathieu Malaterre <malat@debian.org> a écrit :
>
>
>> Since the value of x is never intended to be read, declare it with gcc
>> attribute as unused. Fix warning treated as error with W=1:
>>
>>   arch/powerpc/platforms/powermac/bootx_init.c:471:21: error: variable ‘x’
>> set but not used [-Werror=unused-but-set-variable]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> v2: move x variable within its local scope
>>
>>  arch/powerpc/platforms/powermac/bootx_init.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/powermac/bootx_init.c
>> b/arch/powerpc/platforms/powermac/bootx_init.c
>> index c3c9bbb3573a..d44e8571c1ec 100644
>> --- a/arch/powerpc/platforms/powermac/bootx_init.c
>> +++ b/arch/powerpc/platforms/powermac/bootx_init.c
>> @@ -468,7 +468,7 @@ void __init bootx_init(unsigned long r3, unsigned long
>> r4)
>>         boot_infos_t *bi = (boot_infos_t *) r4;
>>         unsigned long hdr;
>>         unsigned long space;
>> -       unsigned long ptr, x;
>> +       unsigned long ptr;
>>         char *model;
>>         unsigned long offset = reloc_offset();
>>
>> @@ -562,6 +562,7 @@ void __init bootx_init(unsigned long r3, unsigned long
>> r4)
>>          * MMU switched OFF, so this should not be useful anymore.
>>          */
>>         if (bi->version < 4) {
>> +               unsigned long x __maybe_unused;
>>                 bootx_printf("Touching pages...\n");
>
>
> Stylewise, there should be an empty line after your declaration.

See v3

> But I believe you should remove that ugly loop and replace it by a call to
> fault_in_pages_readable()

I have no idea on how to test the the new code, and it did not look
straightforward.

> Christophe
>>
>>
>>                 /*
>> --
>> 2.11.0
>
>
>
