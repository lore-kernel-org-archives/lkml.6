Return-Path: <kernel-hardening-return-11968-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtUdmSmgIOvC2FtZSb/yiyhe2BCEn6yplEmGNYi8lFqIll3b6xVsU47HzXODSDo/Ien9Psl
ARC-Seal: i=1; a=rsa-sha256; t=1519673271; cv=none;
        d=google.com; s=arc-20160816;
        b=n66qCCFz5lKn6be9SGXveqV8J7IOtSTR+MfG0wYdhnVXJ17ClO9yq6QVsAWosOdIJU
         GSl1e2vVAiQ6EZcwzN4kyfMNtVgN6qOGpqv838icREW+GCm7i54Ua1Llj+hAGsrZJusl
         TKJdJMKZP+63H8Xb9qjvfuI6ql/wL5Qe9y+8wFznzKDCC84aT3JFO7P8PWjDjE9TZvkM
         mzabpC2HegweHGkHVZ9xja4eWV/1vMKLmAxGFxx4JnBzKDRUp+CYgymEoGnsyGNfIoJD
         lSmgsq5Tj3Or1k1etRaZnZF2r9VwWJ8ZDE93zGm0/zq+0j0H2yqNDDm30IgiykrdNC2g
         DSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=3vRmBO4qOb5tacX2CQ3P1Vh6G6Px1KCWnLx77qJ2ZJ8=;
        b=0xSx86Bi5EDyOi5SFZqB0JsLiSUC7qJWQl8yLSfVKnWWYt5R0YcDlu6vHhpYo8M/2g
         ctAoMDzEIvNS3Ehd8lwgHSwL9oGCwvH0T+zTkAUUccN3S4rPIxp6GwIpNBqUj/bMbcKC
         2UYE2DTI9rXiQCFHkVtxB/npm4fUwwVjXFvqBF/90moYmKpGoDb8614s5z7+zZyL38G+
         iNIpSk9WF4c7M4GHH9FS+uR1Y48c5JlGUZYXSw78X8jrV41YXVa1L5tlerB5rArJdOZa
         z+IoP7QnXpqG7nBOK/22vpSxO2lVw6ff3YLhyRrO6tjOidQ/m13DxLpm4cLa3XbyLtbD
         v/Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11968-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11968-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11968-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11968-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/7] genalloc: selftest
To: Matthew Wilcox <willy@infradead.org>
CC: J Freyensee <why2jjj.linux@gmail.com>, <david@fromorbit.com>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180223144807.1180-1-igor.stoppa@huawei.com>
 <20180223144807.1180-3-igor.stoppa@huawei.com>
 <76b3d858-b14e-b66d-d8ae-dbd0b307308a@gmail.com>
 <a7b47f45-5929-ae07-1a10-46a02f6db078@huawei.com>
 <45087800-218a-7ff5-22c0-d0a5bfea5001@gmail.com>
 <20249e10-4a13-8084-bcf2-0f98497a755f@huawei.com>
 <20180226191235.GA24087@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <aa491cf5-ace4-1e2c-2f49-60f96b1e6da9@huawei.com>
Date: Mon, 26 Feb 2018 21:26:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226191235.GA24087@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593203665689840629?=
X-GMAIL-MSGID: =?utf-8?q?1593492920372132289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 26/02/18 21:12, Matthew Wilcox wrote:
[...]

> panic() halts the kernel
> BUG_ON() kills the thread
> WARN_ON() just prints messages
> 
> Now, if we're at boot time and we're still executing code from the init
> thread, killing init is equivalent to halting the kernel.
> 
> The question is, what is appropriate for test modules?  I would say
> WARN_ON is not appropriate because people ignore warnings.  BUG_ON is
> reasonable for development.  panic() is probably not.

Ok, so I can leave WARN_ON() in the libraries, and keep the more
restrictive BUG_ON() for the self test, which is optional for both
genalloc and pmalloc.

> Also, calling BUG_ON while holding a lock is not a good idea; if anything
> needs to acquire that lock to shut down in a reasonable fashion, it's
> going to hang.
> 
> And there's no need to do something like BUG_ON(!foo); foo->wibble = 1;
> Dereferencing a NULL pointer already produces a nice informative splat.
> In general, we assume other parts of the kernel are sane and if they pass
> us a NULL pool, it's no good returning -EINVAL, we may as well just oops
> and let somebody else debug it.

Great, that makes the code even simpler.

--
igor
