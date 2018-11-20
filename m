Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30709C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5513208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Olntmcq4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ieFMCIOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5513208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbeKTOjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 09:39:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeKTOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 09:39:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 373086022B; Tue, 20 Nov 2018 04:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542687131;
        bh=7nfLzI//xIu9D6PRs3flQ8Q0AUrN3QunPdThlwbjxVA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Olntmcq4OCfpO4QP1WGy73KoOcZnSV3N5Me6GAMUqQs6Y6GESeL7Kao78z3AyzVSd
         dLYq86+disdSMOP5qFfmwaJ0eNX1hU73D4Y3lLucezbrl5uuPFU7CGVsesgUlq61Av
         y3qLV/ESLyLiA1f/GbsdcMm7cpZFZMg4RUCFU+jY=
Received: from [10.79.128.175] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C98366024C;
        Tue, 20 Nov 2018 04:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542687130;
        bh=7nfLzI//xIu9D6PRs3flQ8Q0AUrN3QunPdThlwbjxVA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ieFMCIOWnczeArFwQQOPSS69P14rTpxMsiAJ1EoBb6yUSDx5DONSfyagT+ZtpTzpl
         6fMBDWpGZ6u4P+q+Os8h2b7/Cq15sQp54XogogDsbE8lziQycfWBn0/CgGocTwvS4h
         IzSPDIxcf3SH7M7F5ZH3/icxIeGPy+SNkSngduwQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C98366024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC PATCH] dt-bindings: opp: Extend qcom-opp bindings with
 properties needed for CPR
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180627045234.27403-3-rnayak@codeaurora.org>
 <20181015124749.27276-1-niklas.cassel@linaro.org>
 <20181105231745.GA25883@bogus> <20181109163917.GA6673@centauri.lan>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <eab94dd1-1d8f-4306-cced-1e34171ef1e7@codeaurora.org>
Date:   Tue, 20 Nov 2018 09:42:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181109163917.GA6673@centauri.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2018 10:09 PM, Niklas Cassel wrote:
> On Mon, Nov 05, 2018 at 05:17:45PM -0600, Rob Herring wrote:
>> On Mon, Oct 15, 2018 at 02:47:49PM +0200, Niklas Cassel wrote:
>>> Extend qcom-opp bindings with properties needed for Core Power Reduction
>>> (CPR).
>>>
>>> CPR is included in a great variety of Qualcomm SoC, e.g. msm8916 and
>>> msm8996, and was first introduced in msm8974.
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>>> ---
>>> Hello Rob, Rajendra,
>>>
>>> Sorry for not replying sooner.
>>> Since Rob wanted the binding to be complete before merging,
>>> this is my proposal to extend the OPP binding with properties
>>> needed to support CPR (both for msm8916 and msm8996).
>>> I've discussed the proposal with Viresh, and this proposal
>>> seems better than what I previously suggested here:
>>> https://lore.kernel.org/lkml/20181005204424.GA29500@centauri.lan/
>>>
>>>   .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
>>> index db4d970c7ec7..3ab5dd84de86 100644
>>> --- a/Documentation/devicetree/bindings/opp/qcom-opp.txt
>>> +++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
>>> @@ -23,3 +23,22 @@ Required properties:
>>>   representing a corner/level that's communicated with a remote microprocessor
>>>   (usually called the RPM) which then translates it into a certain voltage on
>>>   a voltage rail.
>>
>> I've lost the context here. Please send this all together.
> 
> Will do, as soon as I've gotten your feedback on this mail.

Niklas, are you still waiting for feedback on this mail from Rob?
