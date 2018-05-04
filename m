Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-856742-1525474658-2-6332794625343123618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525474658; b=FdJD7MA2FYLXjjns4WJF2s9KAyFwymZQloF9YJxB70ugvSaMpz
    XBG1hoEFqznyK85cl+1RdB+O+dNbM1PkQO0Xi60wlCsO1f2YZ9JbJAhZWF8UeL+P
    +v62Nkp9Af3YxO8DI3nqHjqjdtqdt1p20O6N9OAScBoUCSqEaERF8Ezv9Ky010Ve
    PQ0S8xHZh1BA1P6g3FChhexyj2R3nzDqvvb42NhuNKhc2UbP6G9nEfY617pvuxEt
    Nykfq9UXeFHUnwEjRxgAcd6vPDS9PpjzR3UhuO7oRg8IMLJUrF56j2/drH3Rn+Xa
    JHsEI+DobN6+ZpUzP1fk+qM5Qp/5NM2wf96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525474658;
    bh=bBcAdcNqdtszvAYhA8C6TkmQr491M0D6apuFRelJp5Y=; b=UsL4K3LLn8I5
    dWW0KxLuX2/p6j1B0gKbow6B08GM6l60wNiq/DU9YyiRvpBW8y+qa5VsFzmvLGe/
    c12U1TFoXGVQutBqBhGXpWtvfDRy91ukg2hRumsGwISHwG8BgGug7j5NyvDDxcKH
    L1BIGIHe6Bm0sWNf0N9bN6jRDPN0la4lCMn3cR+jDJMWIOZClSTcyRq5GVBTj1kR
    DBGrMn29k5Sue66DtlYxn34lnBqCJwJjFn9zm9ww2llsXPWYrkdsG+13fzJgB4iv
    GQ27qy1jWvD7Tx3RVtco/Ml+0plJ5A7caebc3jOwxTyKDiEm6LFa/AG89QiKrS9V
    VeJTsCQheA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDoFSMtB7SFEu9WwSIjKGZPbRuWHz4tOAv5B4tWlBivN4NOqIWghh1Nbj9mJ/kT6K7GNZe9mhPsRG+5ta3b4+ltQbJh8sDsEE3W8MlfdmRW6MxQQUh/h
    Y8vHVyLmR2VBq6kPlqc5/+LbA1PpvxwzuR8BN9ckmFBnahvZedaT5qRNbaD7wR3ZlEJ2gQKBTn1GQ3J7nzhkYIVApxeuD5M+FAoOPX5/4RebfuL5aaZKVszE
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vwZ4BmQxoYZpG0bYJ2YA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEDW5e (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 18:57:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:12410 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbeEDW5e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 May 2018 18:57:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="38787712"
Subject: Re: [PATCH v13 3/3] mm, powerpc, x86: introduce an additional vma bit
 for powerpc pkey
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
        mingo@redhat.com, akpm@linux-foundation.org
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
 <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <1e37895e-5a18-11c1-58f1-834f96dfd4d5@intel.com>
Date: Fri, 4 May 2018 15:57:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525471183-21277-3-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 0c9e392..3ddddc7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -679,6 +679,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT1)]	= "",
>  		[ilog2(VM_PKEY_BIT2)]	= "",
>  		[ilog2(VM_PKEY_BIT3)]	= "",
> +		[ilog2(VM_PKEY_BIT4)]	= "",
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
...
> +#if defined(CONFIG_PPC)
> +# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
> +#else 
> +# define VM_PKEY_BIT4	0
> +#endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */

That new line boils down to:

		[ilog2(0)]	= "",

on x86.  It wasn't *obvious* to me that it is OK to do that.  The other
possibly undefined bits (VM_SOFTDIRTY for instance) #ifdef themselves
out of this array.

I would just be a wee bit worried that this would overwrite the 0 entry
("??") with "".
