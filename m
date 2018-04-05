Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeDEO5K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:57:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeDEO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:57:09 -0400
Date: Thu, 5 Apr 2018 16:56:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, parri.andrea@gmail.com,
        will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com,
        linux-kernel@vger.kernel.org,
        Steven Sistare <steven.sistare@oracle.com>,
        Pasha Tatashin <pasha.tatashin@oracle.com>
Subject: Re: Control dependency between prior load in while condition and
 later store?
Message-ID: <20180405145650.GT4043@hirez.programming.kicks-ass.net>
References: <20180405073204.GP4043@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1804051022170.1384-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1804051022170.1384-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 10:35:22AM -0400, Alan Stern wrote:
> In this example, READ_ONCE() is in fact a volatile access, so we're 
> okay.

But our documentation clearly states a control-dep can only be from a
READ_ONCE() (or something stronger), right? So we should be good
irrespectively.
