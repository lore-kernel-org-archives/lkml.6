Return-Path: <SRS0=N/wy=F5=infradead.org=peterz@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3646879-1520439812-2-16406690609604772339
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
X-Mail-from: SRS0=N/wy=F5=infradead.org=peterz@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520439812; b=iZSPyPdOAHdUOvIKMe2SUlzTWMFLA9g6CnV7U5ujmGzXJEb
    oxtJG9LMmkcivkYJyKvhsAo8qObtPcHx0IXqncBGWrjPKwLtUlpdKzF24mdFg+VX
    RxNRbiqhysimVYTJGgdHKVX5PW5GniS4Bjmiacu45TGOYKjFmt5iAblqHGdslGE1
    KPrNbqqkz9oDqr5f5g88l4PbHnaIYSJGknqZoVkPMCdr+txr3e2d2bYaZXXOFhUz
    yBCJXJQhhhlQVFujVugUOqhla994LkIBwMo5NThQjLU7y8fpFVX7BA1pw3hjb+S1
    65QFnpZTL7zfzlLEbkjj0B/C9usd3c7wRSvL32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1520439812; bh=2rPOtI8590p41XwN68QNVxm3wuWuFXjjZ35XAfRJX/E=; b=i
    Rgfs/RXXofzXhKpYBaUG5qZJ0Ct5qPTQp+iBntyEB3ovjolBVBxuPUGTZbrEM69t
    FSnGU+obTjlIOQQAl+xCa04r/6633rVROhXc6uJ4MIv/GUsQZJcfPpiE3jNAgz1l
    M7TAPhx3Ga3bEQp6xTdbOHoAUTUydEADX1YPaHQYWLS+D9Fw/t1/MIp/kkNuGCfq
    L0AvXoTpM4JPRHtD2+q7yXElVkVKfTBnJwpANm7IdxeVG+FzlSB6bUmVak+MVJzz
    7l8U5sRvBZeWkhfhUzQHB7Ei/gpffC7+iBQywbhp+28S3nB+ZfozxjDOvR4svqpb
    P4fCBY3wScXw4C9aJT9NQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GKMVo/VK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=N/wy=F5=infradead.org=peterz@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=GKMVo/VK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=merlin.20170209;
    dmarc=none (p=none,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=N/wy=F5=infradead.org=peterz@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6D72172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=peterz@infradead.org
Date: Wed, 7 Mar 2018 17:23:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Lai Jiangshan <jiangshanlai+lkml@gmail.com>, Tejun Heo <tj@kernel.org>,
	torvalds@linux-foundation.org, jannh@google.com, bcrl@kvack.org,
	viro@zeniv.linux.org.uk, kent.overstreet@gmail.com,
	security@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	kernel-team@fb.com
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
Message-ID: <20180307162317.GO25181@hirez.programming.kicks-ass.net>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-7-tj@kernel.org>
 <CAJhGHyAuz3TRCpPnCBzZ+om3k9N3ykCWYOq_bv+hucV=XXiY9w@mail.gmail.com>
 <20180307145408.GC3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307145408.GC3918@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 06:54:08AM -0800, Paul E. McKenney wrote:
> One downside of allowing RCU callback functions to sleep is that
> one poorly written callback can block a bunch of other ones.

Not to mention that we really want the RCU callbacks to be simple and
short. Needing fancy things in the callback really should be the
exception not the rule.
