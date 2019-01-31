Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD871C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734ED218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IqjpNbGD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DX9vMKJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfAaRJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:09:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfAaRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:09:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 452F2606DC; Thu, 31 Jan 2019 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548954585;
        bh=3mrCvj4mxqlwEYCtaYQQW8G9o1UjkJJSz62/uvPhuPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IqjpNbGDJvDgHZ3JRew71WAjR3EaDdZgYJbN5Fq3IJKFkMB0vcMz9bQBICpCb8bGY
         TvUx6EH7AP+JQskBmAIzmd8FJpmLq7LKrwzn4yzPMcnIIFak6/Qhph36J0Rkg3VkBO
         yC1KxOdHE+GL1vQ8NtVXD1xXh24cpcS9P+CSyCaM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7C3276037C;
        Thu, 31 Jan 2019 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548954584;
        bh=3mrCvj4mxqlwEYCtaYQQW8G9o1UjkJJSz62/uvPhuPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DX9vMKJbH2PAs9M1uAcxp32dZTeRkr0vh9x60lN6TCSUpwemhgMgfdrXX194xkf/R
         8KNb834qY4TBmlBs4wIizOHOPLe1SUb309GJ4yz07+qAgliTtOFbjyfOi+cZCOBoHM
         i3wvZwGN+Vx0iFv3/IhwwqavAHQU3f7yg/JIMaEE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 Jan 2019 22:39:44 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v5 02/10] arm64: dts: qcom: sdm845: Define rmtfs memory
In-Reply-To: <20190131003933.11436-3-bjorn.andersson@linaro.org>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
 <20190131003933.11436-3-bjorn.andersson@linaro.org>
Message-ID: <fabd30bb14cf174bbee06f6c1844cd98@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-31 06:09, Bjorn Andersson wrote:
> Define the rmtfs memory node. As the memory region specified in version
> 10 of the memory map is only 1MB a chunk of unallocated memory is
> chosen.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v4:
> - Moved rmtfs_mem, to not collide with xbl_mem
> 
> Changes since v3:
> - Labeled the node
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 45b1616392aa..d19486ba1e5e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -104,6 +104,15 @@
>  			no-map;
>  		};
> 
> +		rmtfs_mem: memory@88f0000 {

Hey Bjorn,
we are missing a trailing zero here ^^
rmtfs_mem: memory@88f00000

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0 0x88f00000 0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +
>  		qseecom_mem: memory@8ab00000 {
>  			reg = <0 0x8ab00000 0 0x1400000>;
>  			no-map;

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
