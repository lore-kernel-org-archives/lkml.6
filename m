Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x227S8b7eSrbphj6u2BileNTgmWGud5c+kJfAHDIKCahya6lXvpgs3hdK8RJuBeT+/uNlunz9
ARC-Seal: i=1; a=rsa-sha256; t=1518517543; cv=none;
        d=google.com; s=arc-20160816;
        b=G28OLyKFOgrrQzyf02NXPw8Rj9fBU3SkwTPVHOa4HwtQ/JXNH/NE0nxyUSTCPBM+nw
         QSaQJ0wgpAcTXdb0q1JpwAX+hY2teiLZDiznUDaOkj0Wcfm+N2uscCAWjfFjOIkaM+B8
         2jBvA22sOwIUd3n9uQsU1xyNNpDt3MTmHY8UtIJR+IUDYNlVKeEgFLrby9xIWJC3i5gG
         y4RRJgjOZxr1lnZ/fKBJhrgZ0AWKqAqVUPpcav++gIdq5xCkFnQZHh+EW9YTFMJNHE5B
         7YiOinsG+rejYcLE33cgzHO9GwicJdIboWmwQrlb8e3vGnX5BQG7S8jZD5LyO3fbqg+s
         8jGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=xr86nq93PJm9wLXchpW1tXXkQRtNtFDTZWjDL/WDR2w=;
        b=mbNQt835C8vRDBpABbcnsfS/XBDfWB5qT+0lc4SofwdV553jbFlEFnQV7AIqX90q83
         kS6S9Vg5DI3tWtPLOc6qrWxGIWOUz5CeGv5A0meEOQvSk32lAYEX31MSGTdnGDUvkQI9
         ausV3VAcT1jrIMnjUUx4ocubpXHwuOq80/U6B9TzXq1qye7TPhPttOEP7HxATP0Fj3HY
         gOxwP/EWPCbNB+BWn1C7AhpoM6OU7PYBtayWvnXrQdH0kB+BtyYR9Qm1MlSKHdIBClhL
         kLFOUNy8sIHQgq7XIzQZ0zH0wi9vg9FXiBYk97gTbejAiL6FVykWLSvGr1hqFJEyYQGq
         UlOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dhc78lUw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G5SVLULB;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dhc78lUw;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G5SVLULB;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8540D60F6B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <CAAFQd5B2u8RL-tdB3qgPxVUcXnsBSEhXRBZWxqO-w6rYKAiOtg@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-3-git-send-email-vivek.gautam@codeaurora.org> <CAAFQd5B2u8RL-tdB3qgPxVUcXnsBSEhXRBZWxqO-w6rYKAiOtg@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 13 Feb 2018 15:55:40 +0530
X-Gmail-Original-Message-ID: <CAFp+6iHECNQ_b_rDwNKyHPgNG3xpc+qgpu8cXvqathai6EW9PQ@mail.gmail.com>
Message-ID: <CAFp+6iHECNQ_b_rDwNKyHPgNG3xpc+qgpu8cXvqathai6EW9PQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
To: Tomasz Figa <tfiga@chromium.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rob Clark <robdclark@gmail.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>, freedreno@lists.freedesktop.org,
	David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>,
	Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737857427495630?=
X-GMAIL-MSGID: =?utf-8?q?1592281051282194758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomasz,


Please find my response inline below.

On Tue, Feb 13, 2018 at 1:33 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> Hi Vivek,
>
> Thanks for the patch. Please see some comments inline.
>
> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> The smmu needs to be functional only when the respective
>> master's using it are active. The device_link feature
>> helps to track such functional dependencies, so that the
>> iommu gets powered when the master device enables itself
>> using pm_runtime. So by adapting the smmu driver for
>> runtime pm, above said dependency can be addressed.
>>
>> This patch adds the pm runtime/sleep callbacks to the
>> driver and also the functions to parse the smmu clocks
>> from DT and enable them in resume/suspend.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Signed-off-by: Archit Taneja <architt@codeaurora.org>
>> [vivek: Clock rework to request bulk of clocks]
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 69e7c60792a8..9e2f917e16c2 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -48,6 +48,7 @@
>>  #include <linux/of_iommu.h>
>>  #include <linux/pci.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>
>> @@ -205,6 +206,8 @@ struct arm_smmu_device {
>>         u32                             num_global_irqs;
>>         u32                             num_context_irqs;
>>         unsigned int                    *irqs;
>> +       struct clk_bulk_data            *clocks;
>> +       int                             num_clks;
>
> nit: Perhaps "num_clocks" to be consistent with "clocks"?
>
>>
>>         u32                             cavium_id_base; /* Specific to Cavium */
>>
>> @@ -1897,10 +1900,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>  struct arm_smmu_match_data {
>>         enum arm_smmu_arch_version version;
>>         enum arm_smmu_implementation model;
>> +       const char * const *clks;
>> +       int num_clks;
>
> nit: Perhaps s/clks/clocks/ here or s/clocks/clks/ in struct arm_smmu_device?

Sure. Will change to s/clocks/clks/ in struct arm_smmu_device.

>
>>  };
>>
>>  #define ARM_SMMU_MATCH_DATA(name, ver, imp)    \
>> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
>> +static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
>>
>>  ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
>>  ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
>> @@ -2001,6 +2006,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>         data = of_device_get_match_data(dev);
>>         smmu->version = data->version;
>>         smmu->model = data->model;
>> +       smmu->num_clks = data->num_clks;
>>
>>         parse_driver_options(smmu);
>>
>> @@ -2039,6 +2045,28 @@ static void arm_smmu_bus_init(void)
>>  #endif
>>  }
>>
>> +static int arm_smmu_init_clks(struct arm_smmu_device *smmu)
>> +{
>> +       int i;
>> +       int num = smmu->num_clks;
>> +       const struct arm_smmu_match_data *data;
>> +
>> +       if (num < 1)
>> +               return 0;
>> +
>> +       smmu->clocks = devm_kcalloc(smmu->dev, num,
>> +                                   sizeof(*smmu->clocks), GFP_KERNEL);
>> +       if (!smmu->clocks)
>> +               return -ENOMEM;
>> +
>> +       data = of_device_get_match_data(smmu->dev);
>> +
>> +       for (i = 0; i < num; i++)
>> +               smmu->clocks[i].id = data->clks[i];
>
> I'd argue that arm_smmu_device_dt_probe() is a better place for all
> the code above, since this function is called regardless of whether
> the device is probed from DT or not. Going further,
> arm_smmu_device_acpi_probe() could fill smmu->num_clks and ->clocks
> using ACPI-like way (as opposed to OF match data) if necessary.

Right, it's valid to fill the data in arm_smmu_device_dt_probe().
Perhaps we can just keep the devm_clk_bulk_get() in arm_smmu_device_probe()
at the point where we are currently doing arm_smmu_init_clks().

Thanks & regards
Vivek

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
