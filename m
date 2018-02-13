Return-Path: <jcrouse@codeaurora.org>
X-Google-Smtp-Source: AH8x226HM66R00EMhLSpd1YIEGvPSijqwWm1MTDgrlwxe7TWDROfd8i3ndYdapj75szqVt4ukrOj
ARC-Seal: i=1; a=rsa-sha256; t=1518540129; cv=none;
        d=google.com; s=arc-20160816;
        b=P75qN2jQ5Hz2+yc4I2NGTVNM0Ro41c/87cwLUt1liuuZp1isrE9H9pJw20A6kwsAr9
         CXGibKWFIUGijfY9M9gWr7nr2/kZg8avLBONxhBKbaKSdMrKHM3d5NLe4nOEr+TsWeSB
         WdgGSGQC6cvbuGZtcHAYZUxEsfvsWn/JdmOksgxCPSUF/d/WIOPDPMosSRchB6h6p1y2
         w4YKkdYlIiScWJjA4m8S/xfCAzEQGiWyHZ9JODHYkwukybfUiX0Ssyp69EWxJagsznuW
         g1Wd3IlN8j2BYjgYfDSzJMs9K6w9KaRbGm0Ou1IFvqc9zcC1fu1ZeolqtSmShCgxZKU6
         DBPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=urH3thVpLxkMmpRTeH5QSBPkobKjUurfZn/5TYIK1xQ=;
        b=kQdP/gvI4xgW810rA9o4FI05MzH3CHBlyOihosCCObLy6igchCJeyoQGW4n9JP6T7G
         KpKzRwSZVgRZU0D9smr6IPyyE58KzlaR6SAPQ2WrVvZzEPtREf0+d9lIpn6W289Xsr8C
         ErF/Yt8/Vq+3iZ8TxRQVkzgn5GPZCX388EQLrBKVzgzVqyLneSPWGNbrrzIa/hzS61S7
         Tc+Rf8BsF0Tcgn0YEcHUjMWJ/aieddV2Df6ncY105TeijCEZU3FcgOdpAh7qXaf928TC
         nP3wwooNl5A+uF6QjH9M4ArLEq2tGRhhCAus2mX5lcIm4NHQA1XFcRq5npDckzGDE4co
         fmOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ni5FW66x;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=laQnbadK;
       spf=pass (google.com: domain of jcrouse@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=jcrouse@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ni5FW66x;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=laQnbadK;
       spf=pass (google.com: domain of jcrouse@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=jcrouse@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67EC360F6B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Tue, 13 Feb 2018 09:42:05 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Tomasz Figa <tfiga@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	freedreno@lists.freedesktop.org,
	Robin Murphy <robin.murphy@arm.com>, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with
 runtime suppliers
Message-ID: <20180213164205.GA7599@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Tomasz Figa <tfiga@chromium.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, David Airlie <airlied@linux.ie>,
	Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	freedreno@lists.freedesktop.org,
	Robin Murphy <robin.murphy@arm.com>, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1592304735267809608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 06:10:38PM +0900, Tomasz Figa wrote:
> Hi Vivek,
> 
> Thanks for the patch. Please see my comments inline.
> 
> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> > While handling the concerned iommu, there should not be a
> > need to power control the drm devices from iommu interface.
> > If these drm devices need to be powered around this time,
> > the respective drivers should take care of this.
> >
> > Replace the pm_runtime_get/put_sync(<drm_device>) with
> > pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
> > the connected iommu through the device link interface.
> > In case the device link is not setup these get/put_suppliers()
> > calls will be a no-op, and the iommu driver should take care of
> > powering on its devices accordingly.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > ---
> >  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> > index b23d33622f37..1ab629bbee69 100644
> > --- a/drivers/gpu/drm/msm/msm_iommu.c
> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
> > @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
> >         struct msm_iommu *iommu = to_msm_iommu(mmu);
> >         int ret;
> >
> > -       pm_runtime_get_sync(mmu->dev);
> > +       pm_runtime_get_suppliers(mmu->dev);
> >         ret = iommu_attach_device(iommu->domain, mmu->dev);
> > -       pm_runtime_put_sync(mmu->dev);
> > +       pm_runtime_put_suppliers(mmu->dev);
> 
> For me, it looks like a wrong place to handle runtime PM of IOMMU
> here. iommu_attach_device() calls into IOMMU driver's attach_device()
> callback and that's where necessary runtime PM gets should happen, if
> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
> with power state of device controlled by driver B (ARM SMMU).
 
This whole thing is confused by the fact that on MSM the GPU and the GPU IOMMU
share some of the same clocks and power rail so turning on the GPU also
turned on the IOMMU register banks by extension.

But if we put that aside the question is who should be responsible for
controlling the power in this relationship and there are several good reasons to
leave it up to the client device. The most important reason is when we move to
the per-instance model where the GPU self-programmings the SMMU registers. In
that case, the driver will need to make sure that the SMMU is powered up before
submitting the command and then removing the power vote when the commands
are done to save energy.

Additionally, there might be legitimate reasons in the driver to batch
operations - you may wish to attach the device and then map several global
buffers immediately - having driver side control prevents several unneeded power
transitions.

Perhaps the right answer is to do both - allow for the driver to enable the
supplier but also do the right power operations at the appropriately places in
the IOMMU driver.

> This is also important for the reasons I stated in my comments to
> "[PATCH v7 1/6] base: power: runtime: Export
> pm_runtime_get/put_suppliers". Quoting for everyone's convenience:
> 
> >> There are however cases in which the consumer wants to power-on
> >> the supplier, but not itself.
> >> E.g., A Graphics or multimedia driver wants to power-on the SMMU
> >> to unmap a buffer and finish the TLB operations without powering
> >> on itself.
> >
> >This sounds strange to me. If the SMMU is powered down, wouldn't the
> >TLB lose its contents as well (and so no flushing needed)?
> >

> >Other than that, what kind of hardware operations would be needed
> >besides just updating the page tables from the CPU?
> >

> In other words, the SMMU driver can deal with hardware state based on
> return value of pm_runtime_get_sync() or pm_runtime_get_if_in_use()
> and decide whether some operations are necessary or not, e.g.
> - a state restore is necessary if the domain was powered off, but we
> are bringing the master on,
> - a flush may not be required when (un)mapping with the domain powered off,
> - etc.

I agree that there is probably some advanced logic that we can do to
conclusively figure out the state of the hardware and improve the behavior.
I would love to see the SMMU driver get smarter but for the moment we can't
trust it and so we need to force the behavior from the GPU driver. The current
code works for a5x and earlier but on sdm845 we can (no longer) treat the GPU
and the SMMU as the same device for power purposes so we need this code. If at
some point in the future we can start to selectively remove the supplier calls
I wouldn't mind one bit.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
