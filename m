Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E28C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BF720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BF720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbeGYTIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:08:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46760 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYTIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:08:07 -0400
Received: by mail-io0-f195.google.com with SMTP id i18-v6so7027135ioj.13;
        Wed, 25 Jul 2018 10:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y62fstzq9Kr6GqQPMn+o0NULfUM1KpXOKn60iz1+JgM=;
        b=DaX1Awl50xjStPpRcPBFIFU45IxlvMReUgUJYAu5Hs1Tl0yVIZCfQRkEwgcEQb0srU
         ovadghPjJPH5p3fQfLd4Pf5DDpvF0FjVX1dUcJCkzzHJe9CDxByUitNMlesU1gs9SX2h
         tCuWGzl1MT08zm+4Sp/onAE0zf011KdvAFzp+71b/q5UCtM8Nf/LEQiz1pgPvVCiuAB1
         zzsej2Hrzj+NqY3LQ3MCkk9J0f2Di5ipm6EgprwwpaHEfvlZuJQophHhZDgQZVPECbHP
         9n1I3uQRYuwQxgeQj3xbl0UWlUrbgQaLDEAL09hUC31k1OiGwEMTtXPlqArXr8ipEw/K
         pY+w==
X-Gm-Message-State: AOUpUlEQYpbK5bukiZyVtBzNm4cMs+tCCthIfnuYVcXx22EO2YH4V79Q
        tPCPIrGPCWKJRapiio40pG27d5xOYw==
X-Google-Smtp-Source: AAOMgpe3xgTXRJXeaYTCEBJisDmT8PC0RRDOcpbbv4Ul+BFweW1dj3kdyLTSCJXuC8bMLKUmlgfhcg==
X-Received: by 2002:a6b:d611:: with SMTP id w17-v6mr18145177ioa.216.1532541323136;
        Wed, 25 Jul 2018 10:55:23 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b27-v6sm105533itd.2.2018.07.25.10.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 10:55:22 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:55:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vijay Viswanath <vviswana@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        mark.rutland@arm.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, venkatg@codeaurora.org,
        jeremymc@redhat.com, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        evgreen@chromium.org, dianders@google.com, sayalil@codeaurora.org
Subject: Re: [PATCH V1 2/3] Documentation: sdhci-msm: Add entries for passing
 load values
Message-ID: <20180725175522.GA10185@rob-hp-laptop>
References: <1532083566-43215-1-git-send-email-vviswana@codeaurora.org>
 <1532083566-43215-3-git-send-email-vviswana@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532083566-43215-3-git-send-email-vviswana@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 04:16:05PM +0530, Vijay Viswanath wrote:
> The load a particular sdhc controller should request from a regulator
> is device specific and hence each device should individually vote for
> the required load.

"dt-bindings: mmc: ..." for the subject.

> 
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..ee34f28 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -26,6 +26,11 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional properties:
> +- <supply>-current-level - specifies load levels for supply during BUS_ON
> +			and BUS_OFF states in power irq. Should be specified in
> +			pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
> +			Units uA.

This should probably be a common regulator property (or maybe one exists 
already).

It is missing vendor prefix and unit suffix as-is.

Rob
