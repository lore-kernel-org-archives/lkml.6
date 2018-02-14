Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AH8x227KNo/HSyUXe+iggdsR+v2/93R5kGK60VDKxQfMp08iXs/rIOBd3G3R5x/ySq8EfhU8TR96
ARC-Seal: i=1; a=rsa-sha256; t=1518624225; cv=none;
        d=google.com; s=arc-20160816;
        b=rleGFCudG/WRNOt4mUXVZm4T2brda+Z+4K5h5Nc4QnF85tl3Nwp/8NPXE68MWawVKh
         8jYb1uzwlR+0UZ6PFS83N6W6nQEHZIJaKL4eAGtEt/grMqAuTxtvQiCwet013cK2vyvF
         GkpcXgwV/9LEBwzsbFwKhoZOzjB6G6m/QPMMc7HpcnySE7+2oVXM1yx4csIqt2+M8V18
         ZLn2DIfGTy5fGMnxgWM+fJiEXnnEgLGftBGw4jHDwcWCkciRTEqX3hOHQQy1Qlpvfouw
         ikd3kxW4cKkhWL4iUL/YgtHoyH257HOqEsIDsmzoOk/IbTixZBMet0upJnwgf5HBFQVo
         l8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=7OlcjijfO1HYHg//nwgoQFhcOs8US4/BbUeZY1sQWWQ=;
        b=LYaBPlV4s9QuMJ2WLKDRzPYC0rcdBzzJjA3/3yPpTMWIgcGrNO7ZVaTwGg2x/p1ApD
         oL79vAdjdE+tp7gRSwsoX9LiujoxwZN5KNwc3XTIQ7wArlSFXZERJ+87o7tBSNee3uuB
         fWX1i1ZjKo9H/v/kaAY1xD9tpH3opTjMbPgRQJq6blx2979y/TLD7xyQVzMj2dn4Zx+9
         C+kKgwWv7wcGZ0EpDwbAw7TlTwzqxbUB/xBpV7wrCxCA+1FNTiMtHVGbWK3dbDSgc/fA
         /J+RsKZ41PttdzZXqOptNi1XvUmj7+MWHmHkCYmj1QlWo70O1/CUmtj0IHvAKHAz4Ql9
         h+TQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls with runtime
 suppliers
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
 Will Deacon <will.deacon@arm.com>
Cc: Rob Clark <robdclark@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 freedreno <freedreno@lists.freedesktop.org>, David Airlie
 <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, jcrouse@codeaurora.org
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
 <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
 <CAF6AEGuNZJKtwGZ5mLfqNND2jtU+HYM11UONfAtVTzoM0QVpdg@mail.gmail.com>
 <CAAFQd5BZJ1G0RG32hYErNzPRvisBhhiSNCBsjbzfm0WzO=DnsQ@mail.gmail.com>
 <CAFp+6iHaycK=CcE1S15EeuMkaw8LnW0ebptU0hM6tUtWdeEOtA@mail.gmail.com>
 <CAAFQd5Afj-Bj+3wHwmF2tT7y=46EsYEtO_mXfY6stXBgHutEUg@mail.gmail.com>
 <CAFp+6iGX6pr+MdPSSHHG=qOnhHky_8OHiDqAcJ9UudEUv=JMHg@mail.gmail.com>
 <CAAFQd5DiwAugGnPOTw0+XrEfef9x-n-vx59JFuXpNawjiXHwCw@mail.gmail.com>
 <CAFp+6iEW0faeHDfzN_F1bRrHGcVo3sPCk4HSY=t9dnEvHkDkYw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b003ecda-1cbe-4e5f-872b-107154ac40e5@arm.com>
