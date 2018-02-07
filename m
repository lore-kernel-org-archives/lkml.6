Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbeBGEt0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:49:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbeBGEtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:49:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ADD2D609D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 2/3] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        evgreen@chromium.org, Rob Herring <robh+dt@kernel.org>
References: <20180131161941.29865-1-rnayak@codeaurora.org>
 <20180131161941.29865-3-rnayak@codeaurora.org>
 <CAD=FV=W3SfQ05_jRdCOZj=sQ9POGFb5NVvpsBYRnuak8zLFBWg@mail.gmail.com>
From: Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <ebd960da-91b0-9634-329b-7da487953680@codeaurora.org>
Date: Wed, 7 Feb 2018 10:19:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=W3SfQ05_jRdCOZj=sQ9POGFb5NVvpsBYRnuak8zLFBWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 03:25 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jan 31, 2018 at 8:19 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> new file mode 100644
>> index 000000000000..02520f19e4ca
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -0,0 +1,277 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. SDM845";
> 
> I'm fairly certain that "model" doesn't belong in the SoC .dtsi file.
> Only in the board .dts file.
> 
> 
>> +       clocks {
>> +               xo_board: xo_board {
> 
> Just to make it explicit: see my comments in patch 3/3 in this series
> about using "_" in node names.  I believe this should be:
> 
>   xo_board: xo-board {
> 
> 
>> +               spmi_bus: qcom,spmi@c440000 {
> 
> Drop the qcom in the node name.  AKA, I believe this should be:
> 
> spmi_bus: spmi@c440000 {
> 
> Specifically the node name is supposed to be a generic component name
> then with an address.  I see that Rob Herring said the same thing when
> he reviewed v1 of this patch just now (it seems like people are still
> commenting there, so make sure you collect the latest feedback from
> there when re-spinning).

yes, I'll make sure I fix up based on Robs' review of the v1.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
