Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3E6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B3D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B3D20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeKUWOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:14:38 -0500
Received: from foss.arm.com ([217.140.101.70]:47938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeKUWOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:14:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7083515;
        Wed, 21 Nov 2018 03:40:34 -0800 (PST)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1203E3F5A0;
        Wed, 21 Nov 2018 03:40:31 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:40:29 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, will.deacon@arm.com,
        linux-tip-commits@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [tip:locking/core] locking/atomics: Check generated headers are
 up-to-date
Message-ID: <20181121114028.iiuleuwuayednvut@salmiak>
References: <20180904104830.2975-6-mark.rutland@arm.com>
 <tip-8d32588077bdc390420cfa6946f407033a20d7a8@git.kernel.org>
 <20181121080258.GA56691@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121080258.GA56691@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Wed, Nov 21, 2018 at 09:02:58AM +0100, Ingo Molnar wrote:
> 
> * tip-bot for Mark Rutland <tipbot@zytor.com> wrote:
> 
> > Commit-ID:  8d32588077bdc390420cfa6946f407033a20d7a8
> > Gitweb:     https://git.kernel.org/tip/8d32588077bdc390420cfa6946f407033a20d7a8
> > Author:     Mark Rutland <mark.rutland@arm.com>
> > AuthorDate: Tue, 4 Sep 2018 11:48:29 +0100
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Thu, 1 Nov 2018 11:01:10 +0100
> > 
> > locking/atomics: Check generated headers are up-to-date
> > 
> > Now that all the generated atomic headers are in place, it would be good
> > to ensure that:
> > 
> > a) the headers are up-to-date when scripting changes.
> > 
> > b) developers don't directly modify the generated headers.
> > 
> > To ensure both of these properties, let's add a Kbuild step to check
> > that the generated headers are up-to-date.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: catalin.marinas@arm.com
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linuxdrivers@attotech.com
> > Cc: dvyukov@google.com
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: arnd@arndb.de
> > Cc: aryabinin@virtuozzo.com
> > Cc: glider@google.com
> > Link: http://lkml.kernel.org/r/20180904104830.2975-6-mark.rutland@arm.com
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  Kbuild                          | 18 ++++++++++++++++--
> >  scripts/atomic/check-atomics.sh | 19 +++++++++++++++++++
> >  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> These scripts are *awfully* slow to be run at every kernel build - even a 
> reasonably fast machine:

Andrew also reported this, and I'm trying to figure out what to do.

I looked into optimizing the scripts, but that turned out to be a dead end.
The majority of the cost is in the fork() etc for sub-shells, which the scripts
make heavy use of to capture string return values. Trying to avoid sub-shells
rendered the scripts unreadable.

> Could we please get this fixed so that proper dependencies are checked 
> and it's only regenerated when needed? This slowdown makes additive-build 
> kernel development quite painful, as ~5 seconds is in the 'too long' 
> category already, while 1.2 seconds is basically instantaneous.

Just to check, are we happy to eat the full cost for the first build of a
pristine tree?

One reason we do the check rather than (re-)generating the headers is that
Linus requested [1] the generated header be committed so that they show up in
git grep, but it looks like he was happy to be flexible on that.

If we're happy to not commit in the generated headers, and if we're happy to
pay the cost for a pristine tree, that's fairly straightforward to do.
Otherwise, this has to be an optional check.

Thoughts?

Thanks,
Mark.

[1] https://lkml.kernel.org/r/CA+55aFxjU0op8QLLu0n-RjHBs7gQsLvD8jcyedgw6jeZFN7B+Q@mail.gmail.com
