Return-Path: <kernel-hardening-return-11768-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227NHVCX6dn6mZ1va59vNwmyof7J2Tg9Tvhiv2GUiyqGP2MvR0ECWT5AF2pb8VhFkpgrMhxG
ARC-Seal: i=1; a=rsa-sha256; t=1518637737; cv=none;
        d=google.com; s=arc-20160816;
        b=U8Sv72ThuD5GRqPpEjoBcaKkLR0t7FBNT7pwb+jjrFYXjkCHmxl15e1cqse3CtB/bJ
         KBanK9JO1jPp/0ov6VmTgMSTtbV1OzlRxceSHN6wnVVrTe1HxZCPvBGIm/3nHE1bEijF
         ZyN4zhUP1ZyBsSF8Z3m1E+DlXHBqWGMtyJNxmaNxw+1S30kz10N78gNt7OpLrxXAFJkE
         x2Gu+7kRN8ygoDBkamYzLHA4NCki9ntULCR60NQJh5zfr4xHhmxybdM6MemcJQOfkArq
         a7aFJxT7ccbEzoflMlkTtIIhRwq6YyEJc6zn3/4HZGv7DyZtbpIwubbUTRCv2ccp2UZr
         sOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=WVPE/J2jb7MxXY7ZEnqYHeTLCYLreEeoTWxuTxEiDNc=;
        b=yeymetqCijXl41ZTcyWzYO1vX78JqFfoJss7a7YRO0sNkjqCX9AGI0oPX2I1bWa3wo
         zNjIWfwaSU+VYYxk0op35PbacJK7VFcHLUVxu4TpxTh/MQvm4jyO/6KPZf2U7bwDbqoh
         4ubt+SlU9CUOIY5WTGu4hJNB3f1n7QF8b3M/e8R/HkQeVZ3XCZwXSUKTUe/oFB49e4IN
         7otCufOdNLqLONM27Y66ziagbYNcBBd+a2kUQWGLGqW6zKyTKmzjPy0kDZ3n+rfqCN+h
         vwNRhsf9oYwL63HHv3SUY0Xq2mx70BiPqzLCsfL3yBOBZf+MaoSa0Kxx3sBf6kF97ulp
         pdVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=q8Y29vRH;
       dkim=pass header.i=@chromium.org header.s=google header.b=fMTjZSIw;
       spf=pass (google.com: domain of kernel-hardening-return-11768-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11768-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=q8Y29vRH;
       dkim=pass header.i=@chromium.org header.s=google header.b=fMTjZSIw;
       spf=pass (google.com: domain of kernel-hardening-return-11768-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11768-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <2f23544a-bd24-1e71-967b-e8d1cf5a20a3@redhat.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org> <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com> <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
 <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com> <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com> <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
 <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com> <CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
 <CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com>
 <f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com> <CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
 <2f23544a-bd24-1e71-967b-e8d1cf5a20a3@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Feb 2018 11:48:38 -0800
X-Google-Sender-Auth: jzL9J1Z2Ks43deFnpru4D76niLY
Message-ID: <CAGXu5j+zkFx+1Dn908iqaTV-yP7Wk_rMXZRvXN32h+i_oAcy6w@mail.gmail.com>
Subject: Re: arm64 physmap (was Re: [kernel-hardening] [PATCH 4/6] Protectable Memory)
To: Laura Abbott <labbott@redhat.com>
Cc: Jann Horn <jannh@google.com>, Igor Stoppa <igor.stoppa@huawei.com>,
	Boris Lukashev <blukashev@sempervictus.com>, Christopher Lameter <cl@linux.com>,
	Matthew Wilcox <willy@infradead.org>, Jerome Glisse <jglisse@redhat.com>,
	Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592404410626838547?=
X-GMAIL-MSGID: =?utf-8?q?1592407083683969225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:06 AM, Laura Abbott <labbott@redhat.com> wrote:
> fixed. Modules yes are not fully protected. The conclusion from past
> experience has been that we cannot safely break down larger page sizes
> at runtime like x86 does. We could theoretically
> add support for fixing up the alias if PAGE_POISONING is enabled but
> I don't know who would actually use that in production. Performance
> is very poor at that point.

XPFO forces 4K pages on the physmap[1] for similar reasons. I have no
doubt about performance changes, but I'd be curious to see real
numbers. Did anyone do benchmarks on just the huge/4K change? (Without
also the XPFO overhead?)

If this, XPFO, and PAGE_POISONING all need it, I think we have to
start a closer investigation. :)

-Kees

[1] http://www.openwall.com/lists/kernel-hardening/2017/09/07/13

-- 
Kees Cook
Pixel Security
