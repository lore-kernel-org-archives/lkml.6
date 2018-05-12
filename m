Date: Sat, 12 May 2018 16:15:22 +0200
From: Greg KH <greg@kroah.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will.deacon@arm.com, mark.rutland@arm.com
Subject: Re: [PATCH] [stable 4.9] arm64: Add work around for Arm Cortex-A55
 Erratum 1024718
Message-ID: <20180512141522.GE6591@kroah.com>
References: <1526046675-23790-1-git-send-email-suzuki.poulose@arm.com>
 <20180511154721.GC17038@kroah.com>
 <843d0226-f715-6a09-276f-ef14d5a06185@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <843d0226-f715-6a09-276f-ef14d5a06185@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 05:06:20PM +0100, Suzuki K Poulose wrote:
> On 11/05/18 16:47, Greg KH wrote:
> > On Fri, May 11, 2018 at 02:51:15PM +0100, Suzuki K Poulose wrote:
> > > commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream
> > > 
> > > Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
> > > from an erratum 1024718, which causes incorrect updates when DBM/AP
> > > bits in a page table entry is modified without a break-before-make
> > > sequence. The work around is to disable the hardware DBM feature
> > > on the affected cores. The hardware Access Flag management features
> > > is not affected.
> > > 
> > > The hardware DBM feature is a non-conflicting capability, i.e, the
> > > kernel could handle cores using the feature and those without having
> > > the features running at the same time. So this work around is detected
> > > at early boot time, rather than delaying it until the CPUs are brought
> > > up into the kernel with MMU turned on. This also avoids other complexities
> > > with late CPUs turning online, with or without the hardware DBM features.
> > > 
> > > Cc: stable@vger.kernel.org # v4.9
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > > Note: The upstream commit is on top of a reworked capability
> > > infrastructure for arm64 heterogeneous systems, which allows
> > > delaying the CPU model checks. This backport is based on the
> > > original version of the patch [0], which checks the affected
> > > CPU models during the early boot.
> > > 
> > > [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose@arm.com
> > 
> > Now applied, thanks.
> 
> Greg,
> 
> I have the backport for v4.4 ready. But it needs to cherry-pick a commit
> (commit 30b5ba5cf33 : arm64: introduce mov_q macro to move a constant into a 64-bit register)
> which adds the assembly helper and that seems to result in a conflict with
> an obvious resolution. What do you prefer in this case ?
> 
> 1) Go ahead with the cherry-pick

Have 2 patches, the first be the cherry pick and the second be your
backported other patch.  I almost always want the original patches that
are in Linus's tree, otherwise we always get the
merging/squashing/rewrite wrong.

thanks,

greg k-h
