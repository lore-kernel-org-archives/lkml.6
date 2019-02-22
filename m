Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52211C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249FB2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfBVL23 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:28:29 -0500
Received: from ozlabs.org ([203.11.71.1]:57883 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbfBVL23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:28:29 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 445TcC37gYz9s8m;
        Fri, 22 Feb 2019 22:28:27 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the powerpc tree
In-Reply-To: <535192d6-2142-05a6-4088-0f71d744c345@c-s.fr>
References: <20190222181403.4ce373bd@canb.auug.org.au> <535192d6-2142-05a6-4088-0f71d744c345@c-s.fr>
Date:   Fri, 22 Feb 2019 22:28:26 +1100
Message-ID: <87tvgwkqp1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 22/02/2019 à 08:14, Stephen Rothwell a écrit :
>> Hi all,
>> 
>> After merging the powerpc tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>> 
>> make[4]: *** No rule to make target 'arch/powerpc/mm/ptdump/core.o', needed by 'arch/powerpc/mm/ptdump/built-in.a'.
>> 
>> Caused by commit
>> 
>>    5df1cfa43394 ("powerpc: Move page table dump files in a dedicated subdirectory")
>> 
>> I have reverted that commit for today.
>
> In the Makefile, replace core.o by ptdump.o (or rename the file ptdump.c 
> to core.c). Michael, what was your intention ?

To not break the build :}

I originally used core.c but then decided ptdump.c was clearer.

My jenkins was unhappy last night due to a distro upgrade so my builds
didn't run and catch the breakage.

I'll just fix it and force push.

cheers
