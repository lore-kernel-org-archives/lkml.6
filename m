Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeBAJjD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:39:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52238 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeBAJjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:39:01 -0500
Date: Thu, 1 Feb 2018 10:38:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] x86: Align TLB invalidation info
Message-ID: <20180201093847.GZ2269@hirez.programming.kicks-ass.net>
References: <20180131201118.1694-1-namit@vmware.com>
 <8bb352bc-4e1f-4e87-80e3-a8e65d618d2a@linux.intel.com>
 <0E65629C-0D7D-4602-A43D-B18E62F330A6@gmail.com>
 <f7270e0d-d1d1-599d-d2c9-ddc2c263e090@linux.intel.com>
 <DBF48795-2F4B-4C65-A5DD-A78D2214DF9B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBF48795-2F4B-4C65-A5DD-A78D2214DF9B@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 09:38:46PM -0800, Nadav Amit wrote:

> I used ftrace to measure the execution time of flush_tlb_func_remote() on a
> 2-socket Haswell machine, using a microbenchmark I wrote for some research
> project.

However cool ftrace is, it is _really_ bad for such uses. The cost of
using ftrace is many many time higher than any change you could affect
by this.

A microbench and/or perf is what you should use for this.
