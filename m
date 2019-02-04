Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F256C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEA52082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hUW2/xlw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hUW2/xlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfBDSG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:06:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfBDSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:06:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 915E66085F; Mon,  4 Feb 2019 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303615;
        bh=PKNvH/BmOX0BhWFefoFMNWOTu4R/DYzKKb2RxjXzFFE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hUW2/xlwVqA/31A3tImzdyV6FKkRBOXicJ1cGIDQ9BMiX4OAN1a9UwG2foHxIeK98
         zT2mxWGdoFXhBKc9/gd6+JGVHmF8KBr6bNJoz1c3dlNefxA1NjfSdOFmX6moPlIDet
         F3z/3JA8BnlNcFyns6icnH/F8K4K16HRaft8OI08=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67AAA60112;
        Mon,  4 Feb 2019 18:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549303615;
        bh=PKNvH/BmOX0BhWFefoFMNWOTu4R/DYzKKb2RxjXzFFE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hUW2/xlwVqA/31A3tImzdyV6FKkRBOXicJ1cGIDQ9BMiX4OAN1a9UwG2foHxIeK98
         zT2mxWGdoFXhBKc9/gd6+JGVHmF8KBr6bNJoz1c3dlNefxA1NjfSdOFmX6moPlIDet
         F3z/3JA8BnlNcFyns6icnH/F8K4K16HRaft8OI08=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67AAA60112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 2/5] arm64: dts: qcom: msm8998: Allow drivers to
 set-load
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <31108a78-e158-5147-2f2f-cd300cb5d49b@free.fr>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <4d99d729-d59c-e799-b4f2-8874372c9e63@codeaurora.org>
Date:   Mon, 4 Feb 2019 11:06:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <31108a78-e158-5147-2f2f-cd300cb5d49b@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2019 10:37 AM, Marc Gonzalez wrote:
> The UFS host controller driver needs to set the load on 3 power rails
> (l20, l26, s4) but the operation fails silently unless we specify the
> regulator-allow-set-load property in the corresponding DT nodes.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

>   arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index 80075283847a..198885db775e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -104,6 +104,7 @@
>   		vreg_s4a_1p8: s4 {
>   			regulator-min-microvolt = <1800000>;
>   			regulator-max-microvolt = <1800000>;
> +			regulator-allow-set-load;
>   		};
>   		vreg_s5a_2p04: s5 {
>   			regulator-min-microvolt = <1904000>;
> @@ -188,6 +189,7 @@
>   		vreg_l20a_2p95: l20 {
>   			regulator-min-microvolt = <2960000>;
>   			regulator-max-microvolt = <2960000>;
> +			regulator-allow-set-load;
>   		};
>   		vreg_l21a_2p95: l21 {
>   			regulator-min-microvolt = <2960000>;
> @@ -212,6 +214,7 @@
>   		vreg_l26a_1p2: l26 {
>   			regulator-min-microvolt = <1200000>;
>   			regulator-max-microvolt = <1200000>;
> +			regulator-allow-set-load;
>   		};
>   		vreg_l28_3p0: l28 {
>   			regulator-min-microvolt = <3008000>;
> 


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
