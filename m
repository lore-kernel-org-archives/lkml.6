Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELtijdkQui3F9wlxiKnmbig2Q9lBqkxfQUnkxBO5uaWl1tsmvmqZYeiLC81ChLvhFi+WnXhn
ARC-Seal: i=1; a=rsa-sha256; t=1520286627; cv=none;
        d=google.com; s=arc-20160816;
        b=tecEgq+puWqz2yR93wYoRyLcSLlJOkrbVfMVWVjAwC16Q+BJeqcJereXWDKLH5RGg/
         1DhEiorIdLxsfEhIGnhd7ojf82KymPnByPKkL2O/qHly5aHDMgKyWNU7/t5mniagXw0u
         59RGOQYFeeH9iSSSQW73jqvuVQ5J0QqTlaMDW+IbgrDHdeOGPozWqXDl9bvUV1ez96/h
         RclQGnGidVXD+HS11B7AaM2Foe8qMbjKQ5+Qyg5GMnpxD1yvtfDQZwLn58k1JVZ+iCO+
         D5AEnO0RqODxlKcn/LSxdQaAkMr1KvQwPEpfOxbzH6ACpxKsdrSGyUIXG8cKLiqNsqbI
         3xWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=pLzazn8ZY+/daRVH1wI0oAL0V8pPBp7mlCPyJW3tVd0=;
        b=VK730g41JUMoGEq04YF14Oo2a1EM4HdGB9wtrMvQY+/iP6T7HaJMbAWOAOVTddP7f3
         9kraj+dZk0YihowB7WBDv5I9j4eWYT36KJQZlCtrCKrVM1IB9LqX/vp7JK98qKcoW63o
         ivxQMoKoNJTV/SNx2o3Zsn0INO2CsrJ9ig/csbpQBNSHpT+1rtVMsvj52tZX84Q97JOJ
         YfsqVMhfqJgnb37NpT5CLHpLTXBTfo3RDVMiHU7UAM5qUoDG7KjiB9V0eNIBbO+HKGq6
         hUT9GBPoWRWnhZJvPm5sdUcB0Ox/jgFsyUCND8dN79FBn4md9wdr+OrQ/O6tB74yaJxi
         +55Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="180115895"
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data
 Integrity)
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net,
 akpm@linux-foundation.org
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <08ef65c1-16b3-44e7-5cc3-7b6bde7bd5a4@linux.intel.com>
 <b241c894-7751-bd01-2658-4cb6b89f7454@oracle.com>
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
Message-ID: <6d57c534-5696-e7a2-4b97-5521afcd072a@linux.intel.com>
Date: Mon, 5 Mar 2018 13:50:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b241c894-7751-bd01-2658-4cb6b89f7454@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1594136071235017010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 01:37 PM, Khalid Aziz wrote:
>> How big can this storage get, btw?  Superficially it seems like it might
>> be able to be gigantic for a large, sparse VMA.
>>
> Tags are stored only for the pages being swapped out, not for the pages
> in entire vma. Each tag storage page can hold tags for 128 pages (each
> page has 128 4-bit tags, hence 64 bytes are needed to store tags for an
> entire page allowing each page to store tags for 128 pages). Sparse VMA
> does not cause any problems since holes do not have corresponding pages
> that will be swapped out. Tag storage pages are freed once all the pages
> they store tags for have been swapped back in, except for a small number
> of pages (maximum of 8) marked for emergency tag storage.

With a linear scan holding a process-wide spinlock?  If you have a fast
swap device, does this become the bottleneck when swapping ADI-tagged
memory?

FWIW, this tag storage is complex and subtle enough code that it
deserves to be in its own well-documented patch, not buried in a
thousand-line patch.

> +tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
> +				   struct vm_area_struct *vma,
> +				   unsigned long addr)
> +{
> +	tag_storage_desc_t *tag_desc = NULL;
> +	unsigned long i, max_desc, flags;
> +
> +	/* Check if this vma already has tag storage descriptor
> +	 * allocated for it.
> +	 */
> +	max_desc = PAGE_SIZE/sizeof(tag_storage_desc_t);
> +	if (mm->context.tag_store) {
> +		tag_desc = mm->context.tag_store;
> +		spin_lock_irqsave(&mm->context.tag_lock, flags);
> +		for (i = 0; i < max_desc; i++) {
> +			if ((addr >= tag_desc->start) &&
> +			    ((addr + PAGE_SIZE - 1) <= tag_desc->end))
> +				break;
> +			tag_desc++;
> +		}
> +		spin_unlock_irqrestore(&mm->context.tag_lock, flags);
