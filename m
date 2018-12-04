Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD43C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAED220850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAED220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLDDzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:55:43 -0500
Received: from ozlabs.org ([203.11.71.1]:44455 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbeLDDzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:55:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4387Lf5JD9z9s55;
        Tue,  4 Dec 2018 14:55:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mathieu Malaterre <malat@debian.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/7] powerpc: change CONFIG_6xx to CONFIG_PPC_BOOK3S_32
In-Reply-To: <CA+7wUsx3iZhPH0uwukRNXaT_ZygaqKNXaNf=kcwoJ9nGqTb2Mw@mail.gmail.com>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr> <73b5e7a43bb5979ac534d1c236adb2e04f9d6307.1542395798.git.christophe.leroy@c-s.fr> <CA+7wUsx3iZhPH0uwukRNXaT_ZygaqKNXaNf=kcwoJ9nGqTb2Mw@mail.gmail.com>
Date:   Tue, 04 Dec 2018 14:55:36 +1100
Message-ID: <877egqhrnr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:
> On Sat, Nov 17, 2018 at 11:29 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> Today we have:
>>
>> config PPC_BOOK3S_32
>>         bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
>>         [depends on PPC32 within a choice]
>>
>> config PPC_BOOK3S
>>         def_bool y
>>         depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
>>
>> config 6xx
>>         def_bool y
>>         depends on PPC32 && PPC_BOOK3S
>>
>> 6xx is therefore redundant with PPC_BOOK3S_32.
>>
>> In order to make the code clearer, lets use preferably PPC_BOOK3S_32.
>> This will allow to remove CONFIG_6xx in a later patch.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/Makefile                     |  2 +-
>>  arch/powerpc/include/asm/cache.h          |  2 +-
>>  arch/powerpc/include/asm/mmu.h            |  2 +-
>>  arch/powerpc/include/asm/reg.h            |  2 +-
>>  arch/powerpc/include/asm/time.h           |  2 +-
>>  arch/powerpc/kernel/Makefile              |  2 +-
>>  arch/powerpc/kernel/cpu_setup_6xx.S       |  2 +-
>>  arch/powerpc/kernel/entry_32.S            | 10 +++++-----
>>  arch/powerpc/kernel/head_32.S             | 14 +++++++-------
>>  arch/powerpc/kernel/misc_32.S             |  4 ++--
>>  arch/powerpc/kernel/pmc.c                 |  2 +-
>>  arch/powerpc/kernel/setup_32.c            |  2 +-
>>  arch/powerpc/kernel/sysfs.c               |  2 +-
>>  arch/powerpc/mm/mmu_decl.h                |  2 +-
>>  arch/powerpc/oprofile/Makefile            |  2 +-
>>  arch/powerpc/oprofile/common.c            |  2 +-
>>  arch/powerpc/platforms/powermac/cache.S   |  4 ++--
>>  arch/powerpc/platforms/powermac/feature.c |  2 +-
>>  arch/powerpc/platforms/powermac/sleep.S   |  4 ++--
>>  arch/powerpc/sysdev/Makefile              |  2 +-
>>  20 files changed, 33 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 8a2ce14d68d0..e259b8a2dd44 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -241,7 +241,7 @@ KBUILD_CFLAGS       += $(call cc-option,-fno-dwarf2-cfi-asm)
>>  # often slow when they are implemented at all
>>  KBUILD_CFLAGS          += $(call cc-option,-mno-string)
>>
>> -ifdef CONFIG_6xx
>> +ifdef CONFIG_PPC_BOOK3S_32
>>  KBUILD_CFLAGS          += -mcpu=powerpc
>>  endif
>
> I never quite understood this part. Let say I want to specify 'power4'
> in arch/powerpc/platforms/Kconfig.cputype as new TARGET_CPU. The line
> above will always append -mcpu=powerpc *after* a TARGET_CPU=power4
> which defeat the whole purpose, right ?

Yes, I think you're right.

The code above was added in 2006 in f48b8296b315 ("[PATCH] powerpc32:
Set cpu explicitly in kernel compiles").

Back then the target CPU selection was 64-bit only, so setting it to
powerpc always for 6xx was fine.

It was only recently that Christophe made the target CPU selection
available on 32-bit, see 0e00a8c9fd92 ("powerpc: Allow CPU selection
also on PPC32").

So since that commit the above has been overriding any specific CPU
selection it seems, eg:
  gcc -Wp,-MD,init/.do_mounts.o.d ...
  -mcpu=powerpc -mbig-endian -m32 ...
  -mcpu=e300c2 ...
  -mcpu=powerpc ...
  ../init/do_mounts.c

That seems like a bug.

It would be good to clean up the CPU selection logic, it's a bit of a
mess. But for now it's probably best to just move the above snippet
prior to the TARGET_CPU logic.

cheers
