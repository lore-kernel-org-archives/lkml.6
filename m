Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D32CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A32020656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547582535;
	bh=To9SCcGmql52ej6S9yuk9qVA7+Y0qvTRe+fDt0nOJww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SitdFqnr++8b7YyYPAfIggi3IQbTXJI3nyQv9Ylb0zxtzEPLm/eLwoj82zDy/2B78
	 1lKErznHRkvm8M08Y0NLb3XgNWtX3HVvCeUjLPe/rm3WUGr4edPlCmPEL1/Up5fftB
	 1u+JXw/HoPEXGFPLroec+knDj6m7gEG9xhh56Nuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbfAOUCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:02:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34823 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732293AbfAOUCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:02:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so3726530otj.2;
        Tue, 15 Jan 2019 12:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHkxmrwQy1JEawfovmtFP1Ph+FNV8d7g5+agjyXgEDI=;
        b=htdxGy6L3IfckZNqF//SrPEUej5ao1r71WqWEPxR6g2bv5mYsGhSrqt9+Wb5MwunCJ
         Km1aqYCWn1c8ahZo3/vn3+omgGYzw/vA0U3Y7hTY/gaEY4eDLTzubUizHA00KKHqqu48
         +nlyZVRFPolpnIL8bbDFJI8Yat84aTkcC6Xzwz9OjHm4PocLsQGa3hfpw9dbZqAgZ8h/
         2rDqI1vNKKOGiTKI0GI9gYr1krtyTj6McyvTvwoW7AVZyVy8eTCBhdT/jhp1L4KssM9K
         REvZKD3kf9wLQyBdvI+LBBBFW1mo374ODnznYsEEY5AQavegxuH1+OmlCO5lcqv2pixT
         NyiA==
X-Gm-Message-State: AJcUukfgyOQIK+xD0cXCaEcbO8e8mrWqumtVtoQSiHpfiJ3Adt7O9RZv
        hTe0busnn5BLZgVf68zTJA==
X-Google-Smtp-Source: ALg8bN48uuKwVh6RpLajIpwgoHOVbGMN0N+muvXekhC1tHRmvBQU93RVZsQZSQnwzanL43rcxuQ4BA==
X-Received: by 2002:a9d:7097:: with SMTP id l23mr3277757otj.49.1547582530904;
        Tue, 15 Jan 2019 12:02:10 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id 127sm1860751oid.36.2019.01.15.12.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:02:10 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:02:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V8 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Message-ID: <20190115200209.GA8473@bogus>
References: <1547176135-2470-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547176135-2470-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:08:53PM -0800, Sowjanya Komatineni wrote:
> Add supports-cqe optional property for Tegra SDMMC.
> 
> Tegra186 and Tegra194 supports HW Command queue only
> on SDMMC4 controller. This property is used to identify
> command queue support controller in the tegra sdhci driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 32b4b4e41923..fb14c2c8d7ee 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -72,6 +72,10 @@ Optional properties for Tegra210 and Tegra186:
>  - nvidia,default-trim : Specify the default outbound clock trimmer
>    value.
>  - nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> +- supports-cqe : The presence of this property indicates that the
> +  corresponding controller supports HW command queue feature.
> +  Tegra186 and Tegra194 has 4 SDMMC Controllers and only SDMMC4
> +  controller supports HW Command Queue with eMMC device.

Don't SDHCI capability bits do this? If not, this should probably be 
common.

Rob
