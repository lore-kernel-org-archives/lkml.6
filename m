Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314BCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E4C20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lue99LFx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DT782eNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfARDyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:54:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfARDyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:54:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 510866081E; Fri, 18 Jan 2019 03:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547783652;
        bh=NlFfjr87qCIIPD1hOrjKVzbXYhAmAHTSTQiPHZhX57w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lue99LFxBkj8crAQ5dkuErYGLBlsrbgHicDuod5KxefBre6EE+JlgcFluA4FkmCae
         oviVHJ2cP7P7Ce2khGGd0fQQ73bIChC1TFiMKpsj2p3V8+3vel2SJv+Lb7/ES2ucLh
         WHno15ZQ1v5W9/4iY28cf60d/Q+K6D0lLpj1w2r8=
Received: from [10.79.128.224] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B584760734;
        Fri, 18 Jan 2019 03:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547783651;
        bh=NlFfjr87qCIIPD1hOrjKVzbXYhAmAHTSTQiPHZhX57w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DT782eNivilCdxHmrEmMJyHc5lpOBFl1YHp9NOPMbfHS9pJHY44dWTluLGrw/ZgC1
         L4UxFztao6YQ2nDG/8Z0j8q/MeNjVqWe2OL/sZoyS/VYRnIgzxjCW9iDy6nIEmRHw8
         wiCbg16sskq/qDsPdDHx/qOa5XwJEMaFMLhzjwww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B584760734
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v11 0/9] Add power domain driver for corners on
 msm8996/sdm845
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
 <90f8bfec-f1dd-6031-9d98-468b29627a2f@free.fr>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <6da2a843-c8d9-70f6-733d-e4bbb3947f04@codeaurora.org>
Date:   Fri, 18 Jan 2019 09:24:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <90f8bfec-f1dd-6031-9d98-468b29627a2f@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2019 8:33 PM, Marc Gonzalez wrote:
> On 10/01/2019 05:02, Rajendra Nayak wrote:
> 
>> Rajendra Nayak (9):
>>    dt-bindings: opp: Introduce opp-level bindings
>>    OPP: Add support for parsing the 'opp-level' property
>>    dt-bindings: power: Add qcom rpm power domain driver bindings
>>    soc: qcom: rpmpd: Add a Power domain driver to model corners
>>    soc: qcom: rpmpd: Add support for get/set performance state
>>    arm64: dts: msm8996: Add rpmpd device node
>>    soc: qcom: rpmhpd: Add RPMh power domain driver
>>    arm64: dts: sdm845: Add rpmh powercontroller node
>>    soc: qcom: rpmhpd: Mark mx as a parent for cx
>>
>>   Documentation/devicetree/bindings/opp/opp.txt |   3 +
>>   .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
>>   arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
> 
> Whenever I see these patches adding support for msm8996 (aka sdm820) and sdm845
> simultaneously, I think to myself: "Why is sdm835 being left out? It was released
> between sdm820 and sdm845, it cannot be /that/ different."

It isn't that different, and it should be quite straight forward to add support for it
with the rpmpd driver (the rpmhpd is for platforms sdm845 and beyond which use rpmh)

When I started working on these patches, support for sdm835 upstream was non-existent
so I started off with what was the better supported one which was the 820 (msm8996).

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
