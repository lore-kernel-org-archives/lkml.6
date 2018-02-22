Return-Path: <kernel-hardening-return-11888-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227D82oxTNnsB0ND5qENWdQ92bYG+UIHlvRzcB6nTTxnkwPgPmo/5biMXLFByGZiB/sQh1m/
ARC-Seal: i=1; a=rsa-sha256; t=1519290911; cv=none;
        d=google.com; s=arc-20160816;
        b=WCd1cX99BY27xcmRopSNcqCOMQz69cq7nwDuukY3s0mBkc1ymaFkWy3K/J2FJPfhqe
         qSi/0FI+s14PczKPS8fWisCqa3PBy9cHHsO8zVirJw1m+B16KAr5kjT/wcYuDok/bNhi
         2DflaPh8CzQjkO65jxeUYg+ynXwgD0waECRO78iwXkbGA0Z/e4vyGCRlf/73N79irCZy
         Q0oxBiTE7XdSeB9taQiA6bPbmuCTYSbsVx8T/8E48HBQLOCB56E1tlcMYkCsDgSerj1C
         PkW20qA4B3yl1D4jpj+XFGaNHhtH8WwWcMirpTF3oDv9AzKvIVilyh1zA2W0EXrXtF4c
         AxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=97ZZP2gy8bUyz6uV4DszVrW2xoOfYyBTWYvI2L/soaM=;
        b=AdQZL/Uad+3Tjxz4JsbGsOt2ERE84Htx5vHNLWP9F6nFwH3161sjBDv0BDWNMCkFXQ
         BOXtO9cqIo3jwTRkmgz2EWi22cqaP/oFpkvAodIeffgBIv8UdVCdAjCJYGlmVRuVTrYu
         3ICucEdKoRaTgL/mBCecEdB5Nm4mCG5y/pYwiz6HBRFi7N+Gw3LE64e+U0GG7c30tDgY
         0+DuOaGOBfcXN4zQsdrbuNNQ6SEZUAf8o6EY+0jAp6sONSbpK8opW26XIp4xNrow6suN
         W3ggEiybbwFIYu9xBTV2F7ZGoY20ZY6xQKbdYalSlmA88CqNvMXqwcdyT8cUNveqUwBy
         a3bQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11888-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11888-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11888-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11888-gregkh=linuxfoundation.org@lists.openwall.com
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
 <f33112e4-608f-ae8c-bf88-80ef83b61398@huawei.com>
 <CAGXu5jLeC285BGDW29aHgFZRV6CnqBmmkZULW2pzYmqd0pe9UQ@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <fb001cd0-7f37-394f-f926-f5b98365b4b8@huawei.com>
Date: Thu, 22 Feb 2018 11:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLeC285BGDW29aHgFZRV6CnqBmmkZULW2pzYmqd0pe9UQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214940015088630?=
X-GMAIL-MSGID: =?utf-8?q?1593091987558368747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 22/02/18 00:28, Kees Cook wrote:
> On Tue, Feb 20, 2018 at 8:59 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>
>>
>> On 13/02/18 01:50, Kees Cook wrote:
>>> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>>>> +       genalloc_selftest();
>>>
>>> I wonder if it's possible to make this module-loadable instead? That
>>> way it could be built and tested separately.
>>
>> In my case modules are not an option.
>> Of course it could be still built in, but what is the real gain?
> 
> The gain for it being a module is that it can be loaded and tested
> separately from the final kernel image and module collection. For
> example, Chrome OS builds lots of debugging test modules but doesn't
> include them on the final image. They're only used for testing, and
> can be separate from the kernel and "production" modules.

ok

> 
>> [...]
>>
>>>> +       BUG_ON(compare_bitmaps(pool, action->pattern));
>>>
>>> There's been a lot recently on BUG vs WARN. It does seem crazy to not
>>> BUG for an allocator selftest, but if we can avoid it, we should.
>>
>> If this fails, I would expect that memory corruption is almost guaranteed.
>> Do we really want to allow the boot to continue, possibly mounting a
>> filesystem, only to corrupt it? It seems very dangerous.
> 
> I would include the rationale in either a comment or the commit log.
> BUG() tends to need to be very well justified these days.

ok

> 
>>> Also, I wonder if it might make sense to split this series up a little
>>> more, as in:
>>>
>>> 1/n: add genalloc selftest
>>> 2/n: update bitmaps
>>> 3/n: add/change bitmap tests to selftest

[...]

> I'll leave it up to the -mm folks, but that was just my thought.

The reasons why I have doubts about your proposal are:

1) leaving 2/n and 3/n separate mean that the selftest could be broken,
if one does bisections with selftest enabled

2) since I would need to change the selftest, to make it work with the
updated bitmap, it would not really prove that the change is correct.

If there was a selftest that can work without changes, after the bitmap
update, I would definitely agree to introduce it first.

OTOH, as I wrote, the bitmap patch itself is already introducing
verification of the calculated value (from the bitmap) against the
provided value (from the call parameters).

This, unfortunately, cannot be split, because it still relies on the
"find end of the allocation" capability introduced by the very same patch.

Anyway, putting aside concerns about the verification of the correctness
of the patch, I still see point #1 as a problem: breaking bisectability.

Or did I not understand correctly how this works?

--
igor
