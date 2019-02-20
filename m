Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065172086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWIDD/U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfBTBJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:09:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45976 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBTBJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:09:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so11290143pls.12;
        Tue, 19 Feb 2019 17:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ukCdnsbnEkGThnCjEEhNHPUZjRnEHIOKiIkN6gE+pOc=;
        b=hWIDD/U2jB0DRz7keDeFOg0MFOMoFq4jH8g1uYf/TrEFjLtInMS5m2DR/EHMe0KDVW
         SbxLBL20yEFOb/v10m+7D183J3JBS+8dkc0U8fwIak3Zlr+COKI6uURkKUnrJAVM/Kcs
         GzpT77iIL6E8LRIPvEhQ3Uefbss8xZYbmSa4Labk2nnft/r/pGsupuD7mxV2FhY3ewag
         lhonEh0SEq6Kt2XpewBY1DjYycWCE84xNBEYxLeXjYkSPJrTPsXTeCmilmbgfPufIRjk
         fhQiZ4ncKMoajStNdyLACxrcklONOAHDkZ4NoCPAHL0jFqZZvI4mtwE5CjRIHArgfDdn
         pfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ukCdnsbnEkGThnCjEEhNHPUZjRnEHIOKiIkN6gE+pOc=;
        b=Tp6Q4rxeoVC8bZQiYIN6EnwSHKMfcfSuhGjC0IKEmXt6oMvjuwEy8sspwu+hDrCRHp
         YAkENxlH5MB/GMaEW1DVuEB1L24v0byNq9UK0pUQh98lSqSVRk8rpUeycq9DKb+Rfa1p
         ijjfySMX+7IkZ5e7wOyHeAWHg/QkB3USTVWVQVmo7Jx/gaeqEL1kpNNp/xX4D0aVeG9T
         3fB8zl6PU5hPocswipEFMd+STpM1/nuiHTp836jlz+p4AIpqg/qa54lm6JUW1zYGgI/F
         e+eq6yrNnH1Wmo1TmD5Od8lDPdwcpegQ9Lzx3APxQkiYdd7lM7ZCK3n8qFLlkBRpar/l
         nppQ==
X-Gm-Message-State: AHQUAuY/W+S/TqOTLMR9r/2nBfLaNRm1vZ7Xk0hukfja+yPlze5qthWY
        mT6Jg8gLbKbnNbNTWQuLmFs=
X-Google-Smtp-Source: AHgI3Iap2yATMiQI4wqlPOdGSORtynWQjO9xYe/O46LTCKevT5YyVYJeMdEBq5ndEIzgEK2bKfjLdA==
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr26761693plb.14.1550624958618;
        Tue, 19 Feb 2019 17:09:18 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id j14sm7219371pfe.12.2019.02.19.17.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 17:09:17 -0800 (PST)
Date:   Tue, 19 Feb 2019 17:09:15 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 23/24] arm64: dts: qcom: qcs404: Add thermal zones for
 each sensor
Message-ID: <20190220010913.GB2811@localhost.localdomain>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
 <42fd6c63c58db82088924c70d016e03a2b6fa9fe.1549525708.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42fd6c63c58db82088924c70d016e03a2b6fa9fe.1549525708.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 04:19:41PM +0530, Amit Kucheria wrote:
> qcs404 has 10 sensors connected to the single TSENS IP. Define a thermal
> zone for each of those sensors to expose the temperature of each zone.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 243 +++++++++++++++++++++++++++
>  1 file changed, 243 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 57d14d8f0c90..ca99c45864df 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -30,6 +31,7 @@
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells= <2>;
>  		};
>  
>  		CPU1: cpu@101 {
> @@ -38,6 +40,7 @@
>  			reg = <0x101>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells= <2>;
>  		};
>  
>  		CPU2: cpu@102 {
> @@ -46,6 +49,7 @@
>  			reg = <0x102>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells= <2>;
>  		};
>  
>  		CPU3: cpu@103 {
> @@ -54,6 +58,7 @@
>  			reg = <0x103>;
>  			enable-method = "psci";
>  			next-level-cache = <&L2_0>;
> +			#cooling-cells= <2>;
>  		};
>  
>  		L2_0: l2-cache {
> @@ -507,4 +512,242 @@
>  			#interrupt-cells = <2>;
>  		};
>  	};
> +
> +	thermal-zones {

There are several zones with passive trips and no cooling maps.

> +		aoss-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 0>;
> +
> +			trips {
> +				aoss_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				aoss_crit: aoss_crit {
> +					temperature = <110000>;
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
> +				dsp_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				dsp_crit: dsp_crit {
> +					temperature = <110000>;
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
> +				lpass_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				lpass_crit: lpass_crit {
> +					temperature = <110000>;
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
> +				wlan_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				wlan_crit: wlan_crit {
> +					temperature = <110000>;
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
> +				cluster_alert0: trip-point@0 {
> +					temperature = <95000>;
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
> +		cpu0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 5>;
> +
> +			trips {
> +				cpu0_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu0_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 6>;
> +
> +			trips {
> +				cpu1_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu1_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu1_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 7>;
> +
> +			trips {
> +				cpu2_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu2_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu2_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu3-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 8>;
> +
> +			trips {
> +				cpu3_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				cpu3_crit: cpu_crit {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu3_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
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
> +				gpu_alert0: trip-point@0 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +				gpu_crit: gpu_crit {
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