Date: Wed, 14 Feb 2018 16:03:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFp+6iEW0faeHDfzN_F1bRrHGcVo3sPCk4HSY=t9dnEvHkDkYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737886832187485?=
X-GMAIL-MSGID: =?utf-8?q?1592392915117814421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/02/18 10:33, Vivek Gautam wrote:
> On Wed, Feb 14, 2018 at 2:46 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> 
> Adding Jordan to this thread as well.
> 
>> On Wed, Feb 14, 2018 at 6:13 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> Hi Tomasz,
>>>
>>> On Wed, Feb 14, 2018 at 11:08 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>> On Wed, Feb 14, 2018 at 1:17 PM, Vivek Gautam
>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>> Hi Tomasz,
>>>>>
>>>>> On Wed, Feb 14, 2018 at 8:31 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>>>> On Wed, Feb 14, 2018 at 11:13 AM, Rob Clark <robdclark@gmail.com> wrote:
>>>>>>> On Tue, Feb 13, 2018 at 8:59 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>>>>>> On Wed, Feb 14, 2018 at 3:03 AM, Rob Clark <robdclark@gmail.com> wrote:
>>>>>>>>> On Tue, Feb 13, 2018 at 4:10 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>>>>>>>>>> Hi Vivek,
>>>>>>>>>>
>>>>>>>>>> Thanks for the patch. Please see my comments inline.
>>>>>>>>>>
>>>>>>>>>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>>>>>>>>>> <vivek.gautam@codeaurora.org> wrote:
>>>>>>>>>>> While handling the concerned iommu, there should not be a
>>>>>>>>>>> need to power control the drm devices from iommu interface.
>>>>>>>>>>> If these drm devices need to be powered around this time,
>>>>>>>>>>> the respective drivers should take care of this.
>>>>>>>>>>>
>>>>>>>>>>> Replace the pm_runtime_get/put_sync(<drm_device>) with
>>>>>>>>>>> pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>>>>>>>>>>> the connected iommu through the device link interface.
>>>>>>>>>>> In case the device link is not setup these get/put_suppliers()
>>>>>>>>>>> calls will be a no-op, and the iommu driver should take care of
>>>>>>>>>>> powering on its devices accordingly.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>>>>>>>> ---
>>>>>>>>>>>   drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>>>>>>>>>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>>>>> index b23d33622f37..1ab629bbee69 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>>>>>>>>>> @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>>>>>>>>>>>          struct msm_iommu *iommu = to_msm_iommu(mmu);
>>>>>>>>>>>          int ret;
>>>>>>>>>>>
>>>>>>>>>>> -       pm_runtime_get_sync(mmu->dev);
>>>>>>>>>>> +       pm_runtime_get_suppliers(mmu->dev);
>>>>>>>>>>>          ret = iommu_attach_device(iommu->domain, mmu->dev);
>>>>>>>>>>> -       pm_runtime_put_sync(mmu->dev);
>>>>>>>>>>> +       pm_runtime_put_suppliers(mmu->dev);
>>>>>>>>>>
>>>>>>>>>> For me, it looks like a wrong place to handle runtime PM of IOMMU
>>>>>>>>>> here. iommu_attach_device() calls into IOMMU driver's attach_device()
>>>>>>>>>> callback and that's where necessary runtime PM gets should happen, if
>>>>>>>>>> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
>>>>>>>>>> with power state of device controlled by driver B (ARM SMMU).
>>>>>>>>>
>>>>>>>>> Note that we end up having to do the same, because of iommu_unmap()
>>>>>>>>> while DRM driver is powered off..  it might be cleaner if it was all
>>>>>>>>> self contained in the iommu driver, but that would make it so other
>>>>>>>>> drivers couldn't call iommu_unmap() from an irq handler, which is
>>>>>>>>> apparently something that some of them want to do..
>>>>>>>>
>>>>>>>> I'd assume that runtime PM status is already guaranteed to be active
>>>>>>>> when the IRQ handler is running, by some other means (e.g.
>>>>>>>> pm_runtime_get_sync() called earlier, when queuing some work to the
>>>>>>>> hardware). Otherwise, I'm not sure how a powered down device could
>>>>>>>> trigger an IRQ.
>>>>>>>>
>>>>>>>> So, if the master device power is already on, suppliers should be
>>>>>>>> powered on as well, thanks to device links.
>>>>>>>>
>>>>>>>
>>>>>>> umm, that is kindof the inverse of the problem..  the problem is
>>>>>>> things like gpu driver (and v4l2 drivers that import dma-buf's,
>>>>>>> afaict).. they will potentially call iommu->unmap() when device is not
>>>>>>> active (due to userspace or things beyond the control of the driver)..
>>>>>>> so *they* would want iommu to do pm get/put calls.
>>>>>>
>>>>>> Which is fine and which is actually already done by one of the patches
>>>>>> in this series, not for map/unmap, but probe, add_device,
>>>>>> remove_device. Having parts of the API doing it inside the callback
>>>>>> and other parts outside sounds at least inconsistent.
>>>>>>
>>>>>>> But other drivers
>>>>>>> trying to unmap from irq ctx would not.  Which is the contradictory
>>>>>>> requirement that lead to the idea of iommu user powering up iommu for
>>>>>>> unmap.
>>>>>>
>>>>>> Sorry, maybe I wasn't clear. My last message was supposed to show that
>>>>>> it's not contradictory at all, because "other drivers trying to unmap
>>>>>> from irq ctx" would already have called pm_runtime_get_*() earlier
>>>>>> from a non-irq ctx, which would have also done the same on all the
>>>>>> linked suppliers, including the IOMMU. The ultimate result would be
>>>>>> that the map/unmap() of the IOMMU driver calling pm_runtime_get_sync()
>>>>>> would do nothing besides incrementing the reference count.
>>>>>
>>>>> The entire point was to avoid the slowpath that pm_runtime_get/put_sync()
>>>>> would add in map/unmap. It would not be correct to add a slowpath in irq_ctx
>>>>> for taking care of non-irq_ctx and for the situations where master is already
>>>>> powered-off.
>>>>
>>>> Correct me if I'm wrong, but I believe that with what I'm proposing
>>>> there wouldn't be any slow path.
>>>
>>> Yea, but only when the power domain is irq-safe? And not all platforms
>>> enable irq-safe power domains. For instance, msm doesn't enable its
>>> gdsc power domains as irq-safe.
>>> Is it something i am missing?
>>
>> irq-safe would matter if there would exist a case when the call is
>> done from IRQ context and the power is off. As I explained in a), it
>> shouldn't happen.
> 
> Hi Robin, Will
> 
> Does adding pm_runtime_get() in map/unmap sounds good to you?

Given that we spent significant effort last year removing as much 
locking as we possibly could from the map/unmap path to minimise the 
significant performance impact it was having on networking/storage/etc. 
workloads, I really don't want to introduce more for the sake of one 
specific use-case, so no.

Robin.
