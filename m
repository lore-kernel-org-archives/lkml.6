Return-Path: <robdclark@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518704081; cv=none;
        d=google.com; s=arc-20160816;
        b=WDc9+QqvYyajg2/3Kve+BFOMO6/cqkHhxAae7BmT8zj4ljSrj5pJ3EVL+nZqp/w/8w
         QaXINfvu6lDKMAi9K0z8SdjWvKFqDuhcv30mQ8qPUITg0fNEwqNeZHYwhB9k1h1s+uAy
         RLohyBfV0AOZaBdt+aBPSvIgeKfEK09uw2Imo5qIzmJBwGQ9z3NJOj7z6IEpJd7T1KtZ
         weoiM9gVwWoVYO+Aq+xyiQXUb7TpztVt9QwTJdgC0t4LjQMZlbW2j+6+/FxVeBrl0JP9
         2VUdAp6iox6L5uQBKal+KFkwMFscx0zRqskm+tOEBgrrlj6VUYOhAdeX0MlrlrIc4uQS
         t6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=FOmISjBC6Is5ZjZWghzdW9qvlburSkxvMszTs4qCx3M=;
        b=BX/NTJTO7JXL9+I5KBmWVxaGseh3qK9SFAPpdCnNAoCx/53PITASWpnKL5Mcs2lh1C
         9W8akgQ57Sw1Zvl154MisQcWLioF5SBAs6mONZ6WcO4rqEWigNjL7aeDNHlvk0MhwWCE
         W3ocDkfCsT5ODvigYUn6S1S5W6R62h4bVMVwuYcpuxl7R2bw3ysimHpa2nFRqxxUonVW
         5rNOxF6lniQmXPIS4cd3ukAlWZ3TjOhbAwRj4yrwMk5vnRSIlVmxSf8SH0IEk41F5ogS
         JPQs3gzGY9QMF/RK1H4HW3y7+nTjPTG2HafFNlY7OIN7Jt8+9SqdickWQdDJM5ZF+Zhh
         M6LQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MvtoIZiH;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MvtoIZiH;
       spf=pass (google.com: domain of robdclark@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robdclark@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225Up8AdhtAK9u5aTRgYpkaL2HaK1QtQ8n3OW+3Pd+ljgRhbD2lPFy+pCMW/tpkKUetzzDZYfz78EyQPWp2OS3k=
MIME-Version: 1.0
In-Reply-To: <CAAFQd5C-9mbd3hDSvz10a1oiO0--FT-L4EpsAYcALxxUvk6Fjg@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <20180213164205.GA7599@jcrouse-lnx.qualcomm.com> <CAAFQd5CjQRFATfh-mRQv5J=WefYuxBVTkk=Ju09FoqA-Or5Cvg@mail.gmail.com>
 <20180214154850.GA25422@jcrouse-lnx.qualcomm.com> <CAF6AEGtFOwBtXw7HvDSpEj+w78dsg9+p2SVk9e-uDuCE23Fpbw@mail.gmail.com>
 <CAAFQd5C-9mbd3hDSvz10a1oiO0--FT-L4EpsAYcALxxUvk6Fjg@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 15 Feb 2018 09:14:40 -0500
Message-ID: <CAF6AEGvWhG83gYOAHSkx4_t3y_y4WH3xEmE3VXzVnO8VExJ0Vw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls
 with runtime suppliers
To: Tomasz Figa <tfiga@chromium.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1592476650921427048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 11:09 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> On Thu, Feb 15, 2018 at 1:12 AM, Rob Clark <robdclark@gmail.com> wrote:
>> On Wed, Feb 14, 2018 at 10:48 AM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
>>> On Wed, Feb 14, 2018 at 12:31:29PM +0900, Tomasz Figa wrote:
>>>>
>>>> - When submitting commands to the GPU, the GPU driver will
>>>> pm_runtime_get_sync() on the GPU device, which will automatically do
>>>> the same on all the linked suppliers, which would also include the
>>>> SMMU itself. The role of device links here is exactly that the GPU
>>>> driver doesn't have to care which other devices need to be brought up.
>>>
>>> This is true.  Assuming that the device link works correctly we would not need
>>> to explicitly power the SMMU which makes my point entirely moot.
>>
>> Just to point out what motivated this patchset, the biggest problem is
>> iommu_unmap() because that can happen when GPU is not powered on (or
>> in the v4l2 case, because some other device dropped it's reference to
>> the dma-buf allowing it to be free'd).  Currently we pm get/put the
>> GPU device around unmap, but it is kinda silly to boot up the GPU just
>> to unmap a buffer.
>
> Note that in V4L2 both mapping and unmapping can happen completely
> without involving the driver. So AFAICT the approach being implemented
> by this patchset will not work, because there will be no one to power
> up the IOMMU before the operation. Moreover, there are platforms for
> which there is no reason to power up the IOMMU just for map/unmap,
> because the hardware state is lost anyway and the only real work
> needed is updating the page tables in memory. (I feel like this is
> actually true for most of the platforms in the wild, but this is based
> purely on the not so small number of platforms I worked with, haven't
> bothered looking for more general evidence.)
>

At least as far as drm/msm/adreno, I'm not terribly concerned about
other platforms that don't need to power up iommu.  It's not really
the same situation as a IP block that shows up in all different
vendor's SoCs.

But if you can convince Robin to go for get/put_sync() calls inside
the iommu driver, I'm fine with that approach too.  That is what I do
in qcom_iommu already.  But if not I'd like to at least solve this for
some platforms if we can't solve for all.

BR,
-R

>>
>> (Semi-related, I would also like to batch map/unmap's, I just haven't
>> gotten around to implementing it yet.. but that would be another case
>> where a single get_supplier()/put_supplier() outside of the iommu
>> would make sense instead of pm_get/put() inside the iommu driver's
>> ->unmap().)
>>
>> If you really dislike the get/put_supplier() approach, then perhaps we
>> need iommu_pm_get()/iommu_pm_put() operations that the iommu user
>> could use to accomplish the same thing?
>
> I'm afraid this wouldn't work for V4L2 either. And I still haven't
> been given any evidence that the approach I'm suggesting, which relies
> only on existing pieces of infrastructure and which worked for both
> Exynos and Rockchip, including V4L2, wouldn't work for SMMU and/or QC
> SoCs.
>
> Best regards,
> Tomasz
