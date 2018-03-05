Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELuy0gF9I8A2f5Aedo5DDxgEM2MMzoTZSY5E30xO3MUwCg7CcPtpM4PcgBBOGOVeC6uU56mN
ARC-Seal: i=1; a=rsa-sha256; t=1520285207; cv=none;
        d=google.com; s=arc-20160816;
        b=QH56Ribhi9bmsQQH26Zag4WxFQUE6qaMe/4I3/N7XD9VqR8ssD6nl+d0zVzmAhtO2d
         HyG8N2q5LTTaGXUFTp0P2c9TIzoU+IwX4C9dTTHzh1DZ5LvrW5n18J5bQ8VWkRegcOBd
         SRGL/6otQgjU9dM2tBpGLQBqH031x+ObZD+HoRO1MaUzGZ8nDPLPrXW8ppz5sp4W2wps
         c7S+orVuveh8+hSxAMO6WQQMecneiqbHk1u1qWB5PX8ranjamkv3gkP/+8M6unTH2LO7
         8Ui8axEs5UN2brcOqLDFeM5AQvlMFiAyrCpRTT6wqE8dz0LfTFHkkbQyoxsAhc57KFHR
         6qeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=/6QJf62VCk4EC8JVdNGHs2blKGNhLaUIiKD4TDTs9E4=;
        b=eU4VI1H9252dAWIVGuBDKBFYVtKHXyfvjH4PnyD2BcrVZFrIrZYVoHI++8yFokO3/X
         JinRmVp8FaduWjxINxITg9Pv8cXF++aV80uJSUgUMzBwXrenNQcZfiUtof7Ouzt2AqYm
         vncfEVEk5gvYw/bcpFf6xc0fqGLc0fxT+pv32BjBtOB1mofflkw3RYiILsg3LHl37Xq0
         R3ue174rXTZ5apiHQ1YXBYbNgFlK7HC9FVphSnYF/fJuf2GnMCJjGGiJHgkEw8wwSr1I
         Tl66tIkLPcjm/fOlbLumx188LBLPoBXzqlrjuWss7vggpU/KTBDmX2FrdPlN/KijdeI4
         ai/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="180108912"
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data
 Integrity)
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net,
 akpm@linux-foundation.org
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <a59ece97-ba1f-dfb1-bfc8-b44ffd8edbca@linux.intel.com>
 <84931753-9a84-8624-adb8-95bd05d87d56@oracle.com>
Cc: corbet@lwn.net, bob.picco@oracle.com, steven.sistare@oracle.com,
 pasha.tatashin@oracle.com, mike.kravetz@oracle.com, rob.gardner@oracle.com,
 mingo@kernel.org, nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com,
 kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com,
 allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com,
 vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz,
 punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com,
 ross.zwisler@linux.intel.com, dave.jiang@intel.com, willy@infradead.org,
 minchan@kernel.org, imbrenda@linux.vnet.ibm.com, aarcange@redhat.com,
 kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 gregkh@linuxfoundation.org, nagarathnam.muthusamy@oracle.com,
 linux@roeck-us.net, jane.chu@oracle.com, dan.j.williams@intel.com,
 jglisse@redhat.com, ktkhai@virtuozzo.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <098cda37-0e3c-de44-5995-9e5f74b301c6@linux.intel.com>
Date: Mon, 5 Mar 2018 13:26:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <84931753-9a84-8624-adb8-95bd05d87d56@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1594134581747470361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 01:14 PM, Khalid Aziz wrote:
> On 03/05/2018 12:22 PM, Dave Hansen wrote:
>> On 02/21/2018 09:15 AM, Khalid Aziz wrote:
>>> +#define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
>>> +static inline int sparc_validate_prot(unsigned long prot, unsigned
>>> long addr)
>>> +{
>>> +    if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM |
>>> PROT_ADI))
>>> +        return 0;
>>> +    if (prot & PROT_ADI) {
>>> +        if (!adi_capable())
>>> +            return 0;
>>> +
>>> +        if (addr) {
>>> +            struct vm_area_struct *vma;
>>> +
>>> +            vma = find_vma(current->mm, addr);
>>> +            if (vma) {
>>> +                /* ADI can not be enabled on PFN
>>> +                 * mapped pages
>>> +                 */
>>> +                if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>>> +                    return 0;
>>
>> You don't hold mmap_sem here.  How can this work?
>>
> Are you suggesting that vma returned by find_vma() could be split or
> merged underneath me if I do not hold mmap_sem and thus make the flag
> check invalid? If so, that is a good point.

Um, yes.  You can't walk the vma tree without holding mmap_sem.
