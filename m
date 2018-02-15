Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518667766; cv=none;
        d=google.com; s=arc-20160816;
        b=RPeQFUEoi+9mIeSPmq+klj9d88OmG5fuUAL60g+JdLJuFKaVJM1JHpWpPnbuFokECq
         eU2I4/Oo41jjzoVxI5zd5zwwNz9bInsSUdcHQXzx3Vn+GYoxed3WN6F3f+Cl3ncfojDT
         nXnci1dF/+IaQleNlmHcicTPVvFfFXx/Ip4LL2Fp6zADkyBpSY6jvApHEfo1ugEnv6aw
         4lIQqlfgABZvbi+NO+MxcyCYagBfjBt6zDmqcTthNYfWV4szfSME+5/lzUz7JS/cl61L
         gew7hqPwsVy/oYINH048FyiIISAirm/bNp4z+gtEtgEVxUSL9dCzz8R0KENvDrcouT8g
         nkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=f4VkzchlQLVppKlHMNFOtIBpaRzxm370ANoaRhKFGa4=;
        b=eVfHuw4UqZYGAAR5lgQGqk4yt9V3EAj96/1vpgZ4NNBH58WJqUvZ/J1GGIr4dC/SmL
         NXaQH9rCihbRHTyxs4SDgrmMDWa/Vr9UIqa+x9/wq7fTL2SRuvX4jvKPC/cSHt4HSSc6
         jA7j4pdaYIfXaBYzHXYedbN8bamFvWWRxS3vVwE9DL81K3iqxtj8QFEB6/66sJWc7vyn
         zUx/eEwnZXIO+oSKa746aeIvXvlU7Gr3I2lWbyoEk263rka+9HeLDRl/jfGy5Jo3g2Kn
         oR7sBkdzlOz8o42ziPg0a0JQbJ0hkZ6N9CVUkzhMRbFBBpnt5VhTMaXda1LWwvP8qSEq
         EJBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NYGNsI2G;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NYGNsI2G;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x227zcAIb1c3emh8u8x0YJ6R8ca8wjVgdVFR5lPfZzokjSkdkA2nyjTnhhM33dOIiKot3Duew1w==
MIME-Version: 1.0
In-Reply-To: <CAF6AEGtFOwBtXw7HvDSpEj+w78dsg9+p2SVk9e-uDuCE23Fpbw@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-7-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5AjopiX6fDgD+mO+-+d0yj-swEnVCNvccWRBSMO+XVJkA@mail.gmail.com>
 <20180213164205.GA7599@jcrouse-lnx.qualcomm.com> <CAAFQd5CjQRFATfh-mRQv5J=WefYuxBVTkk=Ju09FoqA-Or5Cvg@mail.gmail.com>
 <20180214154850.GA25422@jcrouse-lnx.qualcomm.com> <CAF6AEGtFOwBtXw7HvDSpEj+w78dsg9+p2SVk9e-uDuCE23Fpbw@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 15 Feb 2018 13:09:03 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C-9mbd3hDSvz10a1oiO0--FT-L4EpsAYcALxxUvk6Fjg@mail.gmail.com>
Message-ID: <CAAFQd5C-9mbd3hDSvz10a1oiO0--FT-L4EpsAYcALxxUvk6Fjg@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v7 6/6] drm/msm: iommu: Replace runtime calls
 with runtime suppliers
To: Rob Clark <robdclark@gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592438571703048133?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 1:12 AM, Rob Clark <robdclark@gmail.com> wrote:
> On Wed, Feb 14, 2018 at 10:48 AM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
>> On Wed, Feb 14, 2018 at 12:31:29PM +0900, Tomasz Figa wrote:
>>>
>>> - When submitting commands to the GPU, the GPU driver will
>>> pm_runtime_get_sync() on the GPU device, which will automatically do
>>> the same on all the linked suppliers, which would also include the
>>> SMMU itself. The role of device links here is exactly that the GPU
>>> driver doesn't have to care which other devices need to be brought up.
>>
>> This is true.  Assuming that the device link works correctly we would not need
>> to explicitly power the SMMU which makes my point entirely moot.
>
> Just to point out what motivated this patchset, the biggest problem is
> iommu_unmap() because that can happen when GPU is not powered on (or
> in the v4l2 case, because some other device dropped it's reference to
> the dma-buf allowing it to be free'd).  Currently we pm get/put the
> GPU device around unmap, but it is kinda silly to boot up the GPU just
> to unmap a buffer.

Note that in V4L2 both mapping and unmapping can happen completely
without involving the driver. So AFAICT the approach being implemented
by this patchset will not work, because there will be no one to power
up the IOMMU before the operation. Moreover, there are platforms for
which there is no reason to power up the IOMMU just for map/unmap,
because the hardware state is lost anyway and the only real work
needed is updating the page tables in memory. (I feel like this is
actually true for most of the platforms in the wild, but this is based
purely on the not so small number of platforms I worked with, haven't
bothered looking for more general evidence.)

>
> (Semi-related, I would also like to batch map/unmap's, I just haven't
> gotten around to implementing it yet.. but that would be another case
> where a single get_supplier()/put_supplier() outside of the iommu
> would make sense instead of pm_get/put() inside the iommu driver's
> ->unmap().)
>
> If you really dislike the get/put_supplier() approach, then perhaps we
> need iommu_pm_get()/iommu_pm_put() operations that the iommu user
> could use to accomplish the same thing?

I'm afraid this wouldn't work for V4L2 either. And I still haven't
been given any evidence that the approach I'm suggesting, which relies
only on existing pieces of infrastructure and which worked for both
Exynos and Rockchip, including V4L2, wouldn't work for SMMU and/or QC
SoCs.

Best regards,
Tomasz
