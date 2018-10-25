Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C68C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9544D20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9544D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJZCtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:49:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45816 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbeJZCtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:49:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id z15so10024538otm.12;
        Thu, 25 Oct 2018 11:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1fMO9AdLKwAri/Xx9eWeS0vK5xfhHmhOmKxzTBYlR0=;
        b=KBGIv+3DGwsYL2FDWD0XILjdN9WLWjxsbWIunmekuvKkTictwLg0Cmz0nY706rPrra
         7qQqsRAf+DgpHBvwjsyzKl3mLBHgCRgTeKQogYXc/M6ODoxArLoGvfXRDCZU+JmpwWN+
         gJ8R8ScP/SBGYt3Wf7DV0Rix2zjJuhIbABiWt62zmeR47bElt2zGN6Ew4Nem5cghH6FB
         S0F8Xt7KxM+GYZp6vA9GD/m1WEVVniR+YuPNIYoi7Lf9UnM9pYV80ltzbZh2R2o87YSY
         0wNVNuADwQ0qTYtJsCmbNWeDd4aoY51YXUOJHHynsf5jpFyFZ+QnGdhXnPzKdf8NWSMH
         c7Yw==
X-Gm-Message-State: AGRZ1gK1mpw6/gbI5HCZz9SYlpqmAGclu6ZSZmIge+cjnhrqwXqlwr9x
        ZjkAiZGCvQ4wabSmI9vsug==
X-Google-Smtp-Source: AJdET5fXqCnNHIIw1LMP19cku1Sgh7f5URvwpw/cFC3WESgPSO/RCsPN0T6VYRgAmvmEnZ9w17WhpQ==
X-Received: by 2002:a9d:7c90:: with SMTP id q16mr222930otn.166.1540491360623;
        Thu, 25 Oct 2018 11:16:00 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 65sm2992799ott.63.2018.10.25.11.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:16:00 -0700 (PDT)
Date:   Thu, 25 Oct 2018 13:15:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     AnilKumar Chimata <anilc@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add ICE device specific parameters
Message-ID: <20181025181558.GC30244@bogus>
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
 <1539789476-6098-3-git-send-email-anilc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539789476-6098-3-git-send-email-anilc@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:47:55PM +0530, AnilKumar Chimata wrote:
> Add dt parameters information specific to the Inline
> Crypto Engine (ICE) device.
> 
> Signed-off-by: AnilKumar Chimata <anilc@codeaurora.org>
> ---
>  .../devicetree/bindings/crypto/msm/ice.txt         | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/msm/ice.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/msm/ice.txt b/Documentation/devicetree/bindings/crypto/msm/ice.txt
> new file mode 100644
> index 0000000..86eed5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/msm/ice.txt
> @@ -0,0 +1,34 @@
> +* Inline Crypto Engine (ICE)
> +
> +Required properties:
> +  - compatible			: should be "qcom,ice"

Only 1 version ever? Probably not and this needs an SoC specific 
compatible string. Does this follow any standard or ICE is a QCom thing?

> +  - reg 			: <register mapping>

No need to define standard properties. You need to say how many register 
ranges.

> +
> +Optional properties:
> +  - interrupt-names     	: name describing the interrupts for ICE IRQ

No point to this if there is only 1 IRQ.

> +  - interrupts          	: <interrupt mapping for ICE IRQ>
> +  - qcom,enable-ice-clk 	: should enable clocks for ICE HW

This shouldn't be needed.

> +  - clocks              	: List of phandle and clock specifier pairs
> +  - clock-names         	: List of clock input name strings sorted in the same
> +				  order as the clocks property.

How many?  You need to give the 
> +  - qcom,op-freq-hz     	: max clock speed sorted in the same order as the clocks
> +				  property.

Use the assigned-clocks properties for this.

> +  - qcom,instance-type  	: describe the storage type for which ICE node is defined
> +				  currently, only "ufs" and "sdcc" are supported storage type

What if there is more than one instance of ufs or SD? Do you need to 
know which ICE goes with which controller?

> +  - power-domains		: regulator supply to be used by ICE HW
> +
> +Example:
> +	ufs_ice: ufsice@1d90000 {

crytpo@...

> +		compatible = "qcom,ice";
> +		reg = <0x1d90000 0x8000>;
> +		qcom,enable-ice-clk;
> +		clock-names = "ufs_core_clk", "bus_clk",
> +				"iface_clk", "ice_core_clk";
> +		clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
> +			 <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> +			 <&gcc GCC_UFS_PHY_AHB_CLK>,
> +			 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
> +		qcom,op-freq-hz = <0>, <0>, <0>, <300000000>;
> +		power-domains = <&gcc UFS_PHY_GDSC>;
> +		qcom,instance-type = "ufs";
> +	};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
