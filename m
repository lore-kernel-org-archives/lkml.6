Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062AD21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NP6kW2yg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I8XBXGmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062AD21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeI0Rix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:38:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeI0Riw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:38:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BF598607F4; Thu, 27 Sep 2018 11:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538047264;
        bh=iSIHeWzEXyTRHblhsVFnr/41M7iwwOTfpLBfuLL3VXQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NP6kW2yg163tkr+ckxoGRyxpp4YG/QbxEd3B8navNjsLppntgN2IMMVLKunq4ADla
         BG8w8LGnALZDtfBbue8MbYYd5zxlMSOlxpjStt5b5cfB6EoLxVScVJ4ggnCURXM6VX
         TGm6gGf93PFE9zqka7WLiJGZzG/PwLpodH+8jIw8=
Received: from [10.206.25.139] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 059BC605FF;
        Thu, 27 Sep 2018 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538047263;
        bh=iSIHeWzEXyTRHblhsVFnr/41M7iwwOTfpLBfuLL3VXQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=I8XBXGmpPfL+wf+BNTXm3mJU86Sq/Fbqyh8lJoJmdMiVOLKo2/5aJfGzaUsiApz4S
         IY8//jjOT2R1h4Kd0tLqVsv2WDk3DF0UAfKUV6Gdr9vcfsXfWLk4Dm/+k3kavbi7bG
         oB77OI+4lsTcaQPIKzLYOLs7ee9At5j76YAc9n0g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 059BC605FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Add flag for restoring
 dll
To:     Evan Green <evgreen@chromium.org>
Cc:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayali <sayalil@codeaurora.org>,
        Doug Anderson <dianders@google.com>, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org>
 <1537887875-29494-2-git-send-email-vbadigan@codeaurora.org>
 <CAE=gft6Bxtdev+1Zo58LHNaYkB5MTfUZx8eFayvuixVJFWMw_Q@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <5194544b-866a-f0b5-3638-acf6f67fb9c8@codeaurora.org>
Date:   Thu, 27 Sep 2018 16:50:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft6Bxtdev+1Zo58LHNaYkB5MTfUZx8eFayvuixVJFWMw_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2018 11:08 PM, Evan Green wrote:
> On Tue, Sep 25, 2018 at 8:05 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> The dll settings of SDHC controller needs to be restored whenever
>> controller clocks are gated. This restoration is needed only on
>> few SDHCI-MSM controllers. This dt flag indicates whether dll
>> restoration is needed or not.
>>
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 3720385..207ce36 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -31,6 +31,8 @@ Optional properties:
>>                                          BUS_OFF states in power irq. Should be specified in
>>                                          pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
>>                                          Units uA.
>> +- qcom,restore-dll-config - Flag indicates that restoration of dll config after clock gating
>> +                           is needed on given platform. This wouldn't be needed for every MSM.
>>   Example:
>>
>>          sdhc_1: sdhci@f9824900 {
>> @@ -49,6 +51,8 @@ Example:
>>
>>                  clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>>                  clock-names = "core", "iface";
>> +
>> +               qcom,restore-dll-config;
> Hi Veera,
> I'm not sure this is the best approach. It might be better to key this
> behavior off of the compatible string. Actually I'm noticing now that
> the binding for this device doesn't include an SoC-specific compatible
> string, which I think is now the preferred way (eg
> "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"). I think we should add that
> to sdhci-msm.txt, then use the compatible string to enable this
> behavior you're adding now.

Thanks Evan. I will update this one.

> -Evan

Thanks,
Veera
