Return-Path: <kernel-hardening-return-11828-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224NQ0nRETk24JXAqq6zldztmAKEGiWaO3bOLTrpNWouw80yKYX2n6/OnfbFyoL0cPYwluAt
ARC-Seal: i=1; a=rsa-sha256; t=1519144140; cv=none;
        d=google.com; s=arc-20160816;
        b=uZK2yN+ObMRoA5B1hLac/wSeVGKyt4BWc0kzLg341bzQTAUcZbwB+T91ZRsotSc0CE
         Wk9R9HNVXW279DNgGGSGzgQ4JcnRTu8aYMznQgvdcZ8VEor2F66Vhv3lsPEstmGCC2nN
         KiG/0ks4AJ1dR0xzsygPM5xePFBQVseOt95VUXrfY6Ad68GdinZ0tQWkzqjPZvbzS6fp
         IqQEGDjw+n/WnRlV3WdN+fe2UIWWHvQWVNy+q+aVTk4IaV8BJrpcfpXUoAwU1fELamD7
         fAx+Xb6uCbpFq68GaO3OnWKZEHzOGqAILQrr2hysJq/1h9Q6JkQFu/uEYGU49ywrWwaJ
         VODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=eTYCLyykwnldp0aNHNlAgRq7FN7ammZmM9rWMyCAL14=;
        b=TonZbja40JnkOnNJikvBAoCFDIuv4gS2MLnhk6gUxOvp3Tgxl41x9NSctTSMJ/OUlK
         t7TAql3FpjyKloW//ML88KvZ6GN/X1wlNZA2L4wTXMXzTQrNnIcgkWovNKkZaT14qL1B
         esOaDHkkDEf6ZCAJ11r50bTOInM/uDANgiPnsumHnBROd1tJtA0QZdBhWNewPGbfqDZ4
         V7JPrmNe5laY0HBtsgkgShnXQdwZpN4d8ZWoKUQ9GeZEA9xwOYvQ0B7pBbMT9GVK/+WY
         RCJs4tEcHgJWlVT84vbBqFTXxVWL8/Ze/wkQzhZe88mL57YLsa2ITlJ5tXLI9Vu7JJI1
         CQLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11828-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11828-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11828-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11828-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: arm64 physmap (was Re: [kernel-hardening] [PATCH 4/6] Protectable
 Memory)
To: Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>
CC: Jann Horn <jannh@google.com>, Boris Lukashev <blukashev@sempervictus.com>,
	Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>,
	Jerome Glisse <jglisse@redhat.com>, Michal Hocko <mhocko@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-security-module
	<linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180126053542.GA30189@bombadil.infradead.org>
 <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
 <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
 <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com>
 <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
 <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
 <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com>
 <CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
 <CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com>
 <f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com>
 <CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
 <2f23544a-bd24-1e71-967b-e8d1cf5a20a3@redhat.com>
 <CAGXu5j+RRiZtYfO-4Peh=FAHmUS4FThKHp-djoFgY80rebKTxQ@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <b67209f5-4aa7-ffc0-99e6-3ab05e281ce5@huawei.com>
Date: Tue, 20 Feb 2018 18:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+RRiZtYfO-4Peh=FAHmUS4FThKHp-djoFgY80rebKTxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592404410626838547?=
X-GMAIL-MSGID: =?utf-8?q?1592938086648466606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 14/02/18 21:29, Kees Cook wrote:
> On Wed, Feb 14, 2018 at 11:06 AM, Laura Abbott <labbott@redhat.com> wrote:

[...]

>> Kernel code should be fine, if it isn't that is a bug that should be
>> fixed. Modules yes are not fully protected. The conclusion from past
> 
> I think that's a pretty serious problem: we can't have aliases with
> mismatched permissions; this degrades a deterministic protection
> (read-only) to a probabilistic protection (knowing where the alias of
> a target is mapped). Having an attack be "needs some info leaks"
> instead of "need execution control to change perms" is a much lower
> bar, IMO.

Why "need execution control to change permission"?
Or, iow, what does it mean exactly?
ROP/JOP? Data-oriented control flow hijack?

Unless I misunderstand the meaning of "need execution control", I think
that "need write capability to arbitrary data address" should be
sufficient, albeit uncomfortable to use.

OTOH, "need read/write capability from/to arbitrary data address" would
be enough, I think, assuming that one knows the offset where to write to
- but that information could be inferred, for example, by scanning the
memory for known patterns.

IMHO the attack surface is so vast that it's not unreasonable to expect
that it will be possible to fish out means to perform arbitrary R/W into
kernel address space. Ex: some more recent/less tested driver.

One can argue that this sort of R/W activity probably does require some
form of execution control, but AFAIK, the only way to to prevent it, is
to have CFI - btw, is there any standardization in that sense?

So, from my (pessimistic?) perspective, the best that can be hoped for,
is to make it much harder to figure out where the data is located.

Virtual mapping has this side effect, compared to linear mapping.

But, once easier attack targets are removed, I suspect the page mapping
will become the next target.

--
igor
