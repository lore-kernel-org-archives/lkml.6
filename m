Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B361C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE2621780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZNcAEhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE2621780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbeKPEfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:35:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44896 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388293AbeKPEfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:35:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id b81-v6so9592395pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yA7QqcBfYSP+MbR8BVLSVN5HzQOS+B9tMo2+U4VczLE=;
        b=DZNcAEhrwTNJM5WaRsJdHLhKPm5VKNsOcrjYpqrjiHWQeS3gMZoNFjvAiAUgSnCA4l
         wernOyXUY17wmLomHq2JSAXvkbCtDQq2LUOYvj8k/GeqKru/n4hgvgQxAzZhLYnTYd75
         7P/0oAavwnj/kdFMRQ1r6yJB9hK5YXa4kKEHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yA7QqcBfYSP+MbR8BVLSVN5HzQOS+B9tMo2+U4VczLE=;
        b=gJP/fy1oiQ6kXlgnQ3hw5rr2Jzrv5wuqb9WsbHnlSRbVfpw4SO6KcivD8dN+2bFVhY
         NrNqQ9OGb5xwIN07y7loIt6tPk83IrbYlm3jN4UuDaJQjBnGOv/vrnFd8KcbWdm0cuBw
         Fw+RQ0t6ZwREclnZKJ9cqsAf/+RIU/1hMXrbNM613tjBrRG1+plNGfaxs33hSWabkTKh
         O6So8vJ+fLy3aBCGcfIopaoE1xOTzqnOzP1wWyMXgelckkqS3gYkkKtyJmiY4Ubhvef5
         GlTMZtSM3o2HCda8Fcx+nl8IVHIlWKMtTr31VZlK9b4jXP1bpZpZNWgaN71oy2AvOzdZ
         S7Mg==
X-Gm-Message-State: AGRZ1gJHk/9UkFLXkk/gHeTGz+8sMF3z3YmDbdOlmr0CLIww6C5eurdj
        5EmpRp6tdz76bfLzFnTctNbOSg==
X-Google-Smtp-Source: AJdET5dVnhUpiktxc+IFsr5wQizb1C6Zyzzf92hDtnNov5LW1gGgb8tmDYMx/XRKXm58vLwow9Ru/g==
X-Received: by 2002:a63:4246:: with SMTP id p67mr6747934pga.335.1542306403960;
        Thu, 15 Nov 2018 10:26:43 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s2-v6sm58512667pfk.133.2018.11.15.10.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 10:26:43 -0800 (PST)
Date:   Thu, 15 Nov 2018 10:26:39 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: qcom: msm8998: correct xo clock name
Message-ID: <20181115182639.GI10915@tuxbook-pro>
References: <1542302291-6864-1-git-send-email-jhugo@codeaurora.org>
 <1542302291-6864-2-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542302291-6864-2-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15 Nov 09:18 PST 2018, Jeffrey Hugo wrote:

> The root parent clock of most msm8998 clock is the "xo" clock.  The DT node
> is incorrectly named "xo_board", which prevents Linux from correctly
> parsing the clock tree, resulting in most clocks being unparented and
> unable to be manipulated.  The end result is that we can't turn on clocks
> for peripherals like SD, so init usually fails.
> 
> Fixes: 4807c71cc688 (arm64: dts: Add msm8998 SoC and MTP board support)
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index 78227cc..a948d4b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -53,7 +53,7 @@
>  	};
>  
>  	clocks {
> -		xo_board {
> +		xo {

You could have taken the opportunity and added the label here...

>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <19200000>;

Regards,
Bjorn
