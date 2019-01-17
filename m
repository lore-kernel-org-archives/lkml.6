Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91601C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543E220657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gwrTIPhm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hE4mOW3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfAQKIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:08:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfAQKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:08:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 66B13607F4; Thu, 17 Jan 2019 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547719695;
        bh=dh72dpmQp78hMRCM2qBZEOQTVTgnRICZRHZTfjQ5ln8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gwrTIPhmll14wgmdiDSyKR1urv0II3Pkqq3AU4HVZJLOn6kN2uRy5nTcBf0cyXqZA
         S4ha0eQHJPQnuZ9hy0duR/jqMfk8/QtbSPu9MD38drtSYcOHQlNfg7YW6LXMZmNX1X
         BUGXGvi7z/EFaoqsXpq6SVw1yFQ6X2ab4a0pxcMM=
Received: from [10.79.128.217] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF9256024C;
        Thu, 17 Jan 2019 10:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547719694;
        bh=dh72dpmQp78hMRCM2qBZEOQTVTgnRICZRHZTfjQ5ln8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hE4mOW3hwy+ofOdUuDX7Kqm6w4NkNUxHM1sQdLIGaKhYWWm4FR77J/ygN9/MAxigZ
         4Q+KRrgDRBIYyYlMeTYYRL5JGNKKpMoZBrzDl6uhw5mWvv/RKowKkSFwylIhKBrftM
         PMqWlUgNk7NAynjMNNHQp3EA1u1vJfCAqC/dqT1E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF9256024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] arm64: dts: sdm845: Add CPU capacity values
To:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
References: <20190116234039.12935-1-mka@chromium.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <5230df91-5d46-2d12-c31a-ca19934c521c@codeaurora.org>
Date:   Thu, 17 Jan 2019 15:38:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116234039.12935-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/2019 5:10 AM, Matthias Kaehlcke wrote:
> Specify the relative CPU capacity of all SDM845 AP cores.
> 
> The values were provided by Qualcomm engineers.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Rajendra Nayak <rnayak@codeaurora.org>

> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index d9be5bba62c45..e01949fd44075 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -99,6 +99,7 @@
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
> +			capacity-dmips-mhz = <607>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
>   			next-level-cache = <&L2_0>;
>   			L2_0: l2-cache {
> @@ -115,6 +116,7 @@
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x100>;
>   			enable-method = "psci";
> +			capacity-dmips-mhz = <607>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
>   			next-level-cache = <&L2_100>;
>   			L2_100: l2-cache {
> @@ -128,6 +130,7 @@
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x200>;
>   			enable-method = "psci";
> +			capacity-dmips-mhz = <607>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
>   			next-level-cache = <&L2_200>;
>   			L2_200: l2-cache {
> @@ -141,6 +144,7 @@
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x300>;
>   			enable-method = "psci";
> +			capacity-dmips-mhz = <607>;
>   			qcom,freq-domain = <&cpufreq_hw 0>;
>   			next-level-cache = <&L2_300>;
>   			L2_300: l2-cache {
> @@ -154,6 +158,7 @@
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x400>;
>   			enable-method = "psci";
> +			capacity-dmips-mhz = <1024>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
>   			next-level-cache = <&L2_400>;
>   			L2_400: l2-cache {
> @@ -167,6 +172,7 @@
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x500>;
>   			enable-method = "psci";
> +			capacity-dmips-mhz = <1024>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
>   			next-level-cache = <&L2_500>;
>   			L2_500: l2-cache {
> @@ -180,6 +186,7 @@
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x600>;
>   			enable-method = "psci";
> +			capacity-dmips-mhz = <1024>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
>   			next-level-cache = <&L2_600>;
>   			L2_600: l2-cache {
> @@ -193,6 +200,7 @@
>   			compatible = "qcom,kryo385";
>   			reg = <0x0 0x700>;
>   			enable-method = "psci";
> +			capacity-dmips-mhz = <1024>;
>   			qcom,freq-domain = <&cpufreq_hw 1>;
>   			next-level-cache = <&L2_700>;
>   			L2_700: l2-cache {
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
