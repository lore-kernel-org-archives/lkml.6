Return-Path: <robdclark@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518574433; cv=none;
        d=google.com; s=arc-20160816;
        b=YX/qq1gVbsnJJ8HoAm3zkiDMUgQyBgezxjUxRCuaGs29oq23YOUahQSn1nUzq7LG5B
         axAIKdZ6FGzphob1f8f6gkc8R5Ida5LdrqgYNgGuRDDdOeoEQPRnsu3imaoPqsjkjI+C
         1yetXpw2xaUNQyIlVsR9cFtlbuK61GS8bJZ6yOnjOHP4MFKLZZssluGvGtQ6y/lkOXl9
         NmDWxfzAvjpRpdfBjPy8QHEa0+ErxV3M802yLbgtEe7jlbfJPkzyqcg9qTRznwBVj06t
         yXJ3sHCxiaQN6sdJ5lBRsVPA8SMAE9TsoM1d4rGriEavgsl6d3CogGWmw3FRSD1ZEFew
         q4cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=PxaIeIL6ZrWAHt7eiS0Xs81ua87bStkHMYo9DI3iCQg=;
        b=C9h5hyS24z6BxObNNVj6FMnl5S5NomqSDl7ZVtXgwGTbGep8pqFeyDXiK6+O/en0n1
         1XjeTLPm5CzqjkNivp7O53U8x/OYSktRtlo+jHmf6OMrn79prpjvAyM86+0YrWjdnWNA
         5MAVAmJTm8CxuLmj1p0rVAj8Z4Fwi8wSqmALB8i6EbKt4HQrJrNu4VVAk5VjLzaFnPpt
         OQU6B/lpggFnutsnikCkMGgwmw0OglWk6mgWhESyn7lQZIp1n4cb1zS5SdH6gl8A/PVk
         Mpujsb/OZvF+v5mnKs28OPlZyyQKtcwVHaxW3CAkp1KIIIuEfaS5oJv4nMN6l1in6GNj
         VDmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CgTlNn/P;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CgTlNn/P;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225l+6kAAip6ZmysXVZgJqRnkddLiah1a/zQ6GFRoooCRlbi/K9aC53tQhEIUQBW9ZWC+APb9ZTPCZGwzRCnmsA=
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com> <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 13 Feb 2018 21:13:51 -0500
Message-ID: <CAF6AEGuNZJKtwGZ5mLfqNND2jtU+HYM11UONfAtVTzoM0QVpdg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime suppliers
To: Tomasz Figa <tfiga@chromium.org>
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
X-GMAIL-MSGID: =?utf-8?q?1592340704588431106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 8:59 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Wed, Feb 14, 2018 at 3:03 AM, Rob Clark <robdclark@gmail.com> wrote:
>> On Tue, Feb 13, 2018 at 4:10 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>>> Hi Vivek,
>>>
>>> Thanks for the patch. Please see my comments inline.
>>>
>>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>>> <vivek.gautam@codeaurora.org> wrote:
>>>> While handling the concerned iommu, there should not be a
>>>> need to power control the drm devices from iommu interface.
>>>> If these drm devices need to be powered around this time,
>>>> the respective drivers should take care of this.
>>>>
>>>> Replace the pm_runtime_get/put_sync(<drm_device>) with
>>>> pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>>>> the connected iommu through the device link interface.
>>>> In case the device link is not setup these get/put_suppliers()
>>>> calls will be a no-op, and the iommu driver should take care of
>>>> powering on its devices accordingly.
>>>>
>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>> ---
>>>>  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>>>> index b23d33622f37..1ab629bbee69 100644
>>>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>>>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>>> @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>>>>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>>>>         int ret;
>>>>
>>>> -       pm_runtime_get_sync(mmu->dev);
>>>> +       pm_runtime_get_suppliers(mmu->dev);
>>>>         ret = iommu_attach_device(iommu->domain, mmu->dev);
>>>> -       pm_runtime_put_sync(mmu->dev);
>>>> +       pm_runtime_put_suppliers(mmu->dev);
>>>
>>> For me, it looks like a wrong place to handle runtime PM of IOMMU
>>> here. iommu_attach_device() calls into IOMMU driver's attach_device()
>>> callback and that's where necessary runtime PM gets should happen, if
>>> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
>>> with power state of device controlled by driver B (ARM SMMU).
>>
>> Note that we end up having to do the same, because of iommu_unmap()
>> while DRM driver is powered off..  it might be cleaner if it was all
>> self contained in the iommu driver, but that would make it so other
>> drivers couldn't call iommu_unmap() from an irq handler, which is
>> apparently something that some of them want to do..
>
> I'd assume that runtime PM status is already guaranteed to be active
> when the IRQ handler is running, by some other means (e.g.
> pm_runtime_get_sync() called earlier, when queuing some work to the
> hardware). Otherwise, I'm not sure how a powered down device could
> trigger an IRQ.
>
> So, if the master device power is already on, suppliers should be
> powered on as well, thanks to device links.
>

umm, that is kindof the inverse of the problem..  the problem is
things like gpu driver (and v4l2 drivers that import dma-buf's,
afaict).. they will potentially call iommu->unmap() when device is not
active (due to userspace or things beyond the control of the driver)..
so *they* would want iommu to do pm get/put calls.  But other drivers
trying to unmap from irq ctx would not.  Which is the contradictory
requirement that lead to the idea of iommu user powering up iommu for
unmap.

There has already been some discussion about this on various earlier
permutations of this patchset.  I think we have exhausted all other
options.

BR,
-R
