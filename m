Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeCLHHN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:07:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53728 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbeCLHGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:06:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DCD160A24
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v5 3/4] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, evgreen@chromium.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>, swboyd@chromium.org
References: <20180222061208.2031-1-rnayak@codeaurora.org>
 <20180222061208.2031-4-rnayak@codeaurora.org>
 <CAD=FV=X6X+4J8KkKo+CNDF3a1_LP1CGzBDrVvBzXx9OdyYP+Dw@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <0a0ab259-57d2-fce8-3903-514d6dc11c3d@codeaurora.org>
Date: Mon, 12 Mar 2018 12:36:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=X6X+4J8KkKo+CNDF3a1_LP1CGzBDrVvBzXx9OdyYP+Dw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/2018 02:30 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 21, 2018 at 10:12 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> +               gcc: clock-controller@100000 {
>> +                       compatible = "qcom,gcc-sdm845";
>> +                       reg = <0x100000 0x1f0000>;
>> +                       #clock-cells = <1>;
>> +                       #reset-cells = <1>;
>> +               };
> 
> Seems like we need "#power-domain-cells = <1>;" in the gcc node.
> 
> It is true that the property is listed as "optional" in the bindings,
> but we certainly know that the
> "include/dt-bindings/clock/qcom,gcc-sdm845.h" that's posted [1]
> contains several defines ending in "_GDSC" and once we start
> referencing those we'll need "#power-domain-cells".  Seems like we
> should just have it from the beginning.
> 
> NOTE: IMHO adding "#power-domain-cells" could be done as a follow-on
> patch, but since (I think) this series still hasn't landed I guess we
> could just send up v6?

thanks for catching this, I'll send out v6 in a bit.

> 
> [1] https://patchwork.kernel.org/patch/10267093/
> 
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
