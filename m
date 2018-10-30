Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2006E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fQurw45v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R+bKQ2dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2006E20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeJaBML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:12:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJaBML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:12:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D25BF6145B; Tue, 30 Oct 2018 16:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540916283;
        bh=Hp/jWIL9RohCAOJ65l7ZUOtwtzkPDIvovSV8doU/0Js=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fQurw45vRNpr7l4N8a+u/3EznGcAxWeyoDGL9OEjbf3AX5ADTP68j/MuqUvU+aluP
         A4hrlLThUcY1TsvHeW6YtxOqlJr7TfWb/ze0u6AfszFy0qjHAZVPBePRcddnIOa0jX
         DBTTVqgcWu+E31I+zsSFAsfhfcoLjCVsZYfMxRuY=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33C8A6143F;
        Tue, 30 Oct 2018 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540916282;
        bh=Hp/jWIL9RohCAOJ65l7ZUOtwtzkPDIvovSV8doU/0Js=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R+bKQ2dkmpCZITyhJwTIkw//Ibx/8t7K+3PkKy1yQXkua2gB+gFwiIf5GGrcwTAGg
         bhTlIp6AYZMJrKqAPyndKbDFT63v7CZIayHrHYOKEqhAZvGBI5F/bnCJAVHrnXBtrL
         kk4PXOYTCRnI214Xbq98KCa0TGrcHk9/DGots35Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33C8A6143F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Reserve gpio ranges on MTP
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181030054554.1954-1-bjorn.andersson@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <835f226e-8f9b-c89f-d818-d513f18d1494@codeaurora.org>
Date:   Tue, 30 Oct 2018 10:18:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030054554.1954-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/2018 11:45 PM, Bjorn Andersson wrote:
> GPIOs 0 through 3 and 81 through 84 are configured to not be accessible
> from the application CPUs. Mark them as reserved to allow the MSM8998
> MTP to boot after the introduction of 3edfb7bd76bd ("gpiolib: Show
> correct direction from the beginning").
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> index b4276da1fb0d..11fd1fe8bdb5 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
> @@ -241,3 +241,7 @@
>   		};
>   	};
>   };
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;
> +};
> 

Does Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.txt 
need to be updated?  Seems like the majority of the other qcom pinctrl 
bindings docs mention that gpio-reserved-ranges is optional.

In any case,
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
