Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeCGI5Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:57:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeCGI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:57:15 -0500
Date: Wed, 7 Mar 2018 09:57:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com
Subject: Re: [RFC 3/4] trace_uprobe: Support SDT markers having semaphore
Message-ID: <20180307085705.GL25181@hirez.programming.kicks-ass.net>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228075345.674-4-ravi.bangoria@linux.vnet.ibm.com>
 <20180306115921.GD25201@hirez.programming.kicks-ass.net>
 <3a0f9efd-158e-08ba-ae01-38391f580133@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0f9efd-158e-08ba-ae01-38391f580133@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 02:16:13PM +0530, Ravi Bangoria wrote:
> > W.T.H. is that called a semaphore? afaict its just a usage-counter.
> 
> I totally agree with you. But it's not me who named it semaphore :)
> 
> Please refer to "Semaphore Handling" section at:
> https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> 
> We can surly name it differently in the kernel code and document it
> properly in the Documents/tracing/

Yes, just because the SDT people failed their CS101 class doesn't mean
we need to perpetuate that failure. Please name it sensibly in our code.

> > Also, would it not be much better to do userspace jump-labels for this?
> > That completely avoids the dynamic branch at the SDT site.
> >
> 
> Userspace jump-label is a good idea but...
> 
> Semaphore logic has already became a kinda ABI now. Tools like bcc,
> gdb, systemtap etc. flip the semaphore while probing the marker.

*groan*.. maybe suggest it for the next version; it appears we're
already at SDTv3, so surely there will be a v4 too.
