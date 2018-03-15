Return-Path: <kernel-hardening-return-12631-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs5y91QVbNrfKNoQETtwuKA4+CRJF1dLBWRDBRSWHxmB1Wc7AF3ePlXOPxw5XufPJJrYVK2
ARC-Seal: i=1; a=rsa-sha256; t=1521121452; cv=none;
        d=google.com; s=arc-20160816;
        b=BxYSdZ4fIZXP/CJk/mnaeqtjBaqggsmOsXtK6Jhylwt27+K+usFPY5Q5UsHAYwl85j
         LN6gBmtqsPZ+Vs8y6Nu5Urr0BFfutsKsI6LKRTV9EWdBjFavcNFN/qid43kT3xGUGTcH
         O56u5zwWQn98SG7s7ATt1Z6+WCLJob0YRuVbDC1db4B2eQmK0nYBU2+lbCeVXO4z90dK
         nhq/Dek6v0UrZ9lDa8jWCpUsGpdMBEtwYGQpGvrlH+VB5RcjWgBF3O9iCyl6MAsRpkio
         aDRcdaygyZvvTCOhqcpyCS29DLCXp+I3XAD2upM1BgWRVTxxi0q9fPf6wdBF7DRlrdKO
         dLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=mhzmoVQIKxpTlzndIFNjuvLSvWIFosd4AzwrRb6B744=;
        b=Cm9d7KQTDUc+jXzRe6sHT9nujMnKtNJ6Fc8QJSlq1/M+AptlnOXLAu6UVx8D8T2b1b
         qX+ERlVOMqFKgLhnl9hlyxh3YJugqaLKolBXEeebtOUrdL4c2RY7hnTXICpFhSl5HGoA
         2BQn63c8tT535W+2US6tIR6Y5Cz3MS/Qr/enmDfgu8SXBhrWwW795ETRjK+toq7FUZ5g
         KkC9R7axsOfykZtLjIaAqAjkQqHtzi4eIpLoOa5xUj+3LLDbU2rCPhfduqP2NNsg6DHr
         jO14TPkD+2KVGrCret4VsQcOGwdJH6UMDQweUoc6sECAtgS/5IMKyyWkzj1EJTVUqm2B
         jkHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12631-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12631-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12631-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12631-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
To: Matthew Wilcox <willy@infradead.org>
CC: <keescook@chromium.org>, <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>,
	<mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
 <20180314115653.GD29631@bombadil.infradead.org>
 <8623382b-cdbe-8862-8c2f-fa5bc6a1213a@huawei.com>
 <20180314130418.GG29631@bombadil.infradead.org>
 <9623b0d1-4ace-b3e7-b861-edba03b8a8cd@huawei.com>
 <20180314173343.GJ29631@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <fc984bf4-c46a-976c-ec74-ad89dc3d150e@huawei.com>
Date: Thu, 15 Mar 2018 15:43:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314173343.GJ29631@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.185.64]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860649725336168?=
X-GMAIL-MSGID: =?utf-8?q?1595011448225409893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 14/03/2018 19:33, Matthew Wilcox wrote:
> On Wed, Mar 14, 2018 at 06:11:22PM +0200, Igor Stoppa wrote:

[...]

>> Probably page_frag does well with relatively large allocations, while
>> genalloc seems to be better for small (few allocation units) allocations.
> 
> I don't understand why you would think that.  If you allocate 4096 1-byte
> elements, page_frag will just use up a page.  Doing the same thing with
> genalloc requires allocating two bits per byte (1kB of bitmap), plus
> other overheads.

I had misunderstood the amount of page_frag structures needed.

--
igor
