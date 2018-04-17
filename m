Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/ovxxNSE8z6K8YNTqx//WMgnLIFCUUQKuMF3ohUEaOWUO/BDQy/Ree3UK0oSGFQvwraQZn
ARC-Seal: i=1; a=rsa-sha256; t=1523960719; cv=none;
        d=google.com; s=arc-20160816;
        b=VnDikr88oKr0TySfK6m6xG09nUIvYno7jf1I0JMRgn3MEfwe3hZul/e3Yd4QvyADYp
         6JWQj89E53LqrwNhJPYoa0b0ghv3FbMCSztABObDgwLufMM/dObScN1jeLzldpaRFe4O
         YOzJIXiKcgjN85D+0NM8ZfxwFoK8dW7zY/vjoeV3IPZfD89qNABATuahUPL+AAUNFfG+
         9N6+zU0NGJP0kYSBZsUD7THfcNDSRtkVMhnwjyE+LyqVJwbAdvZzHRcpSF+7Fx046PPU
         BtY5ZSp5kEcXJfQbxyIsz7ZxKapsz+SqxCS6APwfAwrsf6iqmscoQbktAmHPYMTvD8/p
         VkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=K/dkAcJ5fNQt6CHn0JbBn2Ryp1NcvaF7ztKQOPKyU1s=;
        b=mO2hSOItyWN2jJtk8brQ/FwUGfZfH+CSgdk8ZRkAjDbz++u81udEbKjfGwXEmRbhD3
         w6IRLj7MOV68QbMPV44Z67AVzp2iWzzKzinDRW5wzcMb9mgPk0St1WD2n590ICb+EiNo
         8y7wAGo9wBcigbS+4ZFcZvw5pf7fz+1pnbGntYJywDHG1xTjKjYZAklog9WZSUr8/CmW
         eepYI9LgnCwwuiN4vHascaTKKA4cLpqc1q7tI/rJLxo9ZRwa0Wp91UeYxOFh05sz3cZh
         S61sJC2XYovTIr9Ut+Hgb6zed6/NhaxrhHNGRx4vbIYFQ4m1/B0Uu3cabsEshtxw6jEX
         e6jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GB0euMbb;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GB0euMbb;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GB0euMbb;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GB0euMbb;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5D46603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
To: catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
 toshi.kani@hpe.com
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, kristina.martsenko@arm.com,
 takahiro.akashi@linaro.org, james.morse@arm.com, tglx@linutronix.de,
 akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <b2ea9760-cad4-8f30-98ac-86a04c4d42a4@codeaurora.org>
Date: Tue, 17 Apr 2018 15:55:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711199968894044?=
X-GMAIL-MSGID: =?utf-8?q?1597988634878954231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ping...

On 4/3/2018 1:30 PM, Chintan Pandya wrote:
> This series of patches are follow up work (and depends on)
> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> panic in ioremap huge pages".
> 
> This series of patches are tested on 4.9 kernel with Cortex-A75
> based SoC.
> 
> These patches can also go into '-stable' branch (if accepted)
> for 4.6 onwards.
> 
>  From V7->V8:
>   - Properly fixed compilation issue in x86 file
> 
>  From V6->V7:
>   - Fixed compilation issue in x86 case
>   - V6 patches were not properly enumarated
> 
>  From V5->V6:
>   - Use __flush_tlb_kernel_pgtable() for both PUD and PMD. Remove
>     "bool tlb_inv" based variance as it is not need now
>   - Re-naming for consistency
> 
>  From V4->V5:
>   - Add new API __flush_tlb_kernel_pgtable(unsigned long addr)
>     for kernel addresses
> 
>  From V3->V4:
>   - Add header for 'addr' in x86 implementation
>   - Re-order pmd/pud clear and table free
>   - Avoid redundant TLB invalidatation in one perticular case
> 
>  From V2->V3:
>   - Use the exisiting page table free interface to do arm64
>     specific things
> 
>  From V1->V2:
>   - Rebased my patches on top of "[PATCH v2 1/2] mm/vmalloc:
>     Add interfaces to free unmapped page table"
>   - Honored BBM for ARM64
> 
> Chintan Pandya (4):
>    ioremap: Update pgtable free interfaces with addr
>    arm64: tlbflush: Introduce __flush_tlb_kernel_pgtable
>    arm64: Implement page table free interfaces
>    Revert "arm64: Enforce BBM for huge IO/VMAP mappings"
> 
>   arch/arm64/include/asm/tlbflush.h |  6 ++++++
>   arch/arm64/mm/mmu.c               | 37 +++++++++++++++++++++++++------------
>   arch/x86/mm/pgtable.c             |  8 +++++---
>   include/asm-generic/pgtable.h     |  8 ++++----
>   lib/ioremap.c                     |  4 ++--
>   5 files changed, 42 insertions(+), 21 deletions(-)
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
