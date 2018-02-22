Return-Path: <kernel-hardening-return-11887-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2242o5l5BzHOBhciuGba0dnQ/GTTQH5D2XgsCKvRVM7aYEQoRzzuIFRqsUw9HuhyGQrVOn2S
ARC-Seal: i=1; a=rsa-sha256; t=1519290116; cv=none;
        d=google.com; s=arc-20160816;
        b=r1WGXg/IDH36+Tijsvw5152v7qBAcXOQZKhw8NQ2j7uvDk62SZd3Hqeu3Lu7nkpItz
         zp3pu9qFHgsRAuCwZSW2+XvqPWu5CgZD4lSpdClzsr1r3r6hxzVIGoeIGdCR0KetkVZF
         pcAVfNjvacWPltG3nP/hyYt1qgh1sPEITS+i0xPtwqVayuNaD76sNRojL6Y1R41tTtxs
         I8JhUSyJw8xNC1syNvQ46YUKwAvlUv83XvyKm7bqQvvvlCIhnMQzjCRggQA7ay+WIbEx
         JL62QAIwPYhWgSf/n9CsTvzawJfuZICaNLYF1jetDxRfrdx96deVcAFsQJ4FIsxyaf9c
         Fjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=4HK1vHimG8F3Is+Dipa8BgmL36UXFZsL4lUHCKeIFEE=;
        b=0wQbiRZNYgPGD7BGfvasGZi/Maj2nwhXzKkZccRK+Sv4uqOnOKRNf7fWBzMJsyMhZ2
         2x6xTp8/ydDg95E87N08KoZzQ7uR6Gdud3Bu9nPgTXy55cr1zfI9TfnYmHS/xsfQ2hvy
         tcwen5ATTbnTmuAvPf+7dipN1HAhprPBx/KzOCRIi2XuqTltD6siNtmkyitWLpymxPhE
         MXs/+B5uHenVr+bjJHeq1wrfnQncXL7l08u1FmP7s4dIJIxkSirn0zeK9rKfKVPimE6e
         Y0cUzmsCKrD2w6kPdhRvvQfEUtGaGd7d8tOjZ6te2wAqI0SoVPFteCjapbbVLrCj2qxz
         XbVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11887-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11887-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11887-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11887-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 5/6] Pmalloc: self-test
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
 <20180212165301.17933-6-igor.stoppa@huawei.com>
 <CAGXu5j+ZZkgLzsxcwAYgyu=A=11Fkeuj+F_8gCUAbXDmjWFdeg@mail.gmail.com>
 <bd11826b-f3c1-be03-895c-85c08a149045@huawei.com>
 <CAGXu5j+ivd0Ys++6hqCjkipx8RFKTAmWf+KbtxEwT3SECD5C6A@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <cfe0dd48-2c72-cc4f-010b-a667648cad3b@huawei.com>
Date: Thu, 22 Feb 2018 11:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+ivd0Ys++6hqCjkipx8RFKTAmWf+KbtxEwT3SECD5C6A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592215146511084234?=
X-GMAIL-MSGID: =?utf-8?q?1593091153297010324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 22/02/18 00:24, Kees Cook wrote:
> On Tue, Feb 20, 2018 at 8:40 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>> sorry for being dense ... are you proposing that I do something to
>> lkdtm_rodata.c ? An example would probably help me understand.
> 
> It would likely live in lkdtm_perms.c (or maybe lkdtm_heap.c). Namely,
> use the pmalloc API and then attempt to write to a read-only variable
> in the pmalloc region (to prove that the permission adjustment
> actually happened). Likely a good example is
> lkdtm_WRITE_RO_AFTER_INIT().


ok, thanks for the explanation, I will do it

--
igor
