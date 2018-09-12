Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11910C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A9B20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTFarwEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A9B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeILPvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:51:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36142 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeILPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:51:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id j192-v6so1862741wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=au41o3cuO0JIan5SCTDOKR4LvErEfj3yWHL3s69UTi4=;
        b=LTFarwEMGTiE8R0Ed9CLdxw4LJBKW0Q5gH3zhJAcNLXl9CFtxRk+AYsyIORSKp4P2Y
         kPsc1L0fvB3Hr7uY7At7wEAbb4e2wVI71RuSeiosfDUEWEIKsr2jd6YThrS+DjRNuoRn
         k6euxgZo8jJtxgWKugLluMjXIkb6mMiYcNpTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=au41o3cuO0JIan5SCTDOKR4LvErEfj3yWHL3s69UTi4=;
        b=TGHmnh1ZxK0oKOKja6HeYwtDovDgDlMYtCGkwhRhiHviEzOWIvNgeUuiAU0LSqckfB
         sWoz9uV2MDlBds5J6Fz8kQZACbCqQiaE2tKnLzNKlDjcxFY7NlD0WUjXITbczV3jSa8H
         UFBppkBbihaip1tkn3OJ8lXp8DUaWJtu0waJVkBaWaWpnJhySmx7XOyV+gYgWQHXqSJ4
         USnyB9Qf6dNgKx4VZnO0PJKFRY0WahdkEN9Q6xD41dRU/rVHNmQ5LtLnpBiv2hLpQkwO
         DIiKZwbfj6kaJj6G0pPx4rW5m2l8eyRwWSJRfQT2mU/gYL0cpayTh+xnGfDsFSa+oOF6
         WqTw==
X-Gm-Message-State: APzg51BN4ScEqPj0Uu6IA4TK1SWl+soUNAEP/NDRHd3+eJP+3pbzDWvz
        QtpkYcnA2qNn1b2H1VhWg2WScQ==
X-Google-Smtp-Source: ANB0VdbThQLranXMY1Tg7FQVov97e5JAXpPW8fz2/rmdyx6PblkaQe2XgdULnUoF5np1CLUoNa+jbQ==
X-Received: by 2002:a1c:28c2:: with SMTP id o185-v6mr1271215wmo.40.1536749269374;
        Wed, 12 Sep 2018 03:47:49 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id a37-v6sm1346840wrc.21.2018.09.12.03.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 03:47:48 -0700 (PDT)
Date:   Wed, 12 Sep 2018 18:47:35 +0800
From:   leo.yan@linaro.org
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        arm@kernel.org, sudeep.holla@arm.com, xuwei5@hisilicon.com,
        lipengcheng8@huawei.com
Subject: Re: [PATCH 02/11] dts: hisilicon: Update coresight bindings for
 hardware ports
Message-ID: <20180912104735.GC3353@leoy-ThinkPad-X240s>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
 <1536661032-30481-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536661032-30481-3-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:17:03AM +0100, Suzuki K Poulose wrote:
> Switch to updated coresight bindings for hw ports.

As Shawn suggested, please change subject as "arm64: dts: hi6220:
...."

> Cc: xuwei5@hisilicon.com
> Cc: lipengcheng8@huawei.com
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 147 ++++++++++++---------
>  1 file changed, 85 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> index 7afee5d..2202816 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi

[...]

> @@ -302,10 +315,12 @@
>  
>  			cpu = <&cpu3>;
>  
> -			port {
> -				etm3_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in3>;
> +			out-ports {
> +				port {
> +					etm3_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in3>;
> +					};
>  				};
>  			};
>  		};
> @@ -319,10 +334,12 @@
>  
>  			cpu = <&cpu4>;
>  
> -			port {
> +			out-ports {
> +				port {
>  				etm4_out: endpoint {

Indent?

After applied this patch and tested on Hikey board; FWIW:

Tested-by: Leo Yan <leo.yan@linaro.org>

> -					remote-endpoint =
> -						<&acpu_funnel_in4>;
> +						remote-endpoint =
> +							<&acpu_funnel_in4>;
> +					};
>  				};
>  			};
>  		};
> @@ -336,10 +353,12 @@
>  
>  			cpu = <&cpu5>;
>  
> -			port {
> -				etm5_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in5>;
> +			out-ports {
> +				port {
> +					etm5_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in5>;
> +					};
>  				};
>  			};
>  		};
> @@ -353,10 +372,12 @@
>  
>  			cpu = <&cpu6>;
>  
> -			port {
> -				etm6_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in6>;
> +			out-ports {
> +				port {
> +					etm6_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in6>;
> +					};
>  				};
>  			};
>  		};
> @@ -370,10 +391,12 @@
>  
>  			cpu = <&cpu7>;
>  
> -			port {
> -				etm7_out: endpoint {
> -					remote-endpoint =
> -						<&acpu_funnel_in7>;
> +			out-ports {
> +				port {
> +					etm7_out: endpoint {
> +						remote-endpoint =
> +							<&acpu_funnel_in7>;
> +					};
>  				};
>  			};
>  		};
> -- 
> 2.7.4
> 
