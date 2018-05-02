Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeEBLFc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:05:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEBLFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:05:31 -0400
Date: Wed, 2 May 2018 12:05:20 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Message-ID: <20180502110441.xuvjs7gu5xir6y72@lakrids.cambridge.arm.com>
References: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
 <15c56137-e7c4-dbfa-ce5d-f5feeea79e98@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c56137-e7c4-dbfa-ce5d-f5feeea79e98@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 11:00:55AM +0200, Laurent Dufour wrote:
> On 02/05/2018 09:54, Ganesh Mahendran wrote:
> > Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
> > enables Speculative Page Fault handler.
> > 
> > Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> > ---
> > This patch is on top of Laurent's v10 spf
> > ---
> >  arch/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index eb2cf49..cd583a9 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -144,6 +144,7 @@ config ARM64
> >  	select SPARSE_IRQ
> >  	select SYSCTL_EXCEPTION_TRACE
> >  	select THREAD_INFO_IN_TASK
> > +	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT if SMP
> 
> There is no need to depend on SMP here as the upper
> CONFIG_SPECULATIVE_PAGE_FAULT is depending on SMP.

Additionally, since commit:

  4b3dc9679cf77933 ("arm64: force CONFIG_SMP=y and remove redundant #ifdefs")

... arm64 is always SMP.

Thanks,
Mark.
