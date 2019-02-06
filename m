Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C88C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02143217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi3M0mUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBFAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:04:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35658 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:04:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so2140087pgs.2;
        Tue, 05 Feb 2019 16:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uOXx80fdt8q/5OUPcdKpfCUe3KPngQ0C559V1cV4WCI=;
        b=pi3M0mUgkFURFTB1z8zkUF9vwenWnIp4HCxFCMIMnOklWqkCPFaaH91PpijAqZqjma
         /fNYF+azWaMt7Dbefe3CGcLEdumoBDJumCJwEkripVyBS/gHCSvPM12xrVdByezKRpIo
         0LZBnDVkQV8ww1uXjbC7w75R0AAS4okZSgleWgoFcxt6lx+iSgqFAJvND/JA5HH8r+40
         YGykThx/i84jmyBceXa584siC5NNssVaXBP7r//F9E7o1nQo9nI4vjTmREu1yx+aBYFs
         1jejz/RwgIITvUBpCuuf3XG5znPscf7uvkkjU4GeT16MAvILOGIri7tTE/LaQCZ8s9G2
         RPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uOXx80fdt8q/5OUPcdKpfCUe3KPngQ0C559V1cV4WCI=;
        b=JrkQbblec8of6Df7EUEbGq+x/dDajejG9qPUQENlcZEi1WbWffLTAp5yFitFTKxGel
         JXNkKQmZ2vNy1gJxJIxMlN+PRdfPSHDRkuRSmKq813zwzW7KR9dhjQ7y7ceplHLoH3rT
         rzxgMqsbzLxCTiGDW0fmpOxtmjsTCB5JepED/xAWsXQn0soKyqYG0ym4RRcVXRPEjvBP
         92s6/Xx0s/4hWFBdmdGdoDFbSMn6MRg2hiLEu9ov9w5wsQRBuV71/3b/Qjcbt+tTY6kY
         8CpKGO9DEJok7op3bIG+zhorQxTKW9o6AaM4YbjpCZdx/Hh/ADfQXuwVaTbIZCcihswI
         OOEw==
X-Gm-Message-State: AHQUAubRtODxzEHVHcATOoSOKYzF7pMIErlacWloksbl9QzOFieDsLt0
        TGbKTwSRF2+W50OI74bNNnk=
X-Google-Smtp-Source: AHgI3IaqYjrhmwHtVtU1e8u7wo5qI2SmycBvBhkqUv3x74d+DIhdODKOQdcGellUwMHkHGIpQ3ycFA==
X-Received: by 2002:a62:8e19:: with SMTP id k25mr7635754pfe.185.1549411497487;
        Tue, 05 Feb 2019 16:04:57 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id x27sm9050439pfe.178.2019.02.05.16.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 16:04:56 -0800 (PST)
Date:   Tue, 5 Feb 2019 16:04:53 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: dts: sdm845: wireup the thermal trip
 points to cpufreq
Message-ID: <20190206000451.GB19687@localhost.localdomain>
References: <cover.1548093127.git.amit.kucheria@linaro.org>
 <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a21a9ee7663e1b32d8ea81ac5e51d187aed25fb.1548093127.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:38:34PM +0530, Amit Kucheria wrote:
> Since all cpus in the big and little clusters, respectively, are in the
> same frequency domain, use all of them for mitigation in the
> cooling-map. We end up with two cooling devices - one each for the big
> and little clusters.
> 
> We throttle lightly at the first trip point, just removing the boost
> frequency. At the next trip point we allow ourselves to be throttled to
> any extent.
> 

