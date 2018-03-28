Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753726AbeC1TOB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:14:01 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42737 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbeC1TOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:14:00 -0400
X-Google-Smtp-Source: AIpwx48NNjxh7xJkcQc9nahVavsjWcmr27sVzlD7ofNAWMDPTh6gby7/VPUlCHMdbVjnZfrV99v873mrxObWfxPd7DQ=
MIME-Version: 1.0
In-Reply-To: <bd4be06c-b5f5-2516-1c1d-d2b6d7861090@c-s.fr>
References: <20180322202007.23088-1-malat@debian.org> <20180322202007.23088-16-malat@debian.org>
 <bd4be06c-b5f5-2516-1c1d-d2b6d7861090@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 28 Mar 2018 21:13:39 +0200
X-Google-Sender-Auth: RgUpYIYew_iIEDQcVV6H4b4RnRc
Message-ID: <CA+7wUsyRSSkwgpBodKkPjhUxiHy-t1q2Q7nsorfRoL=wfxgyFQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] powerpc: Add missing prototype
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2SJE6Br005471

On Fri, Mar 23, 2018 at 1:20 PM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 22/03/2018 à 21:20, Mathieu Malaterre a écrit :
>>
>> Add one missing prototype for function rh_dump_blk. Fix warning treated as
>> error in W=1:
>>
>>    arch/powerpc/lib/rheap.c:740:6: error: no previous prototype for
>> ‘rh_dump_blk’ [-Werror=missing-prototypes]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/include/asm/rheap.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/rheap.h
>> b/arch/powerpc/include/asm/rheap.h
>> index 172381769cfc..e75d96de19a0 100644
>> --- a/arch/powerpc/include/asm/rheap.h
>> +++ b/arch/powerpc/include/asm/rheap.h
>> @@ -83,6 +83,9 @@ extern int rh_get_stats(rh_info_t * info, int what, int
>> max_stats,
>>   /* Simple dump of remote heap info */
>>   extern void rh_dump(rh_info_t * info);
>>   +/* Simple dump of remote info block */
>> +extern void rh_dump_blk(rh_info_t *info, rh_block_t *blk);
>> +
>
>
> Only used in one place, should be static

Well here is what I see over here:

$ git grep rh_dump_blk
...
arch/powerpc/lib/rheap.c:EXPORT_SYMBOL_GPL(rh_dump_blk);



> Christophe
>
>>   /* Set owner of taken block */
>>   extern int rh_set_owner(rh_info_t * info, unsigned long start, const
>> char *owner);
>>
>
>
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le
> logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
