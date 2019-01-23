Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA382C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AB321726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 06:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CxJ6ENy0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CxJ6ENy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfAWGsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:48:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52428 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfAWGsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 01:48:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9574A607DD; Wed, 23 Jan 2019 06:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548226091;
        bh=sySnaYEXw2gSJH42ArZw3PVCWnzAbP8dNS3hi8uuNJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CxJ6ENy0oUwaTPNASodV97v0flEabkbac2FfGv5RSrud7hrIdYwcdxGJBSbzozM7/
         +tuoVkeLDyNYE2sMFMu82NMWtCT3b3yi0KP4QkBY/LUmKFskbfek7rQpfemTY21vrd
         JMneYxEnT/YoCqEqgP2FnYZE4BLb2V/mCvw8ZfGE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 05F7360225;
        Wed, 23 Jan 2019 06:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548226091;
        bh=sySnaYEXw2gSJH42ArZw3PVCWnzAbP8dNS3hi8uuNJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CxJ6ENy0oUwaTPNASodV97v0flEabkbac2FfGv5RSrud7hrIdYwcdxGJBSbzozM7/
         +tuoVkeLDyNYE2sMFMu82NMWtCT3b3yi0KP4QkBY/LUmKFskbfek7rQpfemTY21vrd
         JMneYxEnT/YoCqEqgP2FnYZE4BLb2V/mCvw8ZfGE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 12:18:10 +0530
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
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
In-Reply-To: <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
Message-ID: <686f563e8e5d6f6a8ad226986df685db@codeaurora.org>
X-Sender: alokc@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mark Brown

On 2019-01-22 12:03, Alok Chauhan wrote:
> Add documentation for the interconnect and interconnect-names bindings
> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
> 
> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 
> ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> index dab7ca9..44d7e02 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -17,6 +17,12 @@ Required properties if child node exists:
>  - #address-cells: 	Must be <1> for Serial Engine Address
>  - #size-cells: 		Must be <1> for Serial Engine Address Size
>  - ranges: 		Must be present
> +- interconnects:	phandle to a interconnect provider. Please refer
> +			../interconnect/interconnect.txt for details.
> +			Must be 2 paths corresponding to 2 AXI ports.
> +- interconnect-names:	Port names to differentiate between the
> +			2 interconnect paths defined with interconnect
> +			specifier.
> 
>  Properties for children:
> 
> @@ -67,6 +73,10 @@ Example:
>  		#size-cells = <1>;
>  		ranges;
> 
> +		interconnects = <&qnoc 11 &qnoc 512>,
> +				<&qnoc 0 &qnoc 543>;
> +		interconnect-names = "qup-memory", "qup-config";
> +
>  		i2c0: i2c@a94000 {
>  			compatible = "qcom,geni-i2c";
>  			reg = <0xa94000 0x4000>;

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,a Linux Foundation Collaborative Project
