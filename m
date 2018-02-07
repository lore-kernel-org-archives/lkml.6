Return-Path: <khalid.aziz@oracle.com>
X-Google-Smtp-Source: AH8x2243+Tsc8ntGz/aHjnW+zv3vZErXJWxY/7g/AYHgNu29iTcxGkm8fgoif8XjkigibDdC4M2V
ARC-Seal: i=1; a=rsa-sha256; t=1518019600; cv=none;
        d=google.com; s=arc-20160816;
        b=m0E87ehqn8jQg6W/fVvvnG1nDNy50MoIKyHDwZ0hBxc//irYit8npl3ZoeuG4SG0t+
         nTUglAwAaqeAIY612R7ZWBS6khi1nUsSsbb6K9FeONkacTR7O0UxcASbokU1CVZ/nX/j
         eKC+nbX+CVUkeRXzG9S7Nlzr3NzDsjq69Tf9O6Rb6+NN76cmKOZtq85CcZAJ3jTrLHKh
         WlhhimeM1H++X4PMvJ+zOqyVocA+37jhFQYIMEoAuH7TYjwDdBOv7Z0iqxiGi+PAg+5k
         dDAisRHhgHwnJHq6j8PBkNCfuggo3f4OQFySH9tiVwGYV3yZCPADSdqma1UX0kOi4eVD
         pghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=6ze+uJqfnYhvY9tFEARf5QqX87HQyvA35fkkrTcMS4A=;
        b=KbcT9B57c2ntT4PuJxph9kHb8dU/7MUxHNSUYWvT8LByWAXSecsVl4UfhHMpM28luJ
         j/34dfuqv9ta4waeWhTqHCjj4oMI5SfUEnJOYzc1yXqWJz8TlkCQyomwklJTSda2Lxck
         VpiS13Ei6tNseXZiFU06omAOPxoedmo57o4puspdAbfRTbfm44laECMpze3WozNM8FMZ
         3HUH3Wu3Y90G79bypsrCnnYe9hauDge5kgeKUF4GurAy2xudUvztcnZDQEnRgf6LLCoT
         pBYoPfZ7axhUgRRBTm1y6My3SkkxCbM+PovfnWHE7YzAGnwhA694Axyr8Yvn3hQFwNsR
         e/Ng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TAhOyXDn;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TAhOyXDn;
       spf=pass (google.com: domain of khalid.aziz@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=khalid.aziz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v11 00/10] Application Data Integrity feature introduced
 by SPARC M7
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, allen.pais@oracle.com,
        anthony.yznaga@oracle.com, arnd@arndb.de, babu.moger@oracle.com,
        benh@kernel.crashing.org, bob.picco@oracle.com, bsingharora@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, dave.jiang@intel.com,
        david.j.aldridge@oracle.com, elena.reshetova@intel.com,
        glx@linutronix.de, gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        hillf.zj@alibaba-inc.com, hpa@zytor.com, hughd@google.com,
        imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com,
        jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de,
        khalid@gonehiking.org, khandual@linux.vnet.ibm.com,
        kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org,
        ktkhai@virtuozzo.com, liam.merwick@oracle.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net, me@tobin.cc,
        mgorman@suse.de, mgorman@techsingularity.net, mhocko@suse.com,
        mike.kravetz@oracle.com, minchan@kernel.org, mingo@kernel.org,
        mingo@redhat.com, mpe@ellerman.id.au, nadav.amit@gmail.com,
        nagarathnam.muthusamy@oracle.com, nborisov@suse.com,
        n-horiguchi@ah.jp.nec.com, nick.alcock@oracle.com,
        nitin.m.gupta@oracle.com, ombredanne@nexb.com,
        pasha.tatashin@oracle.com, paulus@samba.org, pombredanne@nexb.com,
        punit.agrawal@arm.com, rob.gardner@oracle.com,
        ross.zwisler@linux.intel.com, shannon.nelson@oracle.com, shli@fb.com,
        sparclinux@vger.kernel.org, steven.sistare@oracle.com,
        tglx@linutronix.de, thomas.tai@oracle.com, tklauser@distanz.ch,
        tom.hromatka@oracle.com, vegard.nossum@oracle.com,
        vijay.ac.kumar@oracle.com, willy@infradead.org, x86@kernel.org,
        zi.yan@cs.rutgers.edu
