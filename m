Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9098EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E258208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E258208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755184AbeFRHBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:01:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19607 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755019AbeFRHBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:01:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 418MTP3Q1Yz9tvRl;
        Mon, 18 Jun 2018 09:01:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id alvT8eiQlHrx; Mon, 18 Jun 2018 09:01:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 418MTP2pC7z9tvRV;
        Mon, 18 Jun 2018 09:01:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C191C8B80A;
        Mon, 18 Jun 2018 09:01:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SBss0golivtv; Mon, 18 Jun 2018 09:01:51 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 822898B74B;
        Mon, 18 Jun 2018 09:01:50 +0200 (CEST)
Subject: Re: [PATCH 3/3] Revert "powerpc: fix build failure by disabling
 attribute-alias warning in pci_32"
To:     Paul Burton <paul.burton@mips.com>, linux-kbuild@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20180616005323.7938-1-paul.burton@mips.com>
 <20180616005323.7938-4-paul.burton@mips.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <14ef00cd-088c-d165-f4b2-b63eb2f3866b@c-s.fr>
Date:   Mon, 18 Jun 2018 09:01:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616005323.7938-4-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/06/2018 à 02:53, Paul Burton a écrit :
> With SYSCALL_DEFINEx() disabling -Wattribute-alias generically, there's
> no need to duplicate that for PowerPC's pciconfig_iobase syscall.
> 
> This reverts commit 415520373975 ("powerpc: fix build failure by
> disabling attribute-alias warning in pci_32").
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthew Wilcox <matthew@wil.cx>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Gideon Israel Dsouza <gidisrael@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Khem Raj <raj.khem@gmail.com>
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org

Acked-by: Christophe Leroy <christophe.leroy@c-s.fr>

> 
> ---
> 
>   arch/powerpc/kernel/pci_32.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index 4f861055a852..d63b488d34d7 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -285,9 +285,6 @@ pci_bus_to_hose(int bus)
>    * Note that the returned IO or memory base is a physical address
>    */
>   
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wpragmas"
> -#pragma GCC diagnostic ignored "-Wattribute-alias"
>   SYSCALL_DEFINE3(pciconfig_iobase, long, which,
>   		unsigned long, bus, unsigned long, devfn)
>   {
> @@ -313,4 +310,3 @@ SYSCALL_DEFINE3(pciconfig_iobase, long, which,
>   
>   	return result;
>   }
> -#pragma GCC diagnostic pop
> 
