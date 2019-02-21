Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79548C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A53218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfBUKAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:00:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:34003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfBUKAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:00:37 -0500
Received: from [10.94.54.243] ([155.56.40.41]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzHZ7-1hAFeg2VMn-014TFn; Thu, 21
 Feb 2019 11:00:07 +0100
Subject: Re: [PATCH v2] parisc: use memblock_alloc() instead of custom
 get_memblock()
To:     Mike Rapoport <rppt@linux.ibm.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-parisc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1549984572-10867-1-git-send-email-rppt@linux.ibm.com>
 <20190221090752.GA32004@rapoport-lnx>
From:   Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <5ce80937-a55a-8e79-2575-27d296078d41@gmx.de>
Date:   Thu, 21 Feb 2019 11:00:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221090752.GA32004@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Q8ZzlXE5bRC4uC3MRuh1+mt3sVB3j+kcDs8NddK3Mq9s0aekSIq
 TupmJg850E1gpRL2IjblWFZQ8IcLZWAx0jNP8Negxq5cVxLv2PqqLrbR9na+jE99VYbeKAk
 6sjehToqTdGnkoS/XP8xUDoj9rDL568q40ef/n+ZI1uUAWIygcXtXPTT1Ze+Rj4ioO7S3tP
 eqiVveJE+YtKQlz/V1EUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gHpssbL9eAo=:vYv6oW+VXeXA3oDcr2ZImJ
 VrVbKUhsfGRYPeTMl8W5CHp5N50F7DDsVv9BAfJR6bGpHo3MpZtW/d/pmifYwClZCCBUEZ3Oj
 J5HsADOgrI8U6voxiHM/71Vl953hik8n/8DesH+UwdrcrehwLGiELP7bN/DA9/JYIUJlhki1Q
 FG8kKiajWc+8PzZ4aJ75T5WxRXizIQJMBlqDuejaaIDZHf7X8ZvGv2DQQMLr61lmyGqhFg83s
 h3QDWGdMidC9fSiokGf6IHltj9QryAKNFuME8HJkyWkt9kVyoFuPgpDGk85UVwktgKACB5C4m
 +UoG16VeiIXvYgmKFaZgAoEtg/TfqAQX0DBNPooxsJDoqlsETvy4ZrL0tVfIikTSlhuPF4pjq
 rJj3xCu+aeTicKvi/+HOtZsZcZ877bxlXyc5XZvg3FMLXKw+YDBdneCOsaJ7GIi6nx1w4QQ0i
 cykR16OhzgSxvUz1thJLEcvyafQ4Z96ScVVse5UhzjRlxAlkIOM9+8DjqITpSnNhYPodIbc7x
 /nR5YiX0NitxCL3sJ2D28nalT+8GnLNSBfFZdjs9xALcUfK/+T48Y6XGn70E1g1v7LEY8Goww
 ovrZ5wjxWquSg13grsE7emHfuAB9VHRnYtdlR8qN2k0DOku2YuynP+TMP9U9xYx0OqEisksko
 4sy3pBvwKzP/AHEMqznzIRX11AzSIZoHeuGV36pPS/DqFcadDCZp0cltUoRq/l9JNGcmCTPG0
 Nf3UZJZS1ExAf3sNKuSOjN/yoFh0YqCxTgnkX1ERsNgrZ1urzJIVLHEC/8yvmS1fwXHdKPBam
 qEkKP5cmSlVWN19tVEUGsNIB8EG2DvJYK1Xg9wcwCUQPaCioECyFMGnWNoMUd5GEgS4vpDCFA
 PcfJixp5xelb8EfYaLStUSWBm1nV8kvG8irHxqXqIFfFoDnGKg9vrWEBexnIFZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.19 10:07, Mike Rapoport wrote:
> On Tue, Feb 12, 2019 at 05:16:12PM +0200, Mike Rapoport wrote:
>> The get_memblock() function implements custom bottom-up memblock allocator.
>> Setting 'memblock_bottom_up = true' before any memblock allocation is done
>> allows replacing get_memblock() calls with memblock_alloc().

>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>

Thanks!
Shall I push the patch upstream with the parisc tree?

Helge



>> ---
>> v2: fix allocation alignment
>>
>>  arch/parisc/mm/init.c | 52 +++++++++++++++++++--------------------------------
>>  1 file changed, 19 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
>> index 059187a..d0b1662 100644
>> --- a/arch/parisc/mm/init.c
>> +++ b/arch/parisc/mm/init.c
>> @@ -79,36 +79,6 @@ static struct resource sysram_resources[MAX_PHYSMEM_RANGES] __read_mostly;
>>  physmem_range_t pmem_ranges[MAX_PHYSMEM_RANGES] __read_mostly;
>>  int npmem_ranges __read_mostly;
>>  
>> -/*
>> - * get_memblock() allocates pages via memblock.
>> - * We can't use memblock_find_in_range(0, KERNEL_INITIAL_SIZE) here since it
>> - * doesn't allocate from bottom to top which is needed because we only created
>> - * the initial mapping up to KERNEL_INITIAL_SIZE in the assembly bootup code.
>> - */
>> -static void * __init get_memblock(unsigned long size)
>> -{
>> -	static phys_addr_t search_addr __initdata;
>> -	phys_addr_t phys;
>> -
>> -	if (!search_addr)
>> -		search_addr = PAGE_ALIGN(__pa((unsigned long) &_end));
>> -	search_addr = ALIGN(search_addr, size);
>> -	while (!memblock_is_region_memory(search_addr, size) ||
>> -		memblock_is_region_reserved(search_addr, size)) {
>> -		search_addr += size;
>> -	}
>> -	phys = search_addr;
>> -
>> -	if (phys)
>> -		memblock_reserve(phys, size);
>> -	else
>> -		panic("get_memblock() failed.\n");
>> -
>> -	memset(__va(phys), 0, size);
>> -
>> -	return __va(phys);
>> -}
>> -
>>  #ifdef CONFIG_64BIT
>>  #define MAX_MEM         (~0UL)
>>  #else /* !CONFIG_64BIT */
>> @@ -321,6 +291,13 @@ static void __init setup_bootmem(void)
>>  			max_pfn = start_pfn + npages;
>>  	}
>>  
>> +	/*
>> +	 * We can't use memblock top-down allocations because we only
>> +	 * created the initial mapping up to KERNEL_INITIAL_SIZE in
>> +	 * the assembly bootup code.
>> +	 */
>> +	memblock_set_bottom_up(true);
>> +
>>  	/* IOMMU is always used to access "high mem" on those boxes
>>  	 * that can support enough mem that a PCI device couldn't
>>  	 * directly DMA to any physical addresses.
>> @@ -442,7 +419,10 @@ static void __init map_pages(unsigned long start_vaddr,
>>  		 */
>>  
>>  		if (!pmd) {
>> -			pmd = (pmd_t *) get_memblock(PAGE_SIZE << PMD_ORDER);
>> +			pmd = memblock_alloc(PAGE_SIZE << PMD_ORDER,
>> +					     PAGE_SIZE << PMD_ORDER);
>> +			if (!pmd)
>> +				panic("pmd allocation failed.\n");
>>  			pmd = (pmd_t *) __pa(pmd);
>>  		}
>>  
>> @@ -461,7 +441,10 @@ static void __init map_pages(unsigned long start_vaddr,
>>  
>>  			pg_table = (pte_t *)pmd_address(*pmd);
>>  			if (!pg_table) {
>> -				pg_table = (pte_t *) get_memblock(PAGE_SIZE);
>> +				pg_table = memblock_alloc(PAGE_SIZE,
>> +							  PAGE_SIZE);
>> +				if (!pg_table)
>> +					panic("page table allocation failed\n");
>>  				pg_table = (pte_t *) __pa(pg_table);
>>  			}
>>  
>> @@ -700,7 +683,10 @@ static void __init pagetable_init(void)
>>  	}
>>  #endif
>>  
>> -	empty_zero_page = get_memblock(PAGE_SIZE);
>> +	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> +	if (!empty_zero_page)
>> +		panic("zero page allocation failed.\n");
>> +
>>  }
>>  
>>  static void __init gateway_init(void)
>> -- 
>> 2.7.4
>>
> 