References: <cover.1517497017.git.khalid.aziz@oracle.com>
 <87wozwi0p1.fsf@xmission.com>
 <0f1bdb63-60d5-467c-a6a4-c06ba62b1f6e@oracle.com>
 <87h8qtfdvj.fsf@xmission.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <c50c053f-1ee7-81f9-99bb-e5f6fe6bb43e@oracle.com>
Date: Wed, 7 Feb 2018 09:04:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <87h8qtfdvj.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8798 signatures=668663
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802070204
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223715312130121?=
X-GMAIL-MSGID: =?utf-8?q?1591758920790347731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/07/2018 12:38 AM, ebiederm@xmission.com wrote:
> Khalid Aziz <khalid.aziz@oracle.com> writes:
> 
>> On 02/01/2018 07:29 PM, ebiederm@xmission.com wrote:
>>> Khalid Aziz <khalid.aziz@oracle.com> writes:
>>>
>>>> V11 changes:
>>>> This series is same as v10 and was simply rebased on 4.15 kernel. Can
>>>> mm maintainers please review patches 2, 7, 8 and 9 which are arch
>>>> independent, and include/linux/mm.h and mm/ksm.c changes in patch 10
>>>> and ack these if everything looks good?
>>>
>>> I am a bit puzzled how this differs from the pkey's that other
>>> architectures are implementing to achieve a similar result.
>>>
>>> I am a bit mystified why you don't store the tag in a vma
>>> instead of inventing a new way to store data on page out.
>>
>> Hello Eric,
>>
>> As Steven pointed out, sparc sets tags per cacheline unlike pkey. This results
>> in much finer granularity for tags that pkey and hence requires larger tag
>> storage than what we can do in a vma.
> 
> *Nod*   I am a bit mystified where you keep the information in memory.
> I would think the tags would need to be stored per cacheline or per
> tlb entry, in some kind of cache that could overflow.  So I would be
> surprised if swapping is the only time this information needs stored
> in memory.  Which makes me wonder if you have the proper data
> structures.
> 
> I would think an array per vma or something in the page tables would
> tend to make sense.
> 
> But perhaps I am missing something.

The ADI tags are stored in spare bits in the RAM. ADI tag storage is 
managed entirely by memory controller which maintains these tags per ADI 
block. An ADI block is the same size as cacheline on M7. Tags for each 
ADI block are associated with the physical ADI block, not the virtual 
address. When a physical page is reused, the physical ADI tag storage 
for that page is overwritten with new ADI tags, hence we need to store 
away the tags when we swap out a page. Kernel updates the ADI tags for 
physical page when it swaps a new page in. Each vma can cover variable 
number of pages so it is best to store a pointer to the tag storage in 
vma as opposed to actual tags in an array. Each 8K page can have 128 
tags on it. Since each tag is 4 bits, we need 64 bytes per page to store 
the tags. That can add up for a large vma.

> 
>>> Can you please use force_sig_fault to send these signals instead
>>> of force_sig_info.  Emperically I have found that it is very
>>> error prone to generate siginfo's by hand, especially on code
>>> paths where several different si_codes may apply.  So it helps
>>> to go through a helper function to ensure the fiddly bits are
>>> all correct.  AKA the unused bits all need to be set to zero before
>>> struct siginfo is copied to userspace.
>>>
>>
>> What you say makes sense. I followed the same code as other fault handlers for
>> sparc. I could change just the fault handlers for ADI related faults. Would it
>> make more sense to change all the fault handlers in a separate patch and keep
>> the code in arch/sparc/kernel/traps_64.c consistent? Dave M, do you have a
>> preference?
> 
> It is my intention post -rc1 to start sending out patches to get the
> rest of not just sparc but all of the architectures using the new
> helpers.  I have the code I just ran out of time befor the merge
> window opened to ensure everything had a good thorough review.
> 
> So if you can handle the your new changes I expect I will handle the
> rest.
> 

I can add a patch at the end of my series to update all force_sig_info() 
in my patchset to force_sig_fault(). That will sync my patches up with 
your changes cleanly. Does that work for you? I can send an updated 
series with this change. Can you review and ack the patches after this 
change.

Thanks,
Khalid
