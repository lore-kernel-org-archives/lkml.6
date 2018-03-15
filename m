Return-Path: <kernel-hardening-return-12624-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvaenqqLsngklDWYtlX37+v1U0ZH1tKTq7i4CAhhYYMH9mzuZvzEC/sWuNgkDyKxIvwWI4Y
ARC-Seal: i=1; a=rsa-sha256; t=1521106783; cv=none;
        d=google.com; s=arc-20160816;
        b=zvSN6I5peQPpJK4n+W6LZ5sluTMMDMtdQsDL2L0CfCE0JajYucbRJCCnwF2AtrbUg4
         HBjcsNUX4/kK8v6M4alDGdifjMpdDwA4qRq5HDANEeaNX/rBoVF7nIznqa1j/9LEiRxv
         cnbVpx47mxhELcp08Dijk9dgHtf6TmxAf6g6LEA9bHayxARDfRa4UmvyWbewAgbTjpfn
         8Dm4ohalwa44P/w4Q86zaLXvAZ7oIOF7hV7utoXEKd3DHJ0ZTexRNFYjRRd6qRWvnN5I
         V3rA7GpPUbfW5Qxa1AnuBPo5lv4SOsjJ8BWd6yjjDDcW46Hr6DL0LybTl//PUenT0+kE
         5u7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=3JJEqRyGusBsTc66ie375zqI2k7H3TYnRbWfes4ayEo=;
        b=Kgv5xcH2tssrMG+ZihlmyMj+yi2qsfg/x16IVjRlKupf8fqncXCsIJNpe79snshgTk
         i23wRdd1+tlREbDvWZ9oV7p+D46HtuNjFGy5daayzMiGqwtkw9upWVC32JnYsH7UPdpJ
         2rnRGQ2VHEoTz9lIQJsRjD76P6fXq1b6wOVJYTJ0YNUoimtMv1iY/Bk6LEXk5Nuf/1xM
         hou+CqMPRNUtpk1fiNTajFIfEh9opGMn7eKaSj8DoU7p5s0Y54RsFbKzllzMKrAwk2ss
         rITe/I1sqndH623fQbN+rfxkmNxWDEJQ/I4mLRICgHTjywupSnuoPuMpcxlAb3z9gLvi
         qQ5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12624-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12624-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12624-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12624-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/8] struct page: add field for vm_struct
To: J Freyensee <why2jjj.linux@gmail.com>, Matthew Wilcox
	<willy@infradead.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-5-igor.stoppa@huawei.com>
 <20180313220040.GA15791@bombadil.infradead.org>
 <7b18521c-539b-2ba1-823e-e83be071c13f@gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <6924c919-dbfb-a9f6-748a-0bbfe8d876b1@huawei.com>
Date: Thu, 15 Mar 2018 11:38:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7b18521c-539b-2ba1-823e-e83be071c13f@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860882497845479?=
X-GMAIL-MSGID: =?utf-8?q?1594996067385883274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/03/18 19:43, J Freyensee wrote:
> On 3/13/18 3:00 PM, Matthew Wilcox wrote:

[...]

>>> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Igor, do you mind sticking these tags on the files that have spent some 
> time reviewing a revision of your patchset (like the Reviewed-by: tags I 
> provided last revision?)

Apologies, that was not intentional, I forgot it.
I will do it, although most of the files will now change so much that I
am not sure what will survive, beside this patch, in the form that you
reviewed.

I suppose the Review-by tag drops, if the patch changes.

--
igor
