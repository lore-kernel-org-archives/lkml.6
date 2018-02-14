Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518579933; cv=none;
        d=google.com; s=arc-20160816;
        b=vJqczVVWb3crH/WqF8YW4KdazqQfwSrR3alBuDAG2c/lDSSJFUfS+cK5UcLYgdR9Tw
         vwB3m/957mbSKRO1y2XCJLOjgJMoOHZwqapxZqXuFbwcyDEYAYGWlIPfXCfouRESKCyV
         5ep2WodXRm6fbEpngzOrmgcebhMcB2tKnc4VzTFhB2lhRJMpMRSDPFh+U3SKRNSUDrPd
         1X/ZPDam0NA2OaaOK7nw5s/Cz2lZPR3Dl0x0M/wiqWfc2Y0t5Azxi+viarX1dKPSNAAP
         o8iNBwc5HTjfE6dDahyFXUZTnOGMe9o/ayoG/OR9SOtSPj/MG+RiRRb/JpfgJmbbvZ+B
         12Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2pvZohrK+95xGqEIlkXKzdUX0yhhrvFu0ruJR5T9nVI=;
        b=RmrqEYAIduoVxARuca4VyT3GGa5qhO3ldNDs3awTon3u6VVjz/KnUITc9Nbdkfkcd5
         far9ExmFB+TXcTlzzKx3Eom+j/Ak96LnLkIKH+nzUi+h0XzdGf6GsI4bAijUCX4R+X9e
         URbCY/V+hjvEsRFahIUbnZ/NkgxdQVBZ8ZwQEj8hG5LDckLn1nZ2ElXTDclwrRi1iLN9
         2oQZQbm3GK5Uz1MZ6YahzzN0mn3g/DHhOVNrnMt5Fgdd+am9phoEcF4atrOKY8V/wcrh
         n9wXT+Rnk/XEOdunIOl/PEpvaFh7FzVhf9/KP/EygMyrNhlqpqFP2MiCWtehA0Q+I+rJ
         Tvmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=eLg3iSsE;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=eLg3iSsE;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x227WHyjuJheHVPPArtB5p+t9YXJlQ7b3lTKwvbku+F0IVfrSl16IuDwusBs9rzdXF5JPxjkx4w==
MIME-Version: 1.0
In-Reply-To: <CAFp+6iHECNQ_b_rDwNKyHPgNG3xpc+qgpu8cXvqathai6EW9PQ@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-3-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5B2u8RL-tdB3qgPxVUcXnsBSEhXRBZWxqO-w6rYKAiOtg@mail.gmail.com> <CAFp+6iHECNQ_b_rDwNKyHPgNG3xpc+qgpu8cXvqathai6EW9PQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 14 Feb 2018 12:45:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Dke8VcR3K1Qg=b962AhQmqi3=HJO8dc4Uu1RZEO0juOw@mail.gmail.com>
Message-ID: <CAAFQd5Dke8VcR3K1Qg=b962AhQmqi3=HJO8dc4Uu1RZEO0juOw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
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
X-GMAIL-THRID: =?utf-8?q?1591737857427495630?=
X-GMAIL-MSGID: =?utf-8?q?1592346471772762115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 7:25 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>>> +static int arm_smmu_init_clks(struct arm_smmu_device *smmu)
>>> +{
>>> +       int i;
>>> +       int num = smmu->num_clks;
>>> +       const struct arm_smmu_match_data *data;
>>> +
>>> +       if (num < 1)
>>> +               return 0;
>>> +
>>> +       smmu->clocks = devm_kcalloc(smmu->dev, num,
>>> +                                   sizeof(*smmu->clocks), GFP_KERNEL);
>>> +       if (!smmu->clocks)
>>> +               return -ENOMEM;
>>> +
>>> +       data = of_device_get_match_data(smmu->dev);
>>> +
>>> +       for (i = 0; i < num; i++)
>>> +               smmu->clocks[i].id = data->clks[i];
>>
>> I'd argue that arm_smmu_device_dt_probe() is a better place for all
>> the code above, since this function is called regardless of whether
>> the device is probed from DT or not. Going further,
>> arm_smmu_device_acpi_probe() could fill smmu->num_clks and ->clocks
>> using ACPI-like way (as opposed to OF match data) if necessary.
>
> Right, it's valid to fill the data in arm_smmu_device_dt_probe().
> Perhaps we can just keep the devm_clk_bulk_get() in arm_smmu_device_probe()
> at the point where we are currently doing arm_smmu_init_clks().

Sounds good to me. Thanks.

Best regards,
Tomasz
