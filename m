Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELv/sPBrB8Oc7v2oO1nGeNzZdlKoSkUQap6EEJ0igyJ3qJk9uBqSkSlEfF4tUCgP/lTdv8KQ
ARC-Seal: i=1; a=rsa-sha256; t=1520285178; cv=none;
        d=google.com; s=arc-20160816;
        b=EPS1OgyHfSShqdubWbVlCf+qxCRX2YC1wh8ogaFh9S2rPbfrxN1L5x1EY3QgIgQN6Y
         ppO3sawP3+f0+CLMnO1/0muD+uLujXgAwTKxtIyzL6UmeXhAmDUAwYkCA8O7bTesInwk
         TKp5EqgCuGdKvz9Derl5yPjzBCk4IEAEQnO/2fhASRv7QrvqU3/lLamPJCdbvBU+1/J0
         tBaSAG7psgjC6E8/DZDZCGkkKJPmCZvAB8X2ePgI58H5O01zYZJTf4hAPchZNUV839vg
         YlFCddqKf1og6tzBGz+ofvgFRhq9G4p3fCJvMHosOmww9SGOYyzP3ou5WOd8xY3FkorC
         nwpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=6DEYciDto211MeLVY9DSizEM2sK2hGWc/My8wa7fDgo=;
        b=O3RWRYERqs6NdrmKDp7B6UX9BEmRhk4LC+zGOyBrp/h8KswAlZjGZSq/2kFfZeVu2W
         kUFQCCc9QdUdLwZN2zfHSYGN/CNF/gDK0FGDmO7UfVvdXSAxQVKT3ae8kE12RNYf55Dr
         bSD/VMQfOb1LYQif3JktUamzX+cFx9u0Stz8hrCSZjgwbU4JMJ5v5xoR+6ZJnQPpA6yu
         2ihN0ddqnO4ZzLRCEpscfLzhSBS27ZNn+4ZjqAMuyynw6USjs2I6ilrPoHuSCBZ8g7ww
         JFqn4QprWdtn8z2cZ9cRW16SeAIbAiE3ia32mkw0L7/jr2o7eCiZF82AkTNFfn+Zi16w
         57fw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="180108775"
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
Message-ID: <08ef65c1-16b3-44e7-5cc3-7b6bde7bd5a4@linux.intel.com>
Date: Mon, 5 Mar 2018 13:26:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031948178483523?=
X-GMAIL-MSGID: =?utf-8?q?1594134551532291040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 09:15 AM, Khalid Aziz wrote:
> +tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
> +				    struct vm_area_struct *vma,
> +				    unsigned long addr)
...
> +	tags = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
> +	if (tags == NULL) {
> +		tag_desc->tag_users = 0;
> +		tag_desc = NULL;
> +		goto out;
> +	}
> +	tag_desc->start = addr;
> +	tag_desc->tags = tags;
> +	tag_desc->end = end_addr;
> +
> +out:
> +	spin_unlock_irqrestore(&mm->context.tag_lock, flags);
> +	return tag_desc;
> +}

OK, sorry, I missed this.  I do see that you now have per-ADI-block tag
storage and it is not per-page.

How big can this storage get, btw?  Superficially it seems like it might
be able to be gigantic for a large, sparse VMA.
