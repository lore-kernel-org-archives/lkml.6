Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65775C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110D9208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Qpt+Q+6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110D9208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJFMgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 08:36:51 -0400
Received: from imap.thunk.org ([74.207.234.97]:37544 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeJFMgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 08:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eNCvdSXnHk7RGTNgGwQlTQ6cNBzhy/g+YAfKuxoR0ZE=; b=Qpt+Q+6PJeUVWyPS+YJKFGaska
        w3OMKcffOD4Xq5oCrzEKHJAtR/BHdf1SRJTKXNxIppDvwAjbmdAL9L3WvXbsCVxwQ7XfQLHIIDz//
        YYZkKXTz2qEx8jxlvPxLKmTKK9levh0Y8XATyfYSummTqKS3l+D+MoRLuenAfdbAUO/A=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g8fEm-0000Bx-0h; Sat, 06 Oct 2018 05:34:48 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B87F47A523B; Sat,  6 Oct 2018 01:34:46 -0400 (EDT)
Date:   Sat, 6 Oct 2018 01:34:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: Re: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Message-ID: <20181006053446.GA2529@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
References: <20181005231815.170433-1-joel@joelfernandes.org>
 <20181005234628.GB2548@thunk.org>
 <20181006034540.GM2674@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181006034540.GM2674@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 08:45:40PM -0700, Paul E. McKenney wrote:
> 
> Shouldn't the synchronize_rcu() precede the loop doing the kfree()
> calls?  Or am I missing something subtle?

No, that was a cut and paste error on my part.  I was removing the
rcu_read_unlock() before the kfree loop, and accidentally removed the
synchronize_rcu().  Then when I put it back, I put it back in the
right place.

The longer version:

I originally used rcu_read_lock() and rcu_read_unlock() around setting
up to_free[] --- since whatisRCU.txt didn't talk about
rcu_derefence_proctected(), just rcu_dereference() in Section 2: "What
is RCU's Core API?"   

Then when I looked at the example in Section 3, I was surprised when I
didn't see the rcu_read_[un]lock() on the updater side, and spent some
time trying to figure out how to use rcu_dereference_protected().

Then when I did the transumation from
rcu_read_lock/rcu_dereference_protected/rcu_read_unlock to
rcu_dereference_protected, I bobbled the location of
synchronize_rcu().

						- Ted

P.S.  Pedagogically, it might make sense to show an example that only
uses the RCU core API --- I assume using rcu_read_[un]lock() and
rcu_dereference() does work; it's just non-optimal, right?  --- and
then introduce the use of rcu_dereference_protected() afterwards.
