Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E488FC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9CC25084
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9CC25084
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755613AbeF3JbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 05:31:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32249 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752494AbeF3JbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 05:31:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41HpDH50MSz9ttFM;
        Sat, 30 Jun 2018 11:31:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wH2_i4o0CmTt; Sat, 30 Jun 2018 11:31:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41HpDH4M6tz9ttFG;
        Sat, 30 Jun 2018 11:31:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 501CE8B7B5;
        Sat, 30 Jun 2018 11:31:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id U5YssNqrrzGW; Sat, 30 Jun 2018 11:31:16 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A5F5C8B74B;
        Sat, 30 Jun 2018 11:31:11 +0200 (CEST)
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <1a73e92a-f77d-ba1e-ebf8-b469db3c465e@c-s.fr>
Date:   Sat, 30 Jun 2018 11:31:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 180630-0, 30/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/06/2018 à 22:42, Larry Finger a écrit :
> My PowerBook G4 Aluminum crashes on boot with 4.18-rcX kernels with a 
> kernel BUG at include/linux/page-flags.h:700! The problem was bisected 
> to commit 1d40a5ea01d5 ("mm: mark pages in use for page tables"). It is 
> not possible to capture the bug with anything other than a camera. The 
> first few lines of the traceback are as follows:
> 
> free_pgd_range+0x19c/0x30c (unreliable)
> free_pgtables_0xa0/0xb0
> exit_pmap+0xf4/0x16c
> mmput+0x64/0xf0
> do_exit+0x33c/0x89c
> oops_end+0x13c/0x144
> _exception_pkey+0x58/0x128
> ret_from_except_full+0x0/0x4
> --- interrupt: 700 at free_pgd_range+0x19c/0x30c
>      LR = free_pgd_range+0x19c/0x30c
> free_pgtables+0xa/0xb
> exit_mnap+0xf4/0x16c
> mmput+0x64/0xf0
> flush_old_exec+0x490/0x550
> 
> I have more information regarding this BUG. Line 700 of page-flags.h is 
> the macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually 
> expanded the macro, and found that the bug line is 
> VM_BUG_ON_PAGE(!PageTable(page), page) in routine __ClearPageTable(), 
> which is called from pgtable_page_dtor() in include/linux/mm.h. I also 
> added a printk call to PageTable() that logs page->page_type. The 
> routine was called twice. The first had page_type of 0xfffffbff, which 
> would have been expected for a . The second call had 0xffffffff, which 
> led to the BUG.
> 

Oh, seems to be the one I noticed and told Aneesh about 
(https://patchwork.ozlabs.org/patch/922771/)

Aneesh provided the patch https://patchwork.ozlabs.org/patch/934111/ for 
it, does it help ?

Christophe

> Larry

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

