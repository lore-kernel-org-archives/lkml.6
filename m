Return-Path: <SRS0=qElZ=GE=infradead.org=peterz@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2529736-1521058141-2-18017120334927432511
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=qElZ=GE=infradead.org=peterz@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521058141; b=SXn2a18UzyOwL7hD6tVHcgTJDWisrEk5TPo1w06xGagT8JW
    LBpmamB0lqrkDueIcUYuur0QasUOnbNNGXbMoTBpSSDheCIVN2KWAqxfs1OEhkKh
    DaWb4ZX/2iwHY9JDMNWatvffGlHsXlVKQCdyxYFEIxYH3GW/WgIhArEs6ltz/G1W
    qtizRe0+ngUO/Jm22TGtRbFX1SeRj5L4Ri0gsS1dvT4OeGzZFTPw3+LnAgY7hlQa
    96pvRr5p6Nr1rgvGDjJHZNn6dFh68SuXNi+ZPEXT1avlgFyTwssCMjJ44aI+PQep
    hU0j0vvKqrQU/jLL8tVOEl4Lq1me4JDYylkBXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521058141; bh=nvhbGiuX2ovYkaRNin8J3IQ9l7y5xi0vm92oAL9N2ao=; b=C
    h8Zxub2mVZ6S4qsdWB9kalyvEr2mwV6zmoD9sX0jsxglANQL9KI0ScNAIM7NF6Zc
    vMoUAfqmPq17qnbbPj4sW5kd2q/5IGf61EhULQv31OTxAGhO4mmKGcwp6hyyeldD
    cJRW3dzb7Nkeg1dfI4VvwVLBw8P0/Jcj5wjO6KEbAt6TMuOWaRn+0Ub/8ifyjQyb
    lPG1IOpXyTpavAytei8VO3Mu+c6UANHffGm0/ZpcSxomaqIU+smFBt2uwH49iaKH
    ISN67oHJNL4oqcWu8o0rl1TsYpNeOzwlePZNaHqRD1YYF0SH9N/9P0C50g9A0612
    k9En4ZszijumEyORtVjag==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Rsu/JnNA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=qElZ=GE=infradead.org=peterz@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Rsu/JnNA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=qElZ=GE=infradead.org=peterz@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0A72077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=peterz@infradead.org
Date: Wed, 14 Mar 2018 21:08:46 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "tj@kernel.org" <tj@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jannh@google.com" <jannh@google.com>,
	"bcrl@kvack.org" <bcrl@kvack.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"security@kernel.org" <security@kernel.org>,
	"kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched()
 in blk_queue_enter()
Message-ID: <20180314200846.GR4064@hirez.programming.kicks-ass.net>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-5-tj@kernel.org>
 <1520358769.3578.21.camel@wdc.com>
 <20180314184636.GC2943022@devbig577.frc2.facebook.com>
 <1521057929.3006.31.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521057929.3006.31.camel@wdc.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 08:05:30PM +0000, Bart Van Assche wrote:
> Can you clarify this further? From <linux/rcupdate.h>:
> 
> static inline void synchronize_rcu(void)
> {
> 	synchronize_sched();
> }

You'll find that is for !CONFIG_PREEMPT_RCU.
