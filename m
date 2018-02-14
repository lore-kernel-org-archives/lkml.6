Return-Path: <jcrouse@codeaurora.org>
X-Google-Smtp-Source: AH8x224f+okn33Ctu9/iM/EImTsS6vYkAmuzMMNr1i0lED9MzfSQX4pzTPLKnDNfXZOjBkXPtLg4
ARC-Seal: i=1; a=rsa-sha256; t=1518623335; cv=none;
        d=google.com; s=arc-20160816;
        b=gMGFuSUdNE6lzdTuB19ikPQ4zIPjSojXujoOqGBWe1xRiG4HzVDMzd3zrNw7qgsO8c
         kgvrTMV+6FDvSNm7N8Vbok7J3V6MjR7NzQHClFd65lrg+b70/W/BDtGYlx5v30ctbzpC
         KNUIMxZBqDhaUjpvT9EplIrRmseQ0e817JRZbp6XPr9KrduxN7U8Q88FjJd5E3hIghMg
         B2Nmj0ZCRO6+KMgZne7ojLLmJqkVIO/EE4q1UBZmbUmIYbQz106jCAjXOJfFXeVefLl4
         oA7vcstoUcwpIe7WpcKjcW16VhRrd1SjF82mY6c7B1KxAg1lGtzWN8OtZjJ+pKGHRctC
         WJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=nL2/btvM8mnCT9rf8p2aN/OSrSsV7918KM19CwcFzFM=;
        b=u2p6y9CAOoyFU67jm0skSzJ+HCqso2uw3gCTxGvICty1439XdIUq8kQbYiC3fgY/j1
         mY4PsMCMPLv7x59VQvMb7fduyopwmwOKIuK+DV9iPLD6k+DbDXKcmCvYmVkvsbDB6vnr
         XaArHKrZMJh2ioA6R50kbTJ+nuOsekKjAme5XqxEyDieV/TDO+ZIzRgUSrhEwGFsfRYp
         flchpfhAJDotL4ERKm2BCuWbubq/ut1oz4/CUsLMMcFvAEahs1SDXLh0DxW2sIFgSxmJ
         TH5aW5a/EQobSOq+b+2qTFSQd+y/VYzjLY0T/YiQyY9hElL29wtlOsWIlYCiLfsvL2S3
         h6sA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=S3ZOVNXC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PMyGKSyN;
       spf=pass (google.com: domain of jcrouse@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=jcrouse@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=S3ZOVNXC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=PMyGKSyN;
       spf=pass (google.com: domain of jcrouse@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=jcrouse@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C42F4608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Wed, 14 Feb 2018 08:48:50 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with
 runtime suppliers
Message-ID: <20180214154850.GA25422@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Tomasz Figa <tfiga@chromium.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <20180213164205.GA7599@jcrouse-lnx.qualcomm.com>
 <CAAFQd5CjQRFATfh-mRQv5J=WefYuxBVTkk=Ju09FoqA-Or5Cvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5CjQRFATfh-mRQv5J=WefYuxBVTkk=Ju09FoqA-Or5Cvg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1592391983066477989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 12:31:29PM +0900, Tomasz Figa wrote:
> Hi Jordan,
> 
> On Wed, Feb 14, 2018 at 1:42 AM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > On Tue, Feb 13, 2018 at 06:10:38PM +0900, Tomasz Figa wrote:
> >> Hi Vivek,
> >>
> >> Thanks for the patch. Please see my comments inline.
> >>
> >> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> >> <vivek.gautam@codeaurora.org> wrote:
> >> > While handling the concerned iommu, there should not be a
> >> > need to power control the drm devices from iommu interface.
> >> > If these drm devices need to be powered around this time,
> >> > the respective drivers should take care of this.
> >> >
> >> > Replace the pm_runtime_get/put_sync(<drm_device>) with
> >> > pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
> >> > the connected iommu through the device link interface.
> >> > In case the device link is not setup these get/put_suppliers()
> >> > calls will be a no-op, and the iommu driver should take care of
> >> > powering on its devices accordingly.
> >> >
> >> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >> > ---
> >> >  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
> >> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> >> > index b23d33622f37..1ab629bbee69 100644
> >> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> >> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> >> > @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
> >> >         struct msm_iommu *iommu = to_msm_iommu(mmu);
> >> >         int ret;
> >> >
> >> > -       pm_runtime_get_sync(mmu->dev);
> >> > +       pm_runtime_get_suppliers(mmu->dev);
> >> >         ret = iommu_attach_device(iommu->domain, mmu->dev);
> >> > -       pm_runtime_put_sync(mmu->dev);
> >> > +       pm_runtime_put_suppliers(mmu->dev);
> >>
> >> For me, it looks like a wrong place to handle runtime PM of IOMMU
> >> here. iommu_attach_device() calls into IOMMU driver's attach_device()
> >> callback and that's where necessary runtime PM gets should happen, if
> >> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
> >> with power state of device controlled by driver B (ARM SMMU).
> >
> > This whole thing is confused by the fact that on MSM the GPU and the GPU IOMMU
> > share some of the same clocks and power rail so turning on the GPU also
> > turned on the IOMMU register banks by extension.
> 
> This is surprisingly not a very surprising case. Exactly the same can
> be seen on Rockchip SoCs and we're solving the problem using the
> solution I suggested. In fact, my suggestions to this thread are based
> on the design we chose for Rockchip, due to the high level of
> similarity (+/- the GPU directly programming IOMMU registers, which is
> not present there, but AFAICT it doesn't pose a problem here).
> 
> >
> > But if we put that aside the question is who should be responsible for
> > controlling the power in this relationship and there are several good reasons to
> > leave it up to the client device. The most important reason is when we move to
> > the per-instance model where the GPU self-programmings the SMMU registers. In
> > that case, the driver will need to make sure that the SMMU is powered up before
> > submitting the command and then removing the power vote when the commands
> > are done to save energy.
> 
> I might need more insight on what's going on in your hardware, but
> with my current understanding I'd argue that that is not right,
> because:
> 
> - When submitting commands to the GPU, the GPU driver will
> pm_runtime_get_sync() on the GPU device, which will automatically do
> the same on all the linked suppliers, which would also include the
> SMMU itself. The role of device links here is exactly that the GPU
> driver doesn't have to care which other devices need to be brought up.

This is true.  Assuming that the device link works correctly we would not need
to explicitly power the SMMU which makes my point entirely moot.

> - When the GPU is operating, the SMMU power must be supplied anyway,
> because it needs to be doing the translations, right? Note that by
> "power" I really mean the physical power supply in the SoC, e.g. as
> for a power domain. The runtime PM API in its current form (e.g.
> binary off or on operation) is unsuitable for managing other things,
> such as clocks (and there is ongoing work on improving it, e.g. by
> adding support for multiple power states).

As others have pointed out, the register banks and the translation unit are
powered separately (or at least, clocked separately).

>    ^^ The above would be actually guaranteed by your hardware design,
> where SMMU and GPU share the power domain and clocks. (We used to rely
> on this in old downstream implementation of Rockchip IOMMU and master
> drivers in Chromium OS kernel, before we moved to handling the clocks
> explicitly in the IOMMU driver and properly using device links to
> manage the power domain and state restoration.)

I wouldn't call it a guarantee. I would instead say that it works by a happy
coincidence that I don't think we should depend on.

> >
> > Additionally, there might be legitimate reasons in the driver to batch
> > operations - you may wish to attach the device and then map several global
> > buffers immediately - having driver side control prevents several unneeded power
> > transitions.
> 
> As I mentioned before, these operations wouldn't normally need any
> power transitions, since mapping with the TLB powered down boils down
> to just updating the page tables in memory. However, as Robin
> mentioned before, there might be some hardware factors, such as TLB
> being powered separately (or retaining contents in some other way),
> where this wouldn't be ensured indeed.
> 
> Still, that's where runtime PM autosuspend feature (i.e. delayed
> suspend) comes to the rescue, with the advantage of handling the cases
> when the master driver receives map/unmap requests not batched (but
> maybe a slight drawback in terms of the suspend not happening
> instantly and losing some power, but it's about power domains, so
> mainly leakage current, isn't it?)

> >
> > Perhaps the right answer is to do both - allow for the driver to enable the
> > supplier but also do the right power operations at the appropriately places in
> > the IOMMU driver.
> >
> >> This is also important for the reasons I stated in my comments to
> >> "[PATCH v7 1/6] base: power: runtime: Export
> >> pm_runtime_get/put_suppliers". Quoting for everyone's convenience:
> >>
> >> >> There are however cases in which the consumer wants to power-on
> >> >> the supplier, but not itself.
> >> >> E.g., A Graphics or multimedia driver wants to power-on the SMMU
> >> >> to unmap a buffer and finish the TLB operations without powering
> >> >> on itself.
> >> >
> >> >This sounds strange to me. If the SMMU is powered down, wouldn't the
> >> >TLB lose its contents as well (and so no flushing needed)?
> >> >
> >
> >> >Other than that, what kind of hardware operations would be needed
> >> >besides just updating the page tables from the CPU?
> >> >
> >
> >> In other words, the SMMU driver can deal with hardware state based on
> >> return value of pm_runtime_get_sync() or pm_runtime_get_if_in_use()
> >> and decide whether some operations are necessary or not, e.g.
> >> - a state restore is necessary if the domain was powered off, but we
> >> are bringing the master on,
> >> - a flush may not be required when (un)mapping with the domain powered off,
> >> - etc.
> >
> > I agree that there is probably some advanced logic that we can do to
> > conclusively figure out the state of the hardware and improve the behavior.
> > I would love to see the SMMU driver get smarter but for the moment we can't
> > trust it and so we need to force the behavior from the GPU driver. The current
> > code works for a5x and earlier but on sdm845 we can (no longer) treat the GPU
> > and the SMMU as the same device for power purposes so we need this code.
> 
> Hmm, you've lost me there. Above you  mention that "on MSM the GPU and
> the GPU IOMMU share some of the same clocks and power rail". Is this
> no longer the case for sdm845? If so, would you mind shedding a bit
> more light on how this looks there?

Sure. I've sent out the code, but it can be confusing, so I'll try to explain it
a little better.

On a5xx and earlier the GPU power/clocks were directly controlled by the CPU so
the pm resume consisted of a handful of clock controls plus the domain(s)
controlled by genpd. 

Starting on sdm845 we have added a new integrated microcontroller called the GMU
which takes over power control for the GPU. The GMU runs in real time and it
can bring the GPU power up and down very quickly - even quickly enough to
collapse between frames. If done right this can save significant leakage.

The problem is of course that the GMU is a fully featured processor in its own
right so its not longer a matter of just turning on clocks and rails.
We need to boot it, load the microcode, establish IPC and so on. As you
imagine,the GMU also uses the SMMU to share code with the CPU.

The kicker is that the while SMMU and GPU share common clocks, the GMU does not
and since from the perspective of the CPU the only device that we control is the
GMU and we have to treat the SMMU as a truly separate device and thats how we
get to where we are.

But as you said, as long as we have the device link correctly set up, I think we
might just be able to get away with depending on the supplier chain working
during pm resume.  I'll test it out today and see how it goes.

Thanks,
Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
