Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5F02145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leYixmlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5F02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbeK3EDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:03:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33842 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbeK3EDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:03:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so1201662pgg.1;
        Thu, 29 Nov 2018 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R+7jLP2gVOCkQXsmp/a+3+oT+RsOxveoQ0CFvt8xMZE=;
        b=leYixmlmB/3BwXTxwxaSnTdtzZwBG17hC8/RlNNQ8VwLcF29rZUFx4NxRc+ICUjAS8
         jUgZqBGBswzKEPRXvyf1JtYpKzozUe2nF9Lw+d8BZwMnXJ8FyJPJp69432YecJqkAXNZ
         vQbGrTh9mUNJ7YzimiASkoqOhKHz0gLak3pE8zFQ0V/NQ0rm/s7yPlS0CYrkR2VEhkEB
         oldZjv92WReFkY0eU36RfKiYx4typuFOi2DUu/Gq2JlanVux25OpMMAiJNKnbNibXLC6
         R7ZedHKsMIXky4p6xl1tsP3+8C0gZvs7SVU79rmZaNw1Civz4b2/XUSq3tWV6i0Kx1DV
         yenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R+7jLP2gVOCkQXsmp/a+3+oT+RsOxveoQ0CFvt8xMZE=;
        b=pmlzqEmXaK0+B1EEF/d60jglGzf1QyGLYXopqcfp5c6PNT79Husv7Dqvt+5aZ+hR6G
         ICZ4fzpe9CwVNkC4vOOHMO5/iEVwz0EQYnPD8BbqGUeD4JWJmRJ1bGUWeX/WwC4FetyP
         SixxT5nZCl65IE+b598yBgHAwEgkaachUD1kDNus/UfFJmMGpzf0WTVLT+U7gQMDVTaH
         Od741WAtKH7+afljf6DuRdbgcgWind3yH7GsT8ABjQsPDU0xhiYH+j7Vxpl+knX5BPtQ
         WCCbChXfCeL3nbdJ6QaRmBybddYLI+Fqe5noPnop8omc7kBNmGzsnOQZVOda9gmPYiD8
         aeQw==
X-Gm-Message-State: AA+aEWaatbztLRxlPC6ynkuBfpUxmhKQ+07qZG3r6mPOlVPx2SBKMrrv
        FvcG2f8du8bBPVhR1mNW1wQ=
X-Google-Smtp-Source: AFSGD/UNRkW2LKgbO3dxeX8dTLcJMtEkhUM/bSH/p+yLzHwlzIjR+sQMG5RX+YulCt1pz7Fb33b72g==
X-Received: by 2002:a63:960a:: with SMTP id c10mr1861534pge.106.1543510634289;
        Thu, 29 Nov 2018 08:57:14 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id k38sm6487681pgb.33.2018.11.29.08.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:57:13 -0800 (PST)
Date:   Thu, 29 Nov 2018 08:57:11 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        vkoul@kernel.org, khasim.mohammed@linaro.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qcs404: Add thermal zones for
 each sensor
Message-ID: <20181129165709.GF2688@localhost.localdomain>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
 <f89944deceba4c16c1863f1b303e2d970f3c8456.1543335819.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89944deceba4c16c1863f1b303e2d970f3c8456.1543335819.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:59:07PM +0530, Amit Kucheria wrote:
> qcs404 has 10 sensors connected to the single TSENS IP. Define a thermal
> zone for each of those sensors to expose the temperature of each zone.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Tested-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 206 +++++++++++++++++++++++++++
>  1 file changed, 206 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 57d14d8f0c90..cbc3fd378893 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -30,6 +30,7 @@
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells= <2>;
>  		};
>  
>  		CPU1: cpu@101 {
> @@ -38,6 +39,7 @@
>  			reg = <0x101>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells= <2>;
>  		};
>  
>  		CPU2: cpu@102 {
> @@ -46,6 +48,7 @@
>  			reg = <0x102>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells= <2>;
>  		};
>  
>  		CPU3: cpu@103 {
> @@ -54,6 +57,7 @@
>  			reg = <0x103>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells= <2>;
>  		};
>  
>  		L2_0: l2-cache {
> @@ -507,4 +511,206 @@
>  			#interrupt-cells = <2>;
>  		};
>  	};
> +
> +	thermal-zones {
> +		aoss-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 0>;
> +
> +			trips {
> +				aoss_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";


A passive trip and yet no cooling map associate to it..

> +				};
> +				aoss_crit: trip1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		dsp-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 1>;
> +
> +			trips {
> +				dsp_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				dsp_crit: trip1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		lpass-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 2>;
> +
> +			trips {
> +				lpass_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				lpass_crit: trip1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		wlan-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 3>;
> +
> +			trips {
> +				wlan_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				wlan_crit: trip1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cluster-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 4>;
> +
> +			trips {
> +				cluster_alert: cluster_alert {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cluster_crit: cluster_crit {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 5>;
> +
> +			trips {
> +				cpu_alert0: cpu_alert0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_crit0: cpu_crit0 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-thermal1 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 6>;
> +
> +			trips {
> +				cpu_alert1: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_crit1: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-thermal2 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 7>;
> +
> +			trips {
> +				cpu_alert2: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_crit2: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-thermal3 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 8>;
> +
> +			trips {
> +				cpu_alert3: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu_crit3: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		gpu-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 9>;
> +
> +			trips {
> +				gpu_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				gpu_crit: trip1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.17.1
> 
