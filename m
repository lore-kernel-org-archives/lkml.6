Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518573593; cv=none;
        d=google.com; s=arc-20160816;
        b=N6zPtpBCvcLl99pGXoNet/B90hvyCsSmzPvk16qQo7Xn7CSxhJluaVD2O1io1BYatl
         8CuZSDy2uNO8YRkOcDhahNwJc7aZ4RvcB5uBD3kwiaOtE3yAlg00f4+oQ0OI+SVEBfZI
         79VdWweTYcpNXj6q2vnOFn9oSmkffOuwO/S8JuXkmguMA4u+LS5Ph7yW90QyA2Eejbn8
         AvEhRIP7GrqfB7/6JvAVvAfEYhpjULnTcp4J77kD6ANnfXedX7NCMjf5TdArqb0qSGoo
         flv41YHZ2TKwRifnpoRbgj0psbDXAITIyA2Qs3ueRNCQUy/qcbafuo+CXN7VxlVxAYmu
         +ygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=EkNRLVo36zk6zH5/pVJMpZM+bB8AbDDmSYvJIY5dMHs=;
        b=pR778mZ5BiueLJiVj0XkzCtUhtpI8WrD2tYOFXIp03rU31/d9hTpJrur3jLKxt217P
         O/Yhd67dYUSNoxYnnXZa0WsnBaCCDqm0KII4w4Ug2HbN+cSzD2zboapAEzAIulfRGV9v
         VO+rv6Zn4pwpneugnhiRAhR1hdR+DGlN++NLJ5oRvjq4Gh88TmE1rEn00Q8xWcSvoZHr
         dGRSRnAKL3l4kfIS4QM0YbOnK48KIAWdALm8ozlfo47S1Mv1u/8vIT5MJxUPNaTsgJ0A
         7bpuJR0tQFhzRsCNNXjdSxw0d6/uqHeAClo2YYkeZfit0/PrgL8X693iKR1/F8Eww0sv
         jL4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Qn8voTQt;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Qn8voTQt;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x227LLPS9w3Dy8xUCmgjAeXDE6P3h0BOmKdvA1gWUZx5/36vdJxAa1W18VvtXKCK507uYOP4WPw==
MIME-Version: 1.0
In-Reply-To: <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com> <CAF6AEGs8qcRTvz6srSfc39ybZrPYMVg2w6qkaO2AdWL1GD4mQw@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 14 Feb 2018 10:59:29 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
Message-ID: <CAAFQd5BKRumpEfAKNF_RKS-ZZ8D671DfOz4vB2+w1SV3aG9NxQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592339824805088904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 3:03 AM, Rob Clark <robdclark@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 4:10 AM, Tomasz Figa <tfiga@chromium.org> wrote:
>> Hi Vivek,
>>
>> Thanks for the patch. Please see my comments inline.
>>
>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> While handling the concerned iommu, there should not be a
>>> need to power control the drm devices from iommu interface.
>>> If these drm devices need to be powered around this time,
>>> the respective drivers should take care of this.
>>>
>>> Replace the pm_runtime_get/put_sync(<drm_device>) with
>>> pm_runtime_get/put_suppliers(<drm_device>) calls, to power-up
>>> the connected iommu through the device link interface.
>>> In case the device link is not setup these get/put_suppliers()
>>> calls will be a no-op, and the iommu driver should take care of
>>> powering on its devices accordingly.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> ---
>>>  drivers/gpu/drm/msm/msm_iommu.c | 16 ++++++++--------
>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>>> index b23d33622f37..1ab629bbee69 100644
>>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>> @@ -40,9 +40,9 @@ static int msm_iommu_attach(struct msm_mmu *mmu, const char * const *names,
>>>         struct msm_iommu *iommu = to_msm_iommu(mmu);
>>>         int ret;
>>>
>>> -       pm_runtime_get_sync(mmu->dev);
>>> +       pm_runtime_get_suppliers(mmu->dev);
>>>         ret = iommu_attach_device(iommu->domain, mmu->dev);
>>> -       pm_runtime_put_sync(mmu->dev);
>>> +       pm_runtime_put_suppliers(mmu->dev);
>>
>> For me, it looks like a wrong place to handle runtime PM of IOMMU
>> here. iommu_attach_device() calls into IOMMU driver's attach_device()
>> callback and that's where necessary runtime PM gets should happen, if
>> any. In other words, driver A (MSM DRM driver) shouldn't be dealing
>> with power state of device controlled by driver B (ARM SMMU).
>
> Note that we end up having to do the same, because of iommu_unmap()
> while DRM driver is powered off..  it might be cleaner if it was all
> self contained in the iommu driver, but that would make it so other
> drivers couldn't call iommu_unmap() from an irq handler, which is
> apparently something that some of them want to do..

I'd assume that runtime PM status is already guaranteed to be active
when the IRQ handler is running, by some other means (e.g.
pm_runtime_get_sync() called earlier, when queuing some work to the
hardware). Otherwise, I'm not sure how a powered down device could
trigger an IRQ.

So, if the master device power is already on, suppliers should be
powered on as well, thanks to device links.

Best regards,
Tomasz
