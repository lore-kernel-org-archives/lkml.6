Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FBAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89CE217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="G5IwqZU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfBESLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:11:25 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:36243 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbfBESLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:11:24 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43vCLx2Vgmz9v31Z;
        Tue,  5 Feb 2019 19:11:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=G5IwqZU5; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DRlQCa-z-TpO; Tue,  5 Feb 2019 19:11:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43vCLx0qnVz9v31Y;
        Tue,  5 Feb 2019 19:11:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1549390281; bh=nGpIwtjdLVZ+t5ASl9uCArhuBc6rS4fZX5PJekS70s4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G5IwqZU53Uv5oHsjy8F0pxOhLexe9ZgcCQsmCLME5ECrglK0XYZv46QEuYjmXQUgZ
         Hx05bDjQer0CXm0YiM+VZ8vR0klkfpXW9m/+N2kG1uet6MeNZgJZdZqXRR8l+NcZ67
         Yjh/Vn67a7CopS1cRJHt8+/1n1Ju1ET459PIrRh8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE1BC8B822;
        Tue,  5 Feb 2019 19:11:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id S1EOY5DY01m1; Tue,  5 Feb 2019 19:11:22 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 76E278B81A;
        Tue,  5 Feb 2019 19:11:22 +0100 (CET)
Subject: Re: [PATCH] powerpc/mm: move a KERN_WARNING message to KERN_DEBUG
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Gibson <david@gibson.dropbear.id.au>
References: <20190205180329.1452-1-lvivier@redhat.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ad592bd1-be25-2c3e-50ae-9d31913b9b2d@c-s.fr>
Date:   Tue, 5 Feb 2019 19:11:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190205180329.1452-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/02/2019 à 19:03, Laurent Vivier a écrit :
> resize_hpt_for_hotplug() reports a warning when it cannot
> increase the hash page table ("Unable to resize hash page
> table to target order") but this is not blocking and
> can make user thinks something has not worked properly.
> 
> If the operation cannot be done the real error message
> will be reported by arch_add_memory() if create_section_mapping()
> fails.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   arch/powerpc/mm/hash_utils_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 0cc7fbc3bd1c..b762bdceb510 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -778,7 +778,7 @@ void resize_hpt_for_hotplug(unsigned long new_mem_size)
>   
>   		rc = mmu_hash_ops.resize_hpt(target_hpt_shift);
>   		if (rc && (rc != -ENODEV))
> -			printk(KERN_WARNING
> +			printk(KERN_DEBUG

You should use pr_debug() instead.

Christophe

>   			       "Unable to resize hash page table to target order %d: %d\n",
>   			       target_hpt_shift, rc);
>   	}
> 
