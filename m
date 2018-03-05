Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeCERTY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:19:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41308 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeCERTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:19:22 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D582C601A3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v8 0/5] iommu/arm-smmu: Add runtime pm/sleep support
To: Tomasz Figa <tfiga@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jcrouse@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <CAAFQd5AZoCgVts=DOET7js5VPi4ONM2m9R-WM6pWHud26XDVfA@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <73b16f5c-fe19-e652-dfd0-de7196d4cec0@codeaurora.org>
Date: Mon, 5 Mar 2018 22:49:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5AZoCgVts=DOET7js5VPi4ONM2m9R-WM6pWHud26XDVfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,


On 3/5/2018 6:55 PM, Tomasz Figa wrote:
> Hi Vivek,
>
> On Fri, Mar 2, 2018 at 7:10 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>> This series provides the support for turning on the arm-smmu's
>> clocks/power domains using runtime pm. This is done using the
>> recently introduced device links patches, which lets the smmu's
>> runtime to follow the master's runtime pm, so the smmu remains
>> powered only when the masters use it.
>>
>> It also adds support for Qcom's arm-smmu-v2 variant that
>> has different clocks and power requirements.
>>
>> Took some reference from the exynos runtime patches [1].
>>
>> After another round of discussion [3], we now finally seem to be
>> in agreement to add a flag based on compatible, a flag that would
>> indicate if a particular implementation of arm-smmu supports
>> runtime pm or not.
>> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
>> calls in map/unmap callbacks so that the clients do not have to
>> worry about handling any of the arm-smmu's power.
>> The patch that exported couple of pm_runtime suppliers APIS, viz.
>> pm_runtime_get_suppliers(), and pm_runtime_put_suppliers() can be
>> dropped since we don't have a user now for these APIs.
>> Thanks Rafael for reviewing the changes, but looks like we don't
>> need to export those APIs for some more time. :)
>>
>> Previous version of this patch series is @ [5].
> Thanks for addressing my comments. There is still a bit of space for
> improving the granularity of power management, as far as I understood
> how it works on SDM845 correctly, but as a first step, this should at
> least let things work.

Sure. I will be sending a patch, based on this series, to add 
'qcom,smmu-500'
that enables *rpm_suported* flag for us.
We can try to take care of some of the things with that.
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Thanks for the review.

regards
Vivek
>
> Best regards,
> Tomasz
