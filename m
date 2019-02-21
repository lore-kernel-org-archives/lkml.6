Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6BBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3461F214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfBUJMf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:12:35 -0500
Received: from ozlabs.org ([203.11.71.1]:50323 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfBUJMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:12:35 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 444pdp1b8Nz9sBr;
        Thu, 21 Feb 2019 20:12:30 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Move page table dump files in a dedicated subdirectory
In-Reply-To: <0f371616-0ab6-fe96-852a-323159c58572@c-s.fr>
References: <913780421c7b73d731bbbe04c215e29667f7c938.1550492751.git.christophe.leroy@c-s.fr> <87d0nm7f8l.fsf@concordia.ellerman.id.au> <0f371616-0ab6-fe96-852a-323159c58572@c-s.fr>
Date:   Thu, 21 Feb 2019 20:12:26 +1100
Message-ID: <87ef81wlmt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 20/02/2019 à 14:37, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>>> This patch moves the files related to page table dump in a
>>> dedicated subdirectory.
>>>
>>> The purpose is to clean a bit arch/powerpc/mm by regrouping
>>> multiple files handling a dedicated function.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/Kconfig.debug                                   |  4 ----
>>>   arch/powerpc/mm/Makefile                                     | 10 +---------
>>>   arch/powerpc/mm/ptdump/Makefile                              |  9 +++++++++
>>>   arch/powerpc/mm/{ => ptdump}/dump_bats.c                     |  0
>>>   arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c            |  0
>>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c      |  0
>>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c |  0
>>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c  |  0
>>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c          |  0
>>>   arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h          |  0
>>>   arch/powerpc/mm/{ => ptdump}/dump_sr.c                       |  0
>>>   11 files changed, 10 insertions(+), 13 deletions(-)
>>>   create mode 100644 arch/powerpc/mm/ptdump/Makefile
>>>   rename arch/powerpc/mm/{ => ptdump}/dump_bats.c (100%)
>>>   rename arch/powerpc/mm/{ => ptdump}/dump_hashpagetable.c (100%)
>>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-8xx.c (100%)
>>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-book3s64.c (100%)
>>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables-generic.c (100%)
>>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.c (100%)
>>>   rename arch/powerpc/mm/{ => ptdump}/dump_linuxpagetables.h (100%)
>>>   rename arch/powerpc/mm/{ => ptdump}/dump_sr.c (100%)
>> 
>> I'd like to shorten the file names as well, now that they're namespaced
>> in the ptdump directory, how about:
>> 
>>   arch/powerpc/Kconfig.debug                                             |  4 ----
>>   arch/powerpc/mm/Makefile                                               | 10 +---------
>>   arch/powerpc/mm/{dump_linuxpagetables-8xx.c => ptdump/8xx.c}           |  2 +-
>>   arch/powerpc/mm/ptdump/Makefile                                        |  9 +++++++++
>>   arch/powerpc/mm/{dump_bats.c => ptdump/bats.c}                         |  0
>>   arch/powerpc/mm/{dump_linuxpagetables-book3s64.c => ptdump/book3s64.c} |  2 +-
>>   arch/powerpc/mm/{dump_hashpagetable.c => ptdump/hashpagetable.c}       |  0
>>   arch/powerpc/mm/{dump_linuxpagetables.c => ptdump/ptdump.c}            |  2 +-
>>   arch/powerpc/mm/{dump_linuxpagetables.h => ptdump/ptdump.h}            |  0
>>   arch/powerpc/mm/{dump_sr.c => ptdump/segment_regs.c}                   |  0
>>   arch/powerpc/mm/{dump_linuxpagetables-generic.c => ptdump/shared.c}    |  2 +-
>
> Yes good idea. Do you want a v2 or will you do it ?

I'll do it, thanks.

cheers
