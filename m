Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8830C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F24F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pyLXSzNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbfAPGzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:55:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:37277 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729807AbfAPGzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:55:32 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43fdJK4FMNzB09Zy;
        Wed, 16 Jan 2019 07:55:29 +0100 (CET)
Authentication-Results: localhost; dkim=permerror reason="key not found"
        header.d=c-s.fr header.i=@c-s.fr header.b=pyLXSzNc;
        dkim-adsp=none (insecure policy); dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xJqdnT9w7Epa; Wed, 16 Jan 2019 07:55:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43fdJK2ty9zB09Zx;
        Wed, 16 Jan 2019 07:55:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1547621729; bh=8tkIGrPdmOBRnCN9Lyz/UJdsI1R+Nm+/VuriQcXFAW0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pyLXSzNcu17Rj2dIqhB5q4EwLWwzLqESlUS9NJVtrl+WIBwWMZkXD8E2RpD5NrkT+
         lv5wXivyWPZSBS4i4ILYCjImpjlHrHirL1ClR2NyFXT9ZTPIap0a5FXWPXk+/l3Eol
         MH4QDgmRvtI6czeUOWqKWoeMeY1LQnHhDekY+DL8IqnxUgtPlxMkvHwLmJnKQF8Wur
         Vq/dj6ElF42uAlOdqUWQrA+7vWOINluxqdpgUMS59vzeBN/c0a9j0ihe2D+2KgmKaM
         AhLJ/g6TJFThepYSU9aPsDEmSxcLU8Eq+6kkjij46QBYNPESyXwItlIz8VGHMOQC6B
         9GnUl66JzmkQkJkUMNT0OTmnyJDuQ1bCs8YkqdBRim+jfu0AVBVKXSJmM/J5cXsv4j
         9TdIcdw+gvHFtBxqQwq107yQtiH3GzT5P3xTdIla18+PqyaoCHBy5nAJPDzzWPxfWf
         SgDYKDqCmH6n2RdBdpNu0iv2Jdtudv4DqfSh6TGqrRUPyyMzQBQbE2MuasKQOguaS/
         1UbSdZCQooPNt+xoU843K29YrjWh/DNDFMGRH0ZCLWwO1v5XjPivzmieUAMPAd86E9
         4ESqupXy82kJcW1FnE47SA7Jk2pIpxQqdmOe5SkH77+MU4Pq3gjg2FjWtbYnHAaG72
         88iP+2IaXQvhGC5VdWmbiIEA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 44F278B804;
        Wed, 16 Jan 2019 07:55:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KDzFuiDJUo6j; Wed, 16 Jan 2019 07:55:30 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F5A98B74B;
        Wed, 16 Jan 2019 07:55:29 +0100 (CET)
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for
 STRICT_KERNEL_RWX
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
 <20190115003353.GD22334@latitude>
 <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
 <20190116003535.GE22334@latitude>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f434aafc-7e5f-dfa2-4cfa-03119c27463a@c-s.fr>
