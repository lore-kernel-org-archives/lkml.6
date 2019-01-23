Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E622C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1838217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FujQ25IF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="k2bumKqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAWGy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:54:57 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfAWGy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:54:57 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0164E601D3; Wed, 23 Jan 2019 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548226496;
        bh=fv8J34Z5tW5zm5Ukwtz/V98wDu3/5/xEaviSqPae3k0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FujQ25IFhtlZhTsFxFSIKIxQJI8IWbz/AWpPd36sgT2f21q7oPM9WksYdmlivFUma
         b6eTvLm6cbomvgzXqQDSFqyrSA6CXBgLuuxO2zm3ArERb+1Jo65lxkcrZ2sT6tvpf1
         ykfH+JRY2QkxWMvYAf1YD6ofgVT9gupTOyvXbVeY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5339B60225;
        Wed, 23 Jan 2019 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548226495;
        bh=fv8J34Z5tW5zm5Ukwtz/V98wDu3/5/xEaviSqPae3k0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k2bumKqFJlF5podcQIOBjjx26so0K4uPd2fRWDC2422/xcAm0JuVWwTF4S2Y/Cc5V
         e26pPbAWnEH5O5DqNgDpPRkAUR4+HjmP5KVybHJEAPfzxamCz4V5pt2iSF5TpNow30
         OPfBmRqP9XsRXzskdgobGJYGpxE7PU6pdxG3n+04=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 12:24:55 +0530
From:   alokc@codeaurora.org
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     georgi.djakov@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: sdm845: Add interconnect for GENI QUP
In-Reply-To: <1548138816-1149-7-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-7-git-send-email-alokc@codeaurora.org>
Message-ID: <ae226b97fa2bbf9992a2727992031367@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mark Brown

On 2019-01-22 12:03, Alok Chauhan wrote:
> Add interconnect ports for GENI QUPs to set bus
> capabilities.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3..fb0a8a7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -374,6 +374,13 @@
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> +
> +			interconnects = <&rsc_hlos MASTER_BLSP_1
> +					&rsc_hlos SLAVE_EBI1>,
> +					<&rsc_hlos MASTER_APPSS_PROC
> +					&rsc_hlos SLAVE_BLSP_1>;
> +			interconnect-names = "qup-memory", "qup-config";
> +
>  			status = "disabled";
> 
>  			i2c0: i2c@880000 {
> @@ -682,6 +689,13 @@
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> +
> +			interconnects = <&rsc_hlos MASTER_BLSP_2
> +					&rsc_hlos SLAVE_EBI1>,
> +					<&rsc_hlos MASTER_APPSS_PROC
> +					&rsc_hlos SLAVE_BLSP_2>;
> +			interconnect-names = "qup-memory", "qup-config";
> +
>  			status = "disabled";
> 
>  			i2c8: i2c@a80000 {

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
