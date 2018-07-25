Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04C2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Nv4VjdEp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fyENrEx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB04C2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeGYGuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:50:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38201 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727735AbeGYGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:50:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E67E521CD2;
        Wed, 25 Jul 2018 01:40:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Jul 2018 01:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=KXuy4WqkFBv0q24NLiliksmysvOi9
        x4uS6RYO0EZdOI=; b=Nv4VjdEplAweFBWfjiw0vjL88U7gi5//SBocKIdFfFgDW
        A4KXhEntwH0N2q1+tSZ/RRyLHUd1h/+E6YGFnTmqrroQGeHzaLouwFwnYmURp4z3
        GjHrYNFeo74o63taBStUi6FPrq+8OSA1Vf/kb24mKi5kDZ8Sf4fgRIhWVe9dGvYS
        P4HyuPaI1RP9M9KUZZWQmA5IuxTXfqSsIXNSvw+zyyfZa9BOJinmlNMa+MxAB1Dk
        LzxERXkse0D7We7RU2Gpw82ubqgAKeJVeT26NDilIhtovh4eNwpOqCD0pOhMxT7t
        WMIiefT/byX5ckYm1CwiM3Pc7riZFXez10t1EIYDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=KXuy4W
        qkFBv0q24NLiliksmysvOi9x4uS6RYO0EZdOI=; b=fyENrEx83c/jZaN5EIY39M
        emIruQZ+RcxoUuvegENDe6EDqk1QemEbH0d1fTv8r9p9uEwBTEeOFBT/mQdehi5D
        TrBOd9WgKjfC08spdv1X4y9unKjjZTjkM9UxEOTswhFtz4KhWMBtdcmnccH38tRV
        vb6tEFqTcac1ciNd3h65JphjU113p6sY7vrdLcwjbZvrkWBI/o7aCDrSJmlOMwZ2
        nYBshKw31xzDEqtBjKHTJxk9RKqTR0HpzWqkxnFRIMQJ/pDzTr9F4kZ+kgTMGYeU
        JXuhKxuJjgU/x9bAp2AIpYG27pRgKITECnZCFbRoNa/QvICMFln8lvx78CgOVmQA
        ==
X-ME-Proxy: <xmx:MQ1YWxC9JhS8JXjQMT_z3hWHmmgYn5Pckcv34doT_m6yNQBbzRgpjA>
    <xmx:MQ1YW0a37AncHXMZaREBDQegOW2_owFJSOZZkVHfGjBBHlPzSG-TfQ>
    <xmx:MQ1YW1I1R8LKiz-mE1DG7J1bSfn5Tms1swDuXJBwhw611-FKvGHZ4g>
    <xmx:MQ1YW9Cu1NF-15V89V6zvZgNvHYbOhUQ996H7jOGfCaVhFW-FfRLNQ>
    <xmx:MQ1YW5M1cf1oGodPFEgrXuI3RyBVCJb4wE9jPD5ftn3BxgeahWgpXA>
    <xmx:MQ1YW5ZKbP32Ki6GMD98w4KafHb1C851HHjLmBSQWDqb4_ajSu8m7A>
X-ME-Sender: <xms:MQ1YWxCyG0k5FH31K-ktbK2fdocw99JYbgTWKBmy1JFFF0MffkEdzw>
Received: from localhost (unknown [118.209.42.46])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F60EE4519;
        Wed, 25 Jul 2018 01:39:58 -0400 (EDT)
Message-ID: <1532497196.2688.65.camel@themaw.net>
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
From:   Ian Kent <raven@themaw.net>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 25 Jul 2018 13:39:56 +0800
In-Reply-To: <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
         <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
         <23894.1532448035@warthog.procyon.org.uk>
         <04b05dbd-0aa4-7789-1314-52108246291a@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 11:57 -0700, Casey Schaufler wrote:
> On 7/24/2018 9:00 AM, David Howells wrote:
> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> > 
> > > >  (1) Mount topology and reconfiguration change events.
> > > 
> > > With the possibility of unprivileged mounting you're going to have to
> > > address access control on events.  If root in a user namespace mounts a
> > > filesystem you may have a case where the "real" user wouldn't want the
> > > listener to receive a notification.
> > 
> > Can you clarify who the listener is in this case?
> 
> That would be anyone with a watchpoint set.

And that process would have had the privilege to do so ...

> 
> > Note that mount topology events don't leak outside of the mount namespace
> > they're generated in.
> > 
> > That said, if you, a random user, put a watchpoint on "/" you can see the
> > mount events triggered by another random user in the same mount
> > namespace.  I
> > don't see a way to control this except by resorting to the LSM since UNIX
> > doesn't have 'notify' permission bits.
> 
> I would call that a write operation from the process that triggered
> the watchpoint to the one watching it. Like a signal. Signals have a
> rudimentary DAC policy (write only to the same UID) that could be
> your model.

I'm not sure signals are a good comparison.

They can affect a process in significant ways whereas triggering
a notification is less invasive so the security requirements
should take that into consideration.

But there is a problem here I think.

How about the case where a user name space is created or entered
without a newly created mount name space and mounts and umounts
are done, the user name space necessarily expects the table of
mounts it sees to be up to date.

But, if the methods here are used by user space, say libmount
was updated to use it, to gain the efficiency of not constantly
re-reading the proc mount table then restrictions on notifications
would mean the mount table seen in the user name space might not
be updated and would no longer be correct.

The converse is more interesting, where the user name space does
create or enter a new mount name space, then libmount would see ???,
probably not the updated mount information ... unless it opens a
new file handle to get mount update information ... a long running
daemon that uses libmount and dispenses or uses mount information
would very likely have a problem ...

The current proc file system method or providing the mount table
forces a new file handle to be opened whenever getting the mount
table so it always sees only the current mount name space mount
table.

At the very least I need to think more about this ...

> 
> > But for each event, I can associate an object label, derived from the
> > source,
> > and use f_cred on the notification queue to provide a subject label.
> 
> ... or UID or groups.
> 
> > 
> > > >  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
> > > 
> > > Here, too. If SELinux (for example) policy says you can't see
> > > anything on a filesystem you shouldn't get notifications about
> > > things that happen to that filesystem.
> > 
> > Yep.  Sounds like I need to refer that to the LSM as above.
> > 
> > It's a bit easier for specifically nominated sb sources since you might only
> > need to do the check once at sb_notify() time.  If there's a general queue
> > that all sbs contribute to, however, then things become more complicated as
> > the checks have to be done at do-we-write-into-this-queue? time.
> > 
> > > >  (3) Key/keyring changes events
> > > 
> > > And again, I should only get notifications about keys and
> > > keyrings I have access to.
> > 
> > Currently, you can only watch keys that grant you View permission, which
> > might
> > suffice.
> 
> That seems appropriate.
> 
> > > I expect that you intentionally left off
> > > 
> > >    (4) User injected events
> > > 
> > > at this point, but it's an obvious extension. That is going
> > > to require access controls (remember kdbus) so I think you'd
> > > do well to design them in now rather than have some security
> > > module hack like me come along later and "fix" it. 
> > 
> > Yeah - the thought had occurred to me, but there needs to be some way to
> > define a 'source' and a way to connect them.  Also, would you want a general
> > source that anyone can contribute through, specific sources where you have
> > to
> > directly connect or namespace-restricted sources?
> 
> My guess is that the consensus would be "Yes" to all the above.
> 
> > 
> > David
> > 
> 
> 
