Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4FE20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4FE20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389485AbeGKQMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:12:17 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44806 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732433AbeGKQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:12:17 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so50212914oih.11;
        Wed, 11 Jul 2018 09:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hTcOWitApQwEo71NdEHxoZ70HKLinz+1IbNAkKb+r4E=;
        b=eSm5jJIUroy4CRkJ5h4xB8ZM8ON0lBx82UVhtb56e94wmlK8VO0JWpLT7ypk7sHHJP
         sINdxmZMDb+heut1PDP7t0sPeuhoSH30hDvvGNZL/lKnJwadPmYitQ5HUyehEJ+05s7a
         efvE1nCo004zeEo9an75+3IoyA4XsWC2R6+hwSgV+jZI7J9RDcXi9jGOFW79XzFB0+z4
         Rz+/DLyeADtp/lUPJskCOXAROxGLJCe2v2ivYAATb+/ryNi/hcrMar1j4wDi5/s8TvGt
         9Iq3fPUCtOLFbt32hXVxG45w/QDb0NKDGBoGs0Caue1dolb85npW4Xq0gYfQr5IsEJDR
         CZlw==
X-Gm-Message-State: APt69E3WgjllnPOzpq5mOu8G0Y6ERZKM1l8cWTiXN3UMIlA71koetV+8
        LjmrbS2rrrTjmaJBrZEH7Q==
X-Google-Smtp-Source: AAOMgpf7KlgjN/WkJnwQbHSvCbS6TkZjjQryCBQgXMQ56LSkVydVu6ol0wTkVBRplvXtnYJ93TW7Ig==
X-Received: by 2002:aca:4e50:: with SMTP id c77-v6mr30442230oib.254.1531325235436;
        Wed, 11 Jul 2018 09:07:15 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id i204-v6sm10216304oia.41.2018.07.11.09.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:07:14 -0700 (PDT)
Date:   Wed, 11 Jul 2018 10:07:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/34] media: camss: Unify the clock names
Message-ID: <20180711160713.GA29354@rob-hp-laptop>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
 <1530797585-8555-9-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530797585-8555-9-git-send-email-todor.tomov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 04:32:39PM +0300, Todor Tomov wrote:
> Unify the clock names - use names closer to the clock
> definitions.

Why? You can't just change names. You are breaking an ABI.

> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,camss.txt       | 24 +++++++++++-----------

Bindings should be a separate patch.

