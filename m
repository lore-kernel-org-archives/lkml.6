Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x224ky9BuljUatwsgi7O7I3/SeKnOsrWLO8yL/5V7yt+6nrtEONRMqKDm7RXyMVcv2Bf9MHY6
ARC-Seal: i=1; a=rsa-sha256; t=1518599638; cv=none;
        d=google.com; s=arc-20160816;
        b=prIZnsKkKeNra2WNdC7HlmVPe3jJ7faX58+OxaA8z7gHCIk8CuxZGdRSBuwljFespH
         5eyNJTLQZf4/us5Oy99/plvJTORDZUiZt/HrRGzGiCkWBXIhlzcFo+7ni43oykjkx0f9
         pFMxZM46QYE0ucA7NjvkJ0B4MQZ2hgnPPlazt2pcywVvwv7LRvBoxYj/LGwO5JcRLHXh
         uL25qarJ6B+NrCRsRRIJ3sGdOvc9B/x4x7oL+pG42hYPEP3Y1uEBc+SQifAucdTNbskd
         jqOStMLquy3ch3xX0YUld7OCtCAbwOaDoLYnBdKv/KNuhlhGdB7ZKK+mcBLHBoOd0Q5H
         zvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=R+fdno4oc/MDgbo52lUIMUMwGBXJ7rGcXoYqhb7glZM=;
        b=l8yFiczaqy3tjW4FZi1ekl7O6MQdCU91wlvD1CUZZQ80lMxajgvrRW6xnt8/cUwJtv
         wB3Fzuyt5zX+w4tr8lEqjAzK3cBeBR8V7SX4wzSMT0MkAXvZubtD6lDKPCG7KOxO0sxn
         bUIpIfebAdfkFlKP5sFhu3hq9jeAPTUr2YQVZVtHP1MzYlrANqXZb17ob3YycNiKWO1v
         GL3UxCGfjuP4U8GgAV1Ck/Z2SJzQJXysdXizLm6mc/PuYcRd+mS4HbR4U94HeYaOwURu
         nyPBF91gY9snI4xhw3p3OwwwKbHNwJPCzi7wbi8hBgNvdEewCyTuhHuhC21vK8uNyC7d
         DB3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FZ/cT0xB;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jtPQtrah;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FZ/cT0xB;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=jtPQtrah;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63A3B60FF3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <CAAFQd5Afj-Bj+3wHwmF2tT7y=46EsYEtO_mXfY6stXBgHutEUg@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
 <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
 <CAF6AEGuNZJKtwGZ5mLfqNND2jtU+HYM11UONfAtVTzoM0QVpdg@mail.gmail.com>
 <CAAFQd5BZJ1G0RG32hYErNzPRvisBhhiSNCBsjbzfm0WzO=DnsQ@mail.gmail.com>
 <CAFp+6iHaycK=CcE1S15EeuMkaw8LnW0ebptU0hM6tUtWdeEOtA@mail.gmail.com> <CAAFQd5Afj-Bj+3wHwmF2tT7y=46EsYEtO_mXfY6stXBgHutEUg@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 14 Feb 2018 14:43:50 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGX6pr+MdPSSHHG=qOnhHky_8OHiDqAcJ9UudEUv=JMHg@mail.gmail.com>
Message-ID: <CAFp+6iGX6pr+MdPSSHHG=qOnhHky_8OHiDqAcJ9UudEUv=JMHg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
To: Tomasz Figa <tfiga@chromium.org>
Cc: Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1592367134795279449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomasz,

