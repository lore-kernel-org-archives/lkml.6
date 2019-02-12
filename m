Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F57C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591D12190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfBLSoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:44:00 -0500
Received: from foss.arm.com ([217.140.101.70]:42070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfBLSn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:43:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55107A78;
        Tue, 12 Feb 2019 10:43:59 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 641D93F575;
        Tue, 12 Feb 2019 10:43:57 -0800 (PST)
Date:   Tue, 12 Feb 2019 18:43:54 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190212184354.GC20961@fuggles.cambridge.arm.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <20190211202218.GQ4240@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211202218.GQ4240@linux.ibm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:22:18PM -0800, Paul E. McKenney wrote:
> On Mon, Feb 11, 2019 at 05:29:48PM +0000, Will Deacon wrote:
> > The "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt is vague,
> > x86-centric, out-of-date, incomplete and demonstrably incorrect in places.
> > This is largely because I/O ordering is a horrible can of worms, but also
> > because the document has stagnated as our understanding has evolved.
> > 
> > Attempt to address some of that, by rewriting the section based on
> > recent(-ish) discussions with Arnd, BenH and others. Maybe one day we'll
> > find a way to formalise this stuff, but for now let's at least try to
> > make the English easier to understand.
> > 
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Daniel Lustig <dlustig@nvidia.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Hello, Will,
> 
> The intent is to replace commit 3f305018dcf3 ("docs/memory-barriers.txt:
> Enforce heavy ordering for port I/O accesses"), correct?  Either way is
> fine, just guessing based on the conflicts when applying this one.  ;-)

Yup, I decided to abandon the old patch:

http://lkml.kernel.org/r/20190211153043.GC32385@fuggles.cambridge.arm.com

Thanks,

Will