Date:   Wed, 16 Jan 2019 07:55:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116003535.GE22334@latitude>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/01/2019 à 01:35, Jonathan Neuschäfer a écrit :
> On Tue, Jan 15, 2019 at 07:51:01AM +0100, Christophe Leroy wrote:
>> Le 15/01/2019 à 01:33, Jonathan Neuschäfer a écrit :
> [...]
>>> I've checked it patch-by-patch now (with STRICT_KERNEL_RWX):
>>>
>>> - patches 1 and 2 build and boot fine
>>> - patches 3 to 6 build, but fail to boot with this error:
>>
>> The bug is in patch 2, mmu_mapin_ram() should return base instead of
>> returning 0 when __map_without_bats is set.
> 
> Indeed, with this change, I can boot up to patch 11.
> 
>>> - patches 12 to 15 build but fail to boot with this error:
>>
>> Thats the one we need to really understand.
>>
>> Do you have modules ? If so, can you try without ?
> 
> I don't use any modules in my test setup, but I have module support
> enabled. Disabling CONFIG_MODULES makes no difference, as far as I can
> see (I get the same backtrace with memblock_alloc_base+0x34/0x44).
> 
>>> 	[    0.000000] [c0f1ff30] [c00280f0] panic+0x144/0x324 (unreliable)
>>> 	[    0.000000] [c0f1ff90] [c0c18a34] memblock_alloc_base+0x34/0x44
>>> 	[    0.000000] [c0f1ffa0] [c0c071e0] MMU_init_hw+0xcc/0x300
>>> 	[    0.000000] [c0f1ffd0] [c0c06554] MMU_init+0x12c/0x198
>>> 	[    0.000000] [c0f1fff0] [c0003418] start_here+0x40/0x78
> 
> With a few printks[1], I traced this error, and got the following
> result:
> 
> [    0.000000] __memblock_find_range_top_down(1000:1800000, 100000:100000, ffffffff, 0)
> [    0.000000] __memblock_find_range_top_down: in loop, 10000000:13f00000
> [    0.000000] __memblock_find_range_top_down: in loop, 179962d:1800000
> [    0.000000] __memblock_find_range_top_down: in loop, 1676000:17987a0
> [    0.000000] __memblock_find_range_top_down: nothing found :(
> 
> The limit of 0x1800000 comes from setup_initial_memory_limit, which only
> considers the first memblock, but the second memblock starts at 256MiB,
> so it wouldn't be usable anyway, according to the comment in
> setup_initial_memory_limit.

Yes, initial_bats() in head_32.S sets one 256Mb BAT for initial booting:

/*
  * On 601, we use 3 BATs to map up to 24M of RAM at _PAGE_OFFSET
  * (we keep one for debugging) and on others, we use one 256M BAT.
  */
initial_bats:
	lis	r11,PAGE_OFFSET@h
	mfspr	r9,SPRN_PVR
	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
	cmpwi	0,r9,1
	bne	4f
...
4:	tophys(r8,r11)
#ifdef CONFIG_SMP
	ori	r8,r8,0x12		/* R/W access, M=1 */
#else
	ori	r8,r8,2			/* R/W access */
#endif /* CONFIG_SMP */
	ori	r11,r11,BL_256M<<2|0x2	/* set up BAT registers for 604 */

	mtspr	SPRN_DBAT0L,r8		/* N.B. 6xx (not 601) have valid */
	mtspr	SPRN_DBAT0U,r11		/* bit in upper BAT register */
	mtspr	SPRN_IBAT0L,r8
	mtspr	SPRN_IBAT0U,r11
	isync
	blr


> 
> Thinning the kernel down a bit actually makes it boot again. Ooops...!
> Maybe enabling CONFIG_STRICT_KERNEL_RWX has made it just large enough to
> fail the hash table allocation, but there may have been other factors
> involved (I'm not sure exactly).  Sorry for the confusion!

Ok, that must be the reason. Thanks for testing.

What about the following modification which maps a second 256Mb BAT, 
does it helps ?



diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index c2f564690778..ea574596de37 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -1160,6 +1160,14 @@ initial_bats:
  	mtspr	SPRN_DBAT0U,r11		/* bit in upper BAT register */
  	mtspr	SPRN_IBAT0L,r8
  	mtspr	SPRN_IBAT0U,r11
+#ifdef CONFIG_WII
+	addis	r11,r11,0x10000000@h
+	addis	r8,r8,0x10000000@h
+	mtspr	SPRN_DBAT2L,r8
+	mtspr	SPRN_DBAT2U,r11
+	mtspr	SPRN_IBAT2L,r8
+	mtspr	SPRN_IBAT2U,r11
+#endif
  	isync
  	blr

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 3f4193201ee7..a334fd5210a8 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -259,6 +259,8 @@ void setup_initial_memory_limit(phys_addr_t 
first_memblock_base,
  	/* 601 can only access 16MB at the moment */
  	if (PVR_VER(mfspr(SPRN_PVR)) == 1)
  		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01000000));
+	else if (IS_ENABLED(CONFIG_WII))
+		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x20000000));
  	else /* Anything else has 256M mapped */
  		memblock_set_current_limit(min_t(u64, first_memblock_size, 0x10000000));
  }


Christophe

> 
> 
> Jonathan
> 
> [1]:
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 022d4cbb3618..66d588e08487 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -215,8 +215,11 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
>   	phys_addr_t this_start, this_end, cand;
>   	u64 i;
>   
> +	printk("%s(%x:%x, %x:%x, %x, %x)\n", __func__, start, end, size, align, nid, flags);
> +
>   	for_each_free_mem_range_reverse(i, nid, flags, &this_start, &this_end,
>   					NULL) {
> +		printk("%s: in loop, %x:%x\n", __func__, this_start, this_end);
>   		this_start = clamp(this_start, start, end);
>   		this_end = clamp(this_end, start, end);
>   
> @@ -228,6 +231,7 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
>   			return cand;
>   	}
>   
> +	printk("%s: nothing found :(\n", __func__);
>   	return 0;
>   }
>   
> 
