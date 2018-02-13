Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AH8x2262bx15hKGM7y/7Y2JiQweJIHvBkkIGoNsTa/SbsUnUR3GFgHZNBCOiMFhmiTdwKF2tM2Mt
ARC-Seal: i=1; a=rsa-sha256; t=1518516859; cv=none;
        d=google.com; s=arc-20160816;
        b=FSaLscsKqNLzQKb3VxxrPB8NDD6ZIJBitRf6O9Mkd0hvh1n9uGLm3e7qZw8mRdMxqE
         WrVWGkmlrwOA1iKnX29IJTDHth6jz2MGevaRZPEPmOYnvHwvx7aP/MjRvaa9APa6BsPm
         ebVCGilggUi18OjykjxciH8jLNJha3lHUZc9x7js89UVzYzpwUHAo0HS+3GW/2v1exsA
         L5y2E6jsLuXWDLzlQyAqRzO8TSrQATPzPMNcmDP3zNHjYpMGgh25VvjzUyD+YpCAByWN
         Ub7APY8sXbSJ0WfaiHCc6e4aaPlS0m9GUH/ool7Ksea7Xqgcj10uMVQdGclck3kE2b+3
         2GOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=3nmBtqUlz+zFQJ4JefP9nO51wDITPjyBS/4Ox3NpoCU=;
        b=l3pZJRP5B42zYzdTrSTbp1ttmOkeSrA154QCuTnm/GphrwtjK5iYdfo4amiSZpKs85
         fXBhaNchltuVU4Nrk+8tQb3wBMSf0jPbWUJ4zqPwRFnV0WxVg7ma//svbA6PDEifwgg7
         CNrpx7uT4TCStC7MtY6JNOSOepIJfWPD9RffLR+9GqHTX83WTDvXNFEpdACUXSyLkkQQ
         wkHkDogePpBkloT8IVp+rFtXQUanQbD5D0JzcVaqh9fNyvn7XgWEygDxXu6tCUwlj70a
         hGeCou5tLcG32n5NSO2yMyS2/8j/U0tscJp+yl+ovyL+BTgQMD+bLE5iu5PAxre9qVei
         f47w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Fwbi9VFA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Xu9JiEbG;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Fwbi9VFA;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Xu9JiEbG;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B91CD60F6B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BQAs9=N27_Z0pJNSrndFY3vFin2KBP44UtiW+tMXy5nQ@mail.gmail.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-5-git-send-email-vivek.gautam@codeaurora.org> <CAAFQd5BQAs9=N27_Z0pJNSrndFY3vFin2KBP44UtiW+tMXy5nQ@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 13 Feb 2018 15:44:16 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFms9ciq5AkGGNobVqhXT3E6xJD3-DahT8i19gp1mLxTw@mail.gmail.com>
Message-ID: <CAFp+6iFms9ciq5AkGGNobVqhXT3E6xJD3-DahT8i19gp1mLxTw@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
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
X-GMAIL-THRID: =?utf-8?q?1591737871126335112?=
X-GMAIL-MSGID: =?utf-8?q?1592280334214726951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomasz,


On Tue, Feb 13, 2018 at 2:01 PM, Tomasz Figa <tfiga@chromium.org> wrote:
> Hi Vivek,
>
> Thanks for the patch. Please see my comments inline.

Thanks for reviewing the patch series.

>
> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> Finally add the device link between the master device and
>> smmu, so that the smmu gets runtime enabled/disabled only when the
>> master needs it. This is done from add_device callback which gets
>> called once when the master is added to the smmu.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index c024f69c1682..c7e924d553bd 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -215,6 +215,9 @@ struct arm_smmu_device {
>>
>>         /* IOMMU core code handle */
>>         struct iommu_device             iommu;
>> +
>> +       /* runtime PM link to master */
>> +       struct device_link *link;
>>  };
>>
>>  enum arm_smmu_context_fmt {
>> @@ -1425,6 +1428,17 @@ static int arm_smmu_add_device(struct device *dev)
>>
>>         pm_runtime_put_sync(smmu->dev);
>>
>> +       /*
>> +        * Establish the link between smmu and master, so that the
>> +        * smmu gets runtime enabled/disabled as per the master's
>> +        * needs.
>> +        */
>> +       smmu->link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
>> +       if (!smmu->link)
>> +               dev_warn(smmu->dev,
>> +                        "Unable to create device link between %s and %s\n",
>> +                        dev_name(smmu->dev), dev_name(dev));
>
> How likely it is that the master can work normally even if the link
> add fails? Perhaps we should just return an error here?

Right. We are assuming that the power is handled for most of the
smmu operations, after we add the master with smmu, based on the fact
that the device link is successful.
We should return error code here. Will make the necessary change.

>
>> +
>>         return 0;
>>
>>  out_rpm_put:
>> @@ -1449,6 +1463,8 @@ static void arm_smmu_remove_device(struct device *dev)
>>         cfg  = fwspec->iommu_priv;
>>         smmu = cfg->smmu;
>>
>> +       device_link_del(smmu->link);
>
> We allowed smmu->link in arm_smmu_add_device(), but here we don't
> check it. Looking at the code, device_link_del() doesn't seem to check
> either.
>
> Note that this problem would go away if we fail add_device on
> device_link_add() failure, as I suggested above, so no change would be
> necessary.

Sure. After making the above change, this should also be handled.

Best regards
Vivek

>
> Best regards,
> Tomasz



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
