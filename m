Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5735C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DDF21A70
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JU+iZfd8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ECUhVdLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DDF21A70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeHGEe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:34:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbeHGEez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:34:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B481560AD8; Tue,  7 Aug 2018 02:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533608575;
        bh=OABubB0DbeLr0+xgLpg4Jl146GkGOP5IuMLiakY5cYA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JU+iZfd8uaPvCapvOeG8+hFkBg9pQEmaBeELsgffmvO+8loGbHpMvEYZaUJ1q5Miu
         3W5bcaE28GfQX7ciuZ1HzUK1o9xyVzLgtUlqrjYGjyK2Y2ja7ZZgoHNkw7vUuqPFV8
         JtWsTn6Uz0PtLw+vsUDensxpSY/P+zaPOUrdM5+o=
Received: from [192.168.1.6] (unknown [117.96.192.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 743DD60710;
        Tue,  7 Aug 2018 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533608574;
        bh=OABubB0DbeLr0+xgLpg4Jl146GkGOP5IuMLiakY5cYA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ECUhVdLRhkUB9VULfLOcPSn91L1GxTELXwrt+tFAmJYB6kL6rjuAJeRTHeJxYjcxO
         aE9lcxpBdqNQAtL21IMjY+pCPep3lxTnm5JdriZyNeLFUW0e3BommT/Z6FQhmegsVu
         vr4a+NGThKrkcb4eC3q7CYfupZ6uWTs5/4RGBGRM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 743DD60710
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 4/5] arm: dts: qcom: Add ipq8064-ap161.dts
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1533305419-29152-1-git-send-email-sricharan@codeaurora.org>
 <1533305419-29152-5-git-send-email-sricharan@codeaurora.org>
 <CAL_JsqL2g+1maJLDf0uDAWEmLtA5bUPP5Pi_pRSd3Lu-yBFq9g@mail.gmail.com>
From:   Sricharan R <sricharan@codeaurora.org>
Message-ID: <b3852f40-d1dc-0002-04b4-398675a42350@codeaurora.org>
Date:   Tue, 7 Aug 2018 07:52:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL2g+1maJLDf0uDAWEmLtA5bUPP5Pi_pRSd3Lu-yBFq9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/7/2018 2:05 AM, Rob Herring wrote:
> On Fri, Aug 3, 2018 at 8:10 AM Sricharan R <sricharan@codeaurora.org> wrote:
>>
>> Add a new board dts for ipq8064-ap161.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.txt | 2 ++
>>  arch/arm/boot/dts/Makefile                     | 1 +
>>  arch/arm/boot/dts/qcom-ipq8064-ap161.dts       | 7 +++++++
>>  3 files changed, 10 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-ap161.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.txt b/Documentation/devicetree/bindings/arm/qcom.txt
>> index ee532e7..2325135 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.txt
>> +++ b/Documentation/devicetree/bindings/arm/qcom.txt
>> @@ -15,6 +15,7 @@ The 'SoC' and 'board' elements are required. All other elements are optional.
>>
>>  The 'SoC' element must be one of the following strings:
>>
>> +       ipq8064
>>         apq8016
>>         apq8074
>>         apq8084
>> @@ -30,6 +31,7 @@ The 'SoC' element must be one of the following strings:
>>
>>  The 'board' element must be one of the following strings:
>>
>> +       ap
>>         cdp
>>         liquid
>>         dragonboard
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 37a3de7..233661a 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -772,6 +772,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>>         qcom-ipq4019-ap.dk07.1-c1.dtb \
>>         qcom-ipq4019-ap.dk07.1-c2.dtb \
>>         qcom-ipq8064-ap148.dtb \
>> +       qcom-ipq8064-ap161.dtb \
>>         qcom-msm8660-surf.dtb \
>>         qcom-msm8960-cdp.dtb \
>>         qcom-msm8974-fairphone-fp2.dtb \
>> diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap161.dts b/arch/arm/boot/dts/qcom-ipq8064-ap161.dts
>> new file mode 100644
>> index 0000000..aab5174
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq8064-ap161.dts
>> @@ -0,0 +1,7 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include "qcom-ipq8064-v1.0.dtsi"
>> +
>> +/ {
>> +       model = "Qualcomm Technologies, Inc. IPQ8064/AP-161";
>> +       compatible = "qcom,ipq8064-ap161";
> 
> Doesn't match what you documented above. I'm guessing the ap148 board
> didn't either...

oops. yeah, ap148 id not having it. will add that and also correct this.
would call it as 'ap161' as the name for the board part.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