From OF thermal descriptor, this patch looks fine to me:

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 225 +++++++++++++++++++++++++--
>  1 file changed, 209 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3bcb0a..878f661d16eb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -99,6 +100,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -114,6 +116,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_100>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> @@ -126,6 +129,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_200>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> @@ -138,6 +142,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_300>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -150,6 +155,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x400>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_400>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> @@ -162,6 +168,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x500>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_500>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> @@ -174,6 +181,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x600>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_600>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> @@ -186,6 +194,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x700>;
>  			enable-method = "psci";
> +			#cooling-cells = <2>;
>  			next-level-cache = <&L2_700>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> @@ -1691,18 +1700,41 @@
>  			thermal-sensors = <&tsens0 1>;
>  
>  			trips {
> -				cpu_alert0: trip0 {
> +				cpu0_alert1: trip-point@0 {
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit0: trip1 {
> +				cpu0_alert0: trip-point@1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu0_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT 1>,
> +							 <&CPU1 THERMAL_NO_LIMIT 1>,
> +							 <&CPU2 THERMAL_NO_LIMIT 1>,
> +							 <&CPU3 THERMAL_NO_LIMIT 1>;
> +				};
> +				map1 {
> +					trip = <&cpu0_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu1-thermal {
> @@ -1712,18 +1744,41 @@
>  			thermal-sensors = <&tsens0 2>;
>  
>  			trips {
> -				cpu_alert1: trip0 {
> +				cpu1_alert0: trip-point@0 {
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit1: trip1 {
> +				cpu1_alert1: trip-point@1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu1_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu1_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT 1>,
> +							 <&CPU1 THERMAL_NO_LIMIT 1>,
> +							 <&CPU2 THERMAL_NO_LIMIT 1>,
> +							 <&CPU3 THERMAL_NO_LIMIT 1>;
> +				};
> +				map1 {
> +					trip = <&cpu1_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu2-thermal {
> @@ -1733,18 +1788,41 @@
>  			thermal-sensors = <&tsens0 3>;
>  
>  			trips {
> -				cpu_alert2: trip0 {
> +				cpu2_alert0: trip-point@0 {
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit2: trip1 {
> +				cpu2_alert1: trip-point@1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu2_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu2_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT 1>,
> +							 <&CPU1 THERMAL_NO_LIMIT 1>,
> +							 <&CPU2 THERMAL_NO_LIMIT 1>,
> +							 <&CPU3 THERMAL_NO_LIMIT 1>;
> +				};
> +				map1 {
> +					trip = <&cpu2_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu3-thermal {
> @@ -1754,18 +1832,41 @@
>  			thermal-sensors = <&tsens0 4>;
>  
>  			trips {
> -				cpu_alert3: trip0 {
> +				cpu3_alert0: trip-point@0 {
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit3: trip1 {
> +				cpu3_alert1: trip-point@1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu3_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu3_alert0>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT 1>,
> +							 <&CPU1 THERMAL_NO_LIMIT 1>,
> +							 <&CPU2 THERMAL_NO_LIMIT 1>,
> +							 <&CPU3 THERMAL_NO_LIMIT 1>;
> +				};
> +				map1 {
> +					trip = <&cpu3_alert1>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu4-thermal {
> @@ -1775,18 +1876,41 @@
>  			thermal-sensors = <&tsens0 7>;
>  
>  			trips {
> -				cpu_alert4: trip0 {
> +				cpu4_alert0: trip-point@0 {
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit4: trip1 {
> +				cpu4_alert1: trip-point@1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu4_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu4_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT 1>,
> +							 <&CPU5 THERMAL_NO_LIMIT 1>,
> +							 <&CPU6 THERMAL_NO_LIMIT 1>,
> +							 <&CPU7 THERMAL_NO_LIMIT 1>;
> +				};
> +				map1 {
> +					trip = <&cpu4_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu5-thermal {
> @@ -1796,18 +1920,41 @@
>  			thermal-sensors = <&tsens0 8>;
>  
>  			trips {
> -				cpu_alert5: trip0 {
> +				cpu5_alert0: trip-point@0 {
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit5: trip1 {
> +				cpu5_alert1: trip-point@1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu5_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu5_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT 1>,
> +							 <&CPU5 THERMAL_NO_LIMIT 1>,
> +							 <&CPU6 THERMAL_NO_LIMIT 1>,
> +							 <&CPU7 THERMAL_NO_LIMIT 1>;
> +				};
> +				map1 {
> +					trip = <&cpu5_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu6-thermal {
> @@ -1817,18 +1964,41 @@
>  			thermal-sensors = <&tsens0 9>;
>  
>  			trips {
> -				cpu_alert6: trip0 {
> +				cpu6_alert0: trip-point@0 {
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit6: trip1 {
> +				cpu6_alert1: trip-point@1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu6_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu6_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT 1>,
> +							 <&CPU5 THERMAL_NO_LIMIT 1>,
> +							 <&CPU6 THERMAL_NO_LIMIT 1>,
> +							 <&CPU7 THERMAL_NO_LIMIT 1>;
> +				};
> +				map1 {
> +					trip = <&cpu6_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu7-thermal {
> @@ -1838,18 +2008,41 @@
>  			thermal-sensors = <&tsens0 10>;
>  
>  			trips {
> -				cpu_alert7: trip0 {
> +				cpu7_alert0: trip-point@0 {
>  					temperature = <75000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit7: trip1 {
> +				cpu7_alert1: trip-point@1 {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu7_crit: cpu_crit {
>  					temperature = <110000>;
>  					hysteresis = <1000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu7_alert0>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT 1>,
> +							 <&CPU5 THERMAL_NO_LIMIT 1>,
> +							 <&CPU6 THERMAL_NO_LIMIT 1>,
> +							 <&CPU7 THERMAL_NO_LIMIT 1>;
> +				};
> +				map1 {
> +					trip = <&cpu7_alert1>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  	};
>  };
> -- 
> 2.17.1
> 
