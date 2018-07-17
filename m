Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091DC21476
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtebvx70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091DC21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbeGQOu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:50:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43541 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbeGQOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:50:57 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so524031plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dyzByYwbK/fU+MHPd5uPvKvHjxu7Lf9ZSqrD72qqyxY=;
        b=dtebvx706yqfg3k8jdcYbqgUJiqjHV0TO2XS3QMnKQtbfuMZAEx9EbkXrg7zeGu19x
         B3+A9Qdi1KW8c9+z19DpPWTOFnxU7NaPgGvML2Uf1KCots9+BTKQ2UHySbeMPKhkiFYy
         X3zU4+63lykOVTanF0FRo71UTg+M4gga6Hrf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dyzByYwbK/fU+MHPd5uPvKvHjxu7Lf9ZSqrD72qqyxY=;
        b=b3FvzqcrHmrd8sM8dakThssj1nC/xAVYQ+VoXn4k3wkD5dvl4s2vHBp5RwzPtfd19S
         /jV/AP7QFrmudyhQvwJ8i9NoE4mc3mhmI5xrlLiPBkV2kjUC1nRxeoT3EtNLh/4euAhw
         BJ1pdNeQcrG/CDRo69WFR1yzJ0qVKwSuIcxDElMzs9TUPV05dbJmWPMPnI6QTYNc74Oz
         VLLW89k4rmzIXU3Jg7yQBqLreVyzyZVro6aFqmtWxMIC88hcg7NIoOC1mBAVn+dziMlm
         1q51WiARlG1rlAhii5mRPgjI40F/gsYFYqbfXSSFH1bYEjPHZMsTJRzkarfdu+iSqiAN
         euGw==
X-Gm-Message-State: AOUpUlF0r2I1s3IvP1odcmQX2F2aLHnM5PqI0380SeO/F+wPTUF7E/R6
        qtfOcFvRSXlnfSAzAOxkQGsY
X-Google-Smtp-Source: AAOMgpeeVsRgnyMfrPc4AJPIf81AGQUEodiK6Q04sKzOYUz2Sup8sWRif6FMGqLswvQOPhT4ZJV3XQ==
X-Received: by 2002:a17:902:8601:: with SMTP id f1-v6mr1823334plo.196.1531837085030;
        Tue, 17 Jul 2018 07:18:05 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id p5-v6sm1954099pfn.57.2018.07.17.07.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:18:04 -0700 (PDT)
Date:   Tue, 17 Jul 2018 19:47:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com
Subject: Re: [PATCH v6 5/5] arm64: dts: actions: Set UART clock reference
 from CMU
Message-ID: <20180717141757.GE19076@mani>
References: <20180715203524.11948-1-sravanhome@gmail.com>
 <20180715203524.11948-6-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715203524.11948-6-sravanhome@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 10:35:24PM +0200, Saravanan Sekar wrote:
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index ef79d7905f44..c08808ca3346 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -28,12 +28,6 @@
>  		device_type = "memory";
>  		reg = <0x1 0xe0000000 0x0 0x0>;
>  	};
> -
> -	uart3_clk: uart3-clk {
> -		compatible = "fixed-clock";
> -		clock-frequency = <921600>;
> -		#clock-cells = <0>;
> -	};
>  };
>  
>  &timer {
> @@ -42,5 +36,5 @@
>  
>  &uart3 {
>  	status = "okay";
> -	clocks = <&uart3_clk>;
> +	clocks = <&cmu CLK_UART3>;
>  };
> -- 
> 2.18.0
> 
