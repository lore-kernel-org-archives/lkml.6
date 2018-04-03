Return-Path: <cpandya@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+lLl+xtig6Cd/hHtd3WFWxGnI9AgcGmlPfZAW6ptNHL6VBxnfzxqs3YvkcOXqbdnPcI6tt
ARC-Seal: i=1; a=rsa-sha256; t=1522742520; cv=none;
        d=google.com; s=arc-20160816;
        b=hNYrM8t3AEFbOahJOnzM8p68/iG7VOZeobyYkezjeR1BCy4AQXq4qRrhhsdz1kIKKO
         IXZQJQxhluC6HojAEAspLoJD/Xt88YEUMJ09Db3g6JtY9y2kjg9qUAxPSyGHqdXzBAY+
         0B0XSgI3+jqm6rCqW6MyYrsBd3sjlunkYS6sj9whl9gqy/9Nh50A4DRQFzDVkUhSWbGS
         ZJ1wfAOx8T+hMhKDS1ZonSgHZCe2Q9ywuZ2Mn3ya3zqpXa+miv9WDucfvJnVXiGyONH6
         tx83dDQNwkxPVVs9O0/NNmq78o7d3424sr9yTzCUUmkx9w2CMDsdn4+yg6VVQsdp6RLM
         d5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=NBs5fnF++kYI/JL1MJJvJjb3Q3iD5aqU33X9MUkyoxY=;
        b=XRedbnmJZ16O8Fqm9Tfvsx1mQn6aCdNjDjU0+Ky+X21zyKIcd2/tSlXGjeZ02UHZbq
         /WSXlAznooNGbH+nwNGIEtZ+TEoXluQqfEjBks/MFeDj7sPYhc7oxn+iknAxFDesp2Yk
         oIMLsbfXC3N3nVqfmudvQT5C8j66Qgj5es77HXMhbIIt+tS+WluesNBk5CJTyFjjAzoW
         7JS4YBUYA0zLJQ5Eq02wyteejYkwNqiI2Z9fSE7tlZiFVEBbgfpl5LA/cD5I/JT3k2EZ
         HnQ+AoRWLpw1dgV8Zx1RN0ztZho7QlgwfFTC9ph+BR+JXWjt0iKRm9BQXX9Oe0NUJJms
         nblg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LTpAGDS4;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GS0HtGsu;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=LTpAGDS4;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GS0HtGsu;
       spf=pass (google.com: domain of cpandya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=cpandya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 719CF602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v7 1/4] ioremap: Update pgtable free interfaces with addr
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, catalin.marinas@arm.com, will.deacon@arm.com,
 mark.rutland@arm.com, toshi.kani@hpe.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org
References: <1522240282-12104-2-git-send-email-cpandya@codeaurora.org>
 <201803291957.TombWSzK%fengguang.wu@intel.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <95da57a0-dcf9-c829-1c4b-6492d7681750@codeaurora.org>
Date: Tue, 3 Apr 2018 13:31:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201803291957.TombWSzK%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596097435911624997?=
X-GMAIL-MSGID: =?utf-8?q?1596711261196528833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/29/2018 5:23 PM, kbuild test robot wrote:
> Hi Chintan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on v4.16-rc7]
> [also build test ERROR on next-20180328]
> [cannot apply to arm64/for-next/core tip/x86/core asm-generic/master]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Chintan-Pandya/ioremap-Update-pgtable-free-interfaces-with-addr/20180329-133736
> config: x86_64-rhel (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>     arch/x86/mm/pgtable.c: In function 'pud_free_pmd_page':
>>> arch/x86/mm/pgtable.c:725:8: error: too few arguments to function 'pmd_free_pte_page'
>        if (!pmd_free_pte_page(&pmd[i]), addr + (i * PMD_SIZE))
>             ^~~~~~~~~~~~~~~~~
>     In file included from arch/x86/include/asm/pgtable.h:1292:0,
>                      from include/linux/memremap.h:8,
>                      from include/linux/mm.h:27,
>                      from arch/x86/mm/pgtable.c:2:
>     include/asm-generic/pgtable.h:987:5: note: declared here
>      int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
>          ^~~~~~~~~~~~~~~~~
>     arch/x86/mm/pgtable.c:725:34: warning: left-hand operand of comma expression has no effect [-Wunused-value]
>        if (!pmd_free_pte_page(&pmd[i]), addr + (i * PMD_SIZE))
>                                       ^
> 
> vim +/pmd_free_pte_page +725 arch/x86/mm/pgtable.c
> 
>     705	
>     706	/**
>     707	 * pud_free_pmd_page - Clear pud entry and free pmd page.
>     708	 * @pud: Pointer to a PUD.
>     709	 * @addr: Virtual address associated with pud.
>     710	 *
>     711	 * Context: The pud range has been unmaped and TLB purged.
>     712	 * Return: 1 if clearing the entry succeeded. 0 otherwise.
>     713	 */
>     714	int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>     715	{
>     716		pmd_t *pmd;
>     717		int i;
>     718	
>     719		if (pud_none(*pud))
>     720			return 1;
>     721	
>     722		pmd = (pmd_t *)pud_page_vaddr(*pud);
>     723	
>     724		for (i = 0; i < PTRS_PER_PMD; i++)
>   > 725			if (!pmd_free_pte_page(&pmd[i]), addr + (i * PMD_SIZE))

Missed it. Will upload v8
>     726				return 0;
>     727	
>     728		pud_clear(pud);
>     729		free_page((unsigned long)pmd);
>     730	
>     731		return 1;
>     732	}
>     733	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
