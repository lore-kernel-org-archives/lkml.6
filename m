Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDKJAH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:00:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34666 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752575AbeDKJAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:00:04 -0400
Subject: Re: [PATCH v3 2/2] mm: remove odd HAVE_PTE_SPECIAL
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc: Rich Felker <dalias@libc.org>, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org, linux-mm@kvack.org, paulus@samba.org,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S . Miller" <davem@davemloft.net>
References: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523433816-14460-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180411083315.GA23400@dhcp22.suse.cz>
 <5bd1bb46-8f71-e6db-7fb7-43d023a37f58@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <fd1be042-c957-feb3-05d5-11244a3626da@c-s.fr>
Date: Wed, 11 Apr 2018 10:59:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5bd1bb46-8f71-e6db-7fb7-43d023a37f58@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/04/2018 à 10:41, Laurent Dufour a écrit :
> On 11/04/2018 10:33, Michal Hocko wrote:
>> On Wed 11-04-18 10:03:36, Laurent Dufour wrote:
>>> @@ -881,7 +876,8 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>>   
>>>   	if (is_zero_pfn(pfn))
>>>   		return NULL;
>>> -check_pfn:
>>> +
>>> +check_pfn: __maybe_unused
>>>   	if (unlikely(pfn > highest_memmap_pfn)) {
>>>   		print_bad_pte(vma, addr, pte, NULL);
>>>   		return NULL;
>>> @@ -891,7 +887,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>>>   	 * NOTE! We still have PageReserved() pages in the page tables.
>>>   	 * eg. VDSO mappings can cause them to exist.
>>>   	 */
>>> -out:
>>> +out: __maybe_unused
>>>   	return pfn_to_page(pfn);
>>
>> Why do we need this ugliness all of the sudden?
> Indeed the compiler doesn't complaint but in theory it should since these
> labels are not used depending on CONFIG_ARCH_HAS_PTE_SPECIAL.

Why should it complain ?

Regards
Christophe

> 
