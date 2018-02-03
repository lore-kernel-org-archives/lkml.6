Return-Path: <kernel-hardening-return-11567-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227jJTZz4ZLxM1YRKjaTxdoLhFO6tlSoUIsUsRPYpJVj4b1KcgMa5h8jgPwBsX7st3ydc58e
ARC-Seal: i=1; a=rsa-sha256; t=1517687867; cv=none;
        d=google.com; s=arc-20160816;
        b=dyZCZXf2lB0KTDcA5rMSWOZOs+gwmxuFKlnxmNdzZa0BY8pujndLxsw9UeHyIQBtLL
         Yf+xod5lY7sBYvuYLwb3QZkGHwHLcwaXv/zz0wMiLMUYIsyUXy4YyyyJ8v2Mu3pM90Wl
         JdHgkjKLXybMPgunrLW/lN4O5L8k6DKEDEp22cDLKcTmzVT7ulliXFIn1yWYRFJzpHAf
         uktkQ7UGsCJLiXySJkWUwGGb40ShMixqgJtgq0UKUs4Zjsxt2fveTxZzjBoEaL6ElmkY
         Sm0rA4UhmZ5DkWVdDKGp2cfLxh/4IFpfJR/gCMS4UNViGaiQ27ZlFx28uQqOvSrVVtZF
         wGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=UJfW3k1FEOspoCZKKwsbTkb9ZhwuYDS6yHGbat9y+rA=;
        b=N/kuuvkHJDxneoGINZpy5qpGgCKzcyMKKW3LZQlxJvAqVfrjaCsPKwD8cQBqitU9Q5
         2jFMXuRwbQ9YkeN1yev6G+JB8fvsrcyTpaIsn0vQUM1YdQay3/XhfheLLrMWpoNxARnN
         3pg4SUVoyAizOBt0ovH/l3oEsv3abYgUn5pcJj2CDzorGsKdq5u6sfJGxC4Zxv0L6Qdi
         QQu2o1TTeTrVvB76K+A6FCL79O5qWlFIaiRCOU/8FQ5nqqZL5vdjtOZgEYgiZB50QQy0
         TH6T0YWVlglWLUWGpOO72WOjWuYr0Z21zAYNmBxk5gHIwaqTrQhRQkIa8LFjzymsYQ8V
         cdRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11567-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11567-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11567-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11567-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
From: Igor Stoppa <igor.stoppa@huawei.com>
To: Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>,
	Boris Lukashev <blukashev@sempervictus.com>
CC: Jann Horn <jannh@google.com>, <jglisse@redhat.com>, Kees Cook
	<keescook@chromium.org>, Michal Hocko <mhocko@kernel.org>, Laura Abbott
	<labbott@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>, kernel list
	<linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com>
 <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org>
 <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
Message-ID: <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
Date: Sat, 3 Feb 2018 21:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1591411073327746010?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>> On Thu, 25 Jan 2018, Matthew Wilcox wrote:

>>> It's worth having a discussion about whether we want the pmalloc API
>>> or whether we want a slab-based API.  
I'd love to have some feedback specifically about the API.

I have also some idea about userspace and how to extend the pmalloc
concept to it:

http://www.openwall.com/lists/kernel-hardening/2018/01/30/20

I'll be AFK intermittently for about 2 weeks, so i might not be able to
reply immediately, but from my perspective this would be just the
beginning of a broader hardening of both kernel and userspace that I'd
like to pursue.

--
igor
