Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ACAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3DF20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aVVVWU9R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aVVVWU9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3DF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJ2Xnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:43:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46348 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJ2Xnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:43:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A74AC60744; Mon, 29 Oct 2018 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540824886;
        bh=54+gFFfnokpRiB0H4nbjotsXLcsVsFrujc56tUtFGRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aVVVWU9RpN6zp5HkFKIoRaM6+KLbPYMYMfljW8iSs+iWSNBYki8Ub0fYSKTRwiVFy
         B2ZFlnVu33/PefSVLtJRMh+z4nzVapLrkji5AzrzyOVODeg3rwNpt0CQKLPdBW6bYu
         xrMBtWEV6zylVvu+RsJoDS67zv1gQ4bJm446caZQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 37C7D6029D;
        Mon, 29 Oct 2018 14:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540824886;
        bh=54+gFFfnokpRiB0H4nbjotsXLcsVsFrujc56tUtFGRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aVVVWU9RpN6zp5HkFKIoRaM6+KLbPYMYMfljW8iSs+iWSNBYki8Ub0fYSKTRwiVFy
         B2ZFlnVu33/PefSVLtJRMh+z4nzVapLrkji5AzrzyOVODeg3rwNpt0CQKLPdBW6bYu
         xrMBtWEV6zylVvu+RsJoDS67zv1gQ4bJm446caZQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Oct 2018 20:24:46 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add SCM DT node
In-Reply-To: <9fb3d2d2-37b5-27d2-ad27-45c77ebe1df2@linaro.org>
References: <20181026122542.4714-1-sibis@codeaurora.org>
 <9fb3d2d2-37b5-27d2-ad27-45c77ebe1df2@linaro.org>
Message-ID: <24ab0b3496de7809cc49479ea33c2eab@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stan,
Thanks for the review!

On 2018-10-29 15:02, Stanimir Varbanov wrote:
> Hi Sibi,
> 
> On 10/26/2018 03:25 PM, Sibi Sankar wrote:
>> Add SCM DT node to enable SCM functionality on SDM845.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi 
>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> index b72bdb0a31a5..fad22acfda4d 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>> @@ -221,6 +221,12 @@
>>  		};
>>  	};
>> 
>> +	firmware {
>> +		scm {
>> +			compatible = "qcom,scm-sdm845", "qcom,scm";
>> +		};
>> +	};
> 
> What will happen if the platform is without tz firmware? I'd move this
> DT node in sdm845-mtp.dts or at least make it status = disabled.

Even in the absence of tz firmware, ATF is expected to implement the 
necessary
handlers for the SMC calls so I don't think it is necessary to keep it 
disabled.

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
