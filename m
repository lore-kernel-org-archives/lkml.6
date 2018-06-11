Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jU7sDuN5HlsFOwAAmS7hNA
	; Mon, 11 Jun 2018 13:33:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C420F607A4; Mon, 11 Jun 2018 13:33:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="TU5KGD5h"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0E67A60791;
	Mon, 11 Jun 2018 13:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E67A60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeFKNd4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:33:56 -0400
Received: from imap.thunk.org ([74.207.234.97]:56218 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932945AbeFKNdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/6VNVFlIgqB86JMIwoR/jMKFROV+4qyP15rj3t3A50c=; b=TU5KGD5hkd8QfALe3tvhK1ixxy
        rsuwM67uFK4PNqxJjByhWW1+aLVzCw0vswahGjqSSI79dSEITeFYSLf1ZpcFRJFEPL6uzdnSmoYM6
        yZ+6zG+TT79amZf/8WuZlwd/pRWjvM8qTKwHtMlewp2303JvzaM14Ew7GReAqW0jSbNw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fSMx7-0005Ua-V2; Mon, 11 Jun 2018 13:33:45 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 38CE07A63CD; Mon, 11 Jun 2018 09:33:45 -0400 (EDT)
Date: Mon, 11 Jun 2018 09:33:45 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Sandeen <sandeen@sandeen.net>,
        Eric Biggers <ebiggers3@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: Bugs involving maliciously crafted file system
Message-ID: <20180611133345.GE5020@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Eric Biggers <ebiggers3@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>
References: <20180522123107.GC3751@bfoster.bfoster>
 <20180522222620.GW23861@dastard>
 <20180522225208.GB658@sol.localdomain>
 <20180523074425.GM14384@magnolia>
 <20180523162015.GA3684@sol.localdomain>
 <a52266f9-0096-b28c-c01c-046ababcfe3a@sandeen.net>
 <20180523234114.GA3434@thunk.org>
 <CACT4Y+YEpThQj=63F8CSHeWSZxbWJ1cTDB7ZvM8OYR921uXT2g@mail.gmail.com>
 <20180526202436.GC4613@thunk.org>
 <CACT4Y+YK9LzYuVSruimbgxSAoCt_UYbHwzhvDGCqZ7FuQLcUUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YK9LzYuVSruimbgxSAoCt_UYbHwzhvDGCqZ7FuQLcUUA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 03:07:24PM +0200, Dmitry Vyukov wrote:
> 
> These can't be weaponized to execute code, but if a BUG_ON is
> triggerable over a network, or from VM guest, then it's likely more
> critical than a local code execution. That's why I am saying that
> automated evaluation is infeasible.

I can't imagine situations where a BUG_ON would be more critical than
local code execution.  You can leverage local code execution to ah
remote privilege escalation attack; and local code execution can (with
less effort) be translated to a system crash.  Hence, local code
execution is always more critical than a BUG_ON.

> Anyway, bug type (UAF, BUG, task hung) is available in the bug title
> on dashboard and on mailing lists, so you can just search/sort bugs on
> the dashboard. What other interface you want on top of this?

I also want to be able to search and filter based on subsystem, and
whether or not there is a reproducer.  Sometimes you can't even figure
out the subsytem from the limited string shown on the dashboard,
because the original string didn't include the subsystem to begin
with, or the the subsytem name was truncated and not included on the
dashboard.

> On a related note, perhaps kernel community needs to finally start
> using bugzilla for real, like with priorities, assignees, up-to-date
> statuses, no stale bugs, etc. All of this is available in bug tracking
> systems for decades...

I do use bugzilla and in fact if syzbot would automatically file a
bugzilla.kernel.org report for things that are in the ext4 subsystem,
that would be really helpful.

As far as no stale bugs, etc., many companies (including Google)
aren't capable of doing that with their own internal bug tracking
systems, because management doesn't give them enough time to track and
fix all stale bugs.  You seem to be assuming/demanding things of the
kernel community that are at least partially constrained by resource
availability --- and since you've used constrained resources as a
reason why Syzbot can't be extended as we've requested to reduce
developer toil and leverage our available resources, it would perhaps
be respectful if you also accepted that resource constraints also
exist in other areas, such as how much we can keep a fully groomed bug
tracking system.

Regards,

						- Ted
