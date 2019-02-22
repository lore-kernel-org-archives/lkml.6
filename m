Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F5EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AC320823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mQhlMa3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfBVHh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:37:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59815 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbfBVHh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:37:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 445NV91FTkzB09ZS;
        Fri, 22 Feb 2019 08:37:53 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=mQhlMa3m; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ES9Zh3bF8BWb; Fri, 22 Feb 2019 08:37:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 445NV90BTKzB09ZR;
        Fri, 22 Feb 2019 08:37:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550821073; bh=pootY2ICxlPl5SwfrjtlioothWZDPlMOqxL4/DIqGY0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mQhlMa3mXlDXo7oyYJ2uCLN9Gtnw4ggsYG3vIHSUgXv+C3mmG3lx6tGZ0POgfld84
         wHes/3k6+IHF2K6+VoTNWoJYN8VjD19Q5pmjrKKOT744fYq5WHJpjVcfUkDKBNZUCD
         HAQL0wWVKm5F+05ktO64fkpANNAnohXg2NYBgqck=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 45C848B885;
        Fri, 22 Feb 2019 08:37:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YZ07whHOHDKY; Fri, 22 Feb 2019 08:37:52 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0833B8B8D7;
        Fri, 22 Feb 2019 08:37:44 +0100 (CET)
Subject: Re: linux-next: build failure after merge of the powerpc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190222181403.4ce373bd@canb.auug.org.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <535192d6-2142-05a6-4088-0f71d744c345@c-s.fr>
Date:   Fri, 22 Feb 2019 08:37:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222181403.4ce373bd@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/02/2019 à 08:14, Stephen Rothwell a écrit :
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> make[4]: *** No rule to make target 'arch/powerpc/mm/ptdump/core.o', needed by 'arch/powerpc/mm/ptdump/built-in.a'.
> 
> Caused by commit
> 
>    5df1cfa43394 ("powerpc: Move page table dump files in a dedicated subdirectory")
> 
> I have reverted that commit for today.
> 

In the Makefile, replace core.o by ptdump.o (or rename the file ptdump.c 
to core.c). Michael, what was your intention ?

Christophe
