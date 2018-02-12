Return-Path: <kernel-hardening-return-11713-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227NM+260CDneaj+LmcBlOodp5phFomnMea+vx3O3qVG7MS3Duasuu09Ns0trJ06ICQY8TsP
ARC-Seal: i=1; a=rsa-sha256; t=1518434259; cv=none;
        d=google.com; s=arc-20160816;
        b=zQmaln//r2njzO0NtJ6GxNGMIz27irpW/q/kSFjghFNbsJgaddeAy2F40gXRhpuMQB
         C03sJx6Bewrc8rJQs7SA7SaT5PwvjIcrohx+1g6EZe5R4ChUcfgyU7LkqKZV/RCkk5r0
         3ba3cvUIhcfYXi6SI7xeX2ABo+qIdVOP9fezlu+gohK1pQO27u9cDECIvOmemJhhWqZS
         0r1WnI4GL7qj6UUu7qXvKB1NOmSCbC5GKcJttMshpkDRwXp+neGRCnDGtou9EJ66V3jY
         LmaQA2NFb3bGxmqKAX5/fuOCSkQwT/q2xN9r4uGaaSwYZ9HvyxEnix5WJ+GjNKWCn7S4
         a8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=KeRlfLVfFlxEerJiwWYxSa85M3TKAOfKPNCsh/3rXKo=;
        b=XLbRLq5MOudo7jdRiAJHE77rFYsHTd8t1u8vRlMW1UvM3bYmaFJk3ENBQF9wt/Ri9U
         9BIx52oPlwWp7LS80qMW1ocdPVKTHClCWZWr7XLy/oETrhDZCaz6HSRmguOvtWFfHSfy
         1nUPa/zkL02zzcjz9/PgFysDhMba+5ndhd6zHvCFhDuianI2FgZpcP3St8lliegcwG2h
         eVich8m/PLZ/a182N/2pIcG+Ix7bojVnEZsV1RFdEnui/5qQhNqEdvcJZlYmGZsjjOLb
         +C1bnphNVSSwq4Q70qfCqs5OnWfwQ3rX8p1XMFl3E4onwpqRBRyXStAROeNvNoguM45T
         fxZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11713-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11713-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11713-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11713-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: <willy@infradead.org>, <rdunlap@infradead.org>, <corbet@lwn.net>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<jglisse@redhat.com>, <hch@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-2-igor.stoppa@huawei.com>
 <20180211122444.GB13931@rapoport-lnx>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <f0a244f2-f63a-376b-28f2-debbe914da34@huawei.com>
Date: Mon, 12 Feb 2018 13:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180211122444.GB13931@rapoport-lnx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073112440630013?=
X-GMAIL-MSGID: =?utf-8?q?1592193722284705318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 11/02/18 14:24, Mike Rapoport wrote:
> On Sun, Feb 11, 2018 at 05:19:15AM +0200, Igor Stoppa wrote:
[...]

>> +/**
>> + * mem_to_units - convert references to memory into orders of allocation
> 
> Documentation/doc-guide/kernel-doc.rst recommends to to include brackets
> for function comments. I haven't noticed any difference in the resulting
> html, so I'm not sure if the brackets are actually required.

This is what I see in the example from mailine docs:

/**
 * foobar() - Brief description of foobar.
 * @argument1: Description of parameter argument1 of foobar.
 * @argument2: Description of parameter argument2 of foobar.
 *
 * Longer description of foobar.
 *
 * Return: Description of return value of foobar.
 */
int foobar(int argument1, char *argument2)


What are you referring to?

[...]

>> + * @size: amount in bytes
>> + * @order: power of 2 represented by each entry in the bitmap
>> + *
>> + * Returns the number of units representing the size.
> 
> Please s/Return/Return:/

:-( I thought I had fixed them all. thanks for spotting this.

[...]

>> + * Return: If two users alter the same bit, to one it will return
>> + * remaining entries, to the other it will return 0.
> 
> And what if there are three or four concurrent users? ;-)
> 
> I believe that a more elaborate description about what happens with
> concurrent attempts to alter the bitmap would be really helpful.

ok

--
thanks, igor
