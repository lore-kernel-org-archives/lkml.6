Return-Path: <SRS0=5xW2=GE=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2380744-1521053205-2-5400359372421236346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=5xW2=GE=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521053203; b=lGkOoq/8YWtx72Clz/zsUrkn6ETTB+U/PuDMLQfbNRPwRaW
    /xDZommiPyTaipSyygsAUHmUfADebHaJCBWArBgf2mHXg8zj3bHB146wocckej1Y
    PPhEMYgRvgTlXDgOG4gzs9OQcZgrSpB050HW1SThbOqU8yMfA/DnOzmdlio5WpYy
    A3t7/HDJbSznsrLRwMMH65OnUk6FWfNRLiMpJx5zaFRZQbyn86LVkLyewlkWtpF1
    pFEPrA4ufuMFheObiY5aQXjS/fbW09i3fiYYovxwWsVQLRoSJfaVMG+hzLG3+6VC
    h9o9HMnuDWQ79FaEegIP7zY7wA7hiFVgXpJieOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521053203; bh=Sy7R3rsH0WkWvcM1i1xWtoDlIY77t55O29XBEyt46dw=; b=A
    YDR+cxSGuq6gpua5KvmSa3MEeONGyJlgCKzkv+RBgJgeRf993s6DIgjOHgG+EtNu
    1TxrnAbKS0L2YM+sMouIltaQAhOrPeR4rbfILuFPemtbnljhSzblxShr4qF0fo/T
    c7flTVxztcl2jMW+UbMOU0UAirASU57pFJ0STXcINyr+xMxSJBr/rti8AYP2AvOy
    00lRBDJBpwNML8ZBeuSZfevlm79uAi28JjI4XCoFwF5mRR4JfOOm/0ReN38ctkw1
    /SMz6NuoE2JebF6omIEHxTJmf6bsKRnaD275rpTNPg4wF3pSAkZ72aenroDkMqQv
    TH0Uvppo2OD5rtVuB8r+w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ciuos+A/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FzEJKBgK;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ciuos+A/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FzEJKBgK;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C672077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELvrZvPNkx6WLZXU6r154p3akeOkTpdVnLxvInlG71y77MTcPQ6cenioRKZkjTDKcv8NTw97nQ==
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 14 Mar 2018 11:46:36 -0700
From: "tj@kernel.org" <tj@kernel.org>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jannh@google.com" <jannh@google.com>,
	"paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
	"bcrl@kvack.org" <bcrl@kvack.org>,
	"kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
	"security@kernel.org" <security@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched()
 in blk_queue_enter()
Message-ID: <20180314184636.GC2943022@devbig577.frc2.facebook.com>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-5-tj@kernel.org>
 <1520358769.3578.21.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520358769.3578.21.camel@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Bart.

On Tue, Mar 06, 2018 at 05:52:50PM +0000, Bart Van Assche wrote:
> I think the rcu_read_lock() and rcu_read_unlock() are really necessary in this
> code. In the LWN article "The RCU-barrier menagerie" it is explained that RCU
> can be used to enforce write ordering globally if the code that reads the writes

Yeah but, for it to be meaningful, just like barriers, it has to be
paired with something on the other side.

> that are ordered with an RCU read lock (https://lwn.net/Articles/573497/). See
> also the following comment in scsi_device_quiesce():
> 
> 	/*
> 	 * Ensure that the effect of blk_set_preempt_only() will be visible
> 	 * for percpu_ref_tryget() callers that occur after the queue
> 	 * unfreeze even if the queue was already frozen before this function
> 	 * was called. See also https://lwn.net/Articles/573497/.
> 	 */
> 
> Since this patch introduces a subtle and hard to debug race condition, please
> drop this patch.

Hah, the pairing is between scsi_device_quiesce() and
blk_queue_enter()?  But that doesn't make sense either because
scsi_device_quiesce() is doing regular synchronize_rcu() and
blk_queue_entre() is doing rcu_read_lock_sched().  They don't
interlock with each other in any way.

So, the right thing to do here would be somehow moving the RCU
synchronization into blk_set_preempt_only() and switching to regular
RCU protection in blk_queue_enter().  The code as-is isn't really
doing anything.

I'll drop this patch from the series for now.  Let's revisit it later.

Thanks.

-- 
tejun
