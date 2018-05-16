Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEPSAs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:00:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750759AbeEPSAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:00:47 -0400
Date: Wed, 16 May 2018 20:01:38 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180516180138.GB5486@asgard.redhat.com>
References: <20180406160541.GA28094@ziepe.ca>
 <20180516173908.GA21169@asgard.redhat.com>
 <20180516174933.GN25675@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516174933.GN25675@mellanox.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 11:49:33AM -0600, Jason Gunthorpe wrote:
> On Wed, May 16, 2018 at 07:39:08PM +0200, Eugene Syromiatnikov wrote:
> > On Fri, Apr 06, 2018 at 10:05:41AM -0600, Jason Gunthorpe wrote:
> > >       RDMA: Change all uapi headers to use __aligned_u64 instead of __u64
> > Looks like this change changed the size of struct hfi1_ctxt_info and the
> > value of HFI1_IOCTL_CTXT_INFO ioctl number as a result.
> 
> Only on 32 bit..
> 
> HF1 does not build on 32 bit kernels, so the 32 bit version of the
> ioctl is never supported.
> 
> HFI1 also does not define '.compat_ioctl' so even a 32 bit user space
> on 64 bit kernel cannot call this ioctl.
> 
> So, yes it changed, but it doesn't matter.
> 
> > >       IB/uverbs: Extend uverbs_ioctl header with driver_id
> > This patch changed the value of the RDMA_VERBS_IOCTL ioctl number.
> > 
> > (see https://lists.strace.io/pipermail/strace-devel/2018-May/008196.html
> > for the reference)
> 
> Yes.
> 
> RDMA_VERBS_IOCTL has been considered experimental and was protected by
> a CONFIG option.
> 
> After the above commit the experimental was dropped and the ABI was
> fixed, but prior to doing so, the struct was revised based on
> feedback.
> 
> There is no userspace user of the old struct, only the new struct.
> 
> Basically from strace's perspective it should use the new ioctl #'s
> across all kernel revs and it will be correct as there is no user
> space that will issue the old ioctls.

Got it, thanks for the clarification!
