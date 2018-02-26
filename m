Return-Path: <kernel-hardening-return-11957-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuKjg0/ZHvC7BR6Ii1wJKlVqdPDLSRfrfWIbADT10pS58NSYrugpoiy5FHAddhTLi0/Z2Us
ARC-Seal: i=1; a=rsa-sha256; t=1519647167; cv=none;
        d=google.com; s=arc-20160816;
        b=oCWtY6yxvv9dFVx5YOb5TYFPVgsJ8M1Y4zozaupZOIKLdsISzc+9q0Y8QexEFoi7vk
         /tsDFZS116cv5xW3ahxKu7FzbQlx/lqUXf/LeEaSR6VZDu//zCEp6bBe0FTUg2Q7LLaB
         r5r9O5Z11wN+WOxIBczyHFk3DEzkFA6flH6i7rnohyNdrn5zkYyoGI1zOVsyVCQWaq4w
         cMHXnxGaxUg18OCAcB/Tkz81bXTkPvsr0fvFmWdl5Ej32OUNru+qwiK8yHzEa5y0wVni
         dDVJsxQxTDo/70z8tocAe4SzKzYq7GKw/jW6/7GbBCQBlFoLDxF+5/xaDW0pOmzwWPzS
         1WQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=uKBlPriJeF9KtMmU8EYyXNYOgWRN/4KZpGsTBHkrkfM=;
        b=EMKgHUvdFH4N0NB3vnuQyrHF7UXMHP7152zRYWoeMUhj8fBDU9De0b+ukZeKHI2hVu
         Lg68WHRTGxRXQpkHzenWCo4T9pSlgf+blG9BBWUu/jKpWTxfbTepbjQlbDVUklgNG64k
         Rt0qr3ZgDZrlSf9GCKni02ZJu3R9VOLcNElVzgE4xDYQmjUNC8HiOYfuSza5R/ZKqGLM
         y1ll3KaSqlUknvtwXREvm8MXo7Cota9Zmwe2x0KlxQbOBXPowvIHknDfKiEqjOg5sq9k
         3K3dtsOWrb/ADVH/pRQ3NBGULcfCotfap7CTqP3zs38Qj0JjyO2dX5id5B6Af5xMPs1J
         +RZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11957-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11957-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11957-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11957-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/7] genalloc: selftest
To: J Freyensee <why2jjj.linux@gmail.com>, <david@fromorbit.com>,
	<willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-3-igor.stoppa@huawei.com>
 <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <a7b47f45-5929-ae07-1a10-46a02f6db078@huawei.com>
Date: Mon, 26 Feb 2018 14:11:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203665689840629?=
X-GMAIL-MSGID: =?utf-8?q?1593465547831147522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24/02/18 00:42, J Freyensee wrote:
> 
>> +	locations[action->location] = gen_pool_alloc(pool, action->size);
>> +	BUG_ON(!locations[action->location]);
> 
> Again, I'd think it through if you really want to use BUG_ON() or not:
> 
> https://lwn.net/Articles/13183/
> https://lkml.org/lkml/2016/10/4/1

Is it acceptable to display only a WARNing, in case of risking damaging
a mounted filesystem?

--
igor
