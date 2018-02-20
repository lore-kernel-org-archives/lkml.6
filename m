Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3115364-1519139944-2-2957500381210583367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519139943; b=HLXbLE/0FFx3ODTixBX9irNG5uYV9PT92y/yGmD8BSwgtUo
    99iGZfhzpOKKJ0aQBOc2ozoypNTxeLMZpptW5puhWhoR27qm0yaKV1ruUbljMKGa
    er/lu6FHBuv6IpijBz20WpnzKzITSR2iHvF5vl4Ahfw9kT789XGYjTenibO18DRh
    FU9OKb6UTkyk5eji1rXtrNSsZU3gnKTJHi/X9LC7pad5GvSkfG31bKz23G2liisj
    4ZdYfgEvnUirx2akkdROdCXvCzEsHpkdng+uiXY0RfxCGuiaaNfj124QE6HwKt4o
    SCg2F3Jq0qSmm7jLccL1t8bXC9quucMruUtyhVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519139943; bh=v1lbXnemylnWTnwpK/uGOsMAZp
    iGHXjWisu4HdfV3kY=; b=XWkfivaedUYsk3nsolUZoODcEKMva9IgXl/cfSGq3B
    socAmV1jPzMbpTlvoPgciNfYRGHoxWTCTe4IXSaQd2y/zhco70bWgML7JfQxK6tX
    pYmn/bpO917+2QuRH13BoMFrsepMXDPJJpuyevvS/vG1jPh1KwFoZHEACFl0Xtfq
    FcpRmuxSfk8jUq6bYfO5wC2uVOHjGVVndvTpE2qMa2AMIIi0tEaGYb5sX+ALeMFV
    1qpqjsiXgx7SqWQFHAjSwt+0VeWl1/sMjCQGrqGXO2OXIWDNkv+/RZ2EXNsyQ9Xx
    JX49VqfhepwXimlzYBU1lmkFOQefE/BPRp5DkH/zISKw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=auM36oBt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=auM36oBt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeBTPTA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 10:19:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbeBTPS6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 10:18:58 -0500
Date: Tue, 20 Feb 2018 16:18:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, linux-audit@redhat.com
Subject: Re: [PATCH 4.10 070/111] audit: fix auditd/kernel connection state
 tracking
Message-ID: <20180220151849.GG25201@hirez.programming.kicks-ass.net>
References: <20170328122915.640228468@linuxfoundation.org>
 <20170328122918.597715642@linuxfoundation.org>
 <20180220123757.GE25314@hirez.programming.kicks-ass.net>
 <CAHC9VhTOxzcJpVSFDign56jkkruQjujTp7GQzk107FNWYTXRYg@mail.gmail.com>
 <20180220140640.GE25201@hirez.programming.kicks-ass.net>
 <CAHC9VhS40=qNxjNJSBqz2GwrqrvTqLKpdOWUrJ5iUDFp8ERO-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS40=qNxjNJSBqz2GwrqrvTqLKpdOWUrJ5iUDFp8ERO-A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 09:51:08AM -0500, Paul Moore wrote:
> On Tue, Feb 20, 2018 at 9:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > It's not at all clear to me what that code does, I just stumbled upon
> > __mutex_owner() outside of the mutex code itself and went WTF.
> 
> If you don't want people to use __mutex_owner() outside of the mutex
> code I might suggest adding a rather serious comment at the top of the
> function, because right now I don't see anything suggesting that
> function shouldn't be used.  Yes, there is the double underscore
> prefix, but that can mean a few different things these days.

Find below.

> > The comment (aside from having the most horribly style) ...
> 
> Yeah, your dog is ugly too.  Notice how neither comment is constructive?

I'm sure you've seen this one:

  https://lkml.org/lkml/2016/7/8/625

It's all about reading code; inconsistent and unbalanced styles are just
_really_ hard on the brain.

> > ... is wrong too, because it claims it will not block when we hold that lock, while,
> > afaict, it will in fact do just that.
> 
> A mutex blocks when it is held, but the audit_log_start() function
> should not block for the task that currently holds the
> audit_cmd_mutex; that is what the comment is meant to convey.  I
> believe the comment makes sense, but I did write it so I'll concede
> that I'm probably the not best judge.  If anyone would like to offer a
> different wording I'm happy to consider it.

The comment uses 'sleep' which is typically used to mean anything that
schedules, but then it does the schedule_timeout() thing.

> > Maybe if you could explain how that code is supposed to work and why it
> > doesn't know if it holds a lock I could make a suggestion...
> 
> I just spent a few minutes looking back over the bits available in
> include/linux/mutex.h and I'm not seeing anything beyond
> __mutex_owner() which would allow us to determine the mutex owning
> task.  It's probably easiest for us to just track ownership ourselves.
> I'll put together a patch later today.

Note that up until recently the mutex implementation didn't even have a
consistent owner field. And the thing is, it's very easy to use wrong,
only today I've seen a patch do: "__mutex_owner() == task", where task
was allowed to be !current, which is just wrong.

Looking through kernel/audit.c I'm not even sure I see how you would end
up in audit_log_start() with audit_cmd_mutex held.

Can you give me a few code paths that trigger this? Simple git-grep is
failing me.


---
Subject: mutex: Add comment to __mutex_owner()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Feb 20 16:01:36 CET 2018

Attempt to deter usage, this is not a public interface. It is entirely
possibly to implement a conformant mutex without having this owner
field (in fact, we used to have that).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -66,6 +66,11 @@ struct mutex {
 #endif
 };
 
+/*
+ * Internal helper function; C doesn't allow us to hide it :/
+ *
+ * DO NOT USE (outside of mutex code).
+ */
 static inline struct task_struct *__mutex_owner(struct mutex *lock)
 {
 	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
