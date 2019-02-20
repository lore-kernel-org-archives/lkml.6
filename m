Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A94C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3844020880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfBTPac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:30:32 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:48632 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726627AbfBTPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:30:32 -0500
Received: (qmail 3094 invoked by uid 2102); 20 Feb 2019 10:30:31 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2019 10:30:31 -0500
Date:   Wed, 20 Feb 2019 10:30:31 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Will Deacon <will.deacon@arm.com>
cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
In-Reply-To: <20190220134106.GA7523@fuggles.cambridge.arm.com>
Message-ID: <Pine.LNX.4.44L0.1902201028400.1589-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019, Will Deacon wrote:

> Whilst I completely agree that relying on the ordering provided by "dep ;
> rfi" is subtle and error prone, having it forbid the outcome above appeals
> to a hardware-based mindset of how memory ordering works. In the kernel
> community, I would posit that the majority of developers are writing code
> with the underlying hardware in mind and so allowing behaviours in the
> memory model which are counter to how a real machine operates is likely to
> make things more confusing, rather than simplifying them!
> 
> IIRC, herd has a feature where you can "flag" the result of a litmus test
> to highlight certain internal constraint violations (e.g. warning that a
> data race is present in a concurrent C11 program). How about we preserve
> the existing semantics, but flag any use of "dep; rfi" to indicate that
> the ordering guarantees being relied upon are subtle and error-prone, and
> therefore should only be considered for fast-path code?

Unfortunately, herd can't really tell whether a particular ordering is 
being _used_; it can only tell when the ordering is present.  Therefore 
such a flag would be prone to false positives.

Alan