On Wed, Feb 14, 2018 at 11:08 AM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Wed, Feb 14, 2018 at 1:17 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> Hi Tomasz,
>>
>> On Wed, Feb 14, 2018 at 8:31 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>>> On Wed, Feb 14, 2018 at 11:13 AM, Rob Clark <robdclark@gmail.com> wrote:
>>>> On Tue, Feb 13, 2018 at 8:59 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>>> On Wed, Feb 14, 2018 at 3:03 AM, Rob Clark <robdclark@gmail.com> wrote:
>>>>>> On Tue, Feb 13, 2018 at 4:10 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>>>>> Hi Vivek,
>>>>>>>
>>>>>>> Thanks for the patch. Please see my comments inline.
>>>>>>>
>>>>>>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>>>>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>>>>> While handling the concerned iommu, there should not be a
>>>>>>>> need to power control the drm devices from iommu interface.
>>>>>>>> If these drm devices need to be powered around this time,
>>>>>>>> the respective drivers should take care of this.
>>>>>>>>
>>>>>>>> Replace the pm_runtime_get/put_sync(<drm_device>) with
>>>>>>>> pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>>>>>>>> the connected iommu through the device link interface.
>>>>>>>> In case the device link is not setup these get/put_suppliers()
>>>>>>>> calls will be a no-op, and the iommu driver should take care of
>>>>>>>> powering on its devices accordingly.
>>>>>>>>
>>>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>>>>> ---
>>>>>>>>  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>>>>>>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>> index b23d33622f37..1ab629bbee69 100644
>>>>>>>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>> @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>>>>>>>>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>>>>>>>>         int ret;
>>>>>>>>
>>>>>>>> -       pm_runtime_get_sync(mmu->dev);
>>>>>>>> +       pm_runtime_get_suppliers(mmu->dev);
>>>>>>>>         ret = iommu_attach_device(iommu->domain, mmu->dev);
>>>>>>>> -       pm_runtime_put_sync(mmu->dev);
>>>>>>>> +       pm_runtime_put_suppliers(mmu->dev);
>>>>>>>
>>>>>>> For me, it looks like a wrong place to handle runtime PM of IOMMU
>>>>>>> here. iommu_attach_device() calls into IOMMU driver's attach_device()
>>>>>>> callback and that's where necessary runtime PM gets should happen, if
>>>>>>> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
>>>>>>> with power state of device controlled by driver B (ARM SMMU).
>>>>>>
>>>>>> Note that we end up having to do the same, because of iommu_unmap()
>>>>>> while DRM driver is powered off..  it might be cleaner if it was all
>>>>>> self contained in the iommu driver, but that would make it so other
>>>>>> drivers couldn't call iommu_unmap() from an irq handler, which is
>>>>>> apparently something that some of them want to do..
>>>>>
>>>>> I'd assume that runtime PM status is already guaranteed to be active
>>>>> when the IRQ handler is running, by some other means (e.g.
>>>>> pm_runtime_get_sync() called earlier, when queuing some work to the
>>>>> hardware). Otherwise, I'm not sure how a powered down device could
>>>>> trigger an IRQ.
>>>>>
>>>>> So, if the master device power is already on, suppliers should be
>>>>> powered on as well, thanks to device links.
>>>>>
>>>>
>>>> umm, that is kindof the inverse of the problem..  the problem is
>>>> things like gpu driver (and v4l2 drivers that import dma-buf's,
>>>> afaict).. they will potentially call iommu->unmap() when device is not
>>>> active (due to userspace or things beyond the control of the driver)..
>>>> so *they* would want iommu to do pm get/put calls.
>>>
>>> Which is fine and which is actually already done by one of the patches
>>> in this series, not for map/unmap, but probe, add_device,
>>> remove_device. Having parts of the API doing it inside the callback
>>> and other parts outside sounds at least inconsistent.
>>>
>>>> But other drivers
>>>> trying to unmap from irq ctx would not.  Which is the contradictory
>>>> requirement that lead to the idea of iommu user powering up iommu for
>>>> unmap.
>>>
>>> Sorry, maybe I wasn't clear. My last message was supposed to show that
>>> it's not contradictory at all, because "other drivers trying to unmap
>>> from irq ctx" would already have called pm_runtime_get_*() earlier
>>> from a non-irq ctx, which would have also done the same on all the
>>> linked suppliers, including the IOMMU. The ultimate result would be
>>> that the map/unmap() of the IOMMU driver calling pm_runtime_get_sync()
>>> would do nothing besides incrementing the reference count.
>>
>> The entire point was to avoid the slowpath that pm_runtime_get/put_sync()
>> would add in map/unmap. It would not be correct to add a slowpath in irq_ctx
>> for taking care of non-irq_ctx and for the situations where master is already
>> powered-off.
>
> Correct me if I'm wrong, but I believe that with what I'm proposing
> there wouldn't be any slow path.

Yea, but only when the power domain is irq-safe? And not all platforms
enable irq-safe power domains. For instance, msm doesn't enable its
gdsc power domains as irq-safe.
Is it something i am missing?

>
> a) For IRQ context, the master is already powered on and so the SMMU
> is also powered on, through respective device link.
> pm_runtime_get_sync() would ultimately just increment the runtime PM
> usage count.
>
> b) For a case when the master is already powered off (which wouldn't
> be IRQ context, for the reason stated in a)), powering on the SMMU is
> unavoidable, if the SMMU hardware really needs to be accessed (i.e.
> some TLBs need to be invalidated, if their state is preserved despite
> master being powered down).
>
>>
>>>
>>>>
>>>> There has already been some discussion about this on various earlier
>>>> permutations of this patchset.  I think we have exhausted all other
>>>> options.
>>>
>>> I guess I should have read those. Let me do that now.
>> Yea, i point to the thread in cover letter and [PATCH 1/6].
>> Thanks.
>
> I read through all the links in the cover letter and I could see other
> attempts not working out indeed, but they were different from what I'm
> proposing.
>
> There was also a point raised that __pm_runtime_resume() called from
> pm_runtime_get_sync() would grab dev->power_lock spinlock, which is
> true, except that if the device is already active, it would do it only
> for the time of checking device state, so I doubt it would really be a
> significant point of contention.
>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
