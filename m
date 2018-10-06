Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD07ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80786208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="G2fhd4zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80786208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbeJGFwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 01:52:40 -0400
Received: from imap.thunk.org ([74.207.234.97]:43430 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbeJGFwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 01:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NZBjo2aGfpTjJRn918klV4zqOc8QA4M8zsX7haRhh2k=; b=G2fhd4zhcsvxg0xVJYL4q2mMqP
        wOwexAbxrp9LMg1xBlUwLhVjvREw6Z/JMjtUVcWY0ratjd0JpJ93lWZ0ysd0U7tQD1anXGTfDro8I
        od2epYH3gDBBPhtWz5DOCNHiaoL4IZbKdkVcILHSCcj2Op9xqs51v9OtG+ypM0vpj3o8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g8vMB-0004hI-2K; Sat, 06 Oct 2018 22:47:31 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 08A247A5240; Sat,  6 Oct 2018 18:47:30 -0400 (EDT)
Date:   Sat, 6 Oct 2018 18:47:29 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: Re: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Message-ID: <20181006224729.GA7130@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
References: <20181005231815.170433-1-joel@joelfernandes.org>
 <20181005234628.GB2548@thunk.org>
 <20181006034540.GM2674@linux.ibm.com>
 <20181006044057.GA41279@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006044057.GA41279@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 09:40:57PM -0700, Joel Fernandes wrote:
> 
> Could you annotate this pointer (sbi->s_qf_names) with __rcu so it can be
> checked by sparse for proper usage? Its also point #16 in the checklist.txt
> RCU document. I enclosed a diff to do this below.

Sure.

> I also saw a bunch of places in super.c where the pointer isn't accessed from
> an rcu read section or rcu_dereference, but it was a quick look so sorry if I
> missed something. If its true, then are you planning to convert these to use
> rcu_dereference and wrapped by an rcu_read_lock/unlock as well?

These are places where we are holding s_umount, so there's no way
s_qf_names can change out from under us.  So the conversion should be
to use rcu_dereference_protected().

> > +		to_free[i] = rcu_dereference_protected(sbi->s_qf_names[i],
> > +						       &sb->s_umount);
> 
> Also should this be the following?
> 		to_free[i] = rcu_dereference_protected(sbi->s_qf_names[i],
> 					       lockdep_is_held(&sb->s_umount));

Yep, good catch, thanks.

						- Ted
