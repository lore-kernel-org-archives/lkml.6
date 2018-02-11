Return-Path: <kernel-hardening-return-11693-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226GVaKyWybZ/mPRSfX+AsVtM/Y4TlYKv3jDGzoYP+TlAitPXCVbCH+05ZhwWCc63fq6/XdX
ARC-Seal: i=1; a=rsa-sha256; t=1518311131; cv=none;
        d=google.com; s=arc-20160816;
        b=C7jW0xEEvEwJCeL3eTLLL5DsSEh1/YjJqGolJNFvcg+S2gyuMBTzAC0PPSmNKJqtdf
         EtdkpZH2dOY7TSJGmzUq2BZLOXbpzOyOa2IfsHeca7OkYr1qKZXyTiIyWvN6VnT3HrTx
         SDxCijmxui8A3bC6aqYmsxNaTMSgYmzrWHdR5M+ZK+axcCzDG+D9OkANq2/Az6BMCl3I
         xJBRHt1VOEjRj+cOk2wBlJc0lCF/CfA+okC9DYCnIgb9VP/VA5foYgEEOBhuurU/NEZm
         82tnor4B2fQZI6/pqzoAwy1ALhsOEjkKmNEy7zUUVrtQoUyEsJcEonaLM52Z9QkIS/lk
         MovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=keYO+ULhVJv4KFROzWLdtJf3HhQNYwjnTHM3mu5v4tQ=;
        b=HE4tKYz+e7KIbctXfveAPLIRg/6ubRRX3cS5E7KZcsR5PVPcYP2uM2Dy+WmE0+9ixg
         lsJ2nA1FY53hWSN0d5+B3HZ+xB15aw3COKjKe02V1zqPx/pBF0yNuldC3NhDwB5oY73+
         iIcv1wgk5KZ9rW51ohIkhIOFcKhSFpHOto1wRn6ZlngoeU7Ynrf8rF6Q0Sp3iJaEIq/F
         LTJdG4FxTxSqvUHflFh1YpwVK41IcJFOZvizETidXaRR4my6GTubStdusYKzJZsF31ds
         aPDTAe8TzfFk7xSNcQ4yG5OgcNuUe5tJ+vptBxIyq+6CI+8cQ7LvGCaO1ylShi3MhdB2
         Ib8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11693-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11693-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11693-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11693-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/6] Protectable Memory
To: Randy Dunlap <rdunlap@infradead.org>, <jglisse@redhat.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<hch@infradead.org>, <willy@infradead.org>
CC: <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180204164732.28241-1-igor.stoppa@huawei.com>
 <20180204164732.28241-5-igor.stoppa@huawei.com>
 <921d4c76-703f-dd41-0451-599441d23c1d@infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <b355e37e-4bc1-526b-8853-5401588f177f@huawei.com>
Date: Sun, 11 Feb 2018 03:04:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <921d4c76-703f-dd41-0451-599441d23c1d@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592064613377237588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/02/18 00:06, Randy Dunlap wrote:
> On 02/04/2018 08:47 AM, Igor Stoppa wrote:

[...]

>> + * pmalloc_create_pool - create a new protectable memory pool -
> 
> Drop trailing " -".

yes

>> + * @name: the name of the pool, must be unique
> 
> Is that enforced?  Will return NULL if @name is duplicated?

ok, I'll state it more clearly that it's enforced

[...]

>> + * @pool: handler to the pool to be used for memory allocation
> 
>              handle (I think)

yes, also for all the other ones

[...]

>> + * avoid sleping during allocation.
> 
>             sleeping

yes

[...]

>> + * opposite to what is allocated on-demand when pmalloc runs out of free
> 
>       opposed to

yes

>> + * space already existing in the pool and has to invoke vmalloc.
>> + *
>> + * Returns true if the vmalloc call was successful, false otherwise.
> 
> Where is the allocated memory (pointer)?  I.e., how does the caller know
> where that memory is?
> Oh, that memory isn't yet available to the caller until it calls pmalloc(), right?

yes, it's a way to:
- preemptively beef up the pool, before entering atomic context
(unlikely that it will be needed, but possible), so that there is no
need to allocate extra pages (assuming one can estimate the max memory
that will be requested)
- avoid fragmentation caused by allocating smaller groups of pages


I'll add explanation for this.

[...]

>> + * @size: amount of memory (in bytes) requested
>> + * @gfp: flags for page allocation
>> + *
>> + * Allocates memory from an unprotected pool. If the pool doesn't have
>> + * enough memory, and the request did not include GFP_ATOMIC, an attempt
>> + * is made to add a new chunk of memory to the pool
>> + * (a multiple of PAGE_SIZE), in order to fit the new request.
> 
>                                              fill
> What if @size is > PAGE_SIZE?

Nothing special, it gets rounded up to the nearest multiple of
PAGE_SIZE. vmalloc doesn't have only drawbacks ;-)

[...]

>> + * Returns the pointer to the memory requested upon success,
>> + * NULL otherwise (either no memory available or pool already read-only).
> 
> It would be good to use the
>     * Return:
> kernel-doc notation for return values.

yes, good point, I'm fixing it everywhere in the patchset

[...]

>> + * will be availabel for further allocations.
> 
>               available

yes

[...]

>> +/**
> 
> /** means that the following comments are kernel-doc notation, but these
> comments are not, so just use /* there, please.

yes, also to the others

[...]

>> +	/* is_pmalloc_object gets called pretty late, so chances are high
>> +	 * that the object is indeed of vmalloc type
>> +	 */
> 
> Multi-line comment style is
> 	/*
> 	 * comment1
> 	 * comment..N
> 	 */

yes, also to the others

--
igor
