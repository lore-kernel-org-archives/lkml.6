Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518577678; cv=none;
        d=google.com; s=arc-20160816;
        b=PrPopokmXfrDu3RuC7rn3GTzLNCkmFZjZ3jW1q0wBI9HBvnJpoYX24pS1jx3bDvei2
         fWiZiYZMCkUpQ+3okty+lGqtF8Z+55KCtXXqS9uX7A06SvH7+XvdlKpjj1yOedxRbToN
         obyjt4M9ZJU0Ajzf1l6eiVReKAl7kB0vYrQTWwOfppvv57vJh5lWokjEK2jiSGAi4zqP
         ZD6Qt5XVpe01nmjtrQJwVXL0VhGYvB28L5JfEe47kjuOL3f1F8oPAuZNaXI/EXcKw5YA
         URLOaa7Zjcr/0HrEeKBcHaVwGXRo/efChecyTrhQfHVNriPCprDubkgOo8a1dnTnE9Fo
         bL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=51THLspHM3nV1ghRTyiuxqh15fHInWU+c8bjkF0WZaw=;
        b=IJbAcQm6P0DykpL1KJQmN17NNz9TyLoS0CKzzL0IBIKxlW+cm2wCEaiNGQsKRMWrew
         YaBSAveUJ/jEBImalsHG8xs0AiCSrlUpi8BpQZuYUWotu1OT1XEHIwY51n5jPIJqzUl9
         a895aOpF01cWmw796tZtI3MHhvMYoPN3IT8w+GqehneW3r2Ni47e5oqpov56tNAhh7fk
         B4VIdrAwFuwQaVd/yl6cOgIHMXwubwi4oaKt7bQwRl2Jgwqqk5x+X4p7F6Y3AMei6kFh
         wovaDFYBET44nyWjaWS997VV+7E7SN0C3J5Nd7q79UFX84zHPDy/QX4f4bTUurojVRJA
         Sv/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NNJQhlJV;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NNJQhlJV;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x227RjDfrFdBRIrthSL5iNgSeQCgpjbeG9vblJLEQrjGZe36fnSSkjOeJgd5MaqQCZvU0OvmciQ==
MIME-Version: 1.0
In-Reply-To: <CAF6AEGuNZJKtwGZ5mLfqNND2jtU+HYM11UONfAtVTzoM0QVpdg@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
 <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com> <CAF6AEGuNZJKtwGZ5mLfqNND2jtU+HYM11UONfAtVTzoM0QVpdg@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 14 Feb 2018 12:01:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BZJ1G0RG32hYErNzPRvisBhhiSNCBsjbzfm0WzO=DnsQ@mail.gmail.com>
Message-ID: <CAAFQd5BZJ1G0RG32hYErNzPRvisBhhiSNCBsjbzfm0WzO=DnsQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
To: Rob Clark <robdclark@gmail.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1592344108584735218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:13 AM, Rob Clark <robdclark@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 8:59 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> On Wed, Feb 14, 2018 at 3:03 AM, Rob Clark <robdclark@gmail.com> wrote:
>>> On Tue, Feb 13, 2018 at 4:10 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>> Hi Vivek,
>>>>
>>>> Thanks for the patch. Please see my comments inline.
>>>>
>>>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>> While handling the concerned iommu, there should not be a
>>>>> need to power control the drm devices from iommu interface.
>>>>> If these drm devices need to be powered around this time,
>>>>> the respective drivers should take care of this.
>>>>>
>>>>> Replace the pm_runtime_get/put_sync(<drm_device>) with
>>>>> pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>>>>> the connected iommu through the device link interface.
>>>>> In case the device link is not setup these get/put_suppliers()
>>>>> calls will be a no-op, and the iommu driver should take care of
>>>>> powering on its devices accordingly.
>>>>>
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> ---
>>>>>  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>>>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>>>>> index b23d33622f37..1ab629bbee69 100644
>>>>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>>>>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>>>> @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>>>>>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>>>>>         int ret;
>>>>>
>>>>> -       pm_runtime_get_sync(mmu->dev);
>>>>> +       pm_runtime_get_suppliers(mmu->dev);
>>>>>         ret = iommu_attach_device(iommu->domain, mmu->dev);
>>>>> -       pm_runtime_put_sync(mmu->dev);
>>>>> +       pm_runtime_put_suppliers(mmu->dev);
>>>>
>>>> For me, it looks like a wrong place to handle runtime PM of IOMMU
>>>> here. iommu_attach_device() calls into IOMMU driver's attach_device()
>>>> callback and that's where necessary runtime PM gets should happen, if
>>>> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
>>>> with power state of device controlled by driver B (ARM SMMU).
>>>
>>> Note that we end up having to do the same, because of iommu_unmap()
>>> while DRM driver is powered off..  it might be cleaner if it was all
>>> self contained in the iommu driver, but that would make it so other
>>> drivers couldn't call iommu_unmap() from an irq handler, which is
>>> apparently something that some of them want to do..
>>
>> I'd assume that runtime PM status is already guaranteed to be active
>> when the IRQ handler is running, by some other means (e.g.
>> pm_runtime_get_sync() called earlier, when queuing some work to the
>> hardware). Otherwise, I'm not sure how a powered down device could
>> trigger an IRQ.
>>
>> So, if the master device power is already on, suppliers should be
>> powered on as well, thanks to device links.
>>
>
> umm, that is kindof the inverse of the problem..  the problem is
> things like gpu driver (and v4l2 drivers that import dma-buf's,
> afaict).. they will potentially call iommu->unmap() when device is not
> active (due to userspace or things beyond the control of the driver)..
> so *they* would want iommu to do pm get/put calls.

Which is fine and which is actually already done by one of the patches
in this series, not for map/unmap, but probe, add_device,
remove_device. Having parts of the API doing it inside the callback
and other parts outside sounds at least inconsistent.

> But other drivers
> trying to unmap from irq ctx would not.  Which is the contradictory
> requirement that lead to the idea of iommu user powering up iommu for
> unmap.

Sorry, maybe I wasn't clear. My last message was supposed to show that
it's not contradictory at all, because "other drivers trying to unmap
from irq ctx" would already have called pm_runtime_get_*() earlier
from a non-irq ctx, which would have also done the same on all the
linked suppliers, including the IOMMU. The ultimate result would be
that the map/unmap() of the IOMMU driver calling pm_runtime_get_sync()
would do nothing besides incrementing the reference count.

>
> There has already been some discussion about this on various earlier
> permutations of this patchset.  I think we have exhausted all other
> options.

I guess I should have read those. Let me do that now.

Best regards,
Tomasz
