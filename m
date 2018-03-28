Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeC1H02 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:26:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbeC1H01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:26:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DFFB60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v3 3/6] dt-bindings: phy-qcom-qmp: Update bindings for
 sdm845
To: Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org>
 <1521785487-29866-4-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=Vwx2nW=pwEzJJSVXLctxOU5uGormBn=t_P6_xyfrrLAw@mail.gmail.com>
From: Manu Gautam <mgautam@codeaurora.org>
Message-ID: <773161d7-0819-9054-b168-008b4558e174@codeaurora.org>
Date: Wed, 28 Mar 2018 12:56:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Vwx2nW=pwEzJJSVXLctxOU5uGormBn=t_P6_xyfrrLAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 3/28/2018 3:07 AM, Doug Anderson wrote:
> Hi,
>
> On Thu, Mar 22, 2018 at 11:11 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
>> Update compatible strings for USB3 PHYs on SDM845.
>> One is QMPv3 DisplayPort-USB combo PHY and other one
>> is USB UNI PHY which is single lane USB3 PHY without
>> DP capability.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> index dcf1b8f..cef8765 100644
>> --- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
>> @@ -9,7 +9,9 @@ Required properties:
>>                "qcom,ipq8074-qmp-pcie-phy" for PCIe phy on IPQ8074
>>                "qcom,msm8996-qmp-pcie-phy" for 14nm PCIe phy on msm8996,
>>                "qcom,msm8996-qmp-usb3-phy" for 14nm USB3 phy on msm8996,
>> -              "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy.
>> +              "qcom,qmp-v3-usb3-phy" for USB3 QMP V3 phy,
>> +              "qcom,sdm845-qmp-usb3-phy" for USB3 QMP V3 phy on sdm845,
>> +              "qcom,sdm845-qmp-usb3-uni-phy" for USB3 QMP V3 UNI phy on sdm845.
> I'm confused.  What value does "qcom,qmp-v3-usb3-phy" have as a
> separate entry from "qcom,sdm845-qmp-usb3-phy"?  Is
> "qcom,qmp-v3-usb3-phy" expected to work on some non-SDM845 based
> device?
>
> Personally I think you should remove "qcom,qmp-v3-usb3-phy" from the
> bindings as part of this patch (replacing it with the new string
> qcom,sdm845-qmp-usb3-phy)".  Yeah, yeah bindings are forever.  ...but
> that particular string was added about a month ago and (I believe) it
> was intended for SDM845 anyway.  As per
> <https://patchwork.kernel.org/patch/10302759/> match to the exact same
> PHY data which leads extra credence to my belief.
>
> If later on you find that some future chip can use the exact same
> driver / settings as the SDM845 you can always list the
> "qcom,sdm845-qmp-usb3-phy" string as a secondary compatible anyway.
>

I agree. Will just remove "qcom,sdm845-qmp-usb3-phy"

> -Doug

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
