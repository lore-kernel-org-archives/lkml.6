Return-Path: <kernel-hardening-return-11897-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2242SZiT+bKRibtEFYK8AW6JAXRsdwa2ihjOZ94h3Ck7y/l/W+Is6/pvQt+b3iMqr4lOJH+R
ARC-Seal: i=1; a=rsa-sha256; t=1519324252; cv=none;
        d=google.com; s=arc-20160816;
        b=zH/H8KEG0AHtCa85OUIuIwzkrgsgLjZq/Ay5uxjwNO7W/iIqOcE8i4QLopqq7lZ2jU
         1aT2+dBhi8HvsVFTJKAthhzK1IEz3F8HQF8kQM6NR74CswBTqEIpD7luA5QNLEGQhxe4
         MUlCPg36uIO10ur61tRNMbaezNKvMdS8whgvkHFVHFdsqS+ULxjRNNA+vAdl748+FNRc
         Od7EJJr+7lCyFuQpLCj6tLXskBEg47Uk+TubxSRaccFnpKrIGYob221DudpqfA29JYOG
         FlH+du6y9p9dvyrbdn6v/vEG4zqjrNBRDVfP03RQtJE9vuACS0XuywKvNcovmVM3gh7V
         QgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=TlahBmqwp9e+Da/sUZyyEUSsZR+kiZly4UjCXOpNmLg=;
        b=QlPSqHzXXMySlFLoVkflysVzwNC05Lku/j3430HO+LRsL7gyVUtF7xrNnzlt4p+iwE
         dxiHVLsjENOZ9djM6X2IwjnJi9Vh6ghlllOFr4oBTeMV/ZKNJ3T0Q5BIBHSYrnMQhxyp
         vALA/bBOSQbrZZ8fBjnQVAvS8fD2mch0Oj56SHXneYCiA6s9L5FKzaKJ518xzo4ckCzz
         s50ZcD3VuFEvJ3kqOm/kDemL0oSaIeK1DZmhykjEWb1RWBUcDIooxAV06WEEXxbnLPxA
         j9r2fOm9oyz5yx6Ts7Hb91lpwmxvCUaM4sDIAjUgRFqnFUg1AJlnqsCVkTLzTo/Naf8X
         SI5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11897-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11897-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11897-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11897-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
From: Igor Stoppa <igor.stoppa@huawei.com>
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
 <f33112e4-608f-ae8c-bf88-80ef83b61398@huawei.com>
 <CAGXu5jLeC285BGDW29aHgFZRV6CnqBmmkZULW2pzYmqd0pe9UQ@mail.gmail.com>
 <fb001cd0-7f37-394f-f926-f5b98365b4b8@huawei.com>
Message-ID: <81471cf6-5a27-6e8c-ac7c-e7c4cc35d410@huawei.com>
Date: Thu, 22 Feb 2018 20:28:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <fb001cd0-7f37-394f-f926-f5b98365b4b8@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214940015088630?=
X-GMAIL-MSGID: =?utf-8?q?1593126947814675703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22/02/18 11:14, Igor Stoppa wrote:
> 
> 
> On 22/02/18 00:28, Kees Cook wrote:
>> On Tue, Feb 20, 2018 at 8:59 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>>
>>>
>>> On 13/02/18 01:50, Kees Cook wrote:
>>>> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> 
> [...]
> 
>>>>> +       genalloc_selftest();
>>>>
>>>> I wonder if it's possible to make this module-loadable instead? That
>>>> way it could be built and tested separately.
>>>
>>> In my case modules are not an option.
>>> Of course it could be still built in, but what is the real gain?
>>
>> The gain for it being a module is that it can be loaded and tested
>> separately from the final kernel image and module collection. For
>> example, Chrome OS builds lots of debugging test modules but doesn't
>> include them on the final image. They're only used for testing, and
>> can be separate from the kernel and "production" modules.
> 
> ok

I started to turn this into a module, but after all it doesn't seem like
it would give any real advantage, compared to the current implementation.

This testing is meant to catch bugs in memory management as early as
possible in the boot phase, before users of genalloc start to fail in
mysterious ways.

This includes, but is not limited to: MCE on x86, uncached pages
provider on arm64, dma on arm.

Should genalloc fail, it's highly unlikely that the test rig would even
reach the point where it can load a module and run it, even if it is
located in initrd.

The test would not be run, precisely at the moment where its output
would be needed the most, leaving a crash log that is hard to debug
because of memory corruption.

I do not know how Chrome OS builds are organized, but I imagine that
probably there is a separate test build, where options like lockdep,
ubsan, etc. are enabled.

All options that cannot be left enabled in a production kernel, but are
very useful for sanity checks and require a separate build.

Genalloc testing should be added there, rather than in a module, imho.

--
igor
