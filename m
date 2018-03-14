Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELvm3O8WQAXSk9hM6GGu9dXrb/HuN+neIrSF2TGOcerrnt91cAAwkW286TaazWlU0GlB/T3W
ARC-Seal: i=1; a=rsa-sha256; t=1521027162; cv=none;
        d=google.com; s=arc-20160816;
        b=T1XIhV2/R2BM/Vzto68yFdaxiN+2X5BpkGpLgb1TDTFHH8OL1YcBKYgXH/KGgz1fx1
         1lTqk4JWyZNsK/bAV8Wd10oi/gT1ZgsxYQAHcH2o9yQm64oDAd7lDaONL1JBj6YhJoss
         UGO60f1acM7QmrU6tHAGE1OpiYlhtCOvmU0+NMaITCm2fpoDGa2n9GsjMDCYcIanFc9R
         c9TM41zNAAfWN/w+McVT8DSzxiUtCg84Qe9AK0VmJxFIBx1/xAUuDBTPSpzjqxpSlnoK
         /pihrqWk9lnW3xdyGUKwyrUeah8BSt2FrjDVlZmaReN25OGo7bcFqoiP5paRSxxNY6fW
         j19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=XFTbaRgbUsSUx+CD60ACZ6j7ArZJguRCQW2QTrf8mHc=;
        b=b7DGdck77PJiBtjYtI1DxFLmKh22lNZEm6C0P3G4eZA3MAWDjhlcjUuTsV2yKb5A5n
         gwfqQ0vAg/KveO4Tl2chnOAlqwNmjtB6n2rWrmjnwY+Ej3M5u1TbNWaCxkwh5XojYyMU
         Vm3/tLqX+zB3dc4hh72MIfrjzBhs1lOhJh15Sd2EnGLZziyLHw2wP5eQwZXhfFRx5iZ/
         9OcWB2RwWXDSWB4ZdGj4cv/Zchd2dQErJNtsCyhsUtw97swKb3XAa3hHfHqR9pN2J+es
         7q1tSHWbYllKTGdjWOk0/ohiGX2NipGDmGNJ/u772qqo7Iw9NegpGXlFzCraVvCLaBka
         mJDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YS9ZaEnh;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UDNWmpyb;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YS9ZaEnh;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UDNWmpyb;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 838D860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v1 4/4] Revert "arm64: Enforce BBM for huge IO/VMAP
 mappings"
To: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
 will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521017305-28518-5-git-send-email-cpandya@codeaurora.org>
 <bdcc02a1-cf1b-4887-06e9-4867415ca214@arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <d7d8fe7c-e313-67ac-3793-6a300d61923f@codeaurora.org>
Date: Wed, 14 Mar 2018 17:02:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bdcc02a1-cf1b-4887-06e9-4867415ca214@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594902291066991790?=
X-GMAIL-MSGID: =?utf-8?q?1594912578549725355?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/14/2018 4:16 PM, Marc Zyngier wrote:
> On 14/03/18 08:48, Chintan Pandya wrote:
>> This commit 15122ee2c515a ("arm64: Enforce BBM for huge
>> IO/VMAP mappings") is a temporary work-around until the
>> issues with CONFIG_HAVE_ARCH_HUGE_VMAP gets fixed.
>>
>> Revert this change as we have fixes for the issue.
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>> ---
>>   arch/arm64/mm/mmu.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index c0df264..19116c6 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -935,10 +935,6 @@ int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
>>   	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
>>   					pgprot_val(mk_sect_prot(prot)));
>>   
>> -	/* ioremap_page_range doesn't honour BBM */
>> -	if (pud_present(READ_ONCE(*pudp)))
>> -		return 0;
>> -
>>   	BUG_ON(phys & ~PUD_MASK);
>>   	if (pud_val(*pud) && !pud_huge(*pud))
>>   		free_page((unsigned long)__va(pud_val(*pud)));
>> @@ -952,10 +948,6 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
>>   	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
>>   					pgprot_val(mk_sect_prot(prot)));
>>   
>> -	/* ioremap_page_range doesn't honour BBM */
>> -	if (pmd_present(READ_ONCE(*pmdp)))
>> -		return 0;
>> -
>>   	BUG_ON(phys & ~PMD_MASK);
>>   	if (pmd_val(*pmd) && !pmd_huge(*pmd))
>>   		free_page((unsigned long)__va(pmd_val(*pmd)));
>>
> 
> But you're still not doing a BBM, right? What prevents a speculative
> access from using the (now freed) entry? The TLB invalidation you've
> introduce just narrows the window where bad things can happen.
Valid point. I will rework on these patches.

Thanks Marc.

> 
> My gut feeling is that this series introduces more bugs than it fixes...
> If you're going to fix it, please fix it by correctly implementing BBM
> for huge mappings.
> 
> Or am I missing something terribly obvious?
> 
> 	M.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
