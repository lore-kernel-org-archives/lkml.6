Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B4EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7FA2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7FA2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeKPFVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:21:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:44738 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725741AbeKPFVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:21:48 -0500
Received: (qmail 5067 invoked by uid 2102); 15 Nov 2018 14:12:44 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Nov 2018 14:12:44 -0500
Date:   Thu, 15 Nov 2018 14:12:44 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Boqun Feng <boqun.feng@gmail.com>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] tools/memory-model: Refactor some RCU relations
In-Reply-To: <20181115175420.GA3227@tardis>
Message-ID: <Pine.LNX.4.44L0.1811151406580.1308-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018, Boqun Feng wrote:

> > -let rcu-rscsi = po ; rcu-rscs^-1 ; po?
> > +let rcu-gp = [Sync-rcu]		(* Compare with gp *)
> > +let rcu-rscsi = rcu-rscs^-1
> 
> Isn't it more straight-forward to use "rcu-rscs^-1" other than
> "rcu-rscsi" in the definition of "rcu-fence", is it?

It's a matter of personal preference.  I prefer to store the inverse
relation in a separate variable rather than recomputing it multiple
times.  (Maybe OCaml is smart enough to recognize when a value has 
already been computed and avoid computing it again; I don't know.)

> The introduction of "rcu-rscsi" makes sense in the first patch, but with
> this refactoring, I think it's better we just don't use it.

In the end this probably doesn't make much difference.

Alan

