Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFC5C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258D120868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258D120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeJMEXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:23:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45016 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeJMEXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:23:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id p23so13584779otf.11;
        Fri, 12 Oct 2018 13:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z53j5ogcElV0JozHbvypMkf8uSSYeiQqMRXhXm2BvzU=;
        b=FToCZ9OtN9o3NOO7UMLcYaQ1jZIKn9k7m3Oa6eD+l6galvUvBNWbmzG5l4wXV9UmIK
         tP57S3JHAroPE39h/EpFhEFZ9wskQe7PHBaNJ2tLRv3/DlV7ymeczknF6O7BDNsoodjZ
         kAANasbM4F3z2hFH/GFKnfk+47VMqqwYuwZTitGHymNCKSXMwxBJKettvNkp4CdWapDY
         5eml3PxODpmsYZ2G9dPbHGugLItT5mQL2YHCKBMYDFxgadGEacDfFXWMCLTiuWsttgsG
         dHgGI6SpyXe0FdhQC2axddYdKEmw8goHHt/8bNCqqKZiuaYYHGix3DYrSJKm74/Fktqd
         QSpg==
X-Gm-Message-State: ABuFfoiB/qR37XzHCU5f5Os4mKYjWlXkvySa7yHDpEjh/w1bpGd+8cIC
        v9tHWWf+J0eGsdUcKm013A==
X-Google-Smtp-Source: ACcGV63yhf1KQVZaFbNOuSfK25PEPeDCrFVUTZIp5MtS8wEiO6B6tc7O7KSDO56BiHP5Ct5JE1G9Pw==
X-Received: by 2002:a9d:26f9:: with SMTP id i54mr5016264otd.142.1539377329875;
        Fri, 12 Oct 2018 13:48:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o18sm748300otb.47.2018.10.12.13.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:48:49 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:48:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        evgreen@chromium.org, dianders@google.com, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for sdcdc10 DLL
Message-ID: <20181012204848.GA30953@bogus>
References: <1539005138-32560-1-git-send-email-vbadigan@codeaurora.org>
 <1539005138-32560-2-git-send-email-vbadigan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539005138-32560-2-git-send-email-vbadigan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:55:37PM +0530, Veerabhadrarao Badiganti wrote:
> On the SDHC-MSM controllers which makes use of sdcdc10 variant DLLs,
> the DLL configuration needs to be restored whenever controller clocks
> are gated. This new compatible string denotes the sdhc-msm controller
> variant which uses sdcdc10 DLL.

What is sdcdc10 DLL? 

Seems like a work-around to not having SoC specific compatible strings.

> 
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 3720385..49b0a43 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -6,7 +6,11 @@ and the properties used by the sdhci-msm driver.
>  Required properties:
>  - compatible: Should contain:
>  		"qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> +		"qcom,sdhci-msm-v4-sdcdc10" for sdcc versions < 5.0 and
> +		which makes use of sdcdc10 variant DLLs.
>  		"qcom,sdhci-msm-v5" for sdcc versions >= 5.0
> +		"qcom,sdhci-msm-v5-sdcdc10" for sdcc versions >= 5.0 and
> +		which makes use of sdcdc10 variant DLLs.
>  		For SDCC version 5.0.0, MCI registers are removed from SDCC
>  		interface and some registers are moved to HC. New compatible
>  		string is added to support this change - "qcom,sdhci-msm-v5".
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
