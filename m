Return-Path: <SRS0=Id9m=HD=thunk.org=tytso@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3054875-1523745867-2-18342473155916194209
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='edu',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=Id9m=HD=thunk.org=tytso@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523745866; b=NyQX9Bkq4HwOag6fqEdt45ymp+r+pDMXGkyD5PqQEtro62wIfs
    unNxoul6Vk+8Dlpt8M3ZVct/ixj8l3hpRCn+CNWRtZsRqEzJXPbghEpY0g1l+19H
    r25kMQ7uzHsF22XCWAsCPI+WU7SUdfLMI4XWmpDxxdpVq+vYjK8U08Jbdi+q7N9Q
    JNSzKA9yu/FDq7S4xeBEF3TBzwlDzdY5DWnWI75L0dBTmgzFvCsF+VQ+eKD94V/Z
    mAEwnpsuU27U6G4z/bdFNZ3qFr5GdOhCWtV1T+zVnGLDWIIS9kjnrwQD4otecaTa
    UhteL7VVlw2ClzIbBE3KKvliPbtw4/DtuJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1523745866; bh=qjvGNaFmdKTa0uBfNdxKGtaEARuQAWDpEwyl9rzoneY=; b=e
    t4p/ZOsvUKqq7imXDvWuk975V2MVI8UhASXLFI5d3TY14FAGjkH2tYv7PdKbXbYb
    NUNob2WfITgOZZKiIc9tEq8HyiOgI5iL9h2fR064ajClMbn5b3el+VXKqB0Jxa2u
    wDVCz7uMCN1NgwtMcA0nB9c3km6U9+ttSMkeNDOl24FCHxLvSqCla//lU7rVbtRi
    Wij8eMi0jaSYmgEXYFaLkleh+v2fiVFojJsAmRPIMlDXrbfClD717hU7FyoiPHKQ
    DIVbjkFOhh9cArEkt71fvW/ACX4riGZVJ6qXTNKp9XRJ1pLuRujEALgn+AuZqdpV
    ZnLnFPQOHUBhZnl/DruqQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=Hhoa+zGE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Id9m=HD=thunk.org=tytso@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=thunk.org header.i=@thunk.org header.b=Hhoa+zGE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Id9m=HD=thunk.org=tytso@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK60CkgW0Cw6fk2di1tUwFbJ4jX0CVZyJ1ThoGnhxwrrq7Bi2R+mQqeADbtMXdj7KfUpVutJ1lntkaSXoKmYOuw1ekNklzNr/fCiqb5rxo5vUHt6g1Fi
    VONMhOtle+hMXFi7TRgu120XEQ/gDqh4U+DWbfpb/tDEuhameWtsKwM+6lKWUGV7BwvH29pJcoerZV7eejSIPrDad+xc1wOXqNY=
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=37rDS-QxAAAA:8 a=VwQbUJbxAAAA:8 a=ZYjLvdI7Z9MjdAT0XIYA:9
    a=aAwTLkoKUa1mA7mc:21 a=PZoe_PuLjwotSTxV:21 a=CjuIK1q_8ugA:10
    a=k1Nq6YrhK2t884LQW06G:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F872177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=tytso@thunk.org
Date: Sat, 14 Apr 2018 18:44:19 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: repeatable boot randomness inside KVM guest
Message-ID: <20180414224419.GA21830@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20180414195921.GA10437@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180414195921.GA10437@avx2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+linux-mm@kvack.org
kvm@vger.kernel.org, security@kernel.org moved to bcc

On Sat, Apr 14, 2018 at 10:59:21PM +0300, Alexey Dobriyan wrote:
> SLAB allocators got CONFIG_SLAB_FREELIST_RANDOM option which randomizes
> allocation pattern inside a slab:
> 
> 	int cache_random_seq_create(struct kmem_cache *cachep, unsigned int count, gfp_t gfp)
> 	{
> 		...
> 		/* Get best entropy at this stage of boot */
> 	        prandom_seed_state(&state, get_random_long());
>
> Then I printed actual random sequences for each kmem cache.
> Turned out they were all the same for most of the caches and
> they didn't vary across guest reboots.

The problem is at the super-early state of the boot path, kernel code
can't allocate memory.  This is something most device drivers kinda
assume they can do.  :-)

So it means we haven't yet initialized the virtio-rng driver, and it's
before interrupts have been enabled, so we can't harvest any entropy
from interrupt timing.  So that's why trying to use virtio-rng didn't
help.

> The only way to get randomness for SLAB is to enable RDRAND inside guest.
> 
> Is it KVM bug?

No, it's not a KVM bug.  The fundamental issue is in how the
CONFIG_SLAB_FREELIST_RANDOM is currently implemented.

What needs to happen is freelist should get randomized much later in
the boot sequence.  Doing it later will require locking; I don't know
enough about the slab/slub code to know whether the slab_mutex would
be sufficient, or some other lock might need to be added.

The other thing I would note that is that using prandom_u32_state() doesn't
really provide much security.  In fact, if the the goal is to protect
against a malicious attacker trying to guess what addresses will be
returned by the slab allocator, I suspect it's much like the security
patdowns done at airports.  It might protect against a really stupid
attacker, but it's mostly security theater.

The freelist randomization is only being done once; so it's not like
performance is really an issue.  It would be much better to just use
get_random_u32() and be done with it.  I'd drop using prandom_*
functions in slab.c and slubct and slab_common.c, and just use a
really random number generator, if the goal is real security as
opposed to security for show....

(Not that there's necessarily any thing wrong with security theater;
the US spends over 3 billion dollars a year on security theater.  As
politicians know, symbolism can be important.  :-)

Cheers,

					- Ted
