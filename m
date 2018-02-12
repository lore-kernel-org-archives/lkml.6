Return-Path: <kernel-hardening-return-11734-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226Uow9LpXkhzim4hHYYjzUk2z6Xv8s3HmNfn/RKbUhQ4n+z9smuFGkCdde4Pt7+6E56Rk+g
ARC-Seal: i=1; a=rsa-sha256; t=1518478058; cv=none;
        d=google.com; s=arc-20160816;
        b=exQBOQYi+cQN2lg8ca+UN24o6gdzKFTtrYq7ss2KSzcj251iVizo8l7pRXnKnRbRqJ
         dATvXNoMELkfmssmM9x/IIyiOOHEKLrTwNv7gzvEhnRrYYNMWmrwjU1HW5JLBoaNGdxE
         5E7oQmGBvo2AMeJk6Sfs47ZsOgeovEqIFGvZtClog1FKRH/aIdvjgWo3WY2Qj1y/PHu1
         unspsHO/PK+k8JEfP49ucDG08BjLPaN580WSMZfnfoYkMba+/5bQez54l/dFaMoSy3sW
         VInZk0WuHTw/c+t8T/g3i4Foie+EHE/m8+SQxuZgOV96PjO3M0Q7xv9mTBQmPqspMWn6
         QCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=mHqPXgJc0vSknFYZn7JjZ9PV1vq5wZgBjD2HHxUiOYc=;
        b=FtcghcMpiyNGfMcEA/iFlVqgrjr8iXkQ39JAHJvRMBSxnZ5wjYmOX2CnfbjLzjBpkf
         7vaUx4/Hi/QXrB/ACLebP6XcSPxbioCUiuhrxRXwGxF7v8OLMuRKsRLRvF7wS5Kou3/c
         sOJJBSjrzUS37skJ1arDZTd+rnvlvpao33XfV3a+CYbFHXGS61e0TTj6lmsGIvifAqwB
         LZYTFbNzW3257e6eRT53QKC9uZ6CjDQfsheuWPr19OXYHFGjPrj4POaUuOoQqgOWZbmT
         Pdz+DKNwQhludV7j/tlgspNXHNCsLDa6MalwM+XqLPFi4V3FpQxRIJx6uS/TiS3ocTe4
         7VBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jSAnxGUL;
       dkim=pass header.i=@chromium.org header.s=google header.b=LolcFZOG;
       spf=pass (google.com: domain of kernel-hardening-return-11734-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11734-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jSAnxGUL;
       dkim=pass header.i=@chromium.org header.s=google header.b=LolcFZOG;
       spf=pass (google.com: domain of kernel-hardening-return-11734-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11734-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org> <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com> <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
 <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com> <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 15:27:19 -0800
X-Google-Sender-Auth: hOVZuSamH-PaKthrOejkDGYiSts
Message-ID: <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Boris Lukashev <blukashev@sempervictus.com>, Christopher Lameter <cl@linux.com>,
	Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
	Jerome Glisse <jglisse@redhat.com>, Michal Hocko <mhocko@kernel.org>,
	Laura Abbott <labbott@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592239648941773124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 4, 2018 at 7:05 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> On 04/02/18 00:29, Boris Lukashev wrote:
>> On Sat, Feb 3, 2018 at 3:32 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
> [...]
>
>>> What you are suggesting, if I have understood it correctly, is that,
>>> when the pool is protected, the addresses already given out, will become
>>> traps that get resolved through a lookup table that is built based on
>>> the content of each allocation.
>>>
>>> That seems to generate a lot of overhead, not to mention the fact that
>>> it might not play very well with the MMU.
>>
>> That is effectively what i'm suggesting - as a form of protection for
>> consumers against direct reads of data which may have been corrupted
>> by some irrelevant means. In the context of pmalloc, it would probably
>> be a separate type of ro+verified pool
> ok, that seems more like an extension though.
>
> ATM I am having problems gaining traction to get even the basic merged :-)
>
> I would consider this as a possibility for future work, unless it is
> said that it's necessary for pmalloc to be accepted ...

I would agree: let's get basic functionality in first. Both
verification and the physmap part can be done separately, IMO.

-Kees

-- 
Kees Cook
Pixel Security
