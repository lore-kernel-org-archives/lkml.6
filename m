Return-Path: <kernel-hardening-return-11560-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224I/6AXHaQmFL4DEiOiuTulWpS+8pmkKW0MNLAmt65txzQUJQ1fOrJi7OQji1xaMy5/716n
ARC-Seal: i=1; a=rsa-sha256; t=1517672318; cv=none;
        d=google.com; s=arc-20160816;
        b=nYtcby0Bg9NT1juh2S+My5w+6ARbqRwPNyI2Gq2fLMYYBTKF048JqkDSS2wEJ3wQl6
         sZTQihMDpOJEMAz6m2swvrjjT4PnONwXQ1jODDvqqBIjLgpR2wngasMt1Dvjq11j7KMg
         p99H9S72Ewpdg5MwSKxjtQNtISL7xFoz+Ypv25EdaJmqPRnwGt47yQjj2dCT+ItYO1zl
         7CGNHrfh/aFNrHtljUhOxdY9/XeYN/lGsaHmMKoDdAUHpFCGzM3Aslhh5eW1EdoZB5Uj
         XPlCsQACXvhsUF5rh7L1WHFKKAA+LXGs3A5MTcb3CDFUoRzXTYTgnAHsKGeqi3tFzp3C
         r/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=GhdOwopFz8jgvr0FNDF0ZLGqM4ZowKdMcjA2iqYgC4k=;
        b=Hq9UoUgGR4cv1ytjjkmOXrQO3nQIGgnQ6so81n1oB9DDPgdkF2ExWT42sFW0apltl/
         FDDONqULp+cBj7V9sLf1hUUOiiHaBhtYZ9vTqF6ES5R8AoQel3E3v2oVzHq6K968IUDE
         ioxdjM5cZzpiF+eJIVrO3ilkwegZaKC2wb/h4oq8JAqDkwVNlzZcJjZPZ/nEL76a6QHP
         XX+CshhKpIrxBlXRnkdvTNsVfVMNVvp60Sz2cfhkjzbXtY70SzROFwx8m3yXScQo0DIt
         eUhPySCXEznYqWLil0TskxHAJTxdgRDN3aSFqFig84bZDWxA3ZOGf7kK1WitgheTPrxz
         B4tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11560-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11560-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11560-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11560-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>,
	Boris Lukashev <blukashev@sempervictus.com>
CC: Jann Horn <jannh@google.com>, <jglisse@redhat.com>, Kees Cook
	<keescook@chromium.org>, Michal Hocko <mhocko@kernel.org>, Laura Abbott
	<labbott@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>, kernel list
	<linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com>
 <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org>
 <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
Date: Sat, 3 Feb 2018 17:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1591394768758443497?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+Boris Lukashev

On 02/02/18 20:39, Christopher Lameter wrote:
> On Thu, 25 Jan 2018, Matthew Wilcox wrote:
> 
>> It's worth having a discussion about whether we want the pmalloc API
>> or whether we want a slab-based API.  We can have a separate discussion
>> about an API to remove pages from the physmap.
> 
> We could even do this in a more thorough way. Can we use a ring 1 / 2
> distinction to create a hardened OS core that policies the rest of
> the ever expanding kernel with all its modules and this and that feature?

What would be the differentiating criteria? Furthermore, what are the
chances
of invalidating the entire concept, because there is already an
hypervisor using
the higher level features?
That is what you are proposing, if I understand correctly.

But more on this below ...


> I think that will long term be a better approach and allow more than the
> current hardening approaches can get you. It seems that we are willing to
> tolerate significant performance regressions now. So lets use the
> protection mechanisms that the hardware offers.

I would rather *not* propose significant performance regression :-P

There might be some one-off case or anyway rare event which is
penalized, but my preference goes to not introducing any significant
performance penalty, during regular use.
After all, the lower the penalty, the wider the (potential) adoption.

More in detail: there are 2 major cases for wanting some form of
read-only protection.

1) extra ward against accidental corruption
The kernel provides many debugging tools and they can detect lots of
errors during development, but they require time and knowledge to use
them, which are not always available.
Furthermore, it is objectively true that not all the code has the same
level of maturity, especially when non-upstream code is used in some
custom product. It's not my main goal, but it would be nice if that case
too could be addressed by the protection.
Corruption *can* happen.
Having live guards against it, will definitely help spotting bugs or, at
the very least, crash/reboot a device before it can cause permanent data
corruption.
Protection against accidental corruption should be used as widely as
possible, therefore it cannot have an high price tag, in terms of lost
performance. Otherwise, there's the risk that it will be just a debug
feature, more like lockdep or ubsan.

2) protection against malicious attacks
This is harder, of course, but what is realistically to be expected?

If an attacker can gain full control of the kernel, the only way to do
damage control is to have HW and/or higher privilege SW that can somehow
limit the reach of the attacker.
To make it work for real, it should be mandated that either these extra
HW/SW means can tell apart legitimate kernel activity from rogue
actions, or they operate so independently from the kernel that a
compromise kernel cannot use any API to influence them.

The consensus seems to be to put aside (for now) this concern and
instead focus on what is a typical scenario:
- some bug is found that allows to read/write kernel memory
- some other bug is found, which leaks the address of a well known
variable, effectively revealing the randomized offset of each symbol
placed in linear memory, once their relative location is known.

What is described above is a toolkit that effectively can allow - with
patience - to attack anything that is writable by the kernel.
Including page tables and permissions.

However the typical attack is more like: "let's flip some bit(s)".
Which is where __ro_after_init has its purpose to exist.

My proposal is to extend the same sort of protection also to variables
allocated dynamically.

* make the pages read only, once the data is initialized
* use vmalloc to prevent that exfiltrating the address of an unrelated
variable can easily give away the location of the real target, because
of the individual page mapping vs linear mapping.

Boris Lukashev proposed additional hardening, when accessing a certain
variable, in the form of hash/checksum, but I could not come up with an
implementation that did not have too much overhead.

Re-considering this, one option would be to have a function
"pool_validate()" - probably expensive - that could be invoked by a
piece of code before using the data from the pool.

Not perfect, because it would not be atomic, but it could be used once,
at the beginning of a function, without adding overhead to each access
to the pool that the function would perform.

An attacker would have to time the attack so that the corruption of the
data wold happen after the pool is validated and before the data is read
from it.
Possible, but way tricker than the current unprotected situation.

What I am trying to say, is that even after having multi-ring
implementation (which would be more dependent on HW features), there
would be still the problem of validating the legitimacy of the use of
the API that such implementation would expose.

I'd rather try to preserve performance and still provide a defense
against the more trivial attacks, since other types of attacks are much
harder to perform in the wild.

Of course, I'm interested in alternatives (I'll comment separately on
the compound pages)


The way pmalloc is designed is to take advantage of any page provider.
So far, vmalloc seems to me the best option, but something else might
emerge that works better.

Yet the pmalloc API is, I think, what would be still needed, to let the
rest of the kernel take advantage of this feature.

--
igor
