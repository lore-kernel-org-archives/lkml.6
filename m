Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC93FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7091A20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544738214;
	bh=nYml34tQ32lTDBQzQDDtD/+ISS3b22gnZ+vRLCC1MDY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ZN07ruJMDn0IK1tEHw+Jvy7z1qi/Gs1oyjsjVlmvxA4eujUO9Bo08bAaSlBOtMVVA
	 4fEEY/p2JBddtxTB5K/tWeq0RROm5KXVdt+nTzyTZD6memOLKq4hMzVd5nWk5faw57
	 c7bs/RRcCtR8wvJaBT9ygzlzTG1roCk5/vq2UpRU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7091A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeLMV4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbeLMV4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:56:53 -0500
Received: from [192.168.1.10] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51FD420811;
        Thu, 13 Dec 2018 21:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544738211;
        bh=nYml34tQ32lTDBQzQDDtD/+ISS3b22gnZ+vRLCC1MDY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=X3gIPmpes3gK0F6Thwlu19ao+jpMZ+B81RkPkKXrqiM4Q6bBMddXV1whAmSlqusRP
         cZZ7IUwtK1nWzShHKY5kvNXHBY3EqouP8vHS+U5EyhX7DDe/Xkvf9YE/c3XNWgfPR7
         unQRsd/va8mrnCQVwLe5ZZV29PkxMIGpreR4auyg=
Subject: Re: [PATCH] arch: arm: socfpga: arria10: Add stmmac ptp_ref clock to
 socdk devicetree
To:     dwesterg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thor.thayer@intel.com
Cc:     Dalon Westergreen <dalon.westergreen@linux.intel.com>
References: <20181213205910.26359-1-dalon.westergreen@linux.intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c703c4d4-4442-19b1-8645-aa906b08f7e6@kernel.org>
Date:   Thu, 13 Dec 2018 15:56:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213205910.26359-1-dalon.westergreen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/18 2:59 PM, dwesterg@gmail.com wrote:
> From: Dalon Westergreen <dalon.westergreen@linux.intel.com>
> 
> Add the stmmac ptp_ref clock as it is configured in the arria10 socdk.
> The stmmac driver defaults the ptp_ref clock to the main stmmac clock
> if the ptp_ref clock is not set in the devicetree.  This is inapprotiate

s/inapprotiate/inappropriate

> for the arria10 socdk.
> 
> Signed-off-by: Dalon Westergreen <dalon.westergreen@linux.intel.com>
> ---
>  arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> index 2a7466891d0e..58bfa84dcdb3 100644
> --- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> @@ -74,7 +74,8 @@
>  &gmac0 {
>  	phy-mode = "rgmii";
>  	phy-addr = <0xffffffff>; /* probe for phy addr */
> -
> +	clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
> +	clock-names = "stmmaceth", "ptp_ref";
>  	
These should go into the base arria10 dtsi at socfpga_arria10.dtsi?
Should the other gmacs get the same updates?

Also the patch header should be "ARM: dts: arria10:"

Dinh
