Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x227rkLr8d4QHxXqHMswq/nayUP5AT1yIMwpdn/Yu1O3pCHFrISRWsuoKZL+OiqC31kr1hbGX
ARC-Seal: i=1; a=rsa-sha256; t=1519382202; cv=none;
        d=google.com; s=arc-20160816;
        b=mmhFUadlaEXxlH7U9ndjdHh8Hiz6yqesjnTGBf1eWZBnEY75NdUw/aaioEcuVQCMOs
         S8mHynakErAlV0vCCZCN4wx5lbLZHMLk1kVtUSZLd9aAV/wKxRfnX0AFXLA4eHYNDT0c
         I2wRDI14t0agUbMAv3/UWpGQ6UJ2dJ+xkqbAdRxlp04BJm3nh2ueoYCfHm4C7knC/Y9b
         0qVNU9yyIrTdAdOZFmEp8H7OnDRsjbHqicAvte7EVsp0JtdzqZ1/hnv5oAUmfDbhxAed
         ziR8bjNMG68fiQR59jRv6GY40+7oPgA1DsiCDrO/UYsopLL0Eic3zaXE1cGH/9SG5QVl
         p5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=c9GYaf/36Al8Zyg4ulz8yZ9piEcM2EeIGVUfp6ezTic=;
        b=wHruDeo9k3FBAVJVK/Hm2W6iAwYlwp6fBjscVHDLn1iC94sp28FgWQRCZChbg5gtOX
         8+g4Qi0EMVIq/C2fyhkjpbRPZl6/MToKImlXCY7v9OD6L2hy/sc1J0atlTyugS4ODUC3
         OcFekH41QH0RyL9sYEjfV26mcZPTH0XaHWhKQ4VdV61QOKbK83sAlSkq5lp1VNbMgg+O
         2P533kd+07VUDqwpiKUwr7VhefYFlP4oVxdispe1ROcyf8IrZ9ArvSmJqjRIyyIMzSHM
         QIRF87sE4seTpC3XTsXd8seXgAktfHZ9lnD+yMn5IS+2ymEICHzP90ahZ6zeOmqplVf8
         CQXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BcFILiZZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kO+VvHtu;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=BcFILiZZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=kO+VvHtu;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AAFB60F6D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <20180222235200.GA18743@jcrouse-lnx.qualcomm.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-4-git-send-email-vivek.gautam@codeaurora.org> <20180222235200.GA18743@jcrouse-lnx.qualcomm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Fri, 23 Feb 2018 16:06:39 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGQ5Vckui14Jb=V0uk_Pjes95hOxo=KBijR4yxPeDDzFg@mail.gmail.com>
Message-ID: <CAFp+6iGQ5Vckui14Jb=V0uk_Pjes95hOxo=KBijR4yxPeDDzFg@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Vivek Gautam <vivek.gautam@codeaurora.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno <freedreno@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737865178016622?=
X-GMAIL-MSGID: =?utf-8?q?1593187712192917454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 5:22 AM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> On Wed, Feb 07, 2018 at 04:01:19PM +0530, Vivek Gautam wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> The smmu device probe/remove and add/remove master device callbacks
>> gets called when the smmu is not linked to its master, that is without
>> the context of the master device. So calling runtime apis in those places
>> separately.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> [vivek: Cleanup pm runtime calls]
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 42 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 38 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 9e2f917e16c2..c024f69c1682 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -913,11 +913,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>       struct arm_smmu_device *smmu = smmu_domain->smmu;
>>       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> -     int irq;
>> +     int ret, irq;
>>
>>       if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>               return;
>>
>> +     ret = pm_runtime_get_sync(smmu->dev);
>> +     if (ret)
>> +             return;
>> +
>>       /*
>>        * Disable the context bank and free the page tables before freeing
>>        * it.
>> @@ -932,6 +936,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>>
>>       free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>>       __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
>> +
>> +     pm_runtime_put_sync(smmu->dev);
>>  }
>>
>>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>> @@ -1407,14 +1413,22 @@ static int arm_smmu_add_device(struct device *dev)
>>       while (i--)
>>               cfg->smendx[i] = INVALID_SMENDX;
>>
>> -     ret = arm_smmu_master_alloc_smes(dev);
>> +     ret = pm_runtime_get_sync(smmu->dev);
>>       if (ret)
>>               goto out_cfg_free;
>
> Hey Vivek, I just hit a problem with this on sdm845. It turns out that
> pm_runtime_get_sync() returns a positive 1 if the device is already active.
>
> I hit this in the GPU code. The a6xx has two platform devices that each use a
> different sid on the iommu. The GPU is probed normally from a platform driver
> and it in turn initializes the GMU device by way of a phandle.
>
> Because the GMU isn't probed with a platform driver we need to call
> of_dma_configure() on the device to set up the IOMMU for the device which ends
> up calling through this path and we discover that the smmu->dev is already
> powered (pm_runtime_get_sync returns 1).
>
> I'm not immediately sure if this is a bug on sdm845 or not because a cursory
> inspection says that the SMMU device shouldn't be powered at this time but there
> might be a connection that I'm not seeing. Obviously if the SMMU was left
> powered thats a bad thing. But putting that aside it is obvious that this
> code should be accommodating of the possibility that the device is already
> powered, and so this should be
>
> if (ret < 0)
>         goto out_cfg_free;

Right, as Tomasz also pointed, we should surely check the negative value of
pm_runtime_get_sync().

>From your description, it may be that the GPU has turned on the smmu, and
then once if goes and probes the GMU, the GMU device also wants to turn-on
the same smmu device. But that's already active. So pm_runtime_get_sync()
returns 1.
Am i making sense?

regards
Vivek

>
> With that the GPU/GMU successfully comes up on Sean Paul's display testing
> branch.
>
> Jordan
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
