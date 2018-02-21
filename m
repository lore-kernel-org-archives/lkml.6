Return-Path: <kernel-hardening-return-11849-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224pYdYyyXWscMyBOURT0op6DpiGdVtNmCW6srud5R1WUq2UnD94XTRUBdeCOyJPI54ItBIx
ARC-Seal: i=1; a=rsa-sha256; t=1519207027; cv=none;
        d=google.com; s=arc-20160816;
        b=wtiv90tzqdae3YzjIvxQqbkozl2gt89B/ohJdZSVj9fQDkyGzmUWaItxvd3DinK4+d
         AIGK0SPm8DjqX0HYBn3yuOufzsSsHK/hS3KFs1FR8psibTd8HaQjbgwdpIozwPYcu2W7
         5vnOdrw6IzRQGjlSwoCyNu8A3JpEVwcINzZJRJrtDtv0DweYZcVL338Gbqr5+NIhnLGt
         A02FWHxO8q+Cao3IklNUxVyfvmsRtIFyhTohVLbXBxdg+f4ez5yFChJivEHvilXjRecY
         HUi392doq3BjOZoljEWZ1Jei+Cv3pIBizdN9Sce+1bRTBMTMUJ7cbdecdIlURY3ANARO
         95LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=bPpfrERbesHpIXqgK5cfI69FssCUlAuaoxSZLLPwp5Q=;
        b=Buddyho0dI6trzazuD7YpxFoyEA1JFU0uSR9qqOKYxyK6qGMkRq7lJ1ZIhV2XWvb6E
         VlBh84A05E74g2JW2rot5mjQgYd68gtJ6bAd/4WIdNhwxfGAwkW8vEv1OyUEVPjCd9Sb
         mBDnHVHx+ycrggIOgEVfZC6oY26uBZ/L2VDnp8YbZZ3Xd8244kIOe2NK0H0SyqYk3z8A
         txgHRyrlIsnOG4p4UzHHf9PdH1zCc3RdEMX4XysmFeB3gBGSIWuJTBolnZen8ydSBPv7
         a4IvAttSChOTNkEDvSSgZnHAIIaQ55iHPOGGN6y/QP8YUVHex97an75sjXgCSZ1eWgtO
         F0Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11849-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11849-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11849-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11849-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
To: Dave Chinner <dchinner@redhat.com>, Matthew Wilcox <willy@infradead.org>
CC: Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, "Laura
 Abbott" <labbott@redhat.com>, Jerome Glisse <jglisse@redhat.com>, "Christoph
 Hellwig" <hch@infradead.org>, Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM
	<linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
 <20180220012111.GC3728@rh> <24e65dec-f452-a444-4382-d1f88fbb334c@huawei.com>
 <20180220213604.GD3728@rh> <20180220235600.GA3706@bombadil.infradead.org>
 <20180221013636.GE3728@rh>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <46a9610a-182b-4765-9d83-cab6297377f3@huawei.com>
Date: Wed, 21 Feb 2018 11:56:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221013636.GE3728@rh>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1593004028237316359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21/02/18 03:36, Dave Chinner wrote:
> On Tue, Feb 20, 2018 at 03:56:00PM -0800, Matthew Wilcox wrote:
>> On Wed, Feb 21, 2018 at 08:36:04AM +1100, Dave Chinner wrote:
>>> FWIW, I'm not wanting to use it to replace static variables. All the
>>> structures are dynamically allocated right now, and get assigned to
>>> other dynamically allocated pointers. I'd likely split the current
>>> structures into a "ro after init" 

I would prefer to use a different terminology, because, if I have
understood the use case, this is not exactly the same as __ro_after_init

So, this is my understanding:

* "const" needs to be known at link time - there might be some
adjustments later on, ex: patching of "const" pointers, after relocation
has taken place - I am assuming we are not planning to patch const data
The compiler can perform whatever optimization it feels like and it is
allowed to do, on this.

* __ro_after_init is almost the same as a const, from a r/w perspective,
but it will become effectively read_only after the completion of the
init phase. The compiler cannot use it in any way to detect errors,
AFAIK. The system will just generate a runtime error is someone tries to
alter some __ro_after_init data, when it's read-only.
The only trick available is to use, after the protection, a different
type of handle, const.

* pmalloc pools can be protected (hence the "p") at any time, but they
start as r/w. Also, they cannot be declared statically.

* data which is either const or __ro_after_init is placed into specific
sections (on arm64 it's actually the same) and its pages are then marked
as read-only.

>>> structure and rw structure, so
>>> how does the "__ro_after_init" attribute work in that case? Is it
>>> something like this?
>>>
>>> struct xfs_mount {
>>> 	struct xfs_mount_ro{
>>> 		.......
>>> 	} *ro __ro_after_init;
>        ^^^^^^^^
> 
> pointer, not embedded structure....

I doubt this would work, because I think it's not possible to put a
field of a structure into a separate section, afaik.

__ro_after_init would refer to the ro field, not to the memory it refers to.

>>> 	......
>>
>> No, you'd do:
>>
>> struct xfs_mount_ro {
>> 	[...]
>> };

is this something that is readonly from the beginning and then shared
among mount points or is it specific to each mount point?

>> struct xfs_mount {
>> 	const struct xfs_mount_ro *ro;
>> 	[...]
>> };
> 
> .... so that's pretty much the same thing :P

The "const" modifier is a nice way to catch errors through the compiler,
iff the ro data will not be initialized through this handle, when it's
still writable.

>>> Also, what compile time checks are in place to catch writes to
>>> ro structure members? Is sparse going to be able to check this sort
>>> of thing, like is does with endian-specific variables?
>>
>> Just labelling the pointer const should be enough for the compiler to
>> catch unintended writes.
> 
> Ok.

yes, anyway the first one trying to alter it at run time, is in for some
surprise.

>>>> I'd be interested to have your review of the pmalloc API, if you think
>>>> something is missing, once I send out the next revision.
>>>
>>> I'll look at it in more depth when it comes past again. :P
>>
>> I think the key question is whether you want a slab-style interface
>> or whether you want a kmalloc-style interface.  I'd been assuming
>> the former, but Igor has implemented the latter already.
> 
> Slabs are rally only useful when you have lots of a specific type of
> object. I'm concerned mostly about one-off per-mount point
> structures, of which there are relatively few. A heap-like pool per
> mount is fine for this.

That was my same sentiment.

Actually it would be even possible to simulate caches with pools: each
pool supports a granularity parameter, during creation. One could have
multiple pools, each with different granularity, but it would probably
lead to a proliferation of pools.

Instead, I preferred to have pmalloc as a drop-in replacement for the
variants of k/v/kv malloc.

The only real issue was the - previous - inability of tracking the size
of an allocation, given its address, but that is taken care of by the
patch for the genalloc bitmap.

If I could have a pointer to a good candidate for the pmalloc treatment,
I could come up with a patch, to show how it could be done.

Then it might be easier to discuss if the API needs to be modified
and/or extended somehow.

--
igor
