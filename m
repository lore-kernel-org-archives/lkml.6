Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtxGBl7IjrjubwMJ1GcrI+G5qwj6dlg33u5I1Xw1ZX5lut6oODtWIKw3K3SwO9sc4pIVHb+
ARC-Seal: i=1; a=rsa-sha256; t=1521529473; cv=none;
        d=google.com; s=arc-20160816;
        b=F2wEzptYT/9rqdQZebG6Uw9O5VQeCSS7K9izfdPk9mLuaEZKO1prlH5NG8qvc6Hspr
         aKFr/kduUCV155TcTWpqIpU6fzqqLBYd2Ia6G3l52KC/d9iNb4DI6RDfmeIJwcUH8Vsp
         P1G+fijcUGvYPLZqJxtRcOfKUEPADx/MzViBTh7bGw6g8xlzulKmxntzr0uso69WjkTg
         Evby1dD0hCPcBS9/tWTLsUjO/BwTfoFIf0h3fx3H94pac0IhGtpwlZsTfZpTcj4CGnZc
         WucPN2L6iDtTYqwECfIGWGAE+zrtOEnPNTL9tH/khAR6tm3OUHb6AdNmP9v8VlnoqH5q
         xzfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=NOFW6CQGcNobS3cBZujJ7yWEunqyZ1j+E5zJt8VQubw=;
        b=nDeGk20Ycxw36oF9aU8oT4k8+oG9VlLs4o6Q1aatPtc2MbHuJAJbr36D2SF5gFhoEy
         nnWCzkk7X6jsevpsqOkRqcAY+WM8nD8/UmDesC6nZ6KMQUkt6P4SQFrYhUXNuEroYyBB
         5wtH72kQrE9/45LoXRvUVOcHwkoymrtLWb4i6GnkRcM+JgVFbRGA4Jsi84HClsTfiZFx
         XKMYgqtcX1tHx9LGzCbxCyntD1vIrSavJXMmEj8+Ecp9NEC24bU6PAANL4tOCr4BsgbS
         hxsQvNHDYCCEHu574r0tQkCZjC6rwNnmGTAreenETKCsMH5aQC5ZDPgOXMoEBidSCeeV
         cwTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hrZhb054;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IRwJ5jeK;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=hrZhb054;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IRwJ5jeK;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A340060314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v3 1/3] ioremap: Update pgtable free interfaces with addr
To: "Kani, Toshi" <toshi.kani@hpe.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
 <1521463256-19858-2-git-send-email-cpandya@codeaurora.org>
 <1521486096.2693.202.camel@hpe.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <472bb600-9387-7fc7-3a2e-26579d785ce6@codeaurora.org>
Date: Tue, 20 Mar 2018 12:34:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521486096.2693.202.camel@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595369882117983930?=
X-GMAIL-MSGID: =?utf-8?q?1595439289750977379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/20/2018 12:31 AM, Kani, Toshi wrote:
> On Mon, 2018-03-19 at 18:10 +0530, Chintan Pandya wrote:
>> This patch ("mm/vmalloc: Add interfaces to free unmapped
>> page table") adds following 2 interfaces to free the page
>> table in case we implement huge mapping.
>>
>> pud_free_pmd_page() and pmd_free_pte_page()
>>
>> Some architectures (like arm64) needs to do proper TLB
>> maintanance after updating pagetable entry even in map.
>> Why ? Read this,
>> https://patchwork.kernel.org/patch/10134581/
>>
>> Pass 'addr' in these interfaces so that proper TLB ops
>> can be performed.
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>   :
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 34cda7e..20b0322 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -710,7 +710,7 @@ int pmd_clear_huge(pmd_t *pmd)
>>    * Context: The pud range has been unmaped and TLB purged.
>>    * Return: 1 if clearing the entry succeeded. 0 otherwise.
>>    */
>> -int pud_free_pmd_page(pud_t *pud)
>> +int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> 
> Please update the function header as well.  Same for pmd.
> 
> + * @addr: Virtual address associated with pud.
Noted.
> 
> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -983,8 +983,8 @@ static inline int p4d_clear_huge(p4d_t *p4d)
>>   int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
>>   int pud_clear_huge(pud_t *pud);
>>   int pmd_clear_huge(pmd_t *pmd);
>> -int pud_free_pmd_page(pud_t *pud);
>> -int pmd_free_pte_page(pmd_t *pmd);
>> +int pud_free_pmd_page(pud_t *pud, unsigned long addr);
>> +int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
>>   #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>>   static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t
> prot)
>>   {
>> @@ -1010,11 +1010,11 @@ static inline int pmd_clear_huge(pmd_t *pmd)
>>   {
>>   	return 0;
>>   }
>> -static inline int pud_free_pmd_page(pud_t *pud)
>> +static inline int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>>   {
>>   	return 0;
>>   }
>> -static inline int pmd_free_pte_page(pud_t *pmd)
>> +static inline int pmd_free_pte_page(pud_t *pmd, unsigned long addr)
> 
> Please base your patches on top of the mm tree or at least pick up
> 8cab93de994f6 in the mm tree.  Andrew fixed the typo; the 'pud_t' above
> should have been 'pmd_t'.

Right. Noted.

> 
> Thanks,
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
