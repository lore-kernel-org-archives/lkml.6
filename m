Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeEOJ4w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:56:52 -0400
Received: from foss.arm.com ([217.140.101.70]:57476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752313AbeEOJ4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:56:50 -0400
Date: Tue, 15 May 2018 10:56:46 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, dave.martin@arm.com, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: Re: [PATCH 12/18] kernel: add ksys_personality()
Message-ID: <20180515095645.zrkwsvhifecghkk4@lakrids.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-13-mark.rutland@arm.com>
 <20180514120756.GA11638@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514120756.GA11638@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 05:07:56AM -0700, Christoph Hellwig wrote:
> On Mon, May 14, 2018 at 10:46:34AM +0100, Mark Rutland wrote:
> > Using this helper allows us to avoid the in-kernel call to the
> > sys_personality() syscall. The ksys_ prefix denotes that this function
> > is meant as a drop-in replacement for the syscall. In particular, it
> > uses the same calling convention as sys_personality().
> > 
> > This is necessary to enable conversion of arm64's syscall handling to
> > use pt_regs wrappers.
> 
> Plese just opencode the trivial sys_personality logic instead.

Sure, I'll make that a static inline in <linux/syscalls.h> as with
ksys_close() and friends.

Thanks,
Mark.
