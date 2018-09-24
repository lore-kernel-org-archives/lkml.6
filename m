Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C93C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF25220C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeZ2nqtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF25220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeIXXmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:42:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44792 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbeIXXmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:42:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so1466811pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YE0exzuxsR+vZFYLxFPQf5Fr83H+z/FbjqFOsXWk2Sw=;
        b=FeZ2nqtCPTs+VTkEo8A2Ef/p4EfJ7i9bZUdTz7AFRmBWsD10dax+70zbRDkBiSNjqk
         vuiKBPGqZDMOuS07z72ooDxYJmyQsRt6yMppLH6x5qaqwi05dUejfUyrxKzMK/y/gRlJ
         KDSp4aRHuA0tG9TiBKS07KwtfBgxG6YrckmTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YE0exzuxsR+vZFYLxFPQf5Fr83H+z/FbjqFOsXWk2Sw=;
        b=fA3JMDqpW91DLnSNc4N0X5ZIFKnat18rgBRAo+Cowhhv4LeLdXgO+rRp7SguqoBFCR
         9yXnpdwQ4KaBl/lbBdwFyndQyPEiRwk7Vyja45n3SJbqJAzPuU76w1qj8fuSc/7hfrew
         Iyi5889QNmLg4BJltk1V6Xtghp8UKw/e8P8GK8qyCmEIgM6G6zkDCSFsKGssFHBM53dV
         UB6gtf5o7CHaRacv3ZdtqoFYr9yD8BNxw0bwkefeD5H5/89hW5w9bHlvTnEcqkXZBM97
         shGWN77/knmmvw/IAsi2pv4SyUbXDw3lYrLhCDDGhDd6WJBzRxlM9qKFzi2IvYVD9FqE
         Facg==
X-Gm-Message-State: ABuFfoiW8MbENWRgQB+0iDbDbIVpqssYeJIFCPsNHjJLKnsn1LNExpAW
        CcGCNjROJ/XAMCd+nPHdALNFVA==
X-Google-Smtp-Source: ANB0VdYBSU7E5bqojxEOcrPNUGv13NV4byMAd9Yx+r/myAdneV6knrTYqxD6u/6CmBQJ1l7kdMSZ8g==
X-Received: by 2002:a62:f610:: with SMTP id x16-v6mr11163195pfh.169.1537810761599;
        Mon, 24 Sep 2018 10:39:21 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t141-v6sm48852483pgb.27.2018.09.24.10.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:39:20 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:43:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: Add sdm660 soc compatible
Message-ID: <20180924174341.GN1367@tuxbook-pro>
References: <20180811162453.10930-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811162453.10930-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 11 Aug 09:24 PDT 2018, Craig Tatlor wrote:

> Add the compatible for SDM660.
> This does not need clocks to do scm calls
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Andy picked my clock-rework patch for the scm driver, so we can now do:

	compatible = "qcom,scm-sdm660", "qcom,scm";

and get the desired result.


Please respin your patch without the code update.

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
>  drivers/firmware/qcom_scm.c                             | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> index fcf6979c0b6d..499608fcc864 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> @@ -11,6 +11,7 @@ Required properties:
>   * "qcom,scm-msm8660" for MSM8660 platforms
>   * "qcom,scm-msm8690" for MSM8690 platforms
>   * "qcom,scm-msm8996" for MSM8996 platforms
> + * "qcom,scm-sdm660" for SDM660 platforms
>   * "qcom,scm-ipq4019" for IPQ4019 platforms
>   * "qcom,scm" for later processors (MSM8916, APQ8084, MSM8974, etc)
>  - clocks: One to three clocks may be required based on compatible.
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index e778af766fae..ee113ceb5d41 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -603,6 +603,9 @@ static const struct of_device_id qcom_scm_dt_match[] = {
>  	{ .compatible = "qcom,scm-msm8996",
>  	  .data = NULL, /* no clocks */
>  	},
> +	{ .compatible = "qcom,scm-sdm660",
> +	  .data = NULL, /* no clocks */
> +	},
>  	{ .compatible = "qcom,scm-ipq4019",
>  	  .data = NULL, /* no clocks */
>  	},
> -- 
> 2.18.0
> 
