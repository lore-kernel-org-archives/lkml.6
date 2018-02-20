Return-Path: <kernel-hardening-return-11831-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224Ok61kyDpneaqTMLX1S7w5jZneVXjK2vKrHyHePhLToV8izHcj6uGLy8bHWrjigh0jBgHs
ARC-Seal: i=1; a=rsa-sha256; t=1519146477; cv=none;
        d=google.com; s=arc-20160816;
        b=sq+1YB/k1Eq7YMPhN1abTOl2wKYPeX2NfChPloWcQYAKhjZCO4U0Iz1cJU+1NkcQTk
         iyRx/PgLhDlArATFvXliUGQyB9u8owbe9dL+/HfGIPAbOT+OoFs6tj6cLNHjRGnfKt7n
         pEllkc9TnxA8xPch6TTuCgmBVe+wZ3a/cQ0Ch7rwvaeS48zGMYAu8Rp9pzQhgQjqEMuJ
         AMz79rhaeKC6x4PujLs0IgNgNZkttq2YlJ0TTxl+y+np2IPQNr9Ow+x0J4KVAVE0ZWh4
         4InVUGOiHJPmYxrdmo011oRM1AeOMOd8emKUYP3fUmAVrbjKi8CnOiuvdv/vLBBXewvA
         OYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=JfYY0LTJrqKwfVutz/JktbLIH/nmQbKdLmwtasI3/8k=;
        b=QuKabw0fPdgO86EnAFUukiqvmr1vGj1CXwRTMn3sr0r3dDh3AdUYwqLDNNJy27FM4u
         XCNj0WHPqCeIw02BM669A6HlsfzgH4s4Lky4agL72SVRfBfe58S03VpHZnKoa6ctT7eY
         52SoVQjCXX3iHtWz4PvJW4Fw5kEsZjwdYmIGRiGwQFLk4tUabRPMOLlmxOYA7FlY+v7k
         Eohi40VpUObO+YJoqsO7GXG44Erwbe2pv2fEHjR2BAaRMvyJaVxVsaqDsjnGx+TELiPm
         WYtv3qVbbl6ouxqiQyQvdRy5cN1qGcIkSh0A63W3E26NdBCGklsV5hkTqN+VAkMuuW9g
         VnTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11831-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11831-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11831-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11831-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
To: Kees Cook <keescook@chromium.org>
CC: Matthew Wilcox <willy@infradead.org>, Randy Dunlap
	<rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Michal Hocko
	<mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>, Jerome Glisse
	<jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, "Christoph
 Lameter" <cl@linux.com>, linux-security-module
	<linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, LKML
	<linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <20180212165301.17933-2-igor.stoppa@huawei.com>
 <CAGXu5jJWLdsBr-6mXiFQprT-=h2qhhXAWRLQ+EaKKiubKOQOfw@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <daaee36a-e6c7-8fbf-b758-ecee5106da9a@huawei.com>
Date: Tue, 20 Feb 2018 19:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJWLdsBr-6mXiFQprT-=h2qhhXAWRLQ+EaKKiubKOQOfw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214925267848300?=
X-GMAIL-MSGID: =?utf-8?q?1592940536181167584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/02/18 01:52, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> @@ -738,14 +1031,16 @@ EXPORT_SYMBOL(devm_gen_pool_create);
>>
>>  #ifdef CONFIG_OF
>>  /**
>> - * of_gen_pool_get - find a pool by phandle property
>> + * of_gen_pool_get() - find a pool by phandle property
>>   * @np: device node
>>   * @propname: property name containing phandle(s)
>>   * @index: index into the phandle array
>>   *
>> - * Returns the pool that contains the chunk starting at the physical
>> - * address of the device tree node pointed at by the phandle property,
>> - * or NULL if not found.
>> + * Return:
>> + * * pool address      - it contains the chunk starting at the physical
>> + *                       address of the device tree node pointed at by
>> + *                       the phandle property
>> + * * NULL              - otherwise
>>   */
>>  struct gen_pool *of_gen_pool_get(struct device_node *np,
>>         const char *propname, int index)
> 
> I wonder if this might be more readable by splitting the kernel-doc
> changes from the bitmap changes? I.e. fix all the kernel-doc in one
> patch, and in the following, make the bitmap changes. Maybe it's such
> a small part that it doesn't matter, though?

I had the same thought, but then I would have made most of the kerneldoc
changes to something that would be altered by the following patch,
because it would have made little sense to fix only those parts that
would have survived.

If it is really a problem to keep them together, I could put these
changes in a following patch. Would that be ok?

--
igor
