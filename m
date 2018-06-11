Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UO91FtvOHVveLQAAmS7hNA
	; Mon, 11 Jun 2018 01:23:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9713860792; Mon, 11 Jun 2018 01:23:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Zlmft24Z"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B5CA4601D2;
	Mon, 11 Jun 2018 01:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5CA4601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeFKBXG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 21:23:06 -0400
Received: from imap.thunk.org ([74.207.234.97]:54548 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753736AbeFKBXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 21:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FPfFGvk7znywbS2Zm0uSjx7LHVcTK7j5Z5rBOBR0ZDo=; b=Zlmft24Zt2nHZXr6w7u7O1xtV/
        452lGxqR91nqclm8LXtNf4CXyp5J9321XUgpi/CZeEZUTh0zDsJIaZKsBXOYHYBmFUpnHixKMuI2n
        pOWp7l7ScHiF1QTeGm2QS1Akx4UZu3+DijF40eA5QvlcHqxharGcaozfv1AohzcWCWR4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fSBXn-0002uS-7q; Mon, 11 Jun 2018 01:22:51 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5D5017A4474; Sun, 10 Jun 2018 21:22:50 -0400 (EDT)
Date: Sun, 10 Jun 2018 21:22:50 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: what trees/branches to test on syzbot
Message-ID: <20180611012250.GD5020@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Guenter Roeck <groeck@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Wu Fengguang <fengguang.wu@intel.com>
References: <CACT4Y+bvA6hrVT5u-Cy_zJLNTM5SYf9kt+sXYmfq13rPGfiqFQ@mail.gmail.com>
 <CABXOdTf+CoB6EkhG1yPtB4NNtohbex=ebHLX7YW5TyQQGn9byw@mail.gmail.com>
 <CACT4Y+aGMoobn069+Lq1BT2YGqi9qYY9vHFtiXT2DLsJ5ZUh9Q@mail.gmail.com>
 <873735n3dy.fsf@xmission.com>
 <20180116173440.GA15893@kroah.com>
 <CACT4Y+Yy4YZG54xXfR1QNM0i8aS66BZyCnaD2YuooYo2sGuSLg@mail.gmail.com>
 <81a0eb59-c204-9e36-13b7-88c2ea99ceab@I-love.SAKURA.ne.jp>
 <CA+55aFzJaHyKBg_PTS85Y5RxUsQEerJ_Lc5HY1dd1YNztf==Wg@mail.gmail.com>
 <20180610015107.GC5020@thunk.org>
 <CACT4Y+Z-+5XhmyVcLjEf6531GKC-b+JL9kes-vjWF5PXJNvqrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z-+5XhmyVcLjEf6531GKC-b+JL9kes-vjWF5PXJNvqrw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 08:11:05AM +0200, Dmitry Vyukov wrote:
> 
> The set of trees where a crash happened is visible on dashboard, so
> one can see if it's only linux-next or whole set of trees. Potentially
> syzbot can act differently depending on this predicate, but I don't
> see what should be the difference.  However, this does not fully save
> from falsely assessing bugs as linux-next-only just because they
> happened few times and only on linux-next so far.

So how about this, only report something as being a linux-next
regression if (a) there is a reproducer, and (b) the reproducer does
not trigger any kind of crash on mainline?

> There is also a problem with rebasing of linux-next: reported commit
> hashes do not make sense and we can forget about bisection.

If there is a valid reproducer, bisection should simply be a matter ofu
running and if we know the reproducer doesn't trigger on mainline,
then the bisection should only require no more than 8-10 VM runs.  For
Linux-next, this would be *super* valuable.  Reporting the commit ID
and the one-line commit summary will be enough for most maintainers,
since even if they are using a rewinding head, so long as the
bisection can be done quickly enough (e.g., within a few days), it
will still be in their git repository.

And if you have a reproducer, then once it's identified as a
linux-next reproducer with a guilty commit, that can be confirmed by
either (a) seeing if you can revert the commit and if it makes the
problem go away, or (b) figure out which subsystem git tree the commit
was introduced via, and then verify that the reproducer triggers on
the tip of the subsystem git tree.

All of this will require development effort, so I suspect it's not
something we'll see from syzbot tomorrow --- but it's not
*impossible*.

I think though that sending e-mail about a linux-next syzbot crash if
there is a reproducer and the reproducer doesn't trigger a crash on
mainline should be really simple to implement, and it would add huge
value without spamming the subsystem maintainers.

					- Ted
