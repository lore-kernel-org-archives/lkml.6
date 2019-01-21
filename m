Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F5C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PHHpF6Y0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="igZjBJZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfAUJUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:20:55 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAUJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:20:54 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2042260850; Mon, 21 Jan 2019 09:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548062453;
        bh=02/Ku2PihT6vcPUqCdkhBrU0NbAbvrqhjHAh2dnOsPM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PHHpF6Y08WqZciIlxuKVEsT/DOq5yq7vBPgP+BaVb34CRep8i6rqokre0oXz298/k
         BnNqHzC0ZxyDVMVzMjnIs0V+l7SGLqe4QM6mVViJoT5/gHNPeyUYC5ikbHt2oIFuBJ
         EOtDGtui2SSQLbU523AVwi3977el4Plom5Ro6TUY=
Received: from [192.168.0.107] (unknown [106.51.20.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 327706014B;
        Mon, 21 Jan 2019 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548062452;
        bh=02/Ku2PihT6vcPUqCdkhBrU0NbAbvrqhjHAh2dnOsPM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=igZjBJZvLHB8co4EtpLv/0hJro2/UrzXgVNE3zifSjuybCbDxqoB3/wZgTXQyo8Y/
         tayx0JssGk1VQrAxelgZlIvjuWQl+LFebXfCJLQ6QxM4vRCHJe6JfYmqQPo0KNNZXp
         dYjI/IaHstWiBmE1UVQOuQKsdL0ru1w8RN2piejw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 327706014B
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
 <6da2a843-c8d9-70f6-733d-e4bbb3947f04@codeaurora.org>
 <40459ee8-7933-505a-bc39-64858d4e7637@free.fr>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <392710d8-3e3d-4987-e0be-a5098da852ab@codeaurora.org>
Date:   Mon, 21 Jan 2019 14:50:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <40459ee8-7933-505a-bc39-64858d4e7637@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2019 3:47 PM, Marc Gonzalez wrote:
> On 18/01/2019 04:54, Rajendra Nayak wrote:
> 
>> On 1/17/2019 8:33 PM, Marc Gonzalez wrote:
>>
>>> On 10/01/2019 05:02, Rajendra Nayak wrote:
>>>
>>>> Rajendra Nayak (9):
>>>>     dt-bindings: opp: Introduce opp-level bindings
>>>>     OPP: Add support for parsing the 'opp-level' property
>>>>     dt-bindings: power: Add qcom rpm power domain driver bindings
>>>>     soc: qcom: rpmpd: Add a Power domain driver to model corners
>>>>     soc: qcom: rpmpd: Add support for get/set performance state
>>>>     arm64: dts: msm8996: Add rpmpd device node
>>>>     soc: qcom: rpmhpd: Add RPMh power domain driver
>>>>     arm64: dts: sdm845: Add rpmh powercontroller node
>>>>     soc: qcom: rpmhpd: Mark mx as a parent for cx
>>>>
>>>>    Documentation/devicetree/bindings/opp/opp.txt |   3 +
>>>>    .../devicetree/bindings/power/qcom,rpmpd.txt  | 145 +++++++
>>>>    arch/arm64/boot/dts/qcom/msm8996.dtsi         |  34 ++
>>>>    arch/arm64/boot/dts/qcom/sdm845.dtsi          |  51 +++
>>>
>>> Whenever I see these patches adding support for msm8996 (aka sdm820) and sdm845
>>> simultaneously, I think to myself: "Why is sdm835 being left out? It was released
>>> between sdm820 and sdm845, it cannot be /that/ different."
>>
>> It isn't that different, and it should be quite straight forward to add support for it
>> with the rpmpd driver (the rpmhpd is for platforms sdm845 and beyond which use rpmh)
>>
>> When I started working on these patches, support for sdm835 upstream was non-existent
>> so I started off with what was the better supported one which was the 820 (msm8996).
> 
> Once you land this patch series, could you take a quick look at how much work is needed
> to add msm8998 support? I'm betting it would take you only a few hours.

Sure, I can take a look. I think I do have a 8998 device which I can probably do
some testing on too.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
