Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278D0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4BC206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YajfINyT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UF8Gmg4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfAGSwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:52:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfAGSwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:52:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EE32606FC; Mon,  7 Jan 2019 18:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546887140;
        bh=VuQJztJFS9uTVqQEtbcXRzO1y83t2FEPM+ODd58iIaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YajfINyTmLpAS7zB/yDtlBe8s4aU1KTjVHcF0xm2wmhVnmFEO/DZRRs1zrQClOahC
         rtmaEetsXTsV9fm+T8zQ5oQlF1asrTAmMokZNCxNu7kOku5H22kMb6oCLBzl10f+xl
         QOf965DQCwZxkRmtC+kOVZcNURdpFS6HFIHmFxcw=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7364260132;
        Mon,  7 Jan 2019 18:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546887139;
        bh=VuQJztJFS9uTVqQEtbcXRzO1y83t2FEPM+ODd58iIaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UF8Gmg4I4Es+qpo/cZrL9DmgZUkubs/IDalmRMoyr7pFMLfMLTSnjBwOEBauuhGuq
         z2wcwO0P0fzIr0YCVyTkG89LvunjfZzVX2COlX5oHjc7UO/29072DrHX+usT6tdVxo
         uScg7d8idC2hIcV8XObIe1ebSRtLKH88/q4lM4Vs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7364260132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 7 Jan 2019 11:52:18 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Raju P L S S S N <rplsssn@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 6/7] arm64: dts: msm: add PDC device bindings for sdm845
Message-ID: <20190107185218.GI14960@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
 <20181219221105.3004-7-ilina@codeaurora.org>
 <CAD=FV=V_+wbOhiVNHYAiZ0zD8tC6vCbZpWAZOhOESSnH12Dqig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=V_+wbOhiVNHYAiZ0zD8tC6vCbZpWAZOhOESSnH12Dqig@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2018 at 11:14 -0700, Doug Anderson wrote:
>Hi,
>
>On Wed, Dec 19, 2018 at 2:11 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Add PDC interrupt controller device bindings for SDM845.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v3:
>>         - Fix PDC map, use GIC SPI port number for hwirq
>> Changes in v2:
>>         - Order by address
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
>nit: ${SUBJECT} makes it sounds like you're adding something into the
>"Documentation/devicetree/bindings" folder, but you're not.  Also you
>probably want the prefix "qcom", not "msm" since it ends up in the
>"qcom" dir.  Also, subject should say that this is the interrupt
>controller.  How about:
>
>arm64: dts: qcom: add PDC interrupt controller for sdm845
>
>
Sure.

>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index b72bdb0a31a5..8e15392a6f64 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -1278,6 +1278,15 @@
>>                         #reset-cells = <1>;
>>                 };
>
>nit: the above node looks like the tail end of pdc reset controller.
>That has a unit address of b2e0000.  Your unit address is smaller than
>the the pdc reset controller so you should be above it, not below it.
>
Ok.
>
>> +               pdc: interrupt-controller@b220000 {
>
>nit: Maybe the label should be "pdc_intc" not just "pdc".  This is
>just the node for the interrupt controller, not the whole pdc, right?
>
>
>> +                       compatible = "qcom,sdm845-pdc";
>> +                       reg = <0xb220000 0x30000>;
>
>nit: apparently common practice for Quaclomm dts is to pad the address
>in the "reg" field to all 8 digits.  So the above should be:
>
>reg = <0x0b220000 0x30000>;
>
>NOTE: it's important to _not_ pad the unit address in the node name
>(so you got that right).  Only update the "reg".  For context:
>
Ok.

Will take care of these in the next spin.

Thanks,
Lina

>https://lkml.kernel.org/r/CAD=FV=WrvRH6QpaQ67yw2MFz8RP59ozkSfQC4+OAM_8fAbGZuw@mail.gmail.com
>
>
>-Doug
