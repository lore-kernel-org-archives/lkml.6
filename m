Return-Path: <jcrouse@codeaurora.org>
X-Google-Smtp-Source: AH8x224ygwf9+SBytedYrySrAVSHNrIZvMeRqUFxGQCQKpv6x/rW1WcVRCWqm953s6XimzlMYLuC
ARC-Seal: i=1; a=rsa-sha256; t=1519400453; cv=none;
        d=google.com; s=arc-20160816;
        b=mk5XOJjk7T0OkKebqUCYC0z5ccr91ChMr9Z1PN2Fze0skiG1kSXNYkyV5nWfAuWywA
         7XMgoxrNvuX/hkO3lQZSeP1jf60npoA29Le/62lXAfwHGzppnbY3WsToqMstMMMUUw85
         rHus9+Yh1DnGl2hKnhzj/blNC/IHjE1ZnAh93lZrjxoEMKABTC89BF1KQPinZDBbJ5Ne
         rIP5nJAz/cD9hhvaYIVBv6iGZ4u7EDuWKcFSS8Hb7hErn8QiaRLciHZfAG2+79SrtOCi
         nlzeZMUD9Xt0IMtXhc479HLNiCqbgECLOKLLKE96JVVbRflH4xCO14fGT+bRHehMTRre
         i31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dmarc-filter
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=iA+sFJwwFJKAXGH5SU+TPqn2/5UlnrJPa7vdsjMvW7c=;
        b=Pn3A5Cv1WrfLNaRc3JFv+mYxSUtzkwA3+AqvMPwb0yytMuugK0LoVboVNr2F61ZuYl
         KnMVf2rcUM5GqWenTg0vEkHsQRIqL68wiyMDhDJY+3u1FzYep5xQzqpKqykUVOlDTkDv
         BgygDk40skbswCysJ8MOf2fu2AaWvcz5A5gn/uQD/Yg5VrWxqTm+BbW2bGGe6la2CBcw
         IIcMXAW8eLN42XB5UOZG0nVqAsSgDnVrdqHnx2KHmrc060sWeqZZfSVLjzmATfx3iH4y
         /QrMefvzNShpCZLxhencdWLMClpGLOuot8xHsiLNm7oensQi7PHMMdNp5cusFfWlv5Ip
         u5VA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DfijPrXQ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DfijPrXQ;
       spf=pass (google.com: domain of jcrouse@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=jcrouse@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DfijPrXQ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DfijPrXQ;
       spf=pass (google.com: domain of jcrouse@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=jcrouse@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A33526030F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Fri, 23 Feb 2018 08:40:48 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <joro@8bytes.org>,
	robh+dt <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [Freedreno] [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime
 during probe, add/remove device
Message-ID: <20180223154048.GB18743@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Vivek Gautam <vivek.gautam@codeaurora.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <joro@8bytes.org>,
	robh+dt <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org>
 <20180222235200.GA18743@jcrouse-lnx.qualcomm.com>
 <CAFp+6iGQ5Vckui14Jb=V0uk_Pjes95hOxo=KBijR4yxPeDDzFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFp+6iGQ5Vckui14Jb=V0uk_Pjes95hOxo=KBijR4yxPeDDzFg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1593206849753019415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 04:06:39PM +0530, Vivek Gautam wrote:
> On Fri, Feb 23, 2018 at 5:22 AM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > On Wed, Feb 07, 2018 at 04:01:19PM +0530, Vivek Gautam wrote:
> >> From: Sricharan R <sricharan@codeaurora.org>
> >>
> >> The smmu device probe/remove and add/remove master device callbacks
> >> gets called when the smmu is not linked to its master, that is without
> >> the context of the master device. So calling runtime apis in those places
> >> separately.
> >>
> >> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> >> [vivek: Cleanup pm runtime calls]
> >> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >> ---
> >>  drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 38 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index 9e2f917e16c2..c024f69c1682 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> >>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >>       struct arm_smmu_device *smmu = smmu_domain->smmu;
> >>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> >> -     int irq;
> >> +     int ret, irq;
> >>
> >>       if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
> >>               return;
> >>
> >> +     ret = pm_runtime_get_sync(smmu->dev);
> >> +     if (ret)
> >> +             return;
> >> +
> >>       /*
> >>        * Disable the context bank and free the page tables before freeing
> >>        * it.
> >> @@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
> >>
> >>       free_io_pgtable_ops(smmu_domain->pgtbl_ops);
> >>       __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> >> +
> >> +     pm_runtime_put_sync(smmu->dev);
> >>  }
> >>
> >>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> >> @@ -1407,14 +1413,22 @@ static int arm_smmu_add_device(struct device *dev)
> >>       while (i--)
> >>               cfg->smendx[i] = INVALID_SMENDX;
> >>
> >> -     ret = arm_smmu_master_alloc_smes(dev);
> >> +     ret = pm_runtime_get_sync(smmu->dev);
> >>       if (ret)
> >>               goto out_cfg_free;
> >
> > Hey Vivek, I just hit a problem with this on sdm845. It turns out that
> > pm_runtime_get_sync() returns a positive 1 if the device is already active.
> >
> > I hit this in the GPU code. The a6xx has two platform devices that each use a
> > different sid on the iommu. The GPU is probed normally from a platform driver
> > and it in turn initializes the GMU device by way of a phandle.
> >
> > Because the GMU isn't probed with a platform driver we need to call
> > of_dma_configure() on the device to set up the IOMMU for the device which ends
> > up calling through this path and we discover that the smmu->dev is already
> > powered (pm_runtime_get_sync returns 1).
> >
> > I'm not immediately sure if this is a bug on sdm845 or not because a cursory
> > inspection says that the SMMU device shouldn't be powered at this time but there
> > might be a connection that I'm not seeing. Obviously if the SMMU was left
> > powered thats a bad thing. But putting that aside it is obvious that this
> > code should be accommodating of the possibility that the device is already
> > powered, and so this should be
> >
> > if (ret < 0)
> >         goto out_cfg_free;
> 
> Right, as Tomasz also pointed, we should surely check the negative value of
> pm_runtime_get_sync().

Sorry, I didn't notice that Tomasz had pointed it out as well. I wanted to
quickly get it on the mailing list so you could catch it in your time zone.

> From your description, it may be that the GPU has turned on the smmu, and
> then once if goes and probes the GMU, the GMU device also wants to turn-on
> the same smmu device. But that's already active. So pm_runtime_get_sync()
> returns 1.
> Am i making sense?

My concern is that this is happening during the probe and we shouldn't be
energizing the GPU at this point. But it is entirely possible that the
bus is on for other reasons. I'll do a bit of digging today and see exactly
which device is at fault.


Jordan
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
