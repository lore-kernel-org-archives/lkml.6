Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6841C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9F72087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9F72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeLCRoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:44:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17631 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeLCRoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:44:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 437smq0SDrz9v0l5;
        Mon,  3 Dec 2018 18:43:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id q1YpAMOjcO7b; Mon,  3 Dec 2018 18:43:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 437smp5m9qz9v0l4;
        Mon,  3 Dec 2018 18:43:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A55D8B7B8;
        Mon,  3 Dec 2018 18:43:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id keSRY77Pu0Do; Mon,  3 Dec 2018 18:43:58 +0100 (CET)
Received: from [192.168.232.3] (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BB4C8B79E;
        Mon,  3 Dec 2018 18:43:57 +0100 (CET)
Subject: Re: [PATCH] powerpc/mm: dump block address translation on book3s/32
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        rashmicy@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <26cc609706833f78e3195e3d35c0372b2f40cae3.1542181167.git.christophe.leroy@c-s.fr>
 <878t1uva0q.fsf@concordia.ellerman.id.au>
 <9cb14c1f-02ce-a2a5-94e6-95afb4d3e168@c-s.fr>
 <87o9ap2uif.fsf@concordia.ellerman.id.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <bab9eb25-a6f4-966c-ceaa-00147b50726d@c-s.fr>
Date:   Mon, 3 Dec 2018 18:43:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <87o9ap2uif.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/11/2018 à 11:20, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
>> Le 15/11/2018 à 12:46, Michael Ellerman a écrit :
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> This patch adds a debugfs file to dump block address translation:
>>>>
>>>> ~# cat /sys/kernel/debug/block_address_translation
>>>
>>> My instinct is it should be in /sys/kernel/debug/powerpc. But I guess
>>> the other page table dump files are not.
>>
>> Lol.
>>
>> Looks like we have the same instinct ...
>>
>> But you rejected my patch https://patchwork.ozlabs.org/patch/750426/ :)
> 
> Haha. My argument was that the kernel page table dump is not powerpc
> specific, but this file *is* powerpc specific. Though I guess it's in
> the same are as the page table / hash table dump, so it may as well live
> next to them.

I see you took the first version in next-test. It doesn't handle the 
case of 64bits phys addresses. v3 does.

I just sent v4 which does to v3 the changes you did (__init and powerpc/ 
subdir)

Christophe

> 
>>>> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
>>>> index ca96e7be4d0e..2adad10b5856 100644
>>>> --- a/arch/powerpc/mm/Makefile
>>>> +++ b/arch/powerpc/mm/Makefile
>>>> @@ -47,7 +47,7 @@ ifdef CONFIG_PPC_PTDUMP
>>>>    obj-$(CONFIG_4xx)		+= dump_linuxpagetables-generic.o
>>>>    obj-$(CONFIG_PPC_8xx)		+= dump_linuxpagetables-8xx.o
>>>>    obj-$(CONFIG_PPC_BOOK3E_MMU)	+= dump_linuxpagetables-generic.o
>>>> -obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o
>>>> +obj-$(CONFIG_PPC_BOOK3S_32)	+= dump_linuxpagetables-generic.o dump_bats.o
>>>
>>> BOOK3S_32 covers quite a lot of CPUs.
>>>
>>> But below the only check is that you're on 601 or 603.
>>>
>>> So is the 603 code going to work on all other BOOK3S_32 CPUs?
>>
>> If I understand function setbat() correctly, it should.
>>
>> See
>> https://elixir.bootlin.com/linux/v4.20-rc1/source/arch/powerpc/mm/ppc_mmu_32.c#L115
>> Tell me if you see something I missed.
> 
> I don't know those 32-bit CPUs at all, so as long as you've thought
> about it that's good enough for me. We can catch bugs in testing anyway.
> 
> cheers
> 
