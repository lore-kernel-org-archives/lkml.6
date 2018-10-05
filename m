Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B222E208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="g5AM9pTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B222E208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeJFGri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:47:38 -0400
Received: from imap.thunk.org ([74.207.234.97]:34918 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbeJFGri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T8FQ87fMp5GojQ36irhU2jJohsZXo68+DssC+p+hm5Y=; b=g5AM9pTOJLMJJRrpo2NMETCNGV
        s3LXZvcUQW3sZbW62lQkaXA0+dX+zcxH1Nev4CL0LcKG1IiBKI120piZDYLE+I7ElDHzOil9VuT93
        inG6QDAV2GrwnM8yrJDC9fv0vDT5GKiVVbAVxy2pe3dOE5mAwwglvvlOFCWD07HkXVmM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g8Znh-0006HE-31; Fri, 05 Oct 2018 23:46:29 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 588AB7A523F; Fri,  5 Oct 2018 19:46:28 -0400 (EDT)
Date:   Fri, 5 Oct 2018 19:46:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: Re: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Message-ID: <20181005234628.GB2548@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
References: <20181005231815.170433-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005231815.170433-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 04:18:09PM -0700, Joel Fernandes (Google) wrote:
> 
> Here are this week's rcu doc updates based on combing through whatisRCU and
> checklists. Hopefully you agree with them. I left several old _bh and _sched
> API references as is, since I don't think its a good idea to remove them till
> the APIs themselves are removed, however I did remove several of them as well
> (like in the first patch in this series) since I feel its better to "encourage"
> new users not to use the old API.

Hi Joel,

As it so happens, I just recently wrote my first RCU patch[1] (file
systems, especially on-disk data structures, generally tend not to be
good candidates for RCU semantics).

[1] http://patchwork.ozlabs.org/patch/979779/

So if you are working on improving RCU documentation, I thought I
would give two comments on the RCU docs from the perspective of a
developer trying to use RCU for the first time.

* whatisRCU is great, but one the example in Section 3 uses
  rcu_dereference_protected() without explaining it.  Given that using
  that function seems to be considered best practice, maybe a few more
  words there would be in order?  That function isn't mentioned in
  rcu.txt either, BTW.

* lockdep.txt *does* explain what rcu_dereference_protected() does,
  but it doesn't really describe lockdep_is_held().  You can mostly
  figure it out from context, but it wasn't obvious to me what locks
  it could be used against, and in the case of a rw_semaphore, whether
  it applied to shared as well as exclusive locks.  That's a lockdep
  abstraction, and not a RCU abstraction, but lockdep isn't
  particularly well documented, so I ended up spending 20-30 minutes
  or so looking at the lockdep implementation before I was sure it
  actually worked the way I thought it was going to.

Anyway, I was going to put submitting a patch to improve whatisRCU on
my (vastly over-long) TODO list, but when I saw your patch set, I
couldn't resist trying to see if I could fob it off on you.  If you
don't think that's fair (and it probably isn't really), just let me
know, and I'll put it back on my todo list.  :-)

Cheers,

					- Ted
