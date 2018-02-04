Return-Path: <kernel-hardening-return-11571-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225mxMpV84IoVvCOCHQ/zLrfeZiBC+RueafS1HYtbB0Zj3dyKMviOCQ2sW0vfOtCYZdx1e8l
ARC-Seal: i=1; a=rsa-sha256; t=1517756778; cv=none;
        d=google.com; s=arc-20160816;
        b=jvEUgKRM6QuIN8HKcf1ZDk0W32VbM75qjDD5Xgcd0qjDbSSriSIcTaDmEcfpTlH+PB
         N8UAD51O8q43l6MzQAbVuN4YpKeLr1ABdF64FWy52helUaDG15s/ks+6yZgxDq4AB7JA
         LVjA2KB6tCgRlstslCFKgQENfxufEEQ0yT8/QAOlyURwIvx7kHYvSuAjAAxL/z9jdCRn
         CtHJz1grIwUIs1oGhXRkh2ZgSyeJ/HhJ8o1NVr/lIYTY8LcBbD40ksJ9IUBhfyuR94iX
         YaCGZYw2aJRb37SkvaBpI36mj/Cl6TO/Kiw+EoYMJZSqAWFfP3yFiklvQUJB698TpZkF
         9rYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=GZMSyDE1UqqMvq4QkW6SHAT6ovg6gGCXhi+0zypPr6w=;
        b=cm5wI8pMniuNFvmeWd1d25z/F7GWZM9DSZMHPrrBqvtqwZJXOMF/28HH4/9fiX2x+K
         98cIHdY+2H2g3G5syBkFLO2i6Kb5eGpg9FChChhSqTUKK6e4qCvjn4nNeHI++Tri0aJL
         cGc4EcLEUwJ0BREBS1mvCZX/471MFxxoDHRiitaHEevRQymbseYmb9FJ+Erhngv+i6vR
         ogeXOq9qppaCPIr8UJt4oOKyB6npxFPH7WIeexgjzbN5hjvA6YNkBiCXciIMSto/X/hU
         N2HePlO/KU9bI9HKTqvcfyBzKCL2/ZNYsVtDdVwaaBpJWrEBh2l2JcJtDvKlJok4tGZQ
         SGZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11571-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11571-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11571-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11571-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Boris Lukashev <blukashev@sempervictus.com>
CC: Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>,
	Jann Horn <jannh@google.com>, Jerome Glisse <jglisse@redhat.com>, Kees Cook
	<keescook@chromium.org>, Michal Hocko <mhocko@kernel.org>, Laura Abbott
	<labbott@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM
	<linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>, "Kernel
 Hardening" <kernel-hardening@lists.openwall.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com>
 <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org>
 <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
 <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
 <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com>
 <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
Date: Sun, 4 Feb 2018 17:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1591483332035142196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/02/18 00:29, Boris Lukashev wrote:
> On Sat, Feb 3, 2018 at 3:32 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>> What you are suggesting, if I have understood it correctly, is that,
>> when the pool is protected, the addresses already given out, will become
>> traps that get resolved through a lookup table that is built based on
>> the content of each allocation.
>>
>> That seems to generate a lot of overhead, not to mention the fact that
>> it might not play very well with the MMU.
> 
> That is effectively what i'm suggesting - as a form of protection for
> consumers against direct reads of data which may have been corrupted
> by some irrelevant means. In the context of pmalloc, it would probably
> be a separate type of ro+verified pool
ok, that seems more like an extension though.

ATM I am having problems gaining traction to get even the basic merged :-)

I would consider this as a possibility for future work, unless it is
said that it's necessary for pmalloc to be accepted ...

--
igor
