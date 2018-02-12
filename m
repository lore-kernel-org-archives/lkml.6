Return-Path: <kernel-hardening-return-11714-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224Zy4loLrGwf03EWxrtLGgn2wCKC0SXFRJhLAv/b35ZWGh7ZOOunxZyiJPcqwMRztz221pw
ARC-Seal: i=1; a=rsa-sha256; t=1518434825; cv=none;
        d=google.com; s=arc-20160816;
        b=rqEpvyrW1Yk2OOjk1BFIzFJq6QwQwwe83LPVUXL3wntEvaUt1tzdbdQif4dyKhuXjH
         ps9IOqtdyN9hkTf/VGEZG76APKoCxtgDdt9oRozHquoXWKiz/KpiYurLIMChV9b/4DTK
         hBVf0hpXGh1Da7AUzySRYhueHF6kEbprx7YquELtlx6faE3CX0IRMUKl8ZNXT7mnT30a
         CkRR5s+e8hTDTOFXl6ziaAoxX9cTeLcVHdJo2Cir7PthLuW+pKTZrH4DYDfK3c0HN2EU
         0jqaMy3JPaqEgSZEO3j4OlGQlY8qG1LNQ19rTgwArMQMS/wk6oZz/1vk454mu3ERufN5
         kXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=wYJUd4yW9v2OfT5uIbAhBukfylchivPFheewcPEP4Fo=;
        b=U6JGWIeoRO+ERGMDYMtBibbD6yf8eh+VX/OS/XR0iud1wxyaVnQ8yhAAq//9z8Dgn2
         Zs9m1yL1CMIaN43mBMqNagB8WpqPKFuXDodZowOpMnbGh8tmBPawx2AaBLcKa5gmg+8C
         I+nY/1Tu/FTxLgk+fFa7fV+g0Hlfct6fT60N48l9nkAPe5Kjyn2NCZZcxIqqg11n9WpB
         kABdjmHn7YK9tDmqTbQF1pPyXDZPVGKf0dGUkSea8ffBtDcjBwZOWlP6WW+cVeRJQFft
         xStqib1CNZ5ebFSOatqsSpwviVokAWfjx1dNY0m+jdWJ83NeDitBmY6hM2xeGm3mBD4k
         dqYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11714-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11714-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11714-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11714-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/6] Protectable Memory
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: <willy@infradead.org>, <rdunlap@infradead.org>, <corbet@lwn.net>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<jglisse@redhat.com>, <hch@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-5-igor.stoppa@huawei.com>
 <20180211123743.GC13931@rapoport-lnx>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <e7ea02b4-3d43-9543-3d14-61c27e155042@huawei.com>
Date: Mon, 12 Feb 2018 13:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180211123743.GC13931@rapoport-lnx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592194315831035216?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11/02/18 14:37, Mike Rapoport wrote:
> On Sun, Feb 11, 2018 at 05:19:18AM +0200, Igor Stoppa wrote:

>> + * Return: 0 if the object does not belong to pmalloc, 1 if it belongs to
>> + * pmalloc, -1 if it partially overlaps pmalloc meory, but incorectly.
> 
> typo:                                            ^ memory

thanks :-(

[...]

>> +/**
>> + * When the sysfs is ready to receive registrations, connect all the
>> + * pools previously created. Also enable further pools to be connected
>> + * right away.
>> + */
> 
> This does not seem as kernel-doc comment. Please either remove the second *
> from the opening comment mark or reformat the comment.

For this too, I thought I had caught them all, but I was wrong ...

I didn't find any mention of automated checking for comments.
Is there such tool?

--
thanks, igor
