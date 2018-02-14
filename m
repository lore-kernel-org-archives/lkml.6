Return-Path: <kernel-hardening-return-11785-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227Ooc/liACmwEigJMm5BmUU008mBlGLB3IZRSocvpTCgB3Dy2nn0xRMP1AT9NgEuxWHh8Tx
ARC-Seal: i=1; a=rsa-sha256; t=1518639245; cv=none;
        d=google.com; s=arc-20160816;
        b=wTlp/DDAAPJ8T+Z9mfytEz+ea4M9eO+3HTUu8WCGjouCyxw6yQuMrdmzkQrk3S4J9Z
         2WcgATysYqP4mB1vqeBDMqhTSEAFPn8KMMPTqiPb2y3VwBSMBRV0e1ngXEILrutH4/kD
         FmfEqJCTd4+vYWAf18G66tPULS7xw1BXHLc8yZ0f40Ur4OELuVekRIdySUCDSfvIbiJh
         Ohgc5kDZVocH6XX+cxZRmTeylMxtGsAoyiuJXusb8z1OLioqUJCG57w1nbSuc9EZ/iU+
         kD5eJGRJO1IOtSkccRxV2DDlJvC5rquTCQaA6oY6qr1h5nB2zSb250KSmrEjGx6u5VEp
         JWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=1lNpz1BEClmqSUTSqH8Pw+a63kZtddb6696oNWiyEWc=;
        b=0AloTAvig1x0KfbnQFL7KFthzWi8eiIf/BND3jI3KEfJmM7oXDToOB5HOOBMxrvaR2
         LBSHYs95lkk00HwOX9cp3CS9tlMtWabFH7lm5augm9LFG5XA5g4H8NLLKbTHxC48k7/a
         RUY/LFIaHwRAZKLGM1RnfHcSBhvMTFuiJU+474Mn78MITDZLCcpCAE8tLZwhv+cmoeih
         mbIvnnQ2prhOJiu7o0T/UD7r6J97w3P28m4avkwQO7GQEp/r7aJf7QZmnSXK/F0T/Sax
         ybsACK7sChMPdyc2ftMsX7lDLWp1Ds8dOGYrvk72pQFZqMTYIss5hng8Nq2c3NJ76yeS
         v49g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11785-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11785-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11785-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11785-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: arm64 physmap (was Re: [kernel-hardening] [PATCH 4/6] Protectable
 Memory)
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
 Igor Stoppa <igor.stoppa@huawei.com>,
 Boris Lukashev <blukashev@sempervictus.com>,
 Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>,
 Jerome Glisse <jglisse@redhat.com>, Michal Hocko <mhocko@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
 <CAKv+Gu8CNGFKLhX2XRuesn3n3k5P2bYS8qKWTTNXGFnr7SUVUA@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <213effab-f0d0-cfc5-8feb-c72eed8ae0aa@redhat.com>
Date: Wed, 14 Feb 2018 12:13:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8CNGFKLhX2XRuesn3n3k5P2bYS8qKWTTNXGFnr7SUVUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592404410626838547?=
X-GMAIL-MSGID: =?utf-8?q?1592408665120514792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/14/2018 11:28 AM, Ard Biesheuvel wrote:
> On 14 February 2018 at 19:06, Laura Abbott <labbott@redhat.com> wrote:
>> On 02/13/2018 01:43 PM, Kees Cook wrote:
>>>
>>> On Tue, Feb 13, 2018 at 8:09 AM, Laura Abbott <labbott@redhat.com> wrote:
>>>>
>>>> No, arm64 doesn't fixup the aliases, mostly because arm64 uses larger
>>>> page sizes which can't be broken down at runtime. CONFIG_PAGE_POISONING
>>>> does use 4K pages which could be adjusted at runtime. So yes, you are
>>>> right we would have physmap exposure on arm64 as well.
>>>
>>>
>>> Errr, so that means even modules and kernel code are writable via the
>>> arm64 physmap? That seems extraordinarily bad. :(
>>>
>>> -Kees
>>>
>>
>> (adding linux-arm-kernel and changing the subject)
>>
>> Kernel code should be fine, if it isn't that is a bug that should be
>> fixed.
> 
> We take care to ensure that the linear alias of the core kernel's
> .text and .rodata segments are mapped read-only. When we first moved
> the kernel out of the linear region, we did not map it there at all
> anymore, but that broke hibernation so we had to put something back.
> 
>> Modules yes are not fully protected. The conclusion from past
>> experience has been that we cannot safely break down larger page sizes
>> at runtime like x86 does. We could theoretically
>> add support for fixing up the alias if PAGE_POISONING is enabled but
>> I don't know who would actually use that in production. Performance
>> is very poor at that point.
>>
> 
> As long as the linear alias of the module is mapped down to pages, we
> should be able to tweak the permissions. I take it that PAGE_POISONING
> does more than just that?
> 

Page poisoning does exactly that. The argument I was trying to make
was that if nobody really uses page poisoning except for debugging
it might not be worth it to fix up the alias. Thinking a bit more,
this is a terrible argument for many reasons so yes I agree that
we can just fix up the alias if PAGE_POISONING (or other features)
are enabled.

Thanks,
Laura
