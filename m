Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD7FC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99FB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zt9f05/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99FB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbeIFU2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:28:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42481 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbeIFU2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:28:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so5167634plq.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OPoZ4eSzEsKlZYCQTSTznTQ4us1t4r/68jFDhoQoza0=;
        b=Zt9f05/dIvJvVUv7wHtXchAf0IR3dUbE0OeJLpgRUQNmixYeLJtjD0l8WOU8Z83sh6
         g1DGywZpTdZJYFlVHSBAdI2dL6G22aFGFxgQ5FkRHfNQfubjJFDopzaHdboliN0BFjOB
         mT3mTy1BB+HQRoGFogF/aopE/XU/cKiO87HEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OPoZ4eSzEsKlZYCQTSTznTQ4us1t4r/68jFDhoQoza0=;
        b=pEpHVJxdFbc25vX+JByy13fh/sSwUdeLDhQxlzzHrTVjNWToOe+DouSaWZhLiu+TdH
         8f3VxWPDcMgAdPD8kQntkiu9PRKdJF6WSqmevIV//vJmgaAFFAz/msnlJE1I/kpa/kjn
         IT7aBOAPGh0kr8X/SvsrEUZoEDDUvQqkgPEvB9UYlGLt6gA05lvFgoxd14v33cwDDzdT
         ddUjH9T0TjEq1CFP3MIoWvJuegwan3w2ssHEM1yoTyVt9C4hXWTItok7PD3h8vCZ8v/I
         KVsPbpk0dtpoCRUvN9mCVzYi68q9OOMaaJpl1lICmv7C13qgmxmyMIfgeSIh63swkVgb
         yRzQ==
X-Gm-Message-State: APzg51C9Tpfk6HDrp6ZTfxL8WVvClL3m1ueHObIoo74ujfQSFPVX2jao
        /clCXSls6eKDSc4Nfdy0EYsTlQ==
X-Google-Smtp-Source: ANB0VdbArM04/PPmlelXFyiC0vHj+Sx5Fhs+JujjfZ/m72+8CdLzbLn2wwq+eTqph7vvCet3qK12Sw==
X-Received: by 2002:a17:902:b189:: with SMTP id s9-v6mr3341588plr.188.1536249137696;
        Thu, 06 Sep 2018 08:52:17 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r17-v6sm15725168pff.50.2018.09.06.08.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 08:52:17 -0700 (PDT)
Date:   Thu, 6 Sep 2018 08:56:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: msm8996: Drop model
Message-ID: <20180906155614.GC3286@tuxbook-pro>
References: <20180905183517.9390-1-niklas.cassel@linaro.org>
 <20180905183517.9390-4-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905183517.9390-4-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Sep 11:35 PDT 2018, Niklas Cassel wrote:

> DTS board files should always specify model and compatible.
> 
> All DTS board files that includes msm8996.dtsi
> already specifies model and compatible, and will thus
> override the model and compatible in msm8996.dtsi.
> 
> Drop model from msm8916.dtsi, since it is only a source of confusion.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index cd3865e7a270..b4d635bb81ac 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -16,8 +16,6 @@
>  #include <dt-bindings/clock/qcom,rpmcc.h>
>  
>  / {
> -	model = "Qualcomm Technologies, Inc. MSM8996";
> -
>  	interrupt-parent = <&intc>;
>  
>  	#address-cells = <2>;
> -- 
> 2.17.1
> 
