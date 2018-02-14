Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518579113; cv=none;
        d=google.com; s=arc-20160816;
        b=zLeLNRnPsg6RGb0X6GSl2xNgEjY/Mwp+fI3pvUF6Pxbjnd5ZatW8srTL7F6um94A9P
         Hflqi1mz8mqw47iRq8+bkwBmRsYOTCvKj1D8hvR35+elGZXMqn/7fVXjSx9AR6RIw5G/
         5lStZdjzPmIVljV3OAI/8Qq2eHeBOT9OUCLu7P4SQH9T/vVkm9iCnq21SiHNqODE11FZ
         8zYs1KLpRrY3O4Tj6ntoVYJRIayC5kTGu744rezTTlZgB2nMVh4WSfaRZ3EHQx0jqR+/
         I4kbK0ZxoLzAYkFqoh6a2fFzpzzF/RJyrlOYBX5rFmfNB3FA0raQmGI50WSNCFg2+x44
         miRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=h4jNVvOcjbnJs2694vumFVslZVLSe4jroeucRCubSI8=;
        b=yxXcsmZGffO0UazS7uQKKi/b8hUExeyeE5nsfMIfSJydQiqyw7lVPc54kb+4/JZaKP
         QFc/jJu8c2z+jtPMYFcX2ek4geVWu2XlJHVuTcI+RprbWlql19axUTFy249d5ql2HP2h
         QKIj6A8wqyRIty+vtt1DClr+Tyh/hvxgom6tARQ5XiM4dF/xBc+kaIaW04sLoXYHudkI
         4i4rfrhwUsW44rTxr8Olhp2OwPt+va6JSl7fhLY8h4KBBlkSBm73Rs/d0THKyF2o99zi
         EQ4huhHv5d6Fyk2r65pJek2c4lr2nFSJojL66BGucPk5M9dxrDA3f3PcRcfJhcAN/aCu
         7g3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=fBefBmWu;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=fBefBmWu;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x224X45ZeVv6SJQma/oNTQbzKxebBeFKMBMPFGaupVRR4GRz/JgFyvv2jIEbKIeIc/a4tWezGXg==
MIME-Version: 1.0
In-Reply-To: <20180213164205.GA7599@jcrouse-lnx.qualcomm.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com> <20180213164205.GA7599@jcrouse-lnx.qualcomm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 14 Feb 2018 12:31:29 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CjQRFATfh-mRQv5J=WefYuxBVTkk=Ju09FoqA-Or5Cvg@mail.gmail.com>
Message-ID: <CAAFQd5CjQRFATfh-mRQv5J=WefYuxBVTkk=Ju09FoqA-Or5Cvg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
To: Tomasz Figa <tfiga@chromium.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	David Airlie <airlied@linux.ie>, Will Deacon <will.deacon@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, freedreno <freedreno@lists.freedesktop.org>,
	Robin Murphy <robin.murphy@arm.com>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1592345612633499537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jordan,

On Wed, Feb 14, 2018 at 1:42 AM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> On Tue, Feb 13, 2018 at 06:10:38PM +0900, Tomasz Figa wrote:
>> Hi Vivek,
>>
>> Thanks for the patch. Please see my comments inline.
>>
>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>> > While handling the concerned iommu, there should not be a
>> > need to power control the drm devices from iommu interface.
>> > If these drm devices need to be powered around this time,
>> > the respective drivers should take care of this.
>> >
>> > Replace the pm_runtime_get/put_sync(<drm_device>) with
>> > pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>> > the connected iommu through the device link interface.
>> > In case the device link is not setup these get/put_suppliers()
>> > calls will be a no-op, and the iommu driver should take care of
>> > powering on its devices accordingly.
>> >
>> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> > ---
>> >  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>> >  1 file changed, 8 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>> > index b23d33622f37..1ab629bbee69 100644
>> > --- a/drivers/gpu/drm/msm/msm_iommu.c
>> > +++ b/drivers/gpu/drm/msm/msm_iommu.c
>> > @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>> >         struct msm_iommu *iommu = to_msm_iommu(mmu);
>> >         int ret;
>> >
>> > -       pm_runtime_get_sync(mmu->dev);
>> > +       pm_runtime_get_suppliers(mmu->dev);
>> >         ret = iommu_attach_device(iommu->domain, mmu->dev);
>> > -       pm_runtime_put_sync(mmu->dev);
>> > +       pm_runtime_put_suppliers(mmu->dev);
>>
>> For me, it looks like a wrong place to handle runtime PM of IOMMU
>> here. iommu_attach_device() calls into IOMMU driver's attach_device()
>> callback and that's where necessary runtime PM gets should happen, if
>> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
>> with power state of device controlled by driver B (ARM SMMU).
>
> This whole thing is confused by the fact that on MSM the GPU and the GPU IOMMU
> share some of the same clocks and power rail so turning on the GPU also
> turned on the IOMMU register banks by extension.

