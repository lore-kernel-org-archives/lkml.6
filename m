Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D896B208D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dv1Std4F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VCbhSqJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D896B208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeH0O64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:58:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeH0O64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:58:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 284B9606FC; Mon, 27 Aug 2018 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535368362;
        bh=waJNMhhSSVArD+KyhHfsHXrf2Nv04yCUI80jR3MSL6w=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=Dv1Std4FEpjyT0Z2ryoMYtArMZpjkcWUXVYRVTXsHQEubPe5ja/ivD+O9GR0VwDsI
         wlpIWwa4KX+PUeSxkrt5swJkl9XZrYfFyCej4qhT0FfJDPw+001Lt4XDI4ysoXQXnM
         JbzzdMXSjo2MPaD/pz+H8Ub/iKnfUs9nquuo8YHo=
Received: from [10.79.40.134] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E01F2606FC;
        Mon, 27 Aug 2018 11:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535368360;
        bh=waJNMhhSSVArD+KyhHfsHXrf2Nv04yCUI80jR3MSL6w=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=VCbhSqJcKDqlMzv1JyqCI0EMFSoc501vBdZ0T2iXVWHjk3dhTOUtBwCLduf0kU+1H
         8QQRdbDrPz3XjMc6+2IpvqzWtwT0eT1QM3TB/6F9ay6P5C3G5w8qrrQENMFMT80Uz7
         L3y6yb5XPCwAbxjIx7ncwGGu7DEL+NyQrGXglJDU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E01F2606FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH v2 3/3] dts: arm64/sdm845: Add node for qcom,smmu-v2
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     Rob Herring <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Andy Gross <andy.gross@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
 <20180814102740.30222-4-vivek.gautam@codeaurora.org>
 <27372288-447d-6c9a-504a-8b8ef40e3d58@arm.com>
 <CAFp+6iG8HohQ5=gwL37OuykK+R4U407yfrp=WN6pSgOK-mdzzA@mail.gmail.com>
 <20180814225750.GA31263@rob-hp-laptop>
 <f8d638bd-d0cb-e03d-bac2-3bc2e30c5422@codeaurora.org>
Message-ID: <1fa25d20-94c8-569d-df32-14b66a1092fc@codeaurora.org>
Date:   Mon, 27 Aug 2018 16:42:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f8d638bd-d0cb-e03d-bac2-3bc2e30c5422@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/2018 2:26 PM, Vivek Gautam wrote:
> Hi Rob, Robin,
>
>
> On 8/15/2018 4:27 AM, Rob Herring wrote:
>> On Wed, Aug 15, 2018 at 01:09:43AM +0530, Vivek Gautam wrote:
>>> Adding Jordan here.
>>>
>>> On Tue, Aug 14, 2018 at 4:19 PM, Robin Murphy <robin.murphy@arm.com> 
>>> wrote:
>>>> Hi Vivek,
>>>>
>>>> On 14/08/18 11:27, Vivek Gautam wrote:
>>>>> Add device node for qcom,smmu-v2 available on sdm845.
>>>>> This smmu is available only to GPU device.
>>>>>
>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/sdm845.dtsi | 23 +++++++++++++++++++++++
>>>>>    1 file changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> index 1c2be2082f33..bd1ec5fa5146 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>>>> @@ -6,6 +6,7 @@
>>>>>     */
>>>>>      #include <dt-bindings/clock/qcom,gcc-sdm845.h>
>>>>> +#include <dt-bindings/clock/qcom,gpucc-sdm845.h>
>>>>>    #include <dt-bindings/clock/qcom,rpmh.h>
>>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>>    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>>>> @@ -989,6 +990,28 @@
>>>>>                          cell-index = <0>;
>>>>>                  };
>>>>>    +             gpu_smmu: iommu@5040000 {
>>>>> +                       compatible = "qcom,sdm845-smmu-v2",
>>>>> "qcom,smmu-v2";
>>>>
>>>> Which of "sdm845" or "msm8996"[1] is the actual SoC name here?
>>> Well, the bindings use the SoC prefix with smmu-v2, so it should be
>>> sdm845 for this SoC. This is same as I posted in my v1 of the series 
>>> [2].
>>> Using 8996 based string in sdm845 makes things look awful.
>> You need to list valid values of '<soc>' in the binding. Otherwise we
>> get this confusion.
>
> Sorry for delayed response, I was away on vacation.
> I will list down the valid values for '<soc>' as suggested, and respin 
> this series, and
> smmu bindings patch that comes as part of the runtime pm series [3].
>
> [3] https://lore.kernel.org/patchwork/patch/968017/
>

I have updated the binding doc with valid values for '<soc>' string [4].
Kindly review this based on [4].

[4] https://lore.kernel.org/patchwork/patch/977888/

Best regards
Vivek
