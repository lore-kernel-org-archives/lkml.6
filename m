Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELsetnq+HDh1CEDYoarsz+4DVN+2slNv3gfYUfTsgV73GGQCb1uupHIOT0+qzlxWRIVQEuya
ARC-Seal: i=1; a=rsa-sha256; t=1520277729; cv=none;
        d=google.com; s=arc-20160816;
        b=usNjIs1q8EMItpB28+F4q3C1MEAQvt6LmYAkjQR0URbB1rpmoka2Oas/U6w7b9tyGv
         KIgLP0W+HC0iHIZ5jzzDcUH7NyXCwlFZqJvD9rTPgloFjHC75HSKSnjHM9SArwdUH5UN
         LqxGMgGgrNOZb/tpBjvru60r8KLzzxe5DXqnQrvdS4+0h17Y9gOzWz9Rrg7RU3EyzKjG
         34Femf8uQCBJDxCll5sW21rP/KhU3IpYp/ixvjmMwbyUkVeAr3pvfAOlfvtYjjOM+XZk
         FJ0LNUGQvN85CiHRfx2Jbg+FDw5WYTD6S6AyIdhKJE8Uu8K3X7MAHLMIrVd+AbHNAeON
         wnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=rlbAEy3VP9ofThDDJvc8JtM8b18KMU6cswDL6c74Lr0=;
        b=e+VgmzVtDJ7yWJ9LXlagn3MzjJKaoSTv57KosQ+bDDVdXZEkFobpnDwCvCZgls/2+S
         4OJ03pbE+v1Qde44aPgqm+Q7qFgMFh0lKjF3PseMYy3tAcJUNxJYDq+p8g1I25MGZJ7h
         tioHgO5At0lHO7NBRPPlv2VQ3YetaUbU2ZV/MF7d+Ipy3SRLu1mxB8zp0g+N8xP/ggT8
         h3tNrDimWzW4QEBFHf6Z+V46Dvt1/zex9iaReosZy4iioJGXPytHFrrPs4Qq7LS2Q6XJ
         kB5jB5K+xQeTliwwvYHYUtIYBJo39FdwpWdDryShz0O4bmMUVFogFACXefaGKbH2W9bM
         UB6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32578687"
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data
 Integrity)
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net,
 akpm@linux-foundation.org
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
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
Message-ID: <a59ece97-ba1f-dfb1-bfc8-b44ffd8edbca@linux.intel.com>
Date: Mon, 5 Mar 2018 11:22:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1594126741125969716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 09:15 AM, Khalid Aziz wrote:
> +#define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
> +static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
> +{
> +	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
> +		return 0;
> +	if (prot & PROT_ADI) {
> +		if (!adi_capable())
> +			return 0;
> +
> +		if (addr) {
> +			struct vm_area_struct *vma;
> +
> +			vma = find_vma(current->mm, addr);
> +			if (vma) {
> +				/* ADI can not be enabled on PFN
> +				 * mapped pages
> +				 */
> +				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> +					return 0;

You don't hold mmap_sem here.  How can this work?
