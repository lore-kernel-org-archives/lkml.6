Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDEPQC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:16:02 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55658 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751038AbeDEPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:16:02 -0400
Date: Thu, 5 Apr 2018 11:16:00 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Peter Zijlstra <peterz@infradead.org>
cc: Daniel Jordan <daniel.m.jordan@oracle.com>, <parri.andrea@gmail.com>,
        <will.deacon@arm.com>, <boqun.feng@gmail.com>, <npiggin@gmail.com>,
        <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>,
        <paulmck@linux.vnet.ibm.com>, <akiyks@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Pasha Tatashin <pasha.tatashin@oracle.com>
Subject: Re: Control dependency between prior load in while condition and
 later store?
In-Reply-To: <20180405145650.GT4043@hirez.programming.kicks-ass.net>
Message-ID: <Pine.LNX.4.44L0.1804051114200.1292-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Apr 2018, Peter Zijlstra wrote:

> On Thu, Apr 05, 2018 at 10:35:22AM -0400, Alan Stern wrote:
> > In this example, READ_ONCE() is in fact a volatile access, so we're 
> > okay.
> 
> But our documentation clearly states a control-dep can only be from a
> READ_ONCE() (or something stronger), right? So we should be good
> irrespectively.

Agreed.  My point was that these are delicate issues.  (And they will 
become more relevant when we want to expand the Linux Kernel Memory 
Consistency Model to cover ordinary accesses and data races.)

Alan
