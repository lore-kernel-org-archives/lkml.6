Return-Path: <kernel-hardening-return-11830-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226TTU4FYk6TxNHWlcf4GRQ1Fe7frawq7VTdLkj+8QU50p6D5pe12W3lr8KMm0x7lec6PcPK
ARC-Seal: i=1; a=rsa-sha256; t=1519145989; cv=none;
        d=google.com; s=arc-20160816;
        b=V1rpLvkd4Ij8UFV/11lQCfO9GMrbgYscM2/l0X7k/K5xx4BLq/hGzby2qDhkrlPsON
         w2B5Oe8XkBt2citO02FDNWtIJqv5DUFHI2m5gWsnjVIKmL2C8hMeCoyOEKZEkgOxq+lJ
         cjV/9IXEpXoPXckpG7MMfcnAc1nsw+AllTel9M7U3H9nQnkSpF1/ZexmaPK5qz8e1/kO
         zV45XXxYS9ZRZfb/brjwOeF2W+ngyy6GHSSIB6JwD/ZwWpqGJQc9omoHJ93NTyt24S8k
         jcbl57raQUy+XGGRSCRSGfAPjtKfellVGML3cVA+H6wXku61/KO1mhUkqwxGR58/tnzk
         DczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=FKp05taS4LAMWyHiWjQ1ONH596CrIW0jrqNvdZzES5g=;
        b=PasqVEzIsSZEfskom7UXkMxEYbJ/vp63CVvM0gCOeienPAMf3NbV1IcjYlwL9ECmIM
         hutb/YO9RPX/GxY5iFbVg7i5KtaPOgfxugZuQkRpOgxrQg/O5QP7ZiLNDUrTajPo0nkK
         XKnoDMJrxCpvVBzZIvnv/vbpwQG/TGUFhF/n189OkSo2hNw/eeGGEcCyn6+dNWLRhoBh
         pRheaMvj24eAv8pfgLyfTiW/0ELl8KfONVG3S94ueuH81pu8TyoNAnfCsCzNbmwK+ogd
         wx0X7QSZbY46xmP1HEMCXHfAK0VGz8uNJ/dqw8N+tCoGVdix3rhAk0kCisD3ycLfKseg
         Cj5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11830-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11830-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11830-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11830-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
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
 <20180212165301.17933-3-igor.stoppa@huawei.com>
 <CAGXu5jJNERp-yni1jdqJRYJ82xrP7=_O1vkxG1sJ-b8CxudP9g@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <f33112e4-608f-ae8c-bf88-80ef83b61398@huawei.com>
Date: Tue, 20 Feb 2018 18:59:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJNERp-yni1jdqJRYJ82xrP7=_O1vkxG1sJ-b8CxudP9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214940015088630?=
X-GMAIL-MSGID: =?utf-8?q?1592940024303351398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 13/02/18 01:50, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>>  lib/genalloc-selftest.c           | 400 ++++++++++++++++++++++++++++++++++++++
> 
> Nit: make this test_genalloc.c instead.

ok

[...]

>> +       genalloc_selftest();
> 
> I wonder if it's possible to make this module-loadable instead? That
> way it could be built and tested separately.

In my case modules are not an option.
Of course it could be still built in, but what is the real gain?

[...]

>> +config GENERIC_ALLOCATOR_SELFTEST
> 
> Like the other lib/test_*.c targets, I'd call this TEST_GENERIC_ALLOCATOR.

ok

[...]

>> +       BUG_ON(compare_bitmaps(pool, action->pattern));
> 
> There's been a lot recently on BUG vs WARN. It does seem crazy to not
> BUG for an allocator selftest, but if we can avoid it, we should.

If this fails, I would expect that memory corruption is almost guaranteed.
Do we really want to allow the boot to continue, possibly mounting a
filesystem, only to corrupt it? It seems very dangerous.

> Also, I wonder if it might make sense to split this series up a little
> more, as in:
> 
> 1/n: add genalloc selftest
> 2/n: update bitmaps
> 3/n: add/change bitmap tests to selftest
> 
> Maybe I'm over-thinking it, but the great thing about this self test
> is that it's checking much more than just the bitmap changes you're
> making, and that can be used to "prove" that genalloc continues to
> work after the changes (i.e. the selftest passes before the changes,
> and after, rather than just after).

If I really have to ... but to me the evidence that the changes to the
bitmaps do really work is already provided by the bitmap patch itself.

Since the patch doesn't remove the parameter indicating the space to be
freed, it can actually compare what the kernel passes to it vs. what it
thinks the space should be.

If the values were different, it would complain, but it doesn't ...
Isn't that even stronger evidence that the bitmap changes work as expected?


(eventually the parameter can be removed, but I intentionally left it,
for facilitating the merge)

--
igor
