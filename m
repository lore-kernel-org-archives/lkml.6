Return-Path: <SRS0=Y6oz=GM=redhat.com=oleg@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2465629-1521717859-2-12508247980603780944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=Y6oz=GM=redhat.com=oleg@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521717859; b=saEM1WrmxANUi+r9a1ErAjo5MYXjqqA0fEcNd+lGejx/QPh
    L+a3KIkQgPh1A/yq61ewq3c6Ry9santxkY4Ujlfdy0McvunC3dJF8tnmZqjvUxgD
    cdWDuBhMkyzXIs2bHDBeZsLGQXPC37UIAhxvYIW3V0WOUuji/30NZODCGLBaVAwB
    xPYEhsPT+wMkX8ozCsjXD9QfqqSV0vl3C6FBclXwM/r49HH+kwPA2sJz8aFtK+nx
    nOZfUgSO9mlFQrPpfnABVobblAvggmQF5EBcTH7YlEcoFRvXS4j5i1u52jeawjKU
    mxrMZGs4eJk03kylSuP6AAC8ula3Ip+9eZZhoAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521717859; bh=KgU7LVFuCKB+XdJ9YqzlwmUeVc+Mx652TbCoOhxYpyI=; b=h
    QN7Xbk6X8RqshamaLD1DoVW+4dJDco2MTDfBUQNgwtbI2kA9Tek4gN1AKg27J9Jg
    nJOrDitSW0O0Xl8EShECoGvn3IfMXB28wwxtIbjQbDrRcJwtA+yVnSWhXJesbc22
    ict5chVZdd5OnKGCjGNx5zpVO+OFDLDq2jdbCxdiQfIU2Kizcb9ehh5oUCYwYVNq
    i8WfFW7EWrSWqezCH4S5R1d0G0uG7r5igNh2JAeH4zET/agh50w7PXeo/HKKPWp/
    wQew12p7+SHNW3rzNko+qSNQtiFv3x6ZzFoFQUp6NbN27nccwKytbMyXbEMFMpI0
    X0QPSF6REto895of7FqQA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Y6oz=GM=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=Y6oz=GM=redhat.com=oleg@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596B921770
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=oleg@redhat.com
Date: Thu, 22 Mar 2018 12:24:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, jannh@google.com,
	paulmck@linux.vnet.ibm.com, bcrl@kvack.org, viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com, security@kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] fs/aio: Use rcu_work instead of explicit rcu and
 work item
Message-ID: <20180322112412.GA22183@redhat.com>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
 <20180314194515.1661824-8-tj@kernel.org>
 <20180321155812.GA9382@redhat.com>
 <20180321164000.GC2149215@devbig577.frc2.facebook.com>
 <20180321171743.GA12834@redhat.com>
 <20180321175356.GD2149215@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321175356.GD2149215@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21, Tejun Heo wrote:
>
> Hello,
>
> On Wed, Mar 21, 2018 at 06:17:43PM +0100, Oleg Nesterov wrote:
> > Mostly I am asking because I do not really understand
> > "[PATCH 6/8] RCU, workqueue: Implement rcu_work".
> >
> > I mean, the code looks simple and correct but why does it play with
> > WORK_STRUCT_PENDING_BIT? IOW, I do not see a "good" use-case when 2 or more
> > queue_rcu_work()'s can use the same rwork and hit work_pending() == T. And
> > what the caller should do if queue_rcu_work() returns false?
>
> It's just following standard workqueue conventions.

OK. And I agree that the usage of WORK_STRUCT_PENDING_BIT in queue_rcu_work() is
fine. If nothing else the kernel won't crash if you call queue_rcu_work() twice.

But why flush_rcu_work() can't simply do flush_work() ?

If WORK_STRUCT_PENDING_BIT was set by us (rcu_work_rcufn() succeeded) we do not
need rcu_barrier(). Why should we care about other rcu callbacks?

If rcu_work_rcufn() fails and someone else sets PENDING, how this rcu_barrier()
can help? We didn't even do call_rcu() in this case.

In short. Once flush_work() returns we know that rcu callback which queued this
work is finished. It doesn't matter if it was fired by us or not. And if it was
not fired by us, then rcu_barrier() doesn't imply a grace period anyway.


> We can try to
> make it more specialized but then flush_rcu_work()'s behavior would
> have to different too and it gets confusing quickly.  Unless there are
> overriding reasons to deviate, I'd like to keep it consistent.

Perhaps this all is consistent, but I fail to understand this API :/

And again, at least for fs/aio.c it doesn't offer too much but sub-optimal
compared to call_rcu() + schedule_work() by hand.

Oleg.