This is surprisingly not a very surprising case. Exactly the same can
be seen on Rockchip SoCs and we're solving the problem using the
solution I suggested. In fact, my suggestions to this thread are based
on the design we chose for Rockchip, due to the high level of
similarity (+/- the GPU directly programming IOMMU registers, which is
not present there, but AFAICT it doesn't pose a problem here).

>
> But if we put that aside the question is who should be responsible for
> controlling the power in this relationship and there are several good reasons to
> leave it up to the client device. The most important reason is when we move to
> the per-instance model where the GPU self-programmings the SMMU registers. In
> that case, the driver will need to make sure that the SMMU is powered up before
> submitting the command and then removing the power vote when the commands
> are done to save energy.

I might need more insight on what's going on in your hardware, but
with my current understanding I'd argue that that is not right,
because:

- When submitting commands to the GPU, the GPU driver will
pm_runtime_get_sync() on the GPU device, which will automatically do
the same on all the linked suppliers, which would also include the
SMMU itself. The role of device links here is exactly that the GPU
driver doesn't have to care which other devices need to be brought up.

- When the GPU is operating, the SMMU power must be supplied anyway,
because it needs to be doing the translations, right? Note that by
"power" I really mean the physical power supply in the SoC, e.g. as
for a power domain. The runtime PM API in its current form (e.g.
binary off or on operation) is unsuitable for managing other things,
such as clocks (and there is ongoing work on improving it, e.g. by
adding support for multiple power states).

   ^^ The above would be actually guaranteed by your hardware design,
where SMMU and GPU share the power domain and clocks. (We used to rely
on this in old downstream implementation of Rockchip IOMMU and master
drivers in Chromium OS kernel, before we moved to handling the clocks
explicitly in the IOMMU driver and properly using device links to
manage the power domain and state restoration.)

>
> Additionally, there might be legitimate reasons in the driver to batch
> operations - you may wish to attach the device and then map several global
> buffers immediately - having driver side control prevents several unneeded power
> transitions.

As I mentioned before, these operations wouldn't normally need any
power transitions, since mapping with the TLB powered down boils down
to just updating the page tables in memory. However, as Robin
mentioned before, there might be some hardware factors, such as TLB
being powered separately (or retaining contents in some other way),
where this wouldn't be ensured indeed.

Still, that's where runtime PM autosuspend feature (i.e. delayed
suspend) comes to the rescue, with the advantage of handling the cases
when the master driver receives map/unmap requests not batched (but
maybe a slight drawback in terms of the suspend not happening
instantly and losing some power, but it's about power domains, so
mainly leakage current, isn't it?)

>
> Perhaps the right answer is to do both - allow for the driver to enable the
> supplier but also do the right power operations at the appropriately places in
> the IOMMU driver.
>
>> This is also important for the reasons I stated in my comments to
>> "[PATCH v7 1/6] base: power: runtime: Export
>> pm_runtime_get/put_suppliers". Quoting for everyone's convenience:
>>
>> >> There are however cases in which the consumer wants to power-on
>> >> the supplier, but not itself.
>> >> E.g., A Graphics or multimedia driver wants to power-on the SMMU
>> >> to unmap a buffer and finish the TLB operations without powering
>> >> on itself.
>> >
>> >This sounds strange to me. If the SMMU is powered down, wouldn't the
>> >TLB lose its contents as well (and so no flushing needed)?
>> >
>
>> >Other than that, what kind of hardware operations would be needed
>> >besides just updating the page tables from the CPU?
>> >
>
>> In other words, the SMMU driver can deal with hardware state based on
>> return value of pm_runtime_get_sync() or pm_runtime_get_if_in_use()
>> and decide whether some operations are necessary or not, e.g.
>> - a state restore is necessary if the domain was powered off, but we
>> are bringing the master on,
>> - a flush may not be required when (un)mapping with the domain powered off,
>> - etc.
>
> I agree that there is probably some advanced logic that we can do to
> conclusively figure out the state of the hardware and improve the behavior.
> I would love to see the SMMU driver get smarter but for the moment we can't
> trust it and so we need to force the behavior from the GPU driver. The current
> code works for a5x and earlier but on sdm845 we can (no longer) treat the GPU
> and the SMMU as the same device for power purposes so we need this code.

Hmm, you've lost me there. Above you  mention that "on MSM the GPU and
the GPU IOMMU share some of the same clocks and power rail". Is this
no longer the case for sdm845? If so, would you mind shedding a bit
more light on how this looks there?

Best regards,
Tomasz
