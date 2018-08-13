Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EB5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 05:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E119C2184F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 05:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RtjwyAR4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZQHTg38h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E119C2184F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeHMIKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 04:10:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeHMIKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 04:10:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6946960AD8; Mon, 13 Aug 2018 05:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534138195;
        bh=Rhdo4cjXQpC8KL4txVBWZ+HIUb6SMivepyP0TQmgoLM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RtjwyAR4KWw+T4/qbMJ8SQ1yYumIiTqqgG1DjGSWTkiOIObQvw2FVyLu1ABy+mqfN
         pqj58gDg6xrKmL3hw7Su9dnPIENrUhIyqnWtDgTI6UQh9mOBokPMarytmg2VRLhnYd
         fl+Lgok46oqypSbDQ40jejmWiqE36x1CEcDrckqE=
Received: from [10.79.40.124] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D482160791;
        Mon, 13 Aug 2018 05:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534138194;
        bh=Rhdo4cjXQpC8KL4txVBWZ+HIUb6SMivepyP0TQmgoLM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZQHTg38h5Jl0/79YMNa829WwSsO5aA+lsAYHz0UXEk0JhGVGBOANcfXLlzXzXy8jn
         2z6TkD189RDgE+wpODw7UO62zeoPWOA97HhWwTlgYSIyx/i2gxdHQBh3dztf4mCAWt
         wOHhWiiEn653OgcxZl6nshNwKI8s1Zi8/uNmXfnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D482160791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
To:     Doug Anderson <dianders@chromium.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, sricharan@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
 <20180719175356.14753-2-vivek.gautam@codeaurora.org>
 <CAD=FV=Vmn40CmLLLEfrE-eq2sj4CYnx2E2-k-dimk24CDTU1jQ@mail.gmail.com>
 <CAD=FV=XqBU0dc6smZsEssXAro5UMqqrgLudBQKqG1zznpg9cSA@mail.gmail.com>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <249d07c0-a2fb-b25e-84aa-ee820bace847@codeaurora.org>
Date:   Mon, 13 Aug 2018 10:59:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XqBU0dc6smZsEssXAro5UMqqrgLudBQKqG1zznpg9cSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,


On 8/11/2018 4:00 AM, Doug Anderson wrote:
> Hi,
>
> On Fri, Aug 10, 2018 at 3:18 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Thu, Jul 19, 2018 at 10:53 AM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> Add device node for arm,mmu-500 available on sdm845.
>>> This MMU-500 with single TCU and multiple TBU architecture
>>> is shared among all the peripherals except gpu on sdm845.
>>>
>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>>>   arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>>>   2 files changed, 77 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>> index 6d651f314193..13b50dff440f 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>> @@ -58,3 +58,7 @@
>>>                  bias-pull-up;
>>>          };
>>>   };
>>> +
>>> +&apps_smmu {
>>> +       status = "okay";
>>> +};
>> When you spin this patch please put the above in the correct place.
>> Since "a" sorts alphabetically before "i" then this should be just
>> before the line:
>>
>> &i2c10 {
> Sorry--one more thing I thought of after I sent this out...
>
> Possibly you can drop this part of the patch completely and get rid of
> the 'status = "disabled";' in sdm845.dtsi.  As I understand it you
> really only want to mark things as disabled in the SoC dtsi file if
> some boards might use this device and other boards wouldn't.  For
> instance not all boards will have the SD card controller hooked up /
> enabled so having that set to "disabled" in the SoC device tree file
> makes sense.  ...but it's not a board-level question about whether the
> SMMU is present--it's always there.  You don't gain anything by
> forcing all boards to set status to "okay".

Thanks for reviewing the patches.
Will sort the node as per alphabetical order.
Also as you pointed, it makes sense to not have the 'status' property
in SMMU. Will remove that. Thanks.

Best regards
Vivek
>
>
> -Doug

