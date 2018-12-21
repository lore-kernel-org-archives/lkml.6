Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E3D21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b1McA6F2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YQeFOoB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404479AbeLUSQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:16:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbeLUSP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:15:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AD69A60C80; Fri, 21 Dec 2018 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545416158;
        bh=5aToc0KkJmmeRbotA3yXWl3Oy5rpasNi9dLGrXizzh8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=b1McA6F2a65MjbhmoLX7PCPAAt6Hh2Bd8r1S8wajRIQ9KXD0s1mvD1Kq7Y5sn6zY3
         Gbo/5CLLDUXDL9tXMR6gYWnbgmi1EDZDmpyIdaba0Gf7tRyF5hPjjZ6gDGOVe82kMZ
         E5bfTccTBjlFtosbN6lKfCWCa926y3jyA4dPXMnw=
Received: from [192.168.225.247] (unknown [49.32.116.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 708B360ADA;
        Fri, 21 Dec 2018 18:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545416132;
        bh=5aToc0KkJmmeRbotA3yXWl3Oy5rpasNi9dLGrXizzh8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YQeFOoB1VL949XFqMmyr0+iVuOkjp5nK/hgZ27Cj15JXpIUFe152R07ubH7V6POjm
         moVNW427qbnlLr4PBBelEMo3ETdRm1gnJiIV/yv+Uy5UAR9p+J10bAivRJtumB7s4b
         cULGubg7Vb7j5aJFPG57Oz38B95VLwU5DO91dAeg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 708B360ADA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH] arm64: dts: sdm845: Add cpufreq device node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, david.brown@linaro.org,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        amit.kucheria@linaro.org
References: <1545333530-30151-1-git-send-email-tdas@codeaurora.org>
 <20181220195055.GB261387@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <fa9ec7e3-d667-3d7a-b7c5-3a26f51798fb@codeaurora.org>
Date:   Fri, 21 Dec 2018 23:45:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181220195055.GB261387@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

On 12/21/2018 1:20 AM, Matthias Kaehlcke wrote:
> Hi Taniya,
> 
> On Fri, Dec 21, 2018 at 12:48:50AM +0530, Taniya Das wrote:
>> This change adds the cpufreq node as per the bindings example for SDM845.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index 23a253b..5db4fcc 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -99,6 +99,7 @@
>>   			compatible = "qcom,kryo385";
>>   			reg = <0x0 0x0>;
>>   			enable-method = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>>   			next-level-cache = <&L2_0>;
>>   			L2_0: l2-cache {
>>   				compatible = "cache";
>> @@ -114,6 +115,7 @@
>>   			compatible = "qcom,kryo385";
>>   			reg = <0x0 0x100>;
>>   			enable-method = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>>   			next-level-cache = <&L2_100>;
>>   			L2_100: l2-cache {
>>   				compatible = "cache";
>> @@ -126,6 +128,7 @@
>>   			compatible = "qcom,kryo385";
>>   			reg = <0x0 0x200>;
>>   			enable-method = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>>   			next-level-cache = <&L2_200>;
>>   			L2_200: l2-cache {
>>   				compatible = "cache";
>> @@ -138,6 +141,7 @@
>>   			compatible = "qcom,kryo385";
>>   			reg = <0x0 0x300>;
>>   			enable-method = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 0>;
>>   			next-level-cache = <&L2_300>;
>>   			L2_300: l2-cache {
>>   				compatible = "cache";
>> @@ -150,6 +154,7 @@
>>   			compatible = "qcom,kryo385";
>>   			reg = <0x0 0x400>;
>>   			enable-method = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>>   			next-level-cache = <&L2_400>;
>>   			L2_400: l2-cache {
>>   				compatible = "cache";
>> @@ -162,6 +167,7 @@
>>   			compatible = "qcom,kryo385";
>>   			reg = <0x0 0x500>;
>>   			enable-method = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>>   			next-level-cache = <&L2_500>;
>>   			L2_500: l2-cache {
>>   				compatible = "cache";
>> @@ -174,6 +180,7 @@
>>   			compatible = "qcom,kryo385";
>>   			reg = <0x0 0x600>;
>>   			enable-method = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>>   			next-level-cache = <&L2_600>;
>>   			L2_600: l2-cache {
>>   				compatible = "cache";
>> @@ -186,6 +193,7 @@
>>   			compatible = "qcom,kryo385";
>>   			reg = <0x0 0x700>;
>>   			enable-method = "psci";
>> +			qcom,freq-domain = <&cpufreq_hw 1>;
>>   			next-level-cache = <&L2_700>;
>>   			L2_700: l2-cache {
>>   				compatible = "cache";
>> @@ -341,6 +349,17 @@
>>   			#power-domain-cells = <1>;
>>   		};
>>
>> +		cpufreq_hw: cpufreq@17d43000 {
>> +			compatible = "qcom,cpufreq-hw";
>> +			reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
>> +			reg-names = "freq-domain0", "freq-domain1";
>> +
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>> +			clock-names = "xo", "alternate";
>> +
>> +			#freq-domain-cells = <1>;
>> +		};
>> +
>>   		qfprom@784000 {
>>   			compatible = "qcom,qfprom";
>>   			reg = <0x784000 0x8ff>;
> 
> My understanding is that the entries in the SDM845 DT are sorted by
> address. The address of the cpufreq node is 0x17d43000, hence it
> should be the last entry of the 'soc' node, after 'timer@17c90000'.
> 
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> 
Thank you, updated the v2 patch.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
