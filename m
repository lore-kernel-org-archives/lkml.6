Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6D0C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940A524C98
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 17:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940A524C98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeFWRMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 13:12:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55941 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751452AbeFWRMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 13:12:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41Chnt6fKZz9ttRy;
        Sat, 23 Jun 2018 19:12:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IlzLHlBjrRzJ; Sat, 23 Jun 2018 19:12:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41Chnt645xz9ttRr;
        Sat, 23 Jun 2018 19:12:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E92D8B7F9;
        Sat, 23 Jun 2018 19:12:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5l2Fu0yspELQ; Sat, 23 Jun 2018 19:12:38 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 171B58B74B;
        Sat, 23 Jun 2018 19:12:38 +0200 (CEST)
Subject: =?UTF-8?Q?Re:_[PATCH]_powerpc/mm:_remove_warning_about_=e2=80=98typ?=
 =?UTF-8?Q?e=e2=80=99_being_set?=
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20180622192749.24954-1-malat@debian.org>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <c182ca65-f41e-4a1c-95ee-6cb979a6e76b@c-s.fr>
Date:   Sat, 23 Jun 2018 19:12:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622192749.24954-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 180623-2, 23/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/06/2018 à 21:27, Mathieu Malaterre a écrit :
> ‘type’ is only used when CONFIG_DEBUG_HIGHMEM is set. So add a possibly
> unused tag to variable. Remove warning treated as error with W=1:
> 
>    arch/powerpc/mm/highmem.c:59:6: error: variable ‘type’ set but not used [-Werror=unused-but-set-variable]

Is type neeeded at all when CONFIG_DEBUG_HIGHMEM is not set ?

The call 	type = kmap_atomic_idx();          seems useless when 
CONFIG_DEBUG_HIGHMEM isn't set. Couldn't we just most type definition 
and setting inside the CONFIG_DEBUG_HIGHMEM {} below ?

Alternatively, maybe you could replace the #ifdef CONFIG_DEBUG_HIGHMEM 
by an    if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM)) ?

Christophe

> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/mm/highmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/highmem.c b/arch/powerpc/mm/highmem.c
> index 668e87d03f9e..82a0e37557a5 100644
> --- a/arch/powerpc/mm/highmem.c
> +++ b/arch/powerpc/mm/highmem.c
> @@ -56,7 +56,7 @@ EXPORT_SYMBOL(kmap_atomic_prot);
>   void __kunmap_atomic(void *kvaddr)
>   {
>   	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
> -	int type;
> +	int type __maybe_unused;
>   
>   	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
>   		pagefault_enable();
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