>  drivers/media/platform/qcom/camss/camss.c          | 20 ++++++++----------
>  2 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,camss.txt b/Documentation/devicetree/bindings/media/qcom,camss.txt
> index cadeceb..032e8ed 100644
> --- a/Documentation/devicetree/bindings/media/qcom,camss.txt
> +++ b/Documentation/devicetree/bindings/media/qcom,camss.txt
> @@ -53,7 +53,7 @@ Qualcomm Camera Subsystem
>  	Usage: required
>  	Value type: <stringlist>
>  	Definition: Should contain the following entries:
> -                - "camss_top_ahb"
> +                - "top_ahb"
>                  - "ispif_ahb"
>                  - "csiphy0_timer"
>                  - "csiphy1_timer"
> @@ -67,11 +67,11 @@ Qualcomm Camera Subsystem
>                  - "csi1_phy"
>                  - "csi1_pix"
>                  - "csi1_rdi"
> -                - "camss_ahb"
> -                - "camss_vfe_vfe"
> -                - "camss_csi_vfe"
> -                - "iface"
> -                - "bus"
> +                - "ahb"
> +                - "vfe0"
> +                - "csi_vfe0"
> +                - "vfe_ahb"
> +                - "vfe_axi"
>  - vdda-supply:
>  	Usage: required
>  	Value type: <phandle>
> @@ -161,7 +161,7 @@ Qualcomm Camera Subsystem
>  			<&gcc GCC_CAMSS_CSI_VFE0_CLK>,
>  			<&gcc GCC_CAMSS_VFE_AHB_CLK>,
>  			<&gcc GCC_CAMSS_VFE_AXI_CLK>;
> -                clock-names = "camss_top_ahb",
> +                clock-names = "top_ahb",
>                          "ispif_ahb",
>                          "csiphy0_timer",
>                          "csiphy1_timer",
> @@ -175,11 +175,11 @@ Qualcomm Camera Subsystem
>                          "csi1_phy",
>                          "csi1_pix",
>                          "csi1_rdi",
> -                        "camss_ahb",
> -                        "camss_vfe_vfe",
> -                        "camss_csi_vfe",
> -                        "iface",
> -                        "bus";
> +                        "ahb",
> +                        "vfe0",
> +                        "csi_vfe0",
> +                        "vfe_ahb",
> +                        "vfe_axi";
>  		vdda-supply = <&pm8916_l2>;
>  		iommus = <&apps_iommu 3>;
>  		ports {
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index abf6184..0b663e0 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -32,8 +32,7 @@ static const struct resources csiphy_res[] = {
>  	/* CSIPHY0 */
>  	{
>  		.regulator = { NULL },
> -		.clock = { "camss_top_ahb", "ispif_ahb",
> -			   "camss_ahb", "csiphy0_timer" },
> +		.clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy0_timer" },
>  		.clock_rate = { { 0 },
>  				{ 0 },
>  				{ 0 },
> @@ -45,8 +44,7 @@ static const struct resources csiphy_res[] = {
>  	/* CSIPHY1 */
>  	{
>  		.regulator = { NULL },
> -		.clock = { "camss_top_ahb", "ispif_ahb",
> -			   "camss_ahb", "csiphy1_timer" },
> +		.clock = { "top_ahb", "ispif_ahb", "ahb", "csiphy1_timer" },
>  		.clock_rate = { { 0 },
>  				{ 0 },
>  				{ 0 },
> @@ -60,8 +58,7 @@ static const struct resources csid_res[] = {
>  	/* CSID0 */
>  	{
>  		.regulator = { "vdda" },
> -		.clock = { "camss_top_ahb", "ispif_ahb",
> -			   "csi0_ahb", "camss_ahb",
> +		.clock = { "top_ahb", "ispif_ahb", "csi0_ahb", "ahb",
>  			   "csi0", "csi0_phy", "csi0_pix", "csi0_rdi" },
>  		.clock_rate = { { 0 },
>  				{ 0 },
> @@ -78,8 +75,7 @@ static const struct resources csid_res[] = {
>  	/* CSID1 */
>  	{
>  		.regulator = { "vdda" },
> -		.clock = { "camss_top_ahb", "ispif_ahb",
> -			   "csi1_ahb", "camss_ahb",
> +		.clock = { "top_ahb", "ispif_ahb", "csi1_ahb", "ahb",
>  			   "csi1", "csi1_phy", "csi1_pix", "csi1_rdi" },
>  		.clock_rate = { { 0 },
>  				{ 0 },
> @@ -96,10 +92,10 @@ static const struct resources csid_res[] = {
>  
>  static const struct resources_ispif ispif_res = {
>  	/* ISPIF */
> -	.clock = { "camss_top_ahb", "camss_ahb", "ispif_ahb",
> +	.clock = { "top_ahb", "ahb", "ispif_ahb",
>  		   "csi0", "csi0_pix", "csi0_rdi",
>  		   "csi1", "csi1_pix", "csi1_rdi" },
> -	.clock_for_reset = { "camss_vfe_vfe", "camss_csi_vfe" },
> +	.clock_for_reset = { "vfe0", "csi_vfe0" },
>  	.reg = { "ispif", "csi_clk_mux" },
>  	.interrupt = "ispif"
>  
> @@ -108,8 +104,8 @@ static const struct resources_ispif ispif_res = {
>  static const struct resources vfe_res = {
>  	/* VFE0 */
>  	.regulator = { NULL },
> -	.clock = { "camss_top_ahb", "camss_vfe_vfe", "camss_csi_vfe",
> -		   "iface", "bus", "camss_ahb" },
> +	.clock = { "top_ahb", "vfe0", "csi_vfe0",
> +		   "vfe_ahb", "vfe_axi", "ahb" },
>  	.clock_rate = { { 0 },
>  			{ 50000000, 80000000, 100000000, 160000000,
>  			  177780000, 200000000, 266670000, 320000000,
> -- 
> 2.7.4
> 
